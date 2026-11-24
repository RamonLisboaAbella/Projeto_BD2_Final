USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: os_peca                                               */
/*==============================================================*/
CREATE TABLE os_peca (
    id_ordem_servico INT           NOT NULL,
    id_peca          INT           NOT NULL,
    quantidade       SMALLINT      NOT NULL CONSTRAINT df_os_peca_quantidade DEFAULT (1),
    preco_unitario   DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_os_peca            PRIMARY KEY CLUSTERED (id_ordem_servico, id_peca),
    CONSTRAINT fk_os_peca_os         FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico (id_ordem_servico),
    CONSTRAINT fk_os_peca_peca       FOREIGN KEY (id_peca)          REFERENCES peca (id_peca),
    CONSTRAINT ck_os_peca_quantidade CHECK (quantidade > 0),
    CONSTRAINT ck_os_peca_preco      CHECK (preco_unitario >= 0)
);
GO
