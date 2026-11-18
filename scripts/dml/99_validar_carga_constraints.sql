USE manutencao_computadores;
GO

DBCC CHECKCONSTRAINTS WITH ALL_CONSTRAINTS, ALL_ERRORMSGS;
GO

SELECT 'categoria_peca' AS tabela, COUNT(*) AS total_registros FROM dbo.categoria_peca
UNION ALL
SELECT 'cliente', COUNT(*) FROM dbo.cliente
UNION ALL
SELECT 'equipamento', COUNT(*) FROM dbo.equipamento
UNION ALL
SELECT 'forma_pagamento', COUNT(*) FROM dbo.forma_pagamento
UNION ALL
SELECT 'fornecedor', COUNT(*) FROM dbo.fornecedor
UNION ALL
SELECT 'garantia', COUNT(*) FROM dbo.garantia
UNION ALL
SELECT 'historico_status_os', COUNT(*) FROM dbo.historico_status_os
UNION ALL
SELECT 'marca', COUNT(*) FROM dbo.marca
UNION ALL
SELECT 'ordem_servico', COUNT(*) FROM dbo.ordem_servico
UNION ALL
SELECT 'os_peca', COUNT(*) FROM dbo.os_peca
UNION ALL
SELECT 'os_servico', COUNT(*) FROM dbo.os_servico
UNION ALL
SELECT 'pagamento', COUNT(*) FROM dbo.pagamento
UNION ALL
SELECT 'peca', COUNT(*) FROM dbo.peca
UNION ALL
SELECT 'servico', COUNT(*) FROM dbo.servico
UNION ALL
SELECT 'status_os', COUNT(*) FROM dbo.status_os
UNION ALL
SELECT 'tecnico', COUNT(*) FROM dbo.tecnico
UNION ALL
SELECT 'tipo_equipamento', COUNT(*) FROM dbo.tipo_equipamento
ORDER BY tabela;
GO

SELECT id_status_os, descricao
FROM dbo.status_os
WHERE id_status_os = 1;
GO

SELECT OBJECT_NAME(parent_object_id) AS tabela, name AS constraint_nome, type_desc AS tipo
FROM sys.key_constraints
UNION ALL
SELECT OBJECT_NAME(parent_object_id), name, 'FOREIGN_KEY_CONSTRAINT'
FROM sys.foreign_keys
WHERE is_disabled = 0 AND is_not_trusted = 0
UNION ALL
SELECT OBJECT_NAME(parent_object_id), name, 'CHECK_CONSTRAINT'
FROM sys.check_constraints
WHERE is_disabled = 0 AND is_not_trusted = 0
UNION ALL
SELECT OBJECT_NAME(parent_object_id), name, 'DEFAULT_CONSTRAINT'
FROM sys.default_constraints
ORDER BY tabela, tipo, constraint_nome;
GO
