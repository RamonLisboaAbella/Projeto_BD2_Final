USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: pagamento                                             */
/*==============================================================*/
-- status: 1 = pendente | 2 = confirmado | 3 = estornado
CREATE TABLE pagamento (
    id_pagamento       INT           IDENTITY(1,1) NOT NULL,
    id_ordem_servico   INT           NOT NULL,
    id_forma_pagamento TINYINT       NOT NULL,
    valor              DECIMAL(10,2) NOT NULL,
    dt_pagamento       DATETIME      NOT NULL CONSTRAINT df_pagamento_dt_pagamento DEFAULT (GETDATE()),
    status             TINYINT       NOT NULL CONSTRAINT df_pagamento_status       DEFAULT (1),

    CONSTRAINT pk_pagamento        PRIMARY KEY CLUSTERED (id_pagamento),
    CONSTRAINT fk_pagamento_os     FOREIGN KEY (id_ordem_servico)   REFERENCES ordem_servico (id_ordem_servico),
    CONSTRAINT fk_pagamento_forma  FOREIGN KEY (id_forma_pagamento) REFERENCES forma_pagamento (id_forma_pagamento),
    CONSTRAINT ck_pagamento_valor  CHECK (valor > 0),
    CONSTRAINT ck_pagamento_status CHECK (status IN (1, 2, 3))
);
GO
