-- ATENÇÃO: EXECUTAR CADA INSERT SEPARADAMENTE; todos devem falhar.
-- As chaves estrangeiras (InnoDB) e os CHECKs (MySQL 8.0.16+) já são aplicados por padrão.
USE clube_erp;

-- TESTE 01: PK duplicada | Esperado: PRIMARY KEY
INSERT INTO pessoa VALUES (1001,'Outra Pessoa','99999999999','outra@exemplo.com','1995-01-01','ATIVA');

-- TESTE 02: CPF repetido | Esperado: UNIQUE
INSERT INTO pessoa VALUES (1009,'Teste CPF','12345678901','cpf@exemplo.com','1995-01-01','ATIVA');

-- TESTE 03: FK pessoa inexistente | Esperado: FOREIGN KEY
INSERT INTO matricula (id_pessoa, id_modalidade, periodo_ref, data_matricula, status) VALUES (9999,20,'2026-08','2026-08-20','ATIVA');

-- TESTE 04: FK modalidade inexistente | Esperado: FOREIGN KEY
INSERT INTO matricula (id_pessoa, id_modalidade, periodo_ref, data_matricula, status) VALUES (1001,999,'2026-08','2026-08-20','ATIVA');

-- TESTE 05: CHECK taxa negativa | Esperado: CHECK
INSERT INTO modalidade VALUES (90,'Modalidade Invalida',-40.00,'ATIVA');

-- TESTE 06: CHECK status inválido | Esperado: CHECK
INSERT INTO matricula (id_pessoa, id_modalidade, periodo_ref, data_matricula, status) VALUES (1002,21,'2026-08','2026-08-20','PENDENTE');

-- TESTE 07: NOT NULL ausente | Esperado: NOT NULL
INSERT INTO pessoa VALUES (1010,NULL,'12345678910','nulo@exemplo.com','1995-01-01','ATIVA');

-- TESTE 08: UNIQUE composto matrícula | Esperado: UNIQUE
INSERT INTO matricula (id_pessoa, id_modalidade, periodo_ref, data_matricula, status) VALUES (1001,20,'2026-08','2026-08-20','ATIVA');

-- TESTE 09: PK composta associativa | Esperado: PRIMARY KEY
INSERT INTO funcionario_modalidade VALUES (10,20,'2026-08');

-- TESTE 10: FK associativa | Esperado: FOREIGN KEY
INSERT INTO funcionario_modalidade VALUES (999,20,'2026-08');
