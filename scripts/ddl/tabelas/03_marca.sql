USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: marca                                                 */
/*==============================================================*/
CREATE TABLE marca (
    id_marca SMALLINT    IDENTITY(1,1) NOT NULL,
    nome     VARCHAR(50) NOT NULL,

    CONSTRAINT pk_marca      PRIMARY KEY CLUSTERED (id_marca),
    CONSTRAINT ux_marca_nome UNIQUE (nome)
);
GO
