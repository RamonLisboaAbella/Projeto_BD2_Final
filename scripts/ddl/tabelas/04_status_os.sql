USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: status_os                                             */
/*==============================================================*/
-- O id 1 deve ser o status inicial ("Aberta"): é o DEFAULT de ordem_servico
CREATE TABLE status_os (
    id_status_os TINYINT     IDENTITY(1,1) NOT NULL,
    descricao    VARCHAR(30) NOT NULL,

    CONSTRAINT pk_status_os           PRIMARY KEY CLUSTERED (id_status_os),
    CONSTRAINT ux_status_os_descricao UNIQUE (descricao)
);
GO
