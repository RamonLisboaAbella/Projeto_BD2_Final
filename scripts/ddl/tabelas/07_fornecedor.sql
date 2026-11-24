USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: fornecedor                                            */
/*==============================================================*/
CREATE TABLE fornecedor (
    id_fornecedor INT          IDENTITY(1,1) NOT NULL,
    nome          VARCHAR(100) NOT NULL,
    cnpj          CHAR(14)     NOT NULL,
    telefone      VARCHAR(15)  NULL,
    email         VARCHAR(150) NULL,
    endereco      VARCHAR(150) NULL,
    estado        CHAR(2)      NULL,
    dt_cadastro   DATE         NOT NULL CONSTRAINT df_fornecedor_dt_cadastro DEFAULT (CAST(GETDATE() AS DATE)),

    CONSTRAINT pk_fornecedor        PRIMARY KEY CLUSTERED (id_fornecedor),
    CONSTRAINT ux_fornecedor_cnpj   UNIQUE (cnpj),
    CONSTRAINT ck_fornecedor_cnpj   CHECK (cnpj NOT LIKE '%[^0-9]%'),
    CONSTRAINT ck_fornecedor_estado CHECK (estado IS NULL OR estado LIKE '[A-Z][A-Z]'),
    CONSTRAINT ck_fornecedor_email  CHECK (email IS NULL OR email LIKE '%_@_%._%')
);
GO
