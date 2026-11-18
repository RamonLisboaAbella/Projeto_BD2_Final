USE manutencao_computadores;
GO

DELETE FROM dbo.garantia;
DELETE FROM dbo.historico_status_os;
DELETE FROM dbo.pagamento;
DELETE FROM dbo.os_peca;
DELETE FROM dbo.os_servico;
DELETE FROM dbo.ordem_servico;
DELETE FROM dbo.equipamento;
DELETE FROM dbo.peca;
DELETE FROM dbo.forma_pagamento;
DELETE FROM dbo.categoria_peca;
DELETE FROM dbo.fornecedor;
DELETE FROM dbo.servico;
DELETE FROM dbo.tecnico;
DELETE FROM dbo.status_os;
DELETE FROM dbo.marca;
DELETE FROM dbo.tipo_equipamento;
DELETE FROM dbo.cliente;
GO

IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.garantia')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.garantia', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.historico_status_os')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.historico_status_os', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.pagamento')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.pagamento', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.ordem_servico')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.ordem_servico', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.equipamento')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.equipamento', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.peca')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.peca', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.forma_pagamento')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.forma_pagamento', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.categoria_peca')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.categoria_peca', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.fornecedor')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.fornecedor', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.servico')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.servico', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.tecnico')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.tecnico', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.status_os')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.status_os', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.marca')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.marca', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.tipo_equipamento')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.tipo_equipamento', RESEED, 0);
IF (SELECT last_value FROM sys.identity_columns WHERE object_id = OBJECT_ID('dbo.cliente')) IS NOT NULL
    DBCC CHECKIDENT ('dbo.cliente', RESEED, 0);
GO
