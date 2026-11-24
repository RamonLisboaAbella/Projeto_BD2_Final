USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: garantia                                              */
/*==============================================================*/
CREATE TABLE garantia (
    id_garantia      INT          IDENTITY(1,1) NOT NULL,
    id_ordem_servico INT          NOT NULL,
    dt_inicio        DATE         NOT NULL CONSTRAINT df_garantia_dt_inicio  DEFAULT (CAST(GETDATE() AS DATE)),
    prazo_dias       SMALLINT     NOT NULL CONSTRAINT df_garantia_prazo_dias DEFAULT (90),
    cobertura        VARCHAR(200) NULL,

    CONSTRAINT pk_garantia        PRIMARY KEY CLUSTERED (id_garantia),
    CONSTRAINT fk_garantia_os     FOREIGN KEY (id_ordem_servico) REFERENCES ordem_servico (id_ordem_servico),
    CONSTRAINT ux_garantia_os     UNIQUE (id_ordem_servico),
    CONSTRAINT ck_garantia_prazo  CHECK (prazo_dias BETWEEN 1 AND 365)
);
GO
