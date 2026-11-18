USE manutencao_computadores;
GO

SET IDENTITY_INSERT cliente ON;
GO
INSERT INTO cliente (id_cliente, nome, cpf, email, telefone, dt_cadastro) VALUES
    (1, 'Lucas Eduardo Mendes', '41829365070', 'lucas.mendes@gmail.com', '48991243810', '2024-03-12'),
    (2, 'Mariana Costa Silveira', '73491820588', 'mariana.silveira@hotmail.com', '48996127405', '2024-04-08'),
    (3, 'Carlos Henrique Becker', '29560481711', 'carlos.becker@gmail.com', '48988312094', '2024-05-19'),
    (4, 'Fernanda Oliveira Rocha', '86142059370', 'fernanda.rocha@outlook.com', '48999456120', '2024-06-03'),
    (5, 'Thiago Augusto Cardoso', '50917384288', 'thiago.cardoso@gmail.com', '48991875342', '2024-07-15'),
    (6, 'Juliana Pereira Nunes', '14785932619', 'juliana.nunes@yahoo.com.br', '48998231476', '2024-08-22'),
    (7, 'Bruno Rafael Machado', '68239410570', 'bruno.machado@gmail.com', '48996548821', '2024-09-10'),
    (8, 'Aline Cristina Zanetti', '92351746864', 'aline.zanetti@gmail.com', '48991023398', '2024-10-05'),
    (9, 'Diego Felipe Bortoluzzi', '35806294170', 'diego.bortoluzzi@outlook.com', '48984197750', '2024-11-14'),
    (10, 'Camila Rodrigues Teixeira', '61472908350', 'camila.teixeira@gmail.com', '48999304612', '2024-12-02'),
    (11, 'Gustavo Almeida Ferreira', '07943851684', 'gustavo.ferreira@hotmail.com', '48991762984', '2025-01-18'),
    (12, 'Patrícia Souza Vieira', '54190627801', 'patricia.vieira@gmail.com', '48998415503', '2025-02-09'),
    (13, 'Eduardo Martins Dal Pont', '83625179482', 'eduardo.dalpont@gmail.com', '48996081937', '2025-03-21'),
    (14, 'Larissa Gomes Barbosa', '26481593042', 'larissa.barbosa@outlook.com', '48991336429', '2025-04-11'),
    (15, 'Vinícius Santos Ribeiro', '79034618269', 'vinicius.ribeiro@gmail.com', '48988749015', '2025-05-27'),
    (16, 'Beatriz Lopes Fernandes', '45318760910', 'beatriz.fernandes@gmail.com', '48999123784', '2025-06-16'),
    (17, 'Matheus Henrique Duarte', '91862043515', 'matheus.duarte@hotmail.com', '48996478210', '2025-07-04'),
    (18, 'Renata Carvalho Medeiros', '30759281432', 'renata.medeiros@gmail.com', '48991594063', '2025-08-19'),
    (19, 'Fábio Júnior Bastos', '67204195876', NULL, '48984621190', '2025-09-07'),
    (20, 'Vanessa Dias Gonçalves', '18593470297', 'vanessa.goncalves@outlook.com', NULL, '2025-10-23'),
    (21, 'Rodrigo César Nogueira', '52976038465', 'rodrigo.nogueira@gmail.com', '47991426809', '2025-11-15'),
    (22, 'Tatiane Freitas Monteiro', '84610925702', 'tatiane.monteiro@gmail.com', '48996214930', '2026-01-12'),
    (23, 'Henrique Morais Antunes', '09348261533', 'henrique.antunes@gmail.com', '48999742258', '2026-02-20'),
    (24, 'Bianca Castro Siqueira', '71582304904', 'bianca.siqueira@hotmail.com', '48991908416', DEFAULT),
    (25, 'André Luiz Bitencourt', '36027491850', 'andre.bitencourt@gmail.com', '48988153672', DEFAULT);
GO
SET IDENTITY_INSERT cliente OFF;
GO

SET IDENTITY_INSERT tipo_equipamento ON;
GO
INSERT INTO tipo_equipamento (id_tipo_equipamento, nome) VALUES
    (1, 'Notebook'),
    (2, 'Desktop'),
    (3, 'All-in-One'),
    (4, 'Workstation'),
    (5, 'Mini PC'),
    (6, 'Ultrabook'),
    (7, 'Notebook Gamer'),
    (8, 'PC Gamer'),
    (9, 'MacBook'),
    (10, 'iMac'),
    (11, 'Mac Mini'),
    (12, 'Chromebook'),
    (13, 'Servidor Torre'),
    (14, 'Servidor Rack'),
    (15, 'Netbook'),
    (16, 'Thin Client'),
    (17, 'Tablet Windows'),
    (18, 'Computador Industrial'),
    (19, 'Terminal PDV'),
    (20, 'Barebone');
GO
SET IDENTITY_INSERT tipo_equipamento OFF;
GO

SET IDENTITY_INSERT marca ON;
GO
INSERT INTO marca (id_marca, nome) VALUES
    (1, 'Dell'),
    (2, 'Lenovo'),
    (3, 'HP'),
    (4, 'Acer'),
    (5, 'Asus'),
    (6, 'Apple'),
    (7, 'Samsung'),
    (8, 'Positivo'),
    (9, 'Avell'),
    (10, 'MSI'),
    (11, 'Gigabyte'),
    (12, 'Vaio'),
    (13, 'LG'),
    (14, 'Multilaser'),
    (15, 'Compaq'),
    (16, 'Alienware'),
    (17, 'Razer'),
    (18, 'Toshiba'),
    (19, 'Fujitsu'),
    (20, 'Montado / Personalizado');
GO
SET IDENTITY_INSERT marca OFF;
GO

SET IDENTITY_INSERT status_os ON;
GO
INSERT INTO status_os (id_status_os, descricao) VALUES
    (1, 'Aberta'),
    (2, 'Em Análise'),
    (3, 'Aguardando Aprovação'),
    (4, 'Aguardando Peça'),
    (5, 'Em Reparo'),
    (6, 'Em Testes'),
    (7, 'Pronta para Retirada'),
    (8, 'Concluída'),
    (9, 'Cancelada'),
    (10, 'Aguardando Diagnóstico'),
    (11, 'Orçamento Enviado'),
    (12, 'Orçamento Aprovado'),
    (13, 'Orçamento Recusado'),
    (14, 'Em Limpeza Preventiva'),
    (15, 'Em Backup de Dados'),
    (16, 'Aguardando Pagamento'),
    (17, 'Em Garantia'),
    (18, 'Retorno de Garantia'),
    (19, 'Enviada a Terceirizada'),
    (20, 'Sem Reparo');
GO
SET IDENTITY_INSERT status_os OFF;
GO

SET IDENTITY_INSERT tecnico ON;
GO
INSERT INTO tecnico (id_tecnico, nome, cpf, especialidade, dt_admissao, ativo) VALUES
    (1, 'Rafael Augusto Colombo', '04829173696', 'Hardware e Placa-Mãe', '2021-02-10', 1),
    (2, 'Gabriel Henrique De Bona', '59173820423', 'Notebooks e Microeletrônica', '2021-06-15', 1),
    (3, 'Marcos Vinícius Rosso', '82406519333', 'Software e Sistemas Operacionais', '2022-01-20', 1),
    (4, 'Daniela Aparecida Moro', '31759402850', 'Recuperação de Dados', '2022-04-04', 1),
    (5, 'Leonardo José Milanez', '65041987211', 'PC Gamer e Alta Performance', '2022-08-12', 1),
    (6, 'Paulo Roberto Gava', '19384260533', 'Redes e Servidores', '2022-11-01', 1),
    (7, 'Camila Beatriz Ronchi', '74290531814', 'Equipamentos Apple', '2023-02-14', 1),
    (8, 'Felipe Eduardo Cechinel', '40618392769', 'Hardware e Upgrades', '2023-05-08', 1),
    (9, 'João Pedro Spillere', '93527048197', 'Notebooks e Telas', '2023-07-19', 1),
    (10, 'Amanda Cristina Dagostim', '27864153909', 'Software e Remoção de Malware', '2023-10-02', 1),
    (11, 'Igor Mateus Zanoni', '61905382405', 'Placa-Mãe e Solda SMD', '2024-01-15', 1),
    (12, 'Natália Fernanda Pierini', '08472619567', 'Diagnóstico e Manutenção Preventiva', '2024-03-18', 1),
    (13, 'Ricardo Alexandre Pavei', '53190846251', 'Workstations e Servidores', '2024-06-10', 1),
    (14, 'Vitor Hugo Maragno', '86731420913', 'Hardware e Fontes', '2024-09-02', 1),
    (15, 'Sabrina Lúcia Feltrin', '42085971350', 'Sistemas Corporativos e Backup', '2025-01-13', 1),
    (16, 'Murilo César Búrigo', '75319204680', 'Notebooks e Carcaças', '2025-04-07', 1),
    (17, 'Letícia Maria Bez', '18946035242', 'Atendimento Técnico e Triagem', '2025-08-01', DEFAULT),
    (18, 'Sérgio Antônio Meller', '60273581902', 'Hardware Geral', '2020-05-11', 0),
    (19, 'Renan Oliveira Darós', '34598127023', 'Software e Redes', '2021-09-06', 0),
    (20, 'Cláudio Henrique Savio', '91402763840', NULL, '2022-03-21', 0);
GO
SET IDENTITY_INSERT tecnico OFF;
GO

SET IDENTITY_INSERT servico ON;
GO
INSERT INTO servico (id_servico, descricao, valor_base, tempo_estimado_min) VALUES
    (1, 'Formatação com Backup de Dados', 180.00, 120),
    (2, 'Formatação Simples de Sistema Operacional', 120.00, 90),
    (3, 'Limpeza Interna Completa e Troca de Pasta Térmica', 150.00, 90),
    (4, 'Substituição de SSD ou HD com Clonagem', 160.00, 90),
    (5, 'Instalação e Upgrade de Memória RAM', 70.00, 30),
    (6, 'Troca de Tela Display de Notebook', 220.00, 120),
    (7, 'Troca de Teclado de Notebook', 140.00, 90),
    (8, 'Substituição de Bateria Interna de Notebook', 100.00, 45),
    (9, 'Reparo Eletrônico em Placa-Mãe', 380.00, 300),
    (10, 'Troca de Conector de Energia DC Jack', 190.00, 150),
    (11, 'Reparo de Dobradiça e Reconstrução de Carcaça', 210.00, 180),
    (12, 'Remoção de Vírus e Otimização do Sistema', 110.00, 60),
    (13, 'Diagnóstico Técnico Avançado de Hardware', 80.00, 60),
    (14, 'Recuperação de Dados Nível 1 (Lógica)', 250.00, 180),
    (15, 'Recuperação de Dados Avançada', 480.00, 360),
    (16, 'Montagem Completa de Desktop ou PC Gamer', 260.00, 180),
    (17, 'Atualização de BIOS e Upgrade de Processador', 170.00, 90),
    (18, 'Troca e Teste de Fonte de Alimentação', 95.00, 45),
    (19, 'Configuração de Rede Local, Wi-Fi e Drivers', 130.00, 60),
    (20, 'Instalação e Configuração de Pacote Corporativo', 145.00, 75);
GO
SET IDENTITY_INSERT servico OFF;
GO

SET IDENTITY_INSERT fornecedor ON;
GO
INSERT INTO fornecedor (id_fornecedor, nome, cnpj, telefone, email, endereco, estado, dt_cadastro) VALUES
    (1, 'SulTech Distribuidora de Informática Ltda', '27481930000160', '4834331020', 'vendas@sultechdist.com.br', 'Av. Centenário, 1450 - Centro, Criciúma', 'SC', '2023-02-10'),
    (2, 'Catarina Componentes Eletrônicos S.A.', '14905283000125', '4832245510', 'comercial@catarinacomp.com.br', 'Rua Felipe Schmidt, 812 - Centro, Florianópolis', 'SC', '2023-03-18'),
    (3, 'MegaParts Hardware Brasil Ltda', '38614029000136', '1130914400', 'pedidos@megapartsbr.com.br', 'Av. Paulista, 2100 - Bela Vista, São Paulo', 'SP', '2023-04-25'),
    (4, 'InfoSul Atacado de Peças Ltda', '09537164000127', '5133417890', 'contato@infosulatacado.com.br', 'Av. Farrapos, 1980 - Floresta, Porto Alegre', 'RS', '2023-05-14'),
    (5, 'Paraná Micros e Periféricos Ltda', '42198507000141', '4132623318', 'atendimento@paranamicros.com.br', 'Rua XV de Novembro, 640 - Centro, Curitiba', 'PR', '2023-06-20'),
    (6, 'NoteParts Telas e Baterias Ltda', '51840392000138', '1135889021', 'vendas@noteparts.com.br', 'Rua Santa Ifigênia, 420 - Centro, São Paulo', 'SP', '2023-07-09'),
    (7, 'ValeTech Suprimentos de TI Ltda', '63029418000141', '4733226140', 'comercial@valetechti.com.br', 'Rua 7 de Setembro, 1125 - Centro, Blumenau', 'SC', '2023-08-17'),
    (8, 'Joinville Hardware Importadora Ltda', '19746250000101', '4734258830', 'import@joinvillehw.com.br', 'Av. Getúlio Vargas, 910 - Bucarein, Joinville', 'SC', '2023-09-05'),
    (9, 'GlobalChip Eletrônica e Reparos Ltda', '74285103000181', '1932514090', 'vendas@globalchip.com.br', 'Av. Brasil, 1340 - Guanabara, Campinas', 'SP', '2023-10-12'),
    (10, 'MinasTech Distribuição de TI Ltda', '31690475000180', '3132715420', 'pedidos@minastech.com.br', 'Av. Afonso Pena, 1755 - Funcionários, Belo Horizonte', 'MG', '2023-11-28'),
    (11, 'Carioca Informática Atacadista Ltda', '25913840000176', '2122406780', 'comercial@cariocainfo.com.br', 'Av. Rio Branco, 156 - Centro, Rio de Janeiro', 'RJ', '2024-01-16'),
    (12, 'Serra Componentes e Cabos Ltda', '48372619000153', '5432142950', 'vendas@serracomponentes.com.br', 'Rua Sinimbu, 1590 - Centro, Caxias do Sul', 'RS', '2024-02-22'),
    (13, 'Litoral Sul Peças de Notebook Ltda', '36501928000105', '4836261480', 'contato@litoralsulpecas.com.br', 'Av. Marcolino Martins Cabral, 870 - Centro, Tubarão', 'SC', '2024-03-30'),
    (14, 'AlphaMemory Armazenamento Ltda', '59248071000150', '1140032870', 'comercial@alphamemory.com.br', 'Alameda Rio Negro, 503 - Alphaville, Barueri', 'SP', '2024-05-08'),
    (15, 'PowerSupply Fontes e Energia Ltda', '67139542000110', '4130157740', 'vendas@powersupplybr.com.br', 'Rua Marechal Deodoro, 980 - Centro, Curitiba', 'PR', '2024-06-19'),
    (16, 'CoolerMax Soluções Térmicas Ltda', '82461093000116', '4733485190', 'suporte@coolermaxbr.com.br', 'Av. Marcos Konder, 440 - Centro, Itajaí', 'SC', '2024-08-01'),
    (17, 'BoardFix Placas e Chips Ltda', '40982735000182', '1133376215', 'vendas@boardfix.com.br', 'Rua dos Timbiras, 285 - Santa Ifigênia, São Paulo', 'SP', '2024-09-14'),
    (18, 'TecnoOeste Distribuidora de Hardware', '53719468000105', '4933234910', 'comercial@tecnooeste.com.br', 'Av. Getúlio Dornelles Vargas, 1210 - Centro, Chapecó', 'SC', '2024-11-05'),
    (19, 'Planalto Periféricos e Peças Ltda', '28654309000114', '6232128300', 'vendas@planaltoperifericos.com.br', 'Av. Goiás, 730 - Setor Central, Goiânia', 'GO', DEFAULT),
    (20, 'Capixaba Tech Importações Ltda', '71390852000180', '2732226640', 'comercial@capixabatech.com.br', 'Av. Nossa Senhora da Penha, 1495 - Santa Lúcia, Vitória', 'ES', DEFAULT);
GO
SET IDENTITY_INSERT fornecedor OFF;
GO

SET IDENTITY_INSERT categoria_peca ON;
GO
INSERT INTO categoria_peca (id_categoria_peca, nome) VALUES
    (1, 'Memória RAM'),
    (2, 'SSD NVMe'),
    (3, 'SSD SATA'),
    (4, 'HD Interno'),
    (5, 'Fonte de Alimentação'),
    (6, 'Placa-Mãe'),
    (7, 'Processador'),
    (8, 'Placa de Vídeo'),
    (9, 'Cooler e Ventoinha'),
    (10, 'Bateria de Notebook'),
    (11, 'Tela e Display LCD'),
    (12, 'Teclado de Notebook'),
    (13, 'Carregador de Notebook'),
    (14, 'Pasta Térmica'),
    (15, 'Gabinete'),
    (16, 'Placa de Rede Wi-Fi'),
    (17, 'Cabo Flat'),
    (18, 'Dobradiça e Carcaça'),
    (19, 'Conector DC Jack'),
    (20, 'Adaptador e Caddy');
GO
SET IDENTITY_INSERT categoria_peca OFF;
GO

SET IDENTITY_INSERT forma_pagamento ON;
GO
INSERT INTO forma_pagamento (id_forma_pagamento, descricao) VALUES
    (1, 'Dinheiro'),
    (2, 'Pix'),
    (3, 'Cartão de Débito'),
    (4, 'Cartão Crédito à Vista'),
    (5, 'Cartão Crédito 2x'),
    (6, 'Cartão Crédito 3x'),
    (7, 'Cartão Crédito 4x'),
    (8, 'Cartão Crédito 5x'),
    (9, 'Cartão Crédito 6x'),
    (10, 'Cartão Crédito 10x'),
    (11, 'Cartão Crédito 12x'),
    (12, 'Boleto Bancário'),
    (13, 'Transferência TED'),
    (14, 'Transferência DOC'),
    (15, 'Mercado Pago'),
    (16, 'PicPay'),
    (17, 'PayPal'),
    (18, 'Link de Pagamento'),
    (19, 'Faturado 30 Dias'),
    (20, 'Crédito em Loja');
GO
SET IDENTITY_INSERT forma_pagamento OFF;
GO

SET IDENTITY_INSERT peca ON;
GO
INSERT INTO peca (id_peca, id_fornecedor, id_categoria_peca, nome, preco, estoque_atual, estoque_minimo, dt_cadastro) VALUES
    (1, 14, 1, 'Memória RAM DDR4 8GB 3200MHz Notebook', 145.00, 28, 6, '2024-06-10'),
    (2, 14, 1, 'Memória RAM DDR4 16GB 3200MHz Desktop', 265.00, 19, 5, '2024-06-10'),
    (3, 14, 2, 'SSD NVMe M.2 500GB PCIe Gen3', 249.90, 32, 8, '2024-06-15'),
    (4, 3, 2, 'SSD NVMe M.2 1TB PCIe Gen4', 429.90, 16, 4, '2024-07-02'),
    (5, 1, 3, 'SSD SATA III 480GB 2.5 Polegadas', 215.00, 24, 6, '2024-07-08'),
    (6, 4, 4, 'HD Interno 1TB 7200RPM SATA III', 289.00, 10, 3, '2024-07-20'),
    (7, 15, 5, 'Fonte ATX 500W 80 Plus Bronze', 279.90, 14, 4, '2024-08-05'),
    (8, 15, 5, 'Fonte ATX 650W 80 Plus Bronze PFC Ativo', 369.90, 9, 3, '2024-08-12'),
    (9, 17, 6, 'Placa-Mãe Micro-ATX Socket AM4 B450', 520.00, 6, 2, '2024-08-25'),
    (10, 17, 6, 'Placa-Mãe Micro-ATX LGA1200 H510', 495.00, 5, 2, '2024-09-03'),
    (11, 3, 7, 'Processador Intel Core i5-12400F', 789.00, 5, 2, '2024-09-15'),
    (12, 8, 8, 'Placa de Vídeo RTX 3060 12GB GDDR6', 1799.00, 3, 2, '2024-10-01'),
    (13, 16, 9, 'Cooler Fan 120mm PWM Silencioso', 48.00, 22, 5, '2024-10-12'),
    (14, 16, 9, 'Cooler Interno Original Notebook Dell Inspiron', 85.00, 11, 4, '2024-10-20'),
    (15, 6, 10, 'Bateria Notebook Dell Inspiron 15 42Wh', 235.00, 12, 4, '2024-11-04'),
    (16, 6, 10, 'Bateria Notebook Lenovo IdeaPad 3 45Wh', 245.00, 4, 5, '2024-11-11'),
    (17, 6, 11, 'Tela LCD 15.6 Full HD IPS Slim 30 Pinos', 449.00, 9, 3, '2024-11-22'),
    (18, 13, 12, 'Teclado Notebook ABNT2 Padrão Dell/Lenovo', 118.00, 17, 5, '2024-12-03'),
    (19, 13, 13, 'Carregador Notebook 19.5V 65W Pino Agulha', 129.90, 21, 6, '2025-01-09'),
    (20, 16, 14, 'Pasta Térmica Alta Condutividade 4g', 39.90, 45, 10, '2025-01-18'),
    (21, 5, 15, 'Gabinete Mid-Tower ATX com Lateral Acrílica', 259.00, 7, 2, '2025-02-05'),
    (22, 2, 16, 'Placa Wi-Fi M.2 Dual Band AC + Bluetooth', 115.00, 13, 4, '2025-02-19'),
    (23, 12, 17, 'Cabo Flat de Vídeo LVDS/eDP 30 Pinos', 68.00, 8, 4, '2025-03-08'),
    (24, 13, 18, 'Par de Dobradiças Metálicas Notebook 15.6', 79.90, 12, 4, '2025-03-22'),
    (25, 9, 19, 'Conector DC Jack com Chicote Universal', 45.00, DEFAULT, 6, '2025-04-10'),
    (26, 7, 20, 'Adaptador Caddy 9.5mm para Segundo SSD', 38.00, 15, DEFAULT, DEFAULT);
GO
SET IDENTITY_INSERT peca OFF;
GO
