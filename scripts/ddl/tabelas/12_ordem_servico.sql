USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: ordem_servico                                         */
/*==============================================================*/
CREATE TABLE ordem_servico (
    id_ordem_servico INT          IDENTITY(1,1) NOT NULL,
    id_equipamento   INT          NOT NULL,
    id_tecnico       SMALLINT     NULL,
    id_status_os     TINYINT      NOT NULL CONSTRAINT df_os_status      DEFAULT (1),
    dt_abertura      DATETIME     NOT NULL CONSTRAINT df_os_dt_abertura DEFAULT (GETDATE()),
    dt_conclusao     DATETIME     NULL,
    defeito_relatado VARCHAR(300) NOT NULL,

    CONSTRAINT pk_ordem_servico   PRIMARY KEY CLUSTERED (id_ordem_servico),
    CONSTRAINT fk_os_equipamento  FOREIGN KEY (id_equipamento) REFERENCES equipamento (id_equipamento),
    CONSTRAINT fk_os_tecnico      FOREIGN KEY (id_tecnico)     REFERENCES tecnico (id_tecnico),
    CONSTRAINT fk_os_status       FOREIGN KEY (id_status_os)   REFERENCES status_os (id_status_os),
    CONSTRAINT ck_os_datas        CHECK (dt_conclusao IS NULL OR dt_conclusao >= dt_abertura)
);
GO
