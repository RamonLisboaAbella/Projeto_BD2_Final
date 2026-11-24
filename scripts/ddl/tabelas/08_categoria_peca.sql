USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: categoria_peca                                        */
/*==============================================================*/
CREATE TABLE categoria_peca (
    id_categoria_peca TINYINT     IDENTITY(1,1) NOT NULL,
    nome              VARCHAR(50) NOT NULL,

    CONSTRAINT pk_categoria_peca      PRIMARY KEY CLUSTERED (id_categoria_peca),
    CONSTRAINT ux_categoria_peca_nome UNIQUE (nome)
);
GO
