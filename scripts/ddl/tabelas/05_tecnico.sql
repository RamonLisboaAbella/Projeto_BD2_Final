USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: tecnico                                               */
/*==============================================================*/
CREATE TABLE tecnico (
    id_tecnico    SMALLINT     IDENTITY(1,1) NOT NULL,
    nome          VARCHAR(100) NOT NULL,
    cpf           CHAR(11)     NOT NULL,
    especialidade VARCHAR(50)  NULL,
    dt_admissao   DATE         NOT NULL,
    ativo         BIT          NOT NULL CONSTRAINT df_tecnico_ativo DEFAULT (1),

    CONSTRAINT pk_tecnico     PRIMARY KEY CLUSTERED (id_tecnico),
    CONSTRAINT ux_tecnico_cpf UNIQUE (cpf),
    CONSTRAINT ck_tecnico_cpf CHECK (cpf NOT LIKE '%[^0-9]%')
);
GO
