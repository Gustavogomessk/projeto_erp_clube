-- Projeto ERP - Clube Social e Esportivo
-- Aula10_01: estrutura (DDL). Requer MySQL 8.0.16+ (para o CHECK ser aplicado).

CREATE DATABASE IF NOT EXISTS clube_erp CHARACTER SET utf8mb4;
USE clube_erp;
SET NAMES utf8mb4;

DROP TABLE IF EXISTS funcionario_modalidade;
DROP TABLE IF EXISTS matricula;
DROP TABLE IF EXISTS funcionario;
DROP TABLE IF EXISTS modalidade;
DROP TABLE IF EXISTS pessoa;

CREATE TABLE pessoa (
  id_pessoa INT NOT NULL,
  nome VARCHAR(100) NOT NULL,
  cpf CHAR(11) NOT NULL,
  email VARCHAR(100) NOT NULL,
  data_nascimento DATE NOT NULL,
  status_pessoa VARCHAR(10) NOT NULL,
  PRIMARY KEY (id_pessoa),
  CONSTRAINT uq_pessoa_cpf UNIQUE (cpf),
  CONSTRAINT uq_pessoa_email UNIQUE (email),
  CONSTRAINT ck_pessoa_cpf CHECK (CHAR_LENGTH(cpf) = 11),
  CONSTRAINT ck_pessoa_status CHECK (status_pessoa IN ('ATIVA','INATIVA','BLOQUEADA'))
);

CREATE TABLE funcionario (
  id_funcionario INT NOT NULL,
  id_pessoa INT NOT NULL,
  matricula_funcional VARCHAR(12) NOT NULL,
  cargo VARCHAR(50) NOT NULL,
  salario DECIMAL(10,2) NOT NULL,
  data_admissao DATE NOT NULL,
  PRIMARY KEY (id_funcionario),
  CONSTRAINT uq_func_pessoa UNIQUE (id_pessoa),
  CONSTRAINT uq_func_matricula UNIQUE (matricula_funcional),
  CONSTRAINT ck_func_salario CHECK (salario > 0),
  CONSTRAINT fk_func_pessoa FOREIGN KEY (id_pessoa) REFERENCES pessoa (id_pessoa)
);

CREATE TABLE modalidade (
  id_modalidade INT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  taxa_adicional DECIMAL(10,2) NOT NULL,
  situacao_modalidade VARCHAR(10) NOT NULL,
  PRIMARY KEY (id_modalidade),
  CONSTRAINT uq_modalidade_nome UNIQUE (nome),
  CONSTRAINT ck_modalidade_taxa CHECK (taxa_adicional >= 0),
  CONSTRAINT ck_modalidade_situacao CHECK (situacao_modalidade IN ('ATIVA','INATIVA'))
);

CREATE TABLE matricula (
  id_matricula INT NOT NULL AUTO_INCREMENT,
  id_pessoa INT NOT NULL,
  id_modalidade INT NOT NULL,
  periodo_ref CHAR(7) NOT NULL,
  data_matricula DATE NOT NULL,
  status VARCHAR(10) NOT NULL,
  PRIMARY KEY (id_matricula),
  CONSTRAINT uq_matricula UNIQUE (id_pessoa, id_modalidade, periodo_ref),
  CONSTRAINT ck_matricula_status CHECK (status IN ('ATIVA','CANCELADA','CONCLUIDA')),
  CONSTRAINT fk_matricula_pessoa FOREIGN KEY (id_pessoa) REFERENCES pessoa (id_pessoa),
  CONSTRAINT fk_matricula_modalidade FOREIGN KEY (id_modalidade) REFERENCES modalidade (id_modalidade)
);

CREATE TABLE funcionario_modalidade (
  id_funcionario INT NOT NULL,
  id_modalidade INT NOT NULL,
  periodo_ref CHAR(7) NOT NULL,
  PRIMARY KEY (id_funcionario, id_modalidade, periodo_ref),
  CONSTRAINT fk_fm_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario),
  CONSTRAINT fk_fm_modalidade FOREIGN KEY (id_modalidade) REFERENCES modalidade (id_modalidade)
);
