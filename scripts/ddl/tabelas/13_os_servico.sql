USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: os_servico                                            */
/*==============================================================*/
CREATE TABLE os_servico (
    id_ordem_servico INT           NOT NULL,
    id_servico       SMALLINT      NOT NULL,
    quantidade       TINYINT       NOT NULL CONSTRAINT df_os_servico_quantidade DEFAULT (1),
    valor_cobrado    DECIMAL(10,2) NOT NULL,

    CONSTRAINT pk_os_servico            PRIMARY KEY CLUSTERED (id_ordem_servico, id_servico),
    CONSTRAINT fk_os_servico_os         FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico (id_ordem_servico),
    CONSTRAINT fk_os_servico_servico    FOREIGN KEY (id_servico)       REFERENCES servico (id_servico),
    CONSTRAINT ck_os_servico_quantidade CHECK (quantidade > 0),
    CONSTRAINT ck_os_servico_valor      CHECK (valor_cobrado >= 0)
);
GO
