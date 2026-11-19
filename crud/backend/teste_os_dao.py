"""
Teste de ponta a ponta do backend do CRUD de Ordem de Serviço (issue #13).

Executa SELECT, INSERT, UPDATE e DELETE no banco real e confere, por uma nova
consulta (nova conexão), se cada alteração foi persistida. Também confere se
a validação bloqueia dados inválidos e se nada é gravado quando a transação falha.

Pré-requisitos: banco criado pelo script DDL e populado pelo DML
(é preciso ter ao menos 1 equipamento, 1 técnico ativo e 2 serviços).

Execução (dentro da pasta crud):
    python -m backend.teste_os_dao
"""

from decimal import Decimal

from . import os_dao
from .os_dao import ErroOrdemServico


def verificar(condicao, descricao):
    if not condicao:
        raise AssertionError(f"FALHOU: {descricao}")
    print(f"  [OK] {descricao}")


def main():
    print("1. Leitura dos combos (SELECT)")
    equipamentos = os_dao.listar_equipamentos()
    tecnicos = os_dao.listar_tecnicos()
    status = os_dao.listar_status()
    servicos = os_dao.listar_servicos()
    print(f"  equipamentos={len(equipamentos)} técnicos ativos={len(tecnicos)} "
          f"status={len(status)} serviços={len(servicos)}")
    if not equipamentos or not tecnicos or len(servicos) < 2:
        raise SystemExit("É preciso ter equipamentos, técnicos ativos e ao menos 2 serviços (rode o DML).")

    total_antes = len(os_dao.listar_ordens())
    id_equipamento = equipamentos[0]["id_equipamento"]
    id_tecnico = tecnicos[0]["id_tecnico"]
    servico_a, servico_b = servicos[0], servicos[1]

    print("2. Inserção (INSERT em ordem_servico + os_servico)")
    novo_id = os_dao.inserir_ordem(
        id_equipamento=id_equipamento,
        id_tecnico=None,
        id_status_os=None,  # usa o DEFAULT (1 = Aberta)
        defeito_relatado="Teste automatizado: notebook não liga",
        itens=[{"id_servico": servico_a["id_servico"], "quantidade": 1, "valor_cobrado": servico_a["valor_base"]}],
    )
    ordem = os_dao.obter_ordem(novo_id)
    verificar(ordem is not None, f"OS {novo_id} gravada no banco")
    verificar(ordem["id_status_os"] == 1, "status inicial veio do DEFAULT (1 = Aberta)")
    verificar(ordem["id_tecnico"] is None, "OS aberta sem técnico")
    verificar(len(ordem["itens"]) == 1, "1 serviço gravado em os_servico")
    verificar(len(os_dao.listar_ordens()) == total_antes + 1, "OS aparece na listagem")

    print("3. Atualização (UPDATE em ordem_servico e regravação de os_servico)")
    os_dao.atualizar_ordem(
        id_ordem_servico=novo_id,
        id_equipamento=id_equipamento,
        id_tecnico=id_tecnico,
        id_status_os=status[1]["id_status_os"],
        defeito_relatado="Teste automatizado: notebook não liga (diagnóstico feito)",
        dt_conclusao=None,
        itens=[
            {"id_servico": servico_a["id_servico"], "quantidade": 1, "valor_cobrado": Decimal("99.90")},
            {"id_servico": servico_b["id_servico"], "quantidade": 2, "valor_cobrado": "50,00"},
        ],
    )
    ordem = os_dao.obter_ordem(novo_id)
    verificar(ordem["id_tecnico"] == id_tecnico, "técnico atribuído")
    verificar(ordem["id_status_os"] == status[1]["id_status_os"], "status alterado")
    verificar(ordem["defeito_relatado"].endswith("(diagnóstico feito)"), "defeito relatado alterado")
    verificar(len(ordem["itens"]) == 2, "serviços regravados (2 itens)")
    total = next(o["total"] for o in os_dao.listar_ordens() if o["id_ordem_servico"] == novo_id)
    verificar(total == Decimal("199.90"), f"total da OS calculado na listagem (R$ {total})")

    print("4. Validações e rollback")
    for descricao, chamada in (
        ("defeito vazio é recusado",
         lambda: os_dao.inserir_ordem(id_equipamento, None, None, "   ")),
        ("serviço repetido é recusado",
         lambda: os_dao.inserir_ordem(id_equipamento, None, None, "x", [
             {"id_servico": servico_a["id_servico"], "valor_cobrado": 1},
             {"id_servico": servico_a["id_servico"], "valor_cobrado": 1}])),
        ("equipamento inexistente é recusado (FK)",
         lambda: os_dao.inserir_ordem(2_000_000_000, None, None, "x")),
        ("conclusão anterior à abertura é recusada (CHECK)",
         lambda: os_dao.atualizar_ordem(novo_id, id_equipamento, id_tecnico, 1, "x", "2000-01-01")),
    ):
        try:
            chamada()
            verificar(False, descricao)
        except ErroOrdemServico as erro:
            verificar(True, f"{descricao} -> \"{erro}\"")

    ordem = os_dao.obter_ordem(novo_id)
    verificar(ordem["dt_conclusao"] is None and len(ordem["itens"]) == 2,
              "UPDATE que falhou não alterou nada (rollback)")
    verificar(len(os_dao.listar_ordens()) == total_antes + 1, "INSERTs que falharam não gravaram OS (rollback)")

    print("5. Exclusão (DELETE da OS e dependentes)")
    os_dao.excluir_ordem(novo_id)
    verificar(os_dao.obter_ordem(novo_id) is None, f"OS {novo_id} removida do banco")
    verificar(len(os_dao.listar_ordens()) == total_antes, "listagem voltou ao total inicial")

    print("\nTodos os testes passaram.")


if __name__ == "__main__":
    main()
