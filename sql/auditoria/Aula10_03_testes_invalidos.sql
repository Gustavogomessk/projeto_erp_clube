USE clube_erp;

-- TESTE 01: PK duplicada em pessoa
INSERT INTO pessoa (cpf, nome, email, telefone, data_nascimento, status_pessoa, data_cadastro)
VALUES ('11111111111','Outra Pessoa','outra1@exemplo.com','11999990099','1995-01-01 00:00:00','ATIVA','2024-06-01 00:00:00');

-- TESTE 02: UNIQUE de email em pessoa
INSERT INTO pessoa (cpf, nome, email, telefone, data_nascimento, status_pessoa, data_cadastro)
VALUES ('12345678901','Teste Email','ana.silva@email.com','11999990098','1995-01-01 00:00:00','ATIVA','2024-06-01 00:00:00');

-- TESTE 03: CHECK length(cpf)=11 em pessoa
INSERT INTO pessoa (cpf, nome, email, telefone, data_nascimento, status_pessoa, data_cadastro)
VALUES ('1234567890','CPF Curto','cpfcurto@exemplo.com','11999990097','1995-01-01 00:00:00','ATIVA','2024-06-01 00:00:00');

-- TESTE 04: CHECK status_pessoa inválido
INSERT INTO pessoa (cpf, nome, email, telefone, data_nascimento, status_pessoa, data_cadastro)
VALUES ('12345678902','Status Ruim','statusruim@exemplo.com','11999990096','1995-01-01 00:00:00','PENDENTE','2024-06-01 00:00:00');

-- TESTE 05: NOT NULL em pessoa.nome
INSERT INTO pessoa (cpf, nome, email, telefone, data_nascimento, status_pessoa, data_cadastro)
VALUES ('12345678903',NULL,'nulo@exemplo.com','11999990095','1995-01-01 00:00:00','ATIVA','2024-06-01 00:00:00');

-- TESTE 06: FK pessoa inexistente em socio
INSERT INTO socio (id_socio, cpf, numero_matricula, id_categoria_socio, data_associacao, data_desligamento, situacao_socio, observacao)
VALUES (999,'00000000000','MAT999999999',1,'2024-06-01 00:00:00',NULL,'ATIVO',NULL);

-- TESTE 07: FK categoria_socio inexistente em socio
INSERT INTO socio (id_socio, cpf, numero_matricula, id_categoria_socio, data_associacao, data_desligamento, situacao_socio, observacao)
VALUES (998,'12121212121','MAT999999998',999,'2024-06-01 00:00:00',NULL,'ATIVO',NULL);

-- TESTE 08: UNIQUE numero_matricula em socio
INSERT INTO socio (id_socio, cpf, numero_matricula, id_categoria_socio, data_associacao, data_desligamento, situacao_socio, observacao)
VALUES (997,'12121212121','MAT000000001',1,'2024-06-01 00:00:00',NULL,'ATIVO',NULL);

-- TESTE 09: CHECK situacao_socio inválido
INSERT INTO socio (id_socio, cpf, numero_matricula, id_categoria_socio, data_associacao, data_desligamento, situacao_socio, observacao)
VALUES (996,'12121212121','MAT999999996',1,'2024-06-01 00:00:00',NULL,'PENDENTE',NULL);

-- TESTE 10: CHECK valor_mensalidade negativa em categoria_socio
INSERT INTO categoria_socio (id_categoria_socio, nome_categoria, valor_mensalidade, descricao_beneficios, situacao_categoria)
VALUES (99,'Categoria Invalida',-10.00,'Teste','ATIVA');

-- TESTE 11: FK id_departamento inexistente em funcionario
INSERT INTO funcionario (id_funcionario, cpf, id_departamento, matricula_funcional, cargo, salario, data_admissao, data_demissao, jornada_trabalho, tipo_contrato, ctps_numero, situacao_funcionario)
VALUES (98,'12121212121',999,'FUN999999998','Cargo Y',3000.00,'2024-06-01 00:00:00',NULL,'40h','CLT','00000000001','ATIVO');

-- TESTE 12: CHECK salario > 0 em funcionario
INSERT INTO funcionario (id_funcionario, cpf, id_departamento, matricula_funcional, cargo, salario, data_admissao, data_demissao, jornada_trabalho, tipo_contrato, ctps_numero, situacao_funcionario)
VALUES (97,'12121212121',1,'FUN999999997','Cargo Z',0.00,'2024-06-01 00:00:00',NULL,'40h','CLT','00000000002','ATIVO');

-- TESTE 13: FK id_modalidade inexistente em turma
INSERT INTO turma (id_turma, id_modalidade, nome_turma, idade_minima, idade_maxima, capacidade_maxima, situacao_turma, observacao)
VALUES (99,999,'Turma X',6,10,10,'ATIVA',NULL);

-- TESTE 14: UNIQUE (id_turma, dia_semana) em turma_horario
INSERT INTO turma_horario (id_turma_horario, id_turma, dia_semana, hora_inicio, hora_fim)
VALUES (98,1,'SEG','10:00','11:00');

-- TESTE 15: FK id_funcionario inexistente em turma_professor
INSERT INTO turma_professor (id_turma_professor, id_turma, id_funcionario, data_inicio, data_fim, situacao_vinculo, observacao)
VALUES (99,1,999,'2024-06-01 00:00:00',NULL,'ATIVO',NULL);

-- TESTE 16: FK id_atleta inexistente em matricula
INSERT INTO matricula (id_matricula, id_atleta, id_turma, data_matricula, situacao_matricula, observacao)
VALUES (99,999,1,'2024-06-01 00:00:00','ATIVA',NULL);

-- TESTE 17: CHECK resultado inválido em exame_medico
INSERT INTO exame_medico (id_exame_medico, cpf, id_medico, data_exame, data_validade, resultado, observacao)
VALUES (98,'12121212121',1,'2024-06-01 00:00:00','2025-06-01 00:00:00','TALVEZ',NULL);

-- TESTE 18: UNIQUE (id_evento, cpf) em inscricao
INSERT INTO inscricao (id_inscricao, id_evento, cpf, data_inscricao, preco_contratado, desconto_aplicado, situacao_inscricao, pagamento_confirmado, observacao)
VALUES (98,1,'77777777777','2024-06-01 00:00:00',50.00,0.00,'CONFIRMADA',0,NULL);

-- TESTE 19: UNIQUE (id_socio, mes_referencia) em mensalidade
INSERT INTO mensalidade (id_mensalidade, id_socio, mes_referencia, valor_base, valor_acrescimos, valor_descontos, data_vencimento, situacao_mensalidade, data_geracao, observacao)
VALUES (99,1,'2024-05',150.00,0.00,0.00,'2024-05-10 00:00:00','PENDENTE','2024-05-01 00:00:00',NULL);

-- TESTE 20: UNIQUE numero_recibo em pagamento
INSERT INTO pagamento (id_pagamento, id_conta, id_contraparte, id_funcionario, id_pagamento_estornado, sentido, data_pagamento, valor_pago, forma_pagamento, numero_recibo, situacao_pagamento, observacao)
VALUES (99,1,1,2,NULL,'ENTRADA','2024-06-01 00:00:00',100.00,'PIX','REC-2024-0001','CONFIRMADO',NULL);