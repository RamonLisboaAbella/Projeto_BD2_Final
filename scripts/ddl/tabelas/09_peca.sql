USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: peca                                                  */
/*==============================================================*/
CREATE TABLE peca (
    id_peca           INT           IDENTITY(1,1) NOT NULL,
    id_fornecedor     INT           NOT NULL,
    id_categoria_peca TINYINT       NOT NULL,
    nome              VARCHAR(100)  NOT NULL,
    preco             DECIMAL(10,2) NOT NULL,
    estoque_atual     INT           NOT NULL CONSTRAINT df_peca_estoque_atual  DEFAULT (0),
    estoque_minimo    INT           NOT NULL CONSTRAINT df_peca_estoque_minimo DEFAULT (0),
    dt_cadastro       DATE          NOT NULL CONSTRAINT df_peca_dt_cadastro    DEFAULT (CAST(GETDATE() AS DATE)),

    CONSTRAINT pk_peca                PRIMARY KEY CLUSTERED (id_peca),
    CONSTRAINT fk_peca_fornecedor     FOREIGN KEY (id_fornecedor)     REFERENCES fornecedor (id_fornecedor),
    CONSTRAINT fk_peca_categoria      FOREIGN KEY (id_categoria_peca) REFERENCES categoria_peca (id_categoria_peca),
    CONSTRAINT ck_peca_preco          CHECK (preco >= 0),
    CONSTRAINT ck_peca_estoque        CHECK (estoque_atual >= 0),
    CONSTRAINT ck_peca_estoque_minimo CHECK (estoque_minimo >= 0)
);
GO
