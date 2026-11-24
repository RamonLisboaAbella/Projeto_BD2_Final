USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: tipo_equipamento                                      */
/*==============================================================*/
CREATE TABLE tipo_equipamento (
    id_tipo_equipamento TINYINT     IDENTITY(1,1) NOT NULL,
    nome                VARCHAR(30) NOT NULL,

    CONSTRAINT pk_tipo_equipamento      PRIMARY KEY CLUSTERED (id_tipo_equipamento),
    CONSTRAINT ux_tipo_equipamento_nome UNIQUE (nome)
);
GO
