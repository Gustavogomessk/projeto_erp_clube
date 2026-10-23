USE clube_erp;
SET NAMES utf8mb4;

INSERT INTO pessoa VALUES
(1001,'Ana Lima','12345678901','ana@exemplo.com','1990-03-15','ATIVA'),
(1002,'Bruno Alves','12345678902','bruno@exemplo.com','1985-07-22','ATIVA'),
(1003,'Carla Souza','12345678903','carla@exemplo.com','2000-11-05','ATIVA'),
(1004,'Diego Reis','12345678904','diego@exemplo.com','1978-01-30','ATIVA'),
(1005,'Eva Rocha','12345678905','eva@exemplo.com','2010-09-12','ATIVA'),
(1006,'Marina Costa','12345678906','marina@exemplo.com','1988-04-18','ATIVA'),
(1007,'Paulo Santos','12345678907','paulo@exemplo.com','1982-12-02','ATIVA'),
(1008,'Lia Mendes','12345678908','lia@exemplo.com','1992-06-25','ATIVA');

INSERT INTO funcionario VALUES
(10,1006,'FUNC0001','Professor de Natação',3500.00,'2020-02-01'),
(11,1007,'FUNC0002','Professor de Futebol',3200.00,'2021-05-10'),
(12,1008,'FUNC0003','Professor de Tênis',3000.00,'2022-08-15');

INSERT INTO modalidade VALUES
(20,'Natação',50.00,'ATIVA'),
(21,'Futebol',30.00,'ATIVA'),
(22,'Tênis',80.00,'ATIVA'),
(23,'Vôlei',0.00,'ATIVA');

INSERT INTO matricula (id_pessoa, id_modalidade, periodo_ref, data_matricula, status) VALUES
(1001,20,'2026-08','2026-08-10','ATIVA'),
(1002,20,'2026-08','2026-08-10','ATIVA'),
(1003,21,'2026-08','2026-08-11','ATIVA'),
(1004,22,'2026-08','2026-08-11','CANCELADA'),
(1001,21,'2026-08','2026-08-12','ATIVA'),
(1005,23,'2026-08','2026-08-12','CONCLUIDA'),
(1001,20,'2026-02','2026-02-10','CONCLUIDA');

INSERT INTO funcionario_modalidade VALUES
(10,20,'2026-08'),
(11,21,'2026-08'),
(12,22,'2026-08'),
(10,23,'2026-08'),
(10,20,'2026-02');
