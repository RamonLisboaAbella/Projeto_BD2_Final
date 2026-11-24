USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: historico_status_os                                   */
/*==============================================================*/
CREATE TABLE historico_status_os (
    id_historico       INT      IDENTITY(1,1) NOT NULL,
    id_ordem_servico   INT      NOT NULL,
    id_status_anterior TINYINT  NULL,
    id_status_novo     TINYINT  NOT NULL,
    dt_alteracao       DATETIME NOT NULL CONSTRAINT df_historico_dt_alteracao DEFAULT (GETDATE()),

    CONSTRAINT pk_historico_status_os       PRIMARY KEY CLUSTERED (id_historico),
    CONSTRAINT fk_historico_os              FOREIGN KEY (id_ordem_servico)   REFERENCES ordem_servico (id_ordem_servico),
    CONSTRAINT fk_historico_status_anterior FOREIGN KEY (id_status_anterior) REFERENCES status_os (id_status_os),
    CONSTRAINT fk_historico_status_novo     FOREIGN KEY (id_status_novo)     REFERENCES status_os (id_status_os),
    CONSTRAINT ck_historico_status_mudou    CHECK (id_status_anterior IS NULL OR id_status_anterior <> id_status_novo)
);
GO
