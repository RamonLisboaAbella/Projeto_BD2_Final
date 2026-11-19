"""
Conexão com o banco de dados SQL Server do projeto (manutencao_computadores).

A configuração é feita por variáveis de ambiente, para que cada integrante
rode na própria máquina sem alterar o código:

    BD_SERVIDOR  servidor/instância do SQL Server (padrão: localhost)
                 ex.: localhost, localhost\\SQLEXPRESS, (localdb)\\MSSQLLocalDB
    BD_BANCO     nome do banco (padrão: manutencao_computadores)
    BD_USUARIO   usuário SQL; se vazio, usa a autenticação do Windows
    BD_SENHA     senha do usuário SQL
    BD_DRIVER    driver ODBC; se vazio, escolhe automaticamente o mais novo instalado
"""

import os

import pyodbc

DRIVERS_PREFERIDOS = (
    "ODBC Driver 18 for SQL Server",
    "ODBC Driver 17 for SQL Server",
    "SQL Server",
)


def _escolher_driver():
    driver = os.getenv("BD_DRIVER")
    if driver:
        return driver

    instalados = pyodbc.drivers()
    for nome in DRIVERS_PREFERIDOS:
        if nome in instalados:
            return nome

    raise RuntimeError(
        "Nenhum driver ODBC do SQL Server foi encontrado. Instale o "
        "'ODBC Driver 18 for SQL Server' ou informe o driver em BD_DRIVER."
    )


def montar_string_conexao():
    driver = _escolher_driver()
    partes = [
        f"DRIVER={{{driver}}}",
        f"SERVER={os.getenv('BD_SERVIDOR', 'localhost')}",
        f"DATABASE={os.getenv('BD_BANCO', 'manutencao_computadores')}",
    ]

    usuario = os.getenv("BD_USUARIO")
    if usuario:
        partes.append(f"UID={usuario}")
        partes.append(f"PWD={os.getenv('BD_SENHA', '')}")
    else:
        partes.append("Trusted_Connection=yes")

    # O driver 18 exige criptografia por padrão; em ambiente local o
    # certificado do SQL Server costuma ser autoassinado.
    if driver.startswith("ODBC Driver 18"):
        partes.append("TrustServerCertificate=yes")

    return ";".join(partes) + ";"


def obter_conexao():
    """Abre uma nova conexão com controle manual de transação (autocommit desligado)."""
    return pyodbc.connect(montar_string_conexao(), autocommit=False)
