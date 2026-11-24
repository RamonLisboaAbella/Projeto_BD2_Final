USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: servico                                               */
/*==============================================================*/
CREATE TABLE servico (
    id_servico         SMALLINT      IDENTITY(1,1) NOT NULL,
    descricao          VARCHAR(100)  NOT NULL,
    valor_base         DECIMAL(10,2) NOT NULL,
    tempo_estimado_min SMALLINT      NULL,

    CONSTRAINT pk_servico           PRIMARY KEY CLUSTERED (id_servico),
    CONSTRAINT ux_servico_descricao UNIQUE (descricao),
    CONSTRAINT ck_servico_valor     CHECK (valor_base >= 0),
    CONSTRAINT ck_servico_tempo     CHECK (tempo_estimado_min IS NULL OR tempo_estimado_min > 0)
);
GO
