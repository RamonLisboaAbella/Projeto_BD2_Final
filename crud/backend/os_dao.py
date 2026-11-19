"""
Camada de acesso a dados do CRUD de Ordem de Serviço (issue #13).

Tabela principal: ordem_servico
Detalhe (mestre-detalhe): os_servico (serviços executados na OS)
Tabelas de apoio (combos): equipamento, tecnico, status_os, servico

Todas as funções abrem a própria conexão. As operações de escrita rodam em
uma única transação: se qualquer comando falhar, nada é gravado (rollback).
Em caso de erro, é lançada ErroOrdemServico com uma mensagem pronta para ser
exibida na interface gráfica.

Formato dos itens (serviços da OS) usado em inserir_ordem/atualizar_ordem:
    [{"id_servico": 3, "quantidade": 1, "valor_cobrado": Decimal("150.00")}, ...]
O total de um item é quantidade x valor_cobrado.
"""

from contextlib import closing
from datetime import date, datetime
from decimal import Decimal, InvalidOperation

import pyodbc

from .conexao import obter_conexao


class ErroOrdemServico(Exception):
    """Erro de validação ou de banco de dados, com mensagem para o usuário."""


# Mensagens amigáveis para as constraints do script DDL
MENSAGENS_CONSTRAINTS = {
    "fk_os_equipamento": "O equipamento informado não existe.",
    "fk_os_tecnico": "O técnico informado não existe.",
    "fk_os_status": "O status informado não existe.",
    "ck_os_datas": "A data de conclusão não pode ser anterior à data de abertura.",
    "fk_os_servico_servico": "Um dos serviços informados não existe.",
    "pk_os_servico": "O mesmo serviço foi informado mais de uma vez na OS.",
    "ck_os_servico_quantidade": "A quantidade do serviço deve ser maior que zero.",
    "ck_os_servico_valor": "O valor cobrado não pode ser negativo.",
    "fk_pagamento_os": "A OS possui pagamento registrado e não pode ser excluída.",
    "fk_garantia_os": "A OS possui garantia registrada e não pode ser excluída.",
}


def _traduzir_erro_banco(erro):
    texto = str(erro)
    for constraint, mensagem in MENSAGENS_CONSTRAINTS.items():
        if constraint in texto:
            return ErroOrdemServico(mensagem)
    return ErroOrdemServico(f"Erro no banco de dados: {texto}")


def _consultar(sql, parametros=()):
    """Executa um SELECT e devolve uma lista de dicionários (coluna -> valor)."""
    try:
        with closing(obter_conexao()) as conexao:
            cursor = conexao.cursor()
            cursor.execute(sql, parametros)
            colunas = [coluna[0] for coluna in cursor.description]
            return [dict(zip(colunas, linha)) for linha in cursor.fetchall()]
    except pyodbc.Error as erro:
        raise _traduzir_erro_banco(erro) from erro


def _executar_transacao(operacao):
    """Executa operacao(cursor) em uma transação: commit no sucesso, rollback em qualquer erro."""
    try:
        with closing(obter_conexao()) as conexao:
            try:
                resultado = operacao(conexao.cursor())
                conexao.commit()
                return resultado
            except Exception:
                conexao.rollback()
                raise
    except pyodbc.Error as erro:
        raise _traduzir_erro_banco(erro) from erro


# ---------------------------------------------------------------------------
# Validações (feitas antes de ir ao banco, para dar mensagens claras na tela)
# ---------------------------------------------------------------------------

def _validar_id(valor, campo, obrigatorio=True):
    if valor is None or valor == "":
        if obrigatorio:
            raise ErroOrdemServico(f"Informe o campo {campo}.")
        return None
    try:
        numero = int(valor)
    except (TypeError, ValueError):
        raise ErroOrdemServico(f"O campo {campo} deve ser um número inteiro.") from None
    if numero <= 0:
        raise ErroOrdemServico(f"O campo {campo} deve ser maior que zero.")
    return numero


def _validar_defeito(defeito_relatado):
    texto = (defeito_relatado or "").strip()
    if not texto:
        raise ErroOrdemServico("Informe o defeito relatado pelo cliente.")
    if len(texto) > 300:
        raise ErroOrdemServico("O defeito relatado deve ter no máximo 300 caracteres.")
    return texto


def _validar_data(valor, campo):
    if valor is None or valor == "":
        return None
    if isinstance(valor, datetime):
        return valor
    if isinstance(valor, date):
        return datetime(valor.year, valor.month, valor.day)
    try:
        return datetime.fromisoformat(str(valor).strip())
    except ValueError:
        raise ErroOrdemServico(f"O campo {campo} deve estar no formato AAAA-MM-DD ou AAAA-MM-DD HH:MM.") from None


def _validar_itens(itens):
    """Valida a lista de serviços da OS e devolve tuplas (id_servico, quantidade, valor_cobrado)."""
    validados = []
    servicos_vistos = set()

    for posicao, item in enumerate(itens or [], start=1):
        id_servico = _validar_id(item.get("id_servico"), f"serviço do item {posicao}")

        if id_servico in servicos_vistos:
            raise ErroOrdemServico("O mesmo serviço foi informado mais de uma vez na OS.")
        servicos_vistos.add(id_servico)

        try:
            quantidade = int(item.get("quantidade", 1))
        except (TypeError, ValueError):
            raise ErroOrdemServico(f"A quantidade do item {posicao} deve ser um número inteiro.") from None
        if not 1 <= quantidade <= 255:  # os_servico.quantidade é TINYINT
            raise ErroOrdemServico(f"A quantidade do item {posicao} deve estar entre 1 e 255.")

        try:
            valor = Decimal(str(item.get("valor_cobrado")).replace(",", ".")).quantize(Decimal("0.01"))
        except (InvalidOperation, ValueError):
            raise ErroOrdemServico(f"O valor cobrado do item {posicao} é inválido.") from None
        if valor < 0 or valor >= Decimal("100000000"):  # DECIMAL(10,2)
            raise ErroOrdemServico(f"O valor cobrado do item {posicao} deve estar entre 0 e 99.999.999,99.")

        validados.append((id_servico, quantidade, valor))

    return validados


def _gravar_itens(cursor, id_ordem_servico, itens):
    if itens:
        cursor.executemany(
            "INSERT INTO os_servico (id_ordem_servico, id_servico, quantidade, valor_cobrado) VALUES (?, ?, ?, ?);",
            [(id_ordem_servico, *item) for item in itens],
        )


def _garantir_existencia(cursor, id_ordem_servico):
    cursor.execute(
        "SELECT 1 FROM ordem_servico WITH (UPDLOCK) WHERE id_ordem_servico = ?;",
        id_ordem_servico,
    )
    if cursor.fetchone() is None:
        raise ErroOrdemServico(f"A ordem de serviço {id_ordem_servico} não foi encontrada.")


# ---------------------------------------------------------------------------
# READ
# ---------------------------------------------------------------------------

def listar_ordens():
    """Lista as OS com cliente, equipamento, técnico, status, abertura e valor total (serviços + peças)."""
    return _consultar(
        """
        SELECT os.id_ordem_servico,
               c.nome                          AS cliente,
               m.nome + ' ' + e.modelo         AS equipamento,
               t.nome                          AS tecnico,
               s.descricao                     AS status,
               os.dt_abertura,
               os.dt_conclusao,
               COALESCE(sv.total_servicos, 0) + COALESCE(pc.total_pecas, 0) AS total
        FROM ordem_servico os
        INNER JOIN equipamento e ON e.id_equipamento = os.id_equipamento
        INNER JOIN cliente     c ON c.id_cliente     = e.id_cliente
        INNER JOIN marca       m ON m.id_marca       = e.id_marca
        INNER JOIN status_os   s ON s.id_status_os   = os.id_status_os
        LEFT  JOIN tecnico     t ON t.id_tecnico     = os.id_tecnico
        -- totais agregados antes do JOIN para não multiplicar linhas quando a OS
        -- tem vários serviços e várias peças ao mesmo tempo
        LEFT JOIN (SELECT id_ordem_servico, SUM(quantidade * valor_cobrado) AS total_servicos
                   FROM os_servico GROUP BY id_ordem_servico) sv
               ON sv.id_ordem_servico = os.id_ordem_servico
        LEFT JOIN (SELECT id_ordem_servico, SUM(quantidade * preco_unitario) AS total_pecas
                   FROM os_peca GROUP BY id_ordem_servico) pc
               ON pc.id_ordem_servico = os.id_ordem_servico
        ORDER BY os.id_ordem_servico DESC;
        """
    )


def obter_ordem(id_ordem_servico):
    """Retorna os dados da OS com a lista de itens (serviços), ou None se ela não existir."""
    id_ordem_servico = _validar_id(id_ordem_servico, "id da ordem de serviço")

    ordens = _consultar(
        """
        SELECT os.id_ordem_servico, os.id_equipamento, os.id_tecnico, os.id_status_os,
               os.dt_abertura, os.dt_conclusao, os.defeito_relatado,
               c.nome AS cliente, m.nome + ' ' + e.modelo AS equipamento,
               t.nome AS tecnico, s.descricao AS status
        FROM ordem_servico os
        INNER JOIN equipamento e ON e.id_equipamento = os.id_equipamento
        INNER JOIN cliente     c ON c.id_cliente     = e.id_cliente
        INNER JOIN marca       m ON m.id_marca       = e.id_marca
        INNER JOIN status_os   s ON s.id_status_os   = os.id_status_os
        LEFT  JOIN tecnico     t ON t.id_tecnico     = os.id_tecnico
        WHERE os.id_ordem_servico = ?;
        """,
        (id_ordem_servico,),
    )
    if not ordens:
        return None

    ordem = ordens[0]
    ordem["itens"] = _consultar(
        """
        SELECT oss.id_servico, sv.descricao, oss.quantidade, oss.valor_cobrado,
               oss.quantidade * oss.valor_cobrado AS subtotal
        FROM os_servico oss
        INNER JOIN servico sv ON sv.id_servico = oss.id_servico
        WHERE oss.id_ordem_servico = ?
        ORDER BY sv.descricao;
        """,
        (id_ordem_servico,),
    )
    return ordem


# ---------------------------------------------------------------------------
# CREATE
# ---------------------------------------------------------------------------

def inserir_ordem(id_equipamento, id_tecnico, id_status_os, defeito_relatado, itens=None):
    """Insere a OS e seus serviços em uma transação. Retorna o id da nova OS.

    id_tecnico é opcional (OS ainda sem técnico). Se id_status_os for None,
    vale o DEFAULT da tabela (1 = Aberta). dt_abertura recebe GETDATE().
    """
    id_equipamento = _validar_id(id_equipamento, "equipamento")
    id_tecnico = _validar_id(id_tecnico, "técnico", obrigatorio=False)
    id_status_os = _validar_id(id_status_os, "status", obrigatorio=False)
    defeito_relatado = _validar_defeito(defeito_relatado)
    itens = _validar_itens(itens)

    def operacao(cursor):
        if id_status_os is None:
            sql_insert = "INSERT INTO ordem_servico (id_equipamento, id_tecnico, defeito_relatado) VALUES (?, ?, ?);"
            parametros = (id_equipamento, id_tecnico, defeito_relatado)
        else:
            sql_insert = ("INSERT INTO ordem_servico (id_equipamento, id_tecnico, id_status_os, defeito_relatado) "
                          "VALUES (?, ?, ?, ?);")
            parametros = (id_equipamento, id_tecnico, id_status_os, defeito_relatado)

        # SCOPE_IDENTITY() em vez de OUTPUT INSERTED: o SQL Server não aceita OUTPUT sem INTO
        # em tabelas com trigger, e a trigger de histórico de status (issue #9) fica em ordem_servico.
        cursor.execute(f"SET NOCOUNT ON; {sql_insert} SELECT CAST(SCOPE_IDENTITY() AS INT);", parametros)
        while cursor.description is None and cursor.nextset():
            pass
        novo_id = cursor.fetchone()[0]

        _gravar_itens(cursor, novo_id, itens)
        return novo_id

    return _executar_transacao(operacao)


# ---------------------------------------------------------------------------
# UPDATE
# ---------------------------------------------------------------------------

def atualizar_ordem(id_ordem_servico, id_equipamento, id_tecnico, id_status_os,
                    defeito_relatado, dt_conclusao=None, itens=None):
    """Atualiza a OS e regrava a lista de serviços em uma transação.

    dt_conclusao aceita datetime, date, texto ISO (AAAA-MM-DD [HH:MM]) ou None.
    """
    id_ordem_servico = _validar_id(id_ordem_servico, "id da ordem de serviço")
    id_equipamento = _validar_id(id_equipamento, "equipamento")
    id_tecnico = _validar_id(id_tecnico, "técnico", obrigatorio=False)
    id_status_os = _validar_id(id_status_os, "status")
    defeito_relatado = _validar_defeito(defeito_relatado)
    dt_conclusao = _validar_data(dt_conclusao, "data de conclusão")
    itens = _validar_itens(itens)

    def operacao(cursor):
        _garantir_existencia(cursor, id_ordem_servico)

        cursor.execute(
            """
            UPDATE ordem_servico
               SET id_equipamento   = ?,
                   id_tecnico       = ?,
                   id_status_os     = ?,
                   defeito_relatado = ?,
                   dt_conclusao     = ?
             WHERE id_ordem_servico = ?;
            """,
            (id_equipamento, id_tecnico, id_status_os, defeito_relatado, dt_conclusao, id_ordem_servico),
        )

        cursor.execute("DELETE FROM os_servico WHERE id_ordem_servico = ?;", id_ordem_servico)
        _gravar_itens(cursor, id_ordem_servico, itens)

    _executar_transacao(operacao)


# ---------------------------------------------------------------------------
# DELETE
# ---------------------------------------------------------------------------

def excluir_ordem(id_ordem_servico):
    """Exclui a OS e seus dependentes em uma transação.

    Bloqueia a exclusão se a OS tiver pagamento ou garantia (registros financeiros
    e de garantia ao cliente não devem ser apagados). Remove junto os serviços,
    as peças e o histórico de status da OS, que só existem em função dela.
    """
    id_ordem_servico = _validar_id(id_ordem_servico, "id da ordem de serviço")

    def operacao(cursor):
        _garantir_existencia(cursor, id_ordem_servico)

        cursor.execute(
            """
            SELECT (SELECT COUNT(*) FROM pagamento WHERE id_ordem_servico = ?),
                   (SELECT COUNT(*) FROM garantia  WHERE id_ordem_servico = ?);
            """,
            (id_ordem_servico, id_ordem_servico),
        )
        pagamentos, garantias = cursor.fetchone()
        if pagamentos:
            raise ErroOrdemServico("A OS possui pagamento registrado e não pode ser excluída.")
        if garantias:
            raise ErroOrdemServico("A OS possui garantia registrada e não pode ser excluída.")

        for tabela in ("os_servico", "os_peca", "historico_status_os", "ordem_servico"):
            cursor.execute(f"DELETE FROM {tabela} WHERE id_ordem_servico = ?;", id_ordem_servico)

    _executar_transacao(operacao)


# ---------------------------------------------------------------------------
# Combos da interface
# ---------------------------------------------------------------------------

def listar_equipamentos():
    """Equipamentos para o combo da OS: 'Cliente - Marca Modelo (SN ...)'."""
    return _consultar(
        """
        SELECT e.id_equipamento,
               c.nome + ' - ' + m.nome + ' ' + e.modelo
                 + COALESCE(' (SN ' + e.numero_serie + ')', '') AS descricao
        FROM equipamento e
        INNER JOIN cliente c ON c.id_cliente = e.id_cliente
        INNER JOIN marca   m ON m.id_marca   = e.id_marca
        ORDER BY c.nome, m.nome, e.modelo;
        """
    )


def listar_tecnicos():
    """Somente técnicos ativos podem receber novas OS."""
    return _consultar("SELECT id_tecnico, nome FROM tecnico WHERE ativo = 1 ORDER BY nome;")


def listar_status():
    return _consultar("SELECT id_status_os, descricao FROM status_os ORDER BY id_status_os;")


def listar_servicos():
    """Serviços do catálogo; valor_base serve para pré-preencher o valor cobrado na tela."""
    return _consultar("SELECT id_servico, descricao, valor_base FROM servico ORDER BY descricao;")
