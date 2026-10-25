UPDATE pessoa SET status_pessoa = 'BLOQUEADA' WHERE cpf = '11111111111';
SELECT cpf, nome, status_pessoa FROM pessoa WHERE cpf = '11111111111';


UPDATE pessoa SET status_pessoa = 'ATIVA' WHERE cpf = '11111111111';
SELECT cpf, nome, status_pessoa FROM pessoa WHERE cpf = '11111111111';


INSERT INTO pessoa (cpf, nome, email, telefone, data_nascimento, status_pessoa, data_cadastro)
VALUES ('20202020202','Descartável','descartavel@exemplo.com','11999990077','1990-01-01 00:00:00','ATIVA','2024-06-01 00:00:00');

SELECT cpf, nome FROM pessoa WHERE cpf = '20202020202';
DELETE FROM pessoa WHERE cpf = '20202020202';
SELECT cpf, nome FROM pessoa WHERE cpf = '20202020202';  