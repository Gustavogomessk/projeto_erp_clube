USE clube_erp;

INSERT INTO pessoa (cpf, nome, email, telefone, data_nascimento, status_pessoa, data_cadastro) VALUES
('11111111111','Ana Silva','ana.silva@email.com','11999990001','1985-03-12 00:00:00','ATIVA','2020-01-10 09:00:00'),
('22222222222','Bruno Souza','bruno.souza@email.com','11999990002','1978-07-25 00:00:00','ATIVA','2020-02-15 10:30:00'),
('33333333333','Carla Oliveira','carla.oliveira@email.com','11999990003','1990-11-02 00:00:00','ATIVA','2020-03-20 11:15:00'),
('44444444444','Diego Santos','diego.santos@email.com','11999990004','1995-05-18 00:00:00','ATIVA','2021-01-05 08:45:00'),
('55555555555','Elena Ferreira','elena.ferreira@email.com','11999990005','2000-09-30 00:00:00','ATIVA','2021-06-12 14:00:00'),
('66666666666','Felipe Lima','felipe.lima@email.com','11999990006','1982-12-08 00:00:00','ATIVA','2019-11-01 09:30:00'),
('77777777777','Gabriela Rocha','gabriela.rocha@email.com','11999990007','2015-04-22 00:00:00','ATIVA','2022-02-18 16:20:00'),
('88888888888','Henrique Alves','henrique.alves@email.com','11999990008','2012-08-14 00:00:00','ATIVA','2022-03-10 10:00:00'),
('99999999999','Isabela Martins','isabela.martins@email.com','11999990009','1970-01-19 00:00:00','ATIVA','2018-07-07 07:50:00'),
('10101010101','João Pereira','joao.pereira@email.com','11999990010','1988-06-05 00:00:00','ATIVA','2020-09-09 13:40:00'),
('12121212121','Visitante Teste','visitante@email.com','11999990011','1999-02-11 00:00:00','ATIVA','2024-01-01 09:00:00'),
('13131313131','Marcos Médico','marcos.medico@email.com','11999990012','1975-10-10 00:00:00','ATIVA','2019-01-01 08:00:00');

INSERT INTO cep (cep, logradouro, bairro, cidade, estado) VALUES
('01001000','Praça da Sé','Sé','São Paulo','SP'),
('20040002','Rua da Assembleia','Centro','Rio de Janeiro','RJ'),
('30130010','Avenida Afonso Pena','Centro','Belo Horizonte','MG'),
('80010000','Rua XV de Novembro','Centro','Curitiba','PR');

INSERT INTO endereco (id_endereco, cpf, cep, numero, complemento, tipo_endereco, endereco_principal) VALUES
(1,'11111111111','01001000','100','Apto 12','RESIDENCIAL',1),
(2,'22222222222','20040002','250',NULL,'RESIDENCIAL',1),
(3,'33333333333','30130010','300','Casa','RESIDENCIAL',1),
(4,'44444444444','80010000','45',NULL,'RESIDENCIAL',1),
(5,'55555555555','01001000','1010','Bloco B','RESIDENCIAL',1),
(6,'66666666666','20040002','77','Sala 3','COMERCIAL',1),
(7,'99999999999','30130010','500',NULL,'RESIDENCIAL',1);

INSERT INTO categoria_socio (id_categoria_socio, nome_categoria, valor_mensalidade, descricao_beneficios, situacao_categoria) VALUES
(1,'Titular',150.00,'Acesso total às dependências','ATIVA'),
(2,'Dependente',80.00,'Acesso às dependências e turmas','ATIVA'),
(3,'Honorário',0.00,'Benefícios institucionais','ATIVA');

INSERT INTO socio (id_socio, cpf, numero_matricula, id_categoria_socio, data_associacao, data_desligamento, situacao_socio, observacao) VALUES
(1,'11111111111','MAT000000001',1,'2020-01-10 09:00:00',NULL,'ATIVO','Sócio fundador'),
(2,'22222222222','MAT000000002',1,'2020-02-15 10:30:00',NULL,'ATIVO',NULL),
(3,'33333333333','MAT000000003',1,'2020-03-20 11:15:00',NULL,'ATIVO',NULL),
(4,'66666666666','MAT000000004',3,'2019-11-01 09:30:00',NULL,'ATIVO','Sócio honorário'),
(5,'99999999999','MAT000000005',1,'2018-07-07 07:50:00',NULL,'ATIVO',NULL);

INSERT INTO dependente (id_dependente, id_socio_titular, cpf, tipo_dependencia, data_inicio_dependencia, data_fim_dependencia, situacao_dependente, observacao) VALUES
(1,1,'77777777777','FILHO','2022-02-18 16:20:00',NULL,'ATIVO','Filha de Ana'),
(2,1,'88888888888','FILHO','2022-03-10 10:00:00',NULL,'ATIVO','Filho de Ana'),
(3,2,'55555555555','CONJUGE','2021-06-12 14:00:00',NULL,'ATIVO','Cônjuge de Bruno');

INSERT INTO departamento (id_departamento, nome_departamento, descricao, id_responsavel, situacao_departamento) VALUES
(1,'Esportes','Responsável pelas modalidades esportivas',NULL,'ATIVO'),
(2,'Administrativo','Financeiro e RH',NULL,'ATIVO'),
(3,'Saúde','Atendimento médico e exames',NULL,'ATIVO');

INSERT INTO funcionario (id_funcionario, cpf, id_departamento, matricula_funcional, cargo, salario, data_admissao, data_demissao, jornada_trabalho, tipo_contrato, ctps_numero, situacao_funcionario) VALUES
(1,'33333333333',1,'FUN000000001','Professora de Natação',3500.00,'2020-03-20 11:15:00',NULL,'40h semanais','CLT','12345678901','ATIVO'),
(2,'44444444444',2,'FUN000000002','Analista Financeiro',4200.00,'2021-01-05 08:45:00',NULL,'44h semanais','CLT','12345678902','ATIVO'),
(3,'10101010101',2,'FUN000000003','Recepcionista',2200.00,'2020-09-09 13:40:00',NULL,'40h semanais','CLT','12345678903','ATIVO'),
(4,'13131313131',3,'FUN000000004','Médico do Esporte',8000.00,'2019-01-01 08:00:00',NULL,'20h semanais','PJ',NULL,'ATIVO');

INSERT INTO modalidade (id_modalidade, nome_modalidade, descricao, taxa_adicional, idade_minima, idade_maxima, exige_exame_medico, situacao_modalidade) VALUES
(1,'Natação','Aulas de natação para todas as idades',50.00,6,80,1,'ATIVA'),
(2,'Futebol','Futebol de campo e society',30.00,8,60,1,'ATIVA'),
(3,'Judô','Arte marcial',40.00,5,70,1,'ATIVA');

INSERT INTO atleta (id_atleta, cpf, id_socio, nivel_atleta, registro_federacao, data_inicio_atividade, situacao_atleta, observacao) VALUES
(1,'77777777777',1,'INICIANTE',NULL,'2022-03-01 10:00:00','ATIVO','Filha de Ana'),
(2,'88888888888',1,'INICIANTE',NULL,'2022-03-15 10:00:00','ATIVO','Filho de Ana'),
(3,'55555555555',2,'INTERMEDIARIO','FED-00123','2021-07-01 09:00:00','ATIVO','Cônjuge de Bruno'),
(4,'44444444444',NULL,'AVANCADO','FED-00456','2019-02-01 08:00:00','ATIVO','Atleta sem vínculo de sócio');

INSERT INTO atleta_modalidade (id_atleta_modalidade, id_atleta, id_modalidade, data_inicio, data_fim, situacao_vinculo, observacao) VALUES
(1,1,1,'2022-03-05 10:00:00',NULL,'ATIVO','Natação infantil'),
(2,2,2,'2022-03-20 10:00:00',NULL,'ATIVO','Futebol infantil'),
(3,3,1,'2021-07-10 09:00:00',NULL,'ATIVO','Natação adulto'),
(4,3,3,'2021-08-01 09:00:00',NULL,'ATIVO','Judô adulto'),
(5,4,3,'2019-03-01 08:00:00',NULL,'ATIVO','Judô competitivo');

INSERT INTO turma (id_turma, id_modalidade, nome_turma, idade_minima, idade_maxima, capacidade_maxima, situacao_turma, observacao) VALUES
(1,1,'Natação Infantil A',6,10,15,'ATIVA','Turma de iniciação'),
(2,2,'Futebol Infantil',8,12,20,'ATIVA',NULL),
(3,1,'Natação Adulto',18,60,12,'ATIVA',NULL),
(4,3,'Judô Avançado',14,50,15,'ATIVA',NULL);

INSERT INTO turma_horario (id_turma_horario, id_turma, dia_semana, hora_inicio, hora_fim) VALUES
(1,1,'SEG','08:00','09:00'),
(2,1,'QUA','08:00','09:00'),
(3,2,'TER','15:00','16:30'),
(4,2,'QUI','15:00','16:30'),
(5,3,'SEG','19:00','20:00'),
(6,3,'QUA','19:00','20:00'),
(7,4,'SEX','18:00','19:30');

INSERT INTO turma_professor (id_turma_professor, id_turma, id_funcionario, data_inicio, data_fim, situacao_vinculo, observacao) VALUES
(1,1,1,'2022-03-01 08:00:00',NULL,'ATIVO','Professora Carla'),
(2,3,1,'2021-07-01 08:00:00',NULL,'ATIVO','Professora Carla'),
(3,2,1,'2022-03-01 08:00:00',NULL,'ATIVO','Professora Carla (futebol)'),
(4,4,1,'2021-08-01 08:00:00',NULL,'ATIVO','Professora Carla (judô)');

INSERT INTO matricula (id_matricula, id_atleta, id_turma, data_matricula, situacao_matricula, observacao) VALUES
(1,1,1,'2022-03-05 10:00:00','ATIVA',NULL),
(2,2,2,'2022-03-20 10:00:00','ATIVA',NULL),
(3,3,3,'2021-07-10 09:00:00','ATIVA',NULL),
(4,4,4,'2019-03-01 08:00:00','ATIVA',NULL);

INSERT INTO medico (id_medico, crm_medico, nome_medico) VALUES
(1,'CRM-SP-123456','Dr. Marcos Médico'),
(2,'CRM-RJ-654321','Dra. Paula Saúde');

INSERT INTO exame_medico (id_exame_medico, cpf, id_medico, data_exame, data_validade, resultado, observacao) VALUES
(1,'77777777777',1,'2024-01-10 09:00:00','2025-01-10 09:00:00','APTO','Exame anual'),
(2,'88888888888',1,'2024-01-10 09:30:00','2025-01-10 09:30:00','APTO','Exame anual'),
(3,'55555555555',1,'2024-02-15 10:00:00','2025-02-15 10:00:00','APTO',NULL),
(4,'44444444444',2,'2024-02-20 11:00:00','2025-02-20 11:00:00','COM_RESTRICAO','Restrição leve no joelho');

INSERT INTO dependencia_fisica (id_dependencia, nome_dependencia, tipo_dependencia, capacidade_maxima, situacao_dependencia, observacao) VALUES
(1,'Quadra Principal','QUADRA',50,'DISPONIVEL',NULL),
(2,'Piscina Semiolímpica','PISCINA',40,'DISPONIVEL',NULL),
(3,'Salão de Festas','SALAO',100,'DISPONIVEL',NULL),
(4,'Campo de Futebol','CAMPO',60,'MANUTENCAO','Manutenção no gramado');

INSERT INTO reserva (id_reserva, id_socio, id_dependencia, data_reserva, hora_inicio, hora_fim, situacao_reserva, data_solicitacao, observacao) VALUES
(1,1,1,'2024-06-10 00:00:00','18:00','19:00','CONFIRMADA','2024-06-01 10:00:00','Reserva de quadra'),
(2,2,3,'2024-06-15 00:00:00','19:00','22:00','CONFIRMADA','2024-06-05 14:00:00','Festa de aniversário'),
(3,3,2,'2024-06-20 00:00:00','08:00','09:00','CANCELADA','2024-06-10 09:00:00','Cancelada pelo sócio');

INSERT INTO evento (id_evento, nome_evento, descricao, data_evento, hora_inicio, hora_fim, id_dependencia, capacidade_maxima, valor_inscricao, tipo_evento, situacao_evento, observacao) VALUES
(1,'Torneio de Natação','Torneio interno de natação','2024-07-20 00:00:00','08:00','17:00',2,100,50.00,'ABERTO','INSCRICOES_ABERTAS',NULL),
(2,'Festa Junina do Clube','Festa junina anual','2024-06-29 00:00:00','18:00','23:59',3,200,30.00,'ABERTO','PLANEJADO',NULL),
(3,'Workshop de Judô','Workshop com mestre convidado','2024-08-10 00:00:00','09:00','12:00',1,40,80.00,'RESTRITO','PLANEJADO',NULL);

INSERT INTO inscricao (id_inscricao, id_evento, cpf, data_inscricao, preco_contratado, desconto_aplicado, situacao_inscricao, pagamento_confirmado, observacao) VALUES
(1,1,'77777777777','2024-06-01 10:00:00',50.00,0.00,'CONFIRMADA',1,NULL),
(2,1,'88888888888','2024-06-01 10:05:00',50.00,0.00,'CONFIRMADA',1,NULL),
(3,1,'55555555555','2024-06-02 09:00:00',50.00,10.00,'CONFIRMADA',0,'Desconto de 10%'),
(4,2,'11111111111','2024-06-10 11:00:00',30.00,0.00,'CONFIRMADA',1,NULL),
(5,3,'44444444444','2024-06-15 15:00:00',80.00,0.00,'LISTA_ESPERA',0,'Aguardando vaga');

INSERT INTO funcao_diretoria (id_funcao_diretoria, nome_funcao, descricao, ordem_hierarquica, situacao_funcao) VALUES
(1,'Presidente','Preside o clube',1,'ATIVA'),
(2,'Vice-Presidente','Auxilia o presidente',2,'ATIVA'),
(3,'Tesoureiro','Responsável financeiro',3,'ATIVA'),
(4,'Secretário','Responsável pelas atas',4,'ATIVA');

INSERT INTO diretoria (id_diretoria, id_socio, id_funcao_diretoria, data_inicio_mandato, data_fim_mandato, situacao_mandato, observacao) VALUES
(1,1,1,'2023-01-01 00:00:00','2025-12-31 00:00:00','EM_ANDAMENTO','Mandato 2023-2025'),
(2,2,2,'2023-01-01 00:00:00','2025-12-31 00:00:00','EM_ANDAMENTO',NULL),
(3,3,3,'2023-01-01 00:00:00','2025-12-31 00:00:00','EM_ANDAMENTO',NULL),
(4,4,4,'2022-01-01 00:00:00','2022-12-31 00:00:00','CONCLUIDO','Mandato anterior');

INSERT INTO convite_visitante (id_convite, id_socio, cpf_visitante, codigo_convite, data_emissao, data_validade, situacao_convite, observacao) VALUES
(1,1,'12121212121','CONV-2024-0001','2024-06-01 10:00:00','2024-06-30 23:59:59','UTILIZADO','Visitante utilizou em 05/06'),
(2,2,'12121212121','CONV-2024-0002','2024-06-10 11:00:00','2024-07-10 23:59:59','ATIVO',NULL),
(3,3,'12121212121','CONV-2024-0003','2024-05-01 09:00:00','2024-05-31 23:59:59','EXPIRADO','Expirou sem uso');

INSERT INTO registro_acesso (id_registro_acesso, cpf, id_convite, data_acesso, hora_acesso, tipo_acesso, meio_acesso, observacao) VALUES
(1,'11111111111',NULL,'2024-06-05 08:00:00','08:00','ENTRADA','CARTEIRINHA',NULL),
(2,'12121212121',1,'2024-06-05 08:05:00','08:05','ENTRADA','QR_CODE','Visitante com convite'),
(3,'12121212121',1,'2024-06-05 18:00:00','18:00','SAIDA','QR_CODE',NULL),
(4,'11111111111',NULL,'2024-06-05 18:05:00','18:05','SAIDA','CARTEIRINHA',NULL),
(5,'22222222222',NULL,'2024-06-06 09:00:00','09:00','ENTRADA','BIOMETRIA',NULL);

INSERT INTO ocorrencia (id_ocorrencia, cpf, id_funcionario, id_ocorrencia_principal, data_ocorrencia, hora_ocorrencia, tipo_ocorrencia, descricao, gravidade, situacao_ocorrencia, providencia_tomada) VALUES
(1,'88888888888',3,NULL,'2024-06-05 10:00:00','10:00','ACIDENTE','Queda na quadra durante atividade','MEDIA','RESOLVIDA','Atendido pela equipe médica'),
(2,'55555555555',3,NULL,'2024-06-06 14:30:00','14:30','ADVERTENCIA','Uso indevido de equipamento','BAIXA','RESOLVIDA','Advertência verbal'),
(3,'77777777777',1,NULL,'2024-06-07 09:15:00','09:15','DANO','Danificou material de natação','BAIXA','EM_ANALISE',NULL),
(4,'77777777777',1,3,'2024-06-08 10:00:00','10:00','OUTRO','Complemento da ocorrência 3','BAIXA','EM_ANALISE',NULL);

INSERT INTO produto (id_produto, nome_produto, descricao, categoria_produto, valor_unitario, codigo_produto, situacao_produto, observacao) VALUES
(1,'Camiseta Oficial','Camiseta do clube','Vestuário',89.90,'PROD-CAM-001','ATIVO',NULL),
(2,'Boné','Boné do clube','Vestuário',49.90,'PROD-BON-001','ATIVO',NULL),
(3,'Garrafa Squeeze','Garrafa 500ml','Acessórios',29.90,'PROD-GAR-001','ATIVO',NULL),
(4,'Óculos de Natação','Óculos para natação','Esportivo',59.90,'PROD-OCU-001','ATIVO',NULL);

INSERT INTO estoque (id_estoque, id_produto, quantidade_disponivel, quantidade_minima, data_atualizacao, observacao) VALUES
(1,1,50,10,'2024-06-01 08:00:00',NULL),
(2,2,30,5,'2024-06-01 08:00:00',NULL),
(3,3,100,20,'2024-06-01 08:00:00',NULL),
(4,4,40,10,'2024-06-01 08:00:00',NULL);

INSERT INTO venda (id_venda, cpf, id_funcionario, data_venda, valor_total, forma_pagamento, situacao_venda, observacao) VALUES
(1,'11111111111',3,'2024-06-02 10:00:00',139.80,'PIX','CONCLUIDA',NULL),
(2,'22222222222',3,'2024-06-03 11:30:00',49.90,'CARTAO','CONCLUIDA',NULL),
(3,'55555555555',3,'2024-06-04 15:00:00',89.80,'DINHEIRO','CONCLUIDA',NULL),
(4,'33333333333',3,'2024-06-05 09:00:00',59.90,'A_PRAZO','CANCELADA','Cliente desistiu');

INSERT INTO item_venda (id_item_venda, id_venda, id_produto, quantidade, valor_unitario, observacao) VALUES
(1,1,1,1,89.90,NULL),
(2,1,2,1,49.90,NULL),
(3,2,2,1,49.90,NULL),
(4,3,1,1,89.90,NULL),
(5,4,4,1,59.90,NULL);

INSERT INTO movimentacao_estoque (id_movimentacao, id_produto, id_funcionario, id_item_venda, tipo_movimentacao, sentido, quantidade, origem, data_movimentacao, observacao) VALUES
(1,1,3,NULL,'ENTRADA','E',60,'Compra inicial','2024-05-30 08:00:00',NULL),
(2,2,3,NULL,'ENTRADA','E',35,'Compra inicial','2024-05-30 08:00:00',NULL),
(3,3,3,NULL,'ENTRADA','E',100,'Compra inicial','2024-05-30 08:00:00',NULL),
(4,4,3,NULL,'ENTRADA','E',45,'Compra inicial','2024-05-30 08:00:00',NULL),
(5,1,3,1,'SAIDA','S',1,'Venda 1','2024-06-02 10:00:00',NULL),
(6,2,3,2,'SAIDA','S',1,'Venda 1','2024-06-02 10:00:00',NULL),
(7,2,3,3,'SAIDA','S',1,'Venda 2','2024-06-03 11:30:00',NULL),
(8,1,3,4,'SAIDA','S',1,'Venda 3','2024-06-04 15:00:00',NULL),
(9,4,3,NULL,'PERDA','S',5,'Avaria','2024-06-05 08:00:00','Produtos danificados');

INSERT INTO mensalidade (id_mensalidade, id_socio, mes_referencia, valor_base, valor_acrescimos, valor_descontos, data_vencimento, situacao_mensalidade, data_geracao, observacao) VALUES
(1,1,'2024-05',150.00,0.00,0.00,'2024-05-10 00:00:00','PAGO','2024-05-01 00:00:00',NULL),
(2,1,'2024-06',150.00,0.00,0.00,'2024-06-10 00:00:00','PENDENTE','2024-06-01 00:00:00',NULL),
(3,2,'2024-05',150.00,0.00,0.00,'2024-05-10 00:00:00','PAGO','2024-05-01 00:00:00',NULL),
(4,2,'2024-06',150.00,10.00,0.00,'2024-06-10 00:00:00','PENDENTE','2024-06-01 00:00:00','Acréscimo por atraso'),
(5,3,'2024-06',150.00,0.00,0.00,'2024-06-10 00:00:00','ATRASADO','2024-06-01 00:00:00',NULL),
(6,5,'2024-06',150.00,0.00,0.00,'2024-06-10 00:00:00','PENDENTE','2024-06-01 00:00:00',NULL);

INSERT INTO contraparte_financeira (id_contraparte, tipo_pessoa, cpf, cnpj, razao_social) VALUES
(1,'PF','11111111111',NULL,NULL),
(2,'PF','22222222222',NULL,NULL),
(3,'PF','33333333333',NULL,NULL),
(4,'PF','55555555555',NULL,NULL),
(5,'PJ',NULL,'12345678000199','Fornecedor de Materiais Esportivos Ltda'),
(6,'PJ',NULL,'98765432000188','Serviços de Manutenção Aquática ME'),
(7,'PF','77777777777',NULL,NULL),
(8,'PF','88888888888',NULL,NULL);

INSERT INTO conta_financeira (id_conta, nome_conta, tipo_conta, banco, agencia, numero_conta, saldo_inicial, situacao_conta) VALUES
(1,'Conta Corrente Principal','BANCARIA','Banco do Brasil','1234','56789-0',10000.00,'ATIVA'),
(2,'Caixa Interno','CAIXA',NULL,NULL,NULL,500.00,'ATIVA'),
(3,'Conta Poupança Reserva','BANCARIA','Caixa Econômica','4321','12345-6',5000.00,'ATIVA');

INSERT INTO titulo_financeiro (id_titulo, natureza, id_contraparte, origem_tipo, id_mensalidade, id_inscricao, id_venda, descricao, valor_original, valor_desconto, valor_acrescimo, saldo_aberto, data_emissao, data_vencimento, situacao_titulo) VALUES
(1,'RECEBER',1,'MENSALIDADE',1,NULL,NULL,'Mensalidade 2024-05 Ana',150.00,0.00,0.00,0.00,'2024-05-01 00:00:00','2024-05-10 00:00:00','LIQUIDADO'),
(2,'RECEBER',1,'MENSALIDADE',2,NULL,NULL,'Mensalidade 2024-06 Ana',150.00,0.00,0.00,150.00,'2024-06-01 00:00:00','2024-06-10 00:00:00','ABERTO'),
(3,'RECEBER',2,'MENSALIDADE',3,NULL,NULL,'Mensalidade 2024-05 Bruno',150.00,0.00,0.00,0.00,'2024-05-01 00:00:00','2024-05-10 00:00:00','LIQUIDADO'),
(4,'RECEBER',2,'MENSALIDADE',4,NULL,NULL,'Mensalidade 2024-06 Bruno',150.00,0.00,10.00,160.00,'2024-06-01 00:00:00','2024-06-10 00:00:00','ABERTO'),
(5,'RECEBER',3,'MENSALIDADE',5,NULL,NULL,'Mensalidade 2024-06 Carla',150.00,0.00,0.00,150.00,'2024-06-01 00:00:00','2024-06-10 00:00:00','ABERTO'),
(6,'RECEBER',7,'INSCRICAO',NULL,1,NULL,'Inscrição Torneio Natação - Isabela',50.00,0.00,0.00,0.00,'2024-06-01 10:00:00','2024-06-15 00:00:00','LIQUIDADO'),
(7,'RECEBER',8,'INSCRICAO',NULL,2,NULL,'Inscrição Torneio Natação - Henrique',50.00,0.00,0.00,0.00,'2024-06-01 10:05:00','2024-06-15 00:00:00','LIQUIDADO'),
(8,'RECEBER',4,'INSCRICAO',NULL,3,NULL,'Inscrição Torneio Natação - Elena',50.00,10.00,0.00,40.00,'2024-06-02 09:00:00','2024-06-15 00:00:00','ABERTO'),
(9,'RECEBER',1,'VENDA',NULL,NULL,1,'Venda 1 - Ana',139.80,0.00,0.00,0.00,'2024-06-02 10:00:00','2024-06-02 10:00:00','LIQUIDADO'),
(10,'RECEBER',2,'VENDA',NULL,NULL,2,'Venda 2 - Bruno',49.90,0.00,0.00,0.00,'2024-06-03 11:30:00','2024-06-03 11:30:00','LIQUIDADO'),
(11,'RECEBER',4,'VENDA',NULL,NULL,3,'Venda 3 - Elena',89.80,0.00,0.00,0.00,'2024-06-04 15:00:00','2024-06-04 15:00:00','LIQUIDADO'),
(12,'PAGAR',5,'DESPESA',NULL,NULL,NULL,'Compra de materiais esportivos',2000.00,0.00,0.00,2000.00,'2024-06-01 00:00:00','2024-06-30 00:00:00','ABERTO'),
(13,'PAGAR',6,'DESPESA',NULL,NULL,NULL,'Manutenção da piscina',800.00,0.00,0.00,800.00,'2024-06-05 00:00:00','2024-06-20 00:00:00','ABERTO');

INSERT INTO pagamento (id_pagamento, id_conta, id_contraparte, id_funcionario, id_pagamento_estornado, sentido, data_pagamento, valor_pago, forma_pagamento, numero_recibo, situacao_pagamento, observacao) VALUES
(1,1,1,2,NULL,'ENTRADA','2024-05-08 10:00:00',150.00,'PIX','REC-2024-0001','CONFIRMADO','Mensalidade Ana 2024-05'),
(2,1,2,2,NULL,'ENTRADA','2024-05-09 11:00:00',150.00,'BOLETO','REC-2024-0002','CONFIRMADO','Mensalidade Bruno 2024-05'),
(3,1,7,2,NULL,'ENTRADA','2024-06-01 10:30:00',50.00,'PIX','REC-2024-0003','CONFIRMADO','Inscrição Isabela'),
(4,1,8,2,NULL,'ENTRADA','2024-06-01 10:35:00',50.00,'CARTAO','REC-2024-0004','CONFIRMADO','Inscrição Henrique'),
(5,2,1,3,NULL,'ENTRADA','2024-06-02 10:05:00',139.80,'DINHEIRO','REC-2024-0005','CONFIRMADO','Venda 1'),
(6,2,2,3,NULL,'ENTRADA','2024-06-03 11:35:00',49.90,'CARTAO','REC-2024-0006','CONFIRMADO','Venda 2'),
(7,2,4,3,NULL,'ENTRADA','2024-06-04 15:05:00',89.80,'DINHEIRO','REC-2024-0007','CONFIRMADO','Venda 3'),
(8,1,5,2,NULL,'SAIDA','2024-06-10 09:00:00',1000.00,'TRANSFERENCIA','PAG-2024-0001','CONFIRMADO','Adiantamento fornecedor'),
(9,1,6,2,NULL,'SAIDA','2024-06-15 14:00:00',400.00,'PIX','PAG-2024-0002','CONFIRMADO','Adiantamento manutenção'),
(10,1,1,2,NULL,'ENTRADA','2024-06-05 10:00:00',150.00,'PIX','REC-2024-0008','ESTORNADO','Pagamento duplicado');

INSERT INTO baixa_financeira (id_baixa, id_pagamento, id_titulo, valor_baixa, data_baixa) VALUES
(1,1,1,150.00,'2024-05-08 10:00:00'),
(2,2,3,150.00,'2024-05-09 11:00:00'),
(3,3,6,50.00,'2024-06-01 10:30:00'),
(4,4,7,50.00,'2024-06-01 10:35:00'),
(5,5,9,139.80,'2024-06-02 10:05:00'),
(6,6,10,49.90,'2024-06-03 11:35:00'),
(7,7,11,89.80,'2024-06-04 15:05:00'),
(8,8,12,1000.00,'2024-06-10 09:00:00'),
(9,9,13,400.00,'2024-06-15 14:00:00');

INSERT INTO item_extrato (id_item_extrato, id_conta, identificador_externo, data_lancamento, descricao, valor, sentido, situacao_conciliacao) VALUES
(1,1,'BB-2024-0001','2024-05-08 10:00:00','PIX recebido Ana Silva',150.00,'ENTRADA','CONCILIADO'),
(2,1,'BB-2024-0002','2024-05-09 11:00:00','Boleto recebido Bruno Souza',150.00,'ENTRADA','CONCILIADO'),
(3,1,'BB-2024-0003','2024-06-01 10:30:00','PIX recebido Isabela Martins',50.00,'ENTRADA','CONCILIADO'),
(4,1,'BB-2024-0004','2024-06-01 10:35:00','Cartão recebido Henrique Alves',50.00,'ENTRADA','CONCILIADO'),
(5,1,'BB-2024-0005','2024-06-10 09:00:00','Transferência enviada Fornecedor',1000.00,'SAIDA','CONCILIADO'),
(6,1,'BB-2024-0006','2024-06-15 14:00:00','PIX enviado Manutenção',400.00,'SAIDA','CONCILIADO'),
(7,1,'BB-2024-0007','2024-06-20 09:00:00','PIX recebido não identificado',200.00,'ENTRADA','PENDENTE');

INSERT INTO conciliacao (id_conciliacao, id_item_extrato, id_pagamento, id_funcionario, valor_conciliado, data_conciliacao, observacao) VALUES
(1,1,1,2,150.00,'2024-05-09 09:00:00','Conciliado automaticamente'),
(2,2,2,2,150.00,'2024-05-10 09:00:00','Conciliado automaticamente'),
(3,3,3,2,50.00,'2024-06-02 09:00:00','Conciliado automaticamente'),
(4,4,4,2,50.00,'2024-06-02 09:05:00','Conciliado automaticamente'),
(5,5,8,2,1000.00,'2024-06-11 09:00:00','Conciliado manualmente'),
(6,6,9,2,400.00,'2024-06-16 09:00:00','Conciliado manualmente');