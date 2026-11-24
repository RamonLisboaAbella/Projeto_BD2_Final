/*==============================================================*/
/* Database: manutencao_computadores                            */
/*==============================================================*/
/* Executar antes dos demais arquivos desta pasta, na ordem     */
/* numérica (01 a 17), por causa das chaves estrangeiras.       */
/*==============================================================*/
IF DB_ID('manutencao_computadores') IS NULL
    CREATE DATABASE manutencao_computadores;
GO

USE manutencao_computadores;
GO

-- Remove as tabelas (ordem inversa das dependências) para que o
-- DDL possa ser executado novamente do início ao fim
DROP TABLE IF EXISTS garantia;
DROP TABLE IF EXISTS historico_status_os;
DROP TABLE IF EXISTS pagamento;
DROP TABLE IF EXISTS forma_pagamento;
DROP TABLE IF EXISTS os_peca;
DROP TABLE IF EXISTS peca;
DROP TABLE IF EXISTS categoria_peca;
DROP TABLE IF EXISTS fornecedor;
DROP TABLE IF EXISTS os_servico;
DROP TABLE IF EXISTS servico;
DROP TABLE IF EXISTS ordem_servico;
DROP TABLE IF EXISTS tecnico;
DROP TABLE IF EXISTS status_os;
DROP TABLE IF EXISTS equipamento;
DROP TABLE IF EXISTS marca;
DROP TABLE IF EXISTS tipo_equipamento;
DROP TABLE IF EXISTS cliente;
GO
