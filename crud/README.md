# CRUD – Ordem de Serviço

Aplicação com interface gráfica para manipular as ordens de serviço do banco `manutencao_computadores` (issue #13).

- **Tabela do CRUD:** `ordem_servico`, com os serviços da OS (`os_servico`) editados no mesmo formulário (mestre-detalhe).
- **Tabelas de apoio (combos):** `equipamento`, `tecnico`, `status_os` e `servico`.
- **Stack:** Python 3 + Tkinter/ttk (interface) + pyodbc (SQL Server).

## Estrutura

```
crud/
├── requirements.txt
├── README.md
└── backend/
    ├── conexao.py       # configuração da conexão com o SQL Server
    ├── os_dao.py        # SELECT, INSERT, UPDATE e DELETE (funções usadas pela interface)
    └── teste_os_dao.py  # teste de persistência das operações no banco
```

## Configuração

1. Criar o banco com o script DDL e popular com o script DML (pasta `scripts/`).
2. Instalar o driver ODBC do SQL Server (recomendado: [ODBC Driver 18 for SQL Server](https://learn.microsoft.com/sql/connect/odbc/download-odbc-driver-for-sql-server)).
3. Instalar as dependências (dentro da pasta `crud`):

   ```bash
   pip install -r requirements.txt
   ```

4. Configurar a conexão por variáveis de ambiente (todas opcionais):

   | Variável | Padrão | Descrição |
   | :--- | :--- | :--- |
   | `BD_SERVIDOR` | `localhost` | Servidor/instância (ex.: `localhost\SQLEXPRESS`, `(localdb)\MSSQLLocalDB`) |
   | `BD_BANCO` | `manutencao_computadores` | Nome do banco |
   | `BD_USUARIO` / `BD_SENHA` | vazio | Usuário SQL; se vazio, usa a autenticação do Windows |
   | `BD_DRIVER` | automático | Driver ODBC (escolhe o mais novo instalado) |

   Exemplo no PowerShell: `$env:BD_SERVIDOR = "localhost\SQLEXPRESS"`

## Teste do backend

Executa INSERT, SELECT, UPDATE e DELETE no banco e confere se cada alteração foi gravada:

```bash
python -m backend.teste_os_dao
```

## Funções do backend (`backend/os_dao.py`)

| Função | Operação |
| :--- | :--- |
| `listar_ordens()` | SELECT com JOIN: OS, cliente, equipamento, técnico, status, abertura, conclusão e total (serviços + peças) |
| `obter_ordem(id_ordem_servico)` | SELECT da OS + lista `itens` com os serviços; retorna `None` se não existir |
| `inserir_ordem(id_equipamento, id_tecnico, id_status_os, defeito_relatado, itens)` | INSERT da OS e dos serviços em uma transação; retorna o id criado |
| `atualizar_ordem(id_ordem_servico, id_equipamento, id_tecnico, id_status_os, defeito_relatado, dt_conclusao, itens)` | UPDATE da OS e regravação dos serviços em uma transação |
| `excluir_ordem(id_ordem_servico)` | DELETE dos serviços, peças, histórico e da OS; bloqueia se houver pagamento ou garantia |
| `listar_equipamentos()`, `listar_tecnicos()`, `listar_status()`, `listar_servicos()` | SELECTs para os combos (técnicos: somente ativos) |

- `itens` = lista de `{"id_servico": int, "quantidade": int, "valor_cobrado": Decimal | str | float}`; o total do item é `quantidade x valor_cobrado`.
- `id_tecnico` é opcional; com `id_status_os=None` na inserção vale o DEFAULT da tabela (1 = Aberta); `dt_conclusao` aceita `datetime`, `date`, texto `AAAA-MM-DD [HH:MM]` ou `None`.
- Em caso de dado inválido ou erro do banco, as funções lançam `ErroOrdemServico` com uma mensagem pronta para mostrar na tela (ex.: `messagebox.showerror("Erro", str(erro))`).
