USE clube_erp;

INSERT INTO pessoa (cpf, nome, email, telefone, data_nascimento, status_pessoa, data_cadastro) VALUES
('11111111111','Ana Souza','ana.souza@email.com','11990000001','1985-03-12 00:00:00','ATIVA','2024-01-10 09:00:00'),
('22222222222','Bruno Lima','bruno.lima@email.com','11990000002','1990-07-25 00:00:00','ATIVA','2024-02-15 10:30:00'),
('33333333333','Carla Mendes','carla.mendes@email.com','11990000003','1988-11-02 00:00:00','ATIVA','2024-03-20 14:00:00'),
('44444444444','Diego Souza','diego.souza@email.com','11990000004','2015-05-20 00:00:00','ATIVA','2024-01-10 09:10:00'),
('55555555555','Marcos Souza','marcos.souza@email.com','11990000005','1983-01-30 00:00:00','ATIVA','2024-01-10 09:15:00'),
('66666666666','Fernando Alves','fernando.alves@clube.com','11990000006','1982-09-14 00:00:00','ATIVA','2023-05-02 08:00:00'),
('77777777777','Gabriela Rocha','gabriela.rocha@clube.com','11990000007','1992-04-08 00:00:00','ATIVA','2023-06-01 08:00:00'),
('88888888888','Henrique Costa','henrique.costa@clube.com','11990000008','1995-12-19 00:00:00','ATIVA','2024-08-01 08:00:00'),
('99999999999','Isabela Nunes','isabela.nunes@email.com','11990000009','1991-06-03 00:00:00','ATIVA','2026-10-20 11:00:00'),
('12121212121','Joao Pereira','joao.pereira@email.com','11990000010','1998-02-17 00:00:00','ATIVA','2025-04-05 16:00:00');

INSERT INTO cep (cep, logradouro, bairro, cidade, estado) VALUES
('09010000','Avenida Dom Pedro II','Jardim','Santo Andre','SP'),
('09020000','Rua das Flores','Centro','Santo Andre','SP'),
('01310100','Avenida Paulista','Bela Vista','Sao Paulo','SP');

INSERT INTO endereco (id_endereco, cpf, cep, numero, complemento, tipo_endereco, endereco_principal) VALUES
(1,'11111111111','09010000','100','Apto 12','RESIDENCIAL',1),
(2,'22222222222','09020000','250',NULL,'RESIDENCIAL',1),
(3,'33333333333','01310100','1500','Sala 4','COMERCIAL',1),
(4,'44444444444','09010000','100','Apto 12','RESIDENCIAL',1),
(5,'55555555555','09010000','100','Apto 12','RESIDENCIAL',1),
(6,'12121212121','09020000','88','Casa 2','RESIDENCIAL',1);

INSERT INTO categoria_socio (id_categoria_socio, nome_categoria, valor_mensalidade, descricao_beneficios, situacao_categoria) VALUES
(1,'Individual',150.00,'Acesso as areas comuns','ATIVA'),
(2,'Familiar',250.00,'Titular e ate 4 dependentes','ATIVA'),
(3,'Atleta',100.00,'Desconto para atletas federados','ATIVA');

INSERT INTO socio (id_socio, cpf, numero_matricula, id_categoria_socio, data_associacao, data_desligamento, situacao_socio, observacao) VALUES
(1,'11111111111','SOC000000001',2,'2024-01-10 09:00:00',NULL,'ATIVO',NULL),
(2,'22222222222','SOC000000002',1,'2024-02-15 10:30:00',NULL,'ATIVO',NULL),
(3,'33333333333','SOC000000003',1,'2024-03-20 14:00:00',NULL,'INADIMPLENTE','Mensalidade de setembro em atraso');

INSERT INTO dependente (id_socio_titular, id_dependente, cpf, tipo_dependencia, data_inicio_dependencia, data_fim_dependencia, situacao_dependente, observacao) VALUES
(1,1,'44444444444','FILHO','2024-01-10 09:10:00',NULL,'ATIVO',NULL),
(1,2,'55555555555','CONJUGE','2024-01-10 09:15:00',NULL,'ATIVO',NULL);

INSERT INTO departamento (id_departamento, nome_departamento, descricao, id_responsavel, situacao_departamento) VALUES
(1,'Esportes','Modalidades e turmas esportivas',NULL,'ATIVO'),
(2,'Financeiro','Contas a pagar, receber e conciliacao',NULL,'ATIVO'),
(3,'Bar e Lanchonete','Vendas de alimentos e bebidas',NULL,'ATIVO'),
(4,'Administrativo','Secretaria e atendimento',NULL,'ATIVO');

INSERT INTO funcionario (id_funcionario, cpf, id_departamento, matricula_funcional, cargo, salario, data_admissao, data_demissao, jornada_trabalho, tipo_contrato, ctps_numero, situacao_funcionario) VALUES
(1,'66666666666',1,'FUN000000001','Professor de Esportes',3500.00,'2023-05-02 08:00:00',NULL,'40h semanais','CLT','1234567','ATIVO'),
(2,'77777777777',2,'FUN000000002','Analista Financeira',4800.00,'2023-06-01 08:00:00',NULL,'40h semanais','CLT','2345678','ATIVO'),
(3,'88888888888',3,'FUN000000003','Atendente de Lanchonete',2200.00,'2024-08-01 08:00:00',NULL,'44h semanais','CLT','3456789','ATIVO');

UPDATE departamento SET id_responsavel = 1 WHERE id_departamento = 1;
UPDATE departamento SET id_responsavel = 2 WHERE id_departamento = 2;
UPDATE departamento SET id_responsavel = 3 WHERE id_departamento = 3;

INSERT INTO modalidade (id_modalidade, nome_modalidade, descricao, taxa_adicional, idade_minima, idade_maxima, exige_exame_medico, situacao_modalidade) VALUES
(1,'Natacao','Aulas de natacao','50.00',5,80,1,'ATIVA'),
(2,'Futsal','Futebol de salao','30.00',6,60,1,'ATIVA'),
(3,'Tenis','Tenis de quadra','40.00',6,80,0,'ATIVA');

INSERT INTO atleta (id_atleta, cpf, id_socio, nivel_atleta, registro_federacao, data_inicio_atividade, situacao_atleta, observacao) VALUES
(1,'44444444444',NULL,'INICIANTE',NULL,'2024-02-01 00:00:00','ATIVO','Dependente da socia Ana'),
(2,'22222222222',2,'INTERMEDIARIO','FPT-2024-0456','2024-03-01 00:00:00','ATIVO',NULL),
(3,'12121212121',NULL,'AVANCADO','FPF-2023-0789','2025-04-10 00:00:00','ATIVO','Atleta convidado');

INSERT INTO atleta_modalidade (id_atleta, id_modalidade, data_inicio, data_fim, situacao_vinculo, observacao) VALUES
(1,2,'2024-02-01 00:00:00',NULL,'ATIVO',NULL),
(2,1,'2024-03-01 00:00:00',NULL,'ATIVO',NULL),
(2,3,'2024-06-01 00:00:00',NULL,'ATIVO',NULL),
(3,3,'2025-04-10 00:00:00',NULL,'ATIVO',NULL);

INSERT INTO turma (id_turma, id_modalidade, nome_turma, idade_minima, idade_maxima, capacidade_maxima, situacao_turma, observacao) VALUES
(1,2,'Futsal Infantil',8,12,20,'ATIVA',NULL),
(2,1,'Natacao Adulto',18,60,15,'ATIVA',NULL),
(3,3,'Tenis Iniciante',16,70,10,'ATIVA',NULL);

INSERT INTO turma_horario (id_turma_horario, id_turma, dia_semana, hora_inicio, hora_fim) VALUES
(1,1,'SEG','17:00','18:00'),
(2,1,'QUA','17:00','18:00'),
(3,2,'TER','07:00','08:00'),
(4,2,'QUI','07:00','08:00'),
(5,3,'SAB','09:00','10:30');

INSERT INTO turma_professor (id_turma, id_funcionario, data_inicio, data_fim, situacao_vinculo, observacao) VALUES
(1,1,'2024-01-15 00:00:00',NULL,'ATIVO',NULL),
(2,1,'2024-01-15 00:00:00',NULL,'ATIVO',NULL),
(3,1,'2024-01-15 00:00:00',NULL,'ATIVO',NULL);

INSERT INTO matricula (id_matricula, id_atleta, id_turma, data_matricula, situacao_matricula, observacao) VALUES
(1,1,1,'2024-02-01 10:00:00','ATIVA',NULL),
(2,2,2,'2024-03-01 10:00:00','ATIVA',NULL),
(3,2,3,'2024-06-01 10:00:00','ATIVA',NULL),
(4,3,3,'2025-04-10 10:00:00','ATIVA',NULL);

INSERT INTO medico (id_medico, crm_medico, nome_medico) VALUES
(1,'CRM-SP 123456','Dr. Paulo Martins');

INSERT INTO exame_medico (id_exame_medico, cpf, id_medico, data_exame, data_validade, resultado, observacao) VALUES
(1,'44444444444',1,'2026-03-10 09:00:00','2027-03-10 09:00:00','APTO',NULL),
(2,'22222222222',1,'2026-02-05 09:00:00','2027-02-05 09:00:00','APTO',NULL),
(3,'12121212121',1,'2026-01-20 09:00:00','2027-01-20 09:00:00','COM_RESTRICAO','Evitar impacto no joelho direito');

INSERT INTO dependencia_fisica (id_dependencia, nome_dependencia, tipo_dependencia, capacidade_maxima, situacao_dependencia, observacao) VALUES
(1,'Quadra Poliesportiva','QUADRA',30,'DISPONIVEL',NULL),
(2,'Piscina Olimpica','PISCINA',80,'DISPONIVEL',NULL),
(3,'Salao de Festas','SALAO',200,'DISPONIVEL',NULL),
(4,'Campo de Futebol','CAMPO',50,'MANUTENCAO','Reforma do gramado');

INSERT INTO reserva (id_reserva, id_socio, id_dependencia, data_reserva, hora_inicio, hora_fim, situacao_reserva, data_solicitacao, observacao) VALUES
(1,1,3,'2026-11-14 00:00:00','18:00','23:00','CONFIRMADA','2026-10-10 15:00:00','Aniversario'),
(2,2,1,'2026-10-18 00:00:00','20:00','21:00','CONCLUIDA','2026-10-12 09:30:00',NULL),
(3,3,1,'2026-10-25 00:00:00','19:00','20:00','CANCELADA','2026-10-15 18:00:00','Cancelada pelo socio');

INSERT INTO evento (id_evento, nome_evento, descricao, data_evento, hora_inicio, hora_fim, id_dependencia, capacidade_maxima, valor_inscricao, tipo_evento, situacao_evento, observacao) VALUES
(1,'Festa Junina do Clube','Festa tradicional com comidas tipicas','2026-10-24 00:00:00','18:00','23:00',3,200,30.00,'ABERTO','REALIZADO',NULL),
(2,'Torneio de Tenis Interno','Torneio entre socios','2026-12-05 00:00:00','08:00','17:00',1,32,50.00,'RESTRITO','INSCRICOES_ABERTAS',NULL);

INSERT INTO inscricao (id_inscricao, id_evento, cpf, data_inscricao, preco_contratado, desconto_aplicado, situacao_inscricao, pagamento_confirmado, observacao) VALUES
(1,1,'11111111111','2026-10-10 12:00:00',30.00,0.00,'CONFIRMADA',1,NULL),
(2,1,'12121212121','2026-10-20 12:00:00',30.00,0.00,'CONFIRMADA',1,NULL),
(3,2,'22222222222','2026-10-22 08:00:00',40.00,10.00,'CONFIRMADA',0,'Desconto de atleta');

INSERT INTO funcao_diretoria (id_funcao_diretoria, nome_funcao, descricao, ordem_hierarquica, situacao_funcao) VALUES
(1,'Presidente','Representa o clube',1,'ATIVA'),
(2,'Tesoureiro','Responsavel pelas financas',2,'ATIVA');

INSERT INTO diretoria (id_diretoria, id_socio, id_funcao_diretoria, data_inicio_mandato, data_fim_mandato, situacao_mandato, observacao) VALUES
(1,1,1,'2025-01-01 00:00:00','2026-12-31 00:00:00','EM_ANDAMENTO',NULL),
(2,2,2,'2025-01-01 00:00:00','2026-12-31 00:00:00','EM_ANDAMENTO',NULL);

INSERT INTO convite_visitante (id_convite, id_socio, cpf_visitante, codigo_convite, data_emissao, data_validade, situacao_convite, observacao) VALUES
(1,1,'99999999999','CONV2026102800000001','2026-10-28 10:00:00','2026-10-31 23:59:59','UTILIZADO',NULL),
(2,2,'99999999999','CONV2026102800000002','2026-10-28 11:00:00','2026-11-05 23:59:59','ATIVO',NULL);

INSERT INTO registro_acesso (id_registro_acesso, cpf, id_convite, data_acesso, hora_acesso, tipo_acesso, meio_acesso, observacao) VALUES
(1,'11111111111',NULL,'2026-10-29 08:00:00','08:00','ENTRADA','QR_CODE',NULL),
(2,'99999999999',1,'2026-10-29 09:15:00','09:15','ENTRADA','QR_CODE','Visitante com convite'),
(3,'99999999999',1,'2026-10-29 12:40:00','12:40','SAIDA','QR_CODE',NULL),
(4,'11111111111',NULL,'2026-10-29 13:00:00','13:00','SAIDA','CARTEIRINHA',NULL);

INSERT INTO ocorrencia (id_ocorrencia, cpf, id_funcionario, id_ocorrencia_principal, data_ocorrencia, hora_ocorrencia, tipo_ocorrencia, descricao, gravidade, situacao_ocorrencia, providencia_tomada) VALUES
(1,'44444444444',1,NULL,'2026-10-12 00:00:00','17:30','ACIDENTE','Crianca caiu durante treino de futsal e torceu o tornozelo','MEDIA','RESOLVIDA','Primeiros socorros e contato com os responsaveis'),
(2,'44444444444',1,1,'2026-10-14 00:00:00','10:00','OUTRO','Acompanhamento do acidente anterior - retorno liberado pelo medico','BAIXA','RESOLVIDA','Atleta liberado para treinos');

INSERT INTO produto (id_produto, nome_produto, descricao, categoria_produto, valor_unitario, codigo_produto, situacao_produto, observacao) VALUES
(1,'Refrigerante Lata 350ml','Refrigerante sabores variados','BEBIDA',6.00,'REFRI-LATA-350','ATIVO',NULL),
(2,'Coxinha','Coxinha de frango','SALGADO',6.50,'SALG-COXINHA','ATIVO',NULL),
(3,'Agua Mineral 500ml','Agua sem gas','BEBIDA',4.00,'AGUA-500','ATIVO',NULL);

INSERT INTO estoque (id_estoque, id_produto, quantidade_disponivel, quantidade_minima, data_atualizacao, observacao) VALUES
(1,1,98,20,'2026-10-25 19:00:00',NULL),
(2,2,48,15,'2026-10-25 19:00:00',NULL),
(3,3,120,30,'2026-10-20 08:00:00',NULL);

INSERT INTO venda (id_venda, cpf, id_funcionario, data_venda, valor_total, forma_pagamento, situacao_venda, observacao) VALUES
(1,'11111111111',3,'2026-10-25 19:00:00',25.00,'PIX','CONCLUIDA',NULL);

INSERT INTO item_venda (id_venda, id_produto, quantidade, valor_unitario, observacao) VALUES
(1,1,2,6.00,NULL),
(1,2,2,6.50,NULL);

INSERT INTO mensalidade (id_mensalidade, id_socio, mes_referencia, valor_base, valor_acrescimos, valor_descontos, data_vencimento, situacao_mensalidade, data_geracao, observacao) VALUES
(1,1,'2026-09',250.00,0.00,0.00,'2026-09-10 00:00:00','PAGO','2026-09-01 00:00:00',NULL),
(2,1,'2026-10',250.00,0.00,0.00,'2026-10-10 00:00:00','PENDENTE','2026-10-01 00:00:00',NULL),
(3,2,'2026-10',150.00,0.00,0.00,'2026-10-10 00:00:00','PAGO','2026-10-01 00:00:00',NULL),
(4,3,'2026-09',150.00,4.50,0.00,'2026-09-10 00:00:00','ATRASADO','2026-09-01 00:00:00','Multa e juros aplicados');

INSERT INTO contraparte_financeira (id_contraparte, tipo_pessoa, cpf, cnpj, razao_social) VALUES
(1,'PF','11111111111',NULL,NULL),
(2,'PF','22222222222',NULL,NULL),
(3,'PF','33333333333',NULL,NULL),
(4,'PF','12121212121',NULL,NULL),
(5,'PJ',NULL,'12345678000199','Distribuidora de Bebidas Ltda'),
(6,'PJ',NULL,'98765432000110','Companhia de Energia S.A.');

INSERT INTO conta_financeira (id_conta, nome_conta, tipo_conta, banco, agencia, numero_conta, saldo_inicial, situacao_conta) VALUES
(1,'Conta Corrente Principal','BANCARIA','Banco do Brasil','1234-5','56789-0',10000.00,'ATIVA'),
(2,'Caixa da Secretaria','CAIXA',NULL,NULL,NULL,500.00,'ATIVA');

INSERT INTO titulo_financeiro (id_titulo, natureza, id_contraparte, origem_tipo, id_mensalidade, id_inscricao, id_venda, descricao, valor_original, valor_desconto, valor_acrescimo, saldo_aberto, data_emissao, data_vencimento, situacao_titulo) VALUES
(1,'RECEBER',1,'MENSALIDADE',1,NULL,NULL,'Mensalidade 2026-09',250.00,0.00,0.00,0.00,'2026-09-01 00:00:00','2026-09-10 00:00:00','LIQUIDADO'),
(2,'RECEBER',1,'MENSALIDADE',2,NULL,NULL,'Mensalidade 2026-10',250.00,0.00,0.00,250.00,'2026-10-01 00:00:00','2026-10-10 00:00:00','ABERTO'),
(3,'RECEBER',2,'MENSALIDADE',3,NULL,NULL,'Mensalidade 2026-10',150.00,0.00,0.00,0.00,'2026-10-01 00:00:00','2026-10-10 00:00:00','LIQUIDADO'),
(4,'RECEBER',3,'MENSALIDADE',4,NULL,NULL,'Mensalidade 2026-09',150.00,0.00,4.50,154.50,'2026-09-01 00:00:00','2026-09-10 00:00:00','ABERTO'),
(5,'RECEBER',4,'INSCRICAO',NULL,2,NULL,'Inscricao Festa Junina',30.00,0.00,0.00,0.00,'2026-10-20 12:00:00','2026-10-24 00:00:00','LIQUIDADO'),
(6,'RECEBER',1,'VENDA',NULL,NULL,1,'Venda lanchonete #1',25.00,0.00,0.00,0.00,'2026-10-25 19:00:00','2026-10-25 19:00:00','LIQUIDADO'),
(7,'PAGAR',5,'DESPESA',NULL,NULL,NULL,'Reposicao de estoque de bebidas',800.00,0.00,0.00,300.00,'2026-10-10 00:00:00','2026-11-10 00:00:00','PARCIAL'),
(8,'PAGAR',6,'DESPESA',NULL,NULL,NULL,'Conta de energia outubro/2026',1200.00,0.00,0.00,1200.00,'2026-10-20 00:00:00','2026-11-15 00:00:00','ABERTO');

INSERT INTO pagamento (id_pagamento, id_conta, id_contraparte, id_funcionario, id_pagamento_estornado, sentido, data_pagamento, valor_pago, forma_pagamento, numero_recibo, situacao_pagamento, observacao) VALUES
(1,1,1,2,NULL,'ENTRADA','2026-09-05 10:00:00',250.00,'PIX','REC-2026-0000000001','CONFIRMADO',NULL),
(2,1,2,2,NULL,'ENTRADA','2026-10-04 11:00:00',150.00,'BOLETO','REC-2026-0000000002','CONFIRMADO',NULL),
(3,2,4,2,NULL,'ENTRADA','2026-10-20 12:10:00',30.00,'DINHEIRO','REC-2026-0000000003','CONFIRMADO',NULL),
(4,1,1,3,NULL,'ENTRADA','2026-10-25 19:01:00',25.00,'PIX','REC-2026-0000000004','CONFIRMADO',NULL),
(5,1,5,2,NULL,'SAIDA','2026-10-15 14:00:00',500.00,'TRANSFERENCIA','REC-2026-0000000005','CONFIRMADO','Pagamento parcial'),
(6,1,3,2,NULL,'ENTRADA','2026-10-12 09:00:00',150.00,'PIX','REC-2026-0000000006','ESTORNADO','Lancado em duplicidade'),
(7,1,3,2,6,'SAIDA','2026-10-13 09:00:00',150.00,'PIX','REC-2026-0000000007','ESTORNO','Estorno do recibo REC-2026-0000000006');

INSERT INTO baixa_financeira (id_baixa, id_pagamento, id_titulo, valor_baixa, data_baixa) VALUES
(1,1,1,250.00,'2026-09-05 10:00:00'),
(2,2,3,150.00,'2026-10-04 11:00:00'),
(3,3,5,30.00,'2026-10-20 12:10:00'),
(4,4,6,25.00,'2026-10-25 19:01:00'),
(5,5,7,500.00,'2026-10-15 14:00:00');

INSERT INTO item_extrato (id_item_extrato, id_conta, identificador_externo, data_lancamento, descricao, valor, sentido, situacao_conciliacao) VALUES
(1,1,'BB20260905001','2026-09-05 00:00:00','PIX RECEBIDO ANA SOUZA',250.00,'ENTRADA','CONCILIADO'),
(2,1,'BB20261004001','2026-10-04 00:00:00','BOLETO LIQUIDADO BRUNO LIMA',150.00,'ENTRADA','CONCILIADO'),
(3,1,'BB20261015001','2026-10-15 00:00:00','TED DISTRIBUIDORA BEBIDAS',500.00,'SAIDA','CONCILIADO'),
(4,1,'BB20261025001','2026-10-25 00:00:00','PIX RECEBIDO ANA SOUZA',25.00,'ENTRADA','CONCILIADO'),
(5,1,'BB20261027001','2026-10-27 00:00:00','PIX RECEBIDO NAO IDENTIFICADO',80.00,'ENTRADA','PENDENTE');

INSERT INTO conciliacao (id_conciliacao, id_item_extrato, id_pagamento, id_funcionario, valor_conciliado, data_conciliacao, observacao) VALUES
(1,1,1,2,250.00,'2026-09-06 08:00:00',NULL),
(2,2,2,2,150.00,'2026-10-05 08:00:00',NULL),
(3,3,5,2,500.00,'2026-10-16 08:00:00',NULL),
(4,4,4,2,25.00,'2026-10-26 08:00:00',NULL);