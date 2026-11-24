USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: equipamento                                           */
/*==============================================================*/
CREATE TABLE equipamento (
    id_equipamento      INT          IDENTITY(1,1) NOT NULL,
    id_cliente          INT          NOT NULL,
    id_tipo_equipamento TINYINT      NOT NULL,
    id_marca            SMALLINT     NOT NULL,
    modelo              VARCHAR(60)  NOT NULL,
    numero_serie        VARCHAR(50)  NULL,
    dt_cadastro         DATE         NOT NULL CONSTRAINT df_equipamento_dt_cadastro DEFAULT (CAST(GETDATE() AS DATE)),
    observacao          VARCHAR(200) NULL,

    CONSTRAINT pk_equipamento         PRIMARY KEY CLUSTERED (id_equipamento),
    CONSTRAINT fk_equipamento_cliente FOREIGN KEY (id_cliente)          REFERENCES cliente (id_cliente),
    CONSTRAINT fk_equipamento_tipo    FOREIGN KEY (id_tipo_equipamento) REFERENCES tipo_equipamento (id_tipo_equipamento),
    CONSTRAINT fk_equipamento_marca   FOREIGN KEY (id_marca)            REFERENCES marca (id_marca)
);
GO

-- número de série é opcional: o índice único filtrado permite vários NULL
-- (uma constraint UNIQUE comum aceitaria só UM equipamento sem número de série)
CREATE UNIQUE NONCLUSTERED INDEX ux_equipamento_numero_serie
    ON equipamento (numero_serie)
    WHERE numero_serie IS NOT NULL;
GO
