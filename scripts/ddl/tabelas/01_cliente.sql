USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: cliente                                               */
/*==============================================================*/
CREATE TABLE cliente (
    id_cliente   INT           IDENTITY(1,1) NOT NULL,
    nome         VARCHAR(100)  NOT NULL,
    cpf          CHAR(11)      NOT NULL,
    email        VARCHAR(100)  NULL,
    telefone     VARCHAR(15)   NULL,
    dt_cadastro  DATE          NOT NULL CONSTRAINT df_cliente_dt_cadastro DEFAULT (CAST(GETDATE() AS DATE)),

    CONSTRAINT pk_cliente       PRIMARY KEY CLUSTERED (id_cliente),
    CONSTRAINT ux_cliente_cpf   UNIQUE (cpf),
    CONSTRAINT ck_cliente_cpf   CHECK (cpf NOT LIKE '%[^0-9]%'),
    CONSTRAINT ck_cliente_email CHECK (email IS NULL OR email LIKE '%_@_%._%')
);
GO
