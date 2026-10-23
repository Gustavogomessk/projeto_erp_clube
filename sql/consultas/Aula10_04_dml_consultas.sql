USE clube_erp;
SET NAMES utf8mb4;

UPDATE matricula SET status='CONCLUIDA' WHERE id_pessoa=1001 AND id_modalidade=21;
SELECT * FROM matricula WHERE id_pessoa=1001;

-- Pessoa temporária, sem vínculos, para demonstrar o DELETE sem violar chave estrangeira
INSERT INTO pessoa VALUES (1099,'Pessoa Temporaria','12345678999','temporaria@exemplo.com','1999-09-09','ATIVA');
DELETE FROM pessoa WHERE id_pessoa=1099;

ALTER TABLE pessoa ADD COLUMN telefone VARCHAR(15);
UPDATE pessoa SET telefone='11999990001' WHERE id_pessoa=1001;
SELECT id_pessoa,nome,telefone FROM pessoa;
ALTER TABLE pessoa DROP COLUMN telefone;
