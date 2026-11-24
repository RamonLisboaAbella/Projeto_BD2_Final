USE manutencao_computadores;
GO

/*==============================================================*/
/* Table: forma_pagamento                                       */
/*==============================================================*/
CREATE TABLE forma_pagamento (
    id_forma_pagamento TINYINT     IDENTITY(1,1) NOT NULL,
    descricao          VARCHAR(30) NOT NULL,

    CONSTRAINT pk_forma_pagamento           PRIMARY KEY CLUSTERED (id_forma_pagamento),
    CONSTRAINT ux_forma_pagamento_descricao UNIQUE (descricao)
);
GO
