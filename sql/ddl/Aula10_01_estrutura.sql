CREATE DATABASE clube_erp;
USE clube_erp;
DROP TABLE IF EXISTS conciliacao;
DROP TABLE IF EXISTS item_extrato;
DROP TABLE IF EXISTS baixa_financeira;
DROP TABLE IF EXISTS pagamento;
DROP TABLE IF EXISTS titulo_financeiro;
DROP TABLE IF EXISTS conta_financeira;
DROP TABLE IF EXISTS contraparte_financeira;
DROP TABLE IF EXISTS mensalidade;
DROP TABLE IF EXISTS movimentacao_estoque;
DROP TABLE IF EXISTS item_venda;
DROP TABLE IF EXISTS venda;
DROP TABLE IF EXISTS estoque;
DROP TABLE IF EXISTS produto;
DROP TABLE IF EXISTS ocorrencia;
DROP TABLE IF EXISTS registro_acesso;
DROP TABLE IF EXISTS convite_visitante;
DROP TABLE IF EXISTS diretoria;
DROP TABLE IF EXISTS funcao_diretoria;
DROP TABLE IF EXISTS inscricao;
DROP TABLE IF EXISTS evento;
DROP TABLE IF EXISTS reserva;
DROP TABLE IF EXISTS dependencia_fisica;
DROP TABLE IF EXISTS exame_medico;
DROP TABLE IF EXISTS medico;
DROP TABLE IF EXISTS matricula;
DROP TABLE IF EXISTS turma_professor;
DROP TABLE IF EXISTS turma_horario;
DROP TABLE IF EXISTS turma;
DROP TABLE IF EXISTS atleta_modalidade;
DROP TABLE IF EXISTS modalidade;
DROP TABLE IF EXISTS atleta;
DROP TABLE IF EXISTS funcionario;
DROP TABLE IF EXISTS departamento;
DROP TABLE IF EXISTS dependente;
DROP TABLE IF EXISTS socio;
DROP TABLE IF EXISTS categoria_socio;
DROP TABLE IF EXISTS endereco;
DROP TABLE IF EXISTS cep;
DROP TABLE IF EXISTS pessoa;

CREATE TABLE pessoa (
cpf char(11) NOT NULL PRIMARY KEY CHECK(length(cpf)=11),
nome TEXT NOT NULL,
email char(100) NOT NULL UNIQUE,
telefone char(15),
data_nascimento timestamp NOT NULL,
status_pessoa TEXT NOT NULL CHECK(status_pessoa IN ('ATIVA','INATIVA','BLOQUEADA')),
data_cadastro timestamp NOT NULL);


CREATE TABLE cep (
cep char(8) PRIMARY KEY,
logradouro TEXT NOT NULL,
bairro TEXT NOT NULL,
cidade TEXT NOT NULL,
estado char(2) NOT NULL);

CREATE TABLE endereco (
id_endereco INTEGER PRIMARY KEY,
cpf char(11) NOT NULL,
cep char(8) NOT NULL,
numero TEXT NOT NULL,
complemento TEXT,
tipo_endereco TEXT NOT NULL CHECK(tipo_endereco IN ('RESIDENCIAL','COMERCIAL','OUTRO')),
endereco_principal INTEGER NOT NULL CHECK(endereco_principal IN (0,1)),
FOREIGN KEY(cpf) REFERENCES pessoa(cpf),
FOREIGN KEY(cep) REFERENCES cep(cep));

CREATE TABLE categoria_socio (
id_categoria_socio INTEGER PRIMARY KEY,
nome_categoria TEXT NOT NULL UNIQUE,
valor_mensalidade DECIMAL(10,2) NOT NULL CHECK(valor_mensalidade>=0),
descricao_beneficios TEXT,
situacao_categoria TEXT NOT NULL CHECK(situacao_categoria IN ('ATIVA','INATIVA')));

CREATE TABLE socio (
id_socio INTEGER PRIMARY KEY,
cpf char(11) NOT NULL UNIQUE,
numero_matricula char(12) NOT NULL UNIQUE,
id_categoria_socio INTEGER NOT NULL,
data_associacao timestamp NOT NULL,
data_desligamento timestamp,
situacao_socio TEXT NOT NULL CHECK(situacao_socio IN ('ATIVO','INADIMPLENTE','SUSPENSO','INATIVO')),
observacao TEXT,
FOREIGN KEY(cpf) REFERENCES pessoa(cpf),
FOREIGN KEY(id_categoria_socio) REFERENCES categoria_socio(id_categoria_socio));

CREATE TABLE dependente (
id_socio_titular INTEGER NOT NULL,
id_dependente INTEGER NOT NULL,
cpf char(11) NOT NULL,
tipo_dependencia TEXT NOT NULL CHECK(tipo_dependencia IN ('CONJUGE','FILHO','ENTEADO','PAIS')),
data_inicio_dependencia timestamp NOT NULL,
data_fim_dependencia timestamp,
situacao_dependente TEXT NOT NULL CHECK(situacao_dependente IN ('ATIVO','INATIVO')),
observacao TEXT,
PRIMARY KEY (id_socio_titular, id_dependente), 
FOREIGN KEY(id_socio_titular) REFERENCES socio(id_socio),
FOREIGN KEY(cpf) REFERENCES pessoa(cpf),
UNIQUE(cpf,data_inicio_dependencia));

CREATE TABLE departamento (
id_departamento INTEGER PRIMARY KEY,
nome_departamento TEXT NOT NULL UNIQUE,
descricao TEXT,
id_responsavel INTEGER UNIQUE,
situacao_departamento TEXT NOT NULL CHECK(situacao_departamento IN ('ATIVO','INATIVO')));


CREATE TABLE atleta (
id_atleta INTEGER PRIMARY KEY,
cpf char(11) NOT NULL,
id_socio INTEGER,
nivel_atleta TEXT NOT NULL CHECK(nivel_atleta IN ('INICIANTE','INTERMEDIARIO','AVANCADO','PROFISSIONAL')),
registro_federacao TEXT,
data_inicio_atividade timestamp NOT NULL,
situacao_atleta TEXT NOT NULL CHECK(situacao_atleta IN ('ATIVO','AFASTADO','LESIONADO','INATIVO')),
observacao TEXT,
FOREIGN KEY(cpf) REFERENCES pessoa(cpf),
FOREIGN KEY(id_socio) REFERENCES socio(id_socio));

CREATE TABLE modalidade (
id_modalidade INTEGER PRIMARY KEY,
nome_modalidade TEXT NOT NULL UNIQUE,
descricao TEXT,
taxa_adicional DECIMAL(10,2) CHECK(taxa_adicional>=0),
idade_minima INTEGER CHECK(idade_minima>=0),
idade_maxima INTEGER CHECK(idade_maxima>=0),
exige_exame_medico INTEGER NOT NULL CHECK(exige_exame_medico IN (0,1)),
situacao_modalidade TEXT NOT NULL CHECK(situacao_modalidade IN ('ATIVA','INATIVA')));

CREATE TABLE atleta_modalidade (
id_atleta_modalidade INTEGER PRIMARY KEY,
id_atleta INTEGER NOT NULL,
id_modalidade INTEGER NOT NULL,
data_inicio timestamp NOT NULL,
data_fim timestamp,
situacao_vinculo TEXT NOT NULL CHECK(situacao_vinculo IN ('ATIVO','INATIVO','SUSPENSO')),
observacao TEXT,
FOREIGN KEY(id_atleta) REFERENCES atleta(id_atleta),
FOREIGN KEY(id_modalidade) REFERENCES modalidade(id_modalidade),
UNIQUE(id_atleta,id_modalidade,data_inicio));


CREATE TABLE turma (
id_turma INTEGER PRIMARY KEY,
id_modalidade INTEGER NOT NULL,
nome_turma TEXT NOT NULL,
idade_minima INTEGER NOT NULL CHECK(idade_minima>=0),
idade_maxima INTEGER NOT NULL CHECK(idade_maxima>=0),
capacidade_maxima INTEGER NOT NULL CHECK(capacidade_maxima>0),
situacao_turma TEXT NOT NULL CHECK(situacao_turma IN ('ATIVA','INATIVA')),
observacao TEXT,
FOREIGN KEY(id_modalidade) REFERENCES modalidade(id_modalidade));


CREATE TABLE turma_horario (
id_turma_horario INTEGER PRIMARY KEY,
id_turma INTEGER NOT NULL,
dia_semana TEXT NOT NULL CHECK(dia_semana IN ('SEG','TER','QUA','QUI','SEX','SAB','DOM')),
hora_inicio char(5) NOT NULL,
hora_fim char(5) NOT NULL,
FOREIGN KEY(id_turma) REFERENCES turma(id_turma),
UNIQUE(id_turma,dia_semana));


CREATE TABLE funcionario (
id_funcionario INTEGER PRIMARY KEY,
cpf char(11) NOT NULL,
id_departamento INTEGER NOT NULL,
matricula_funcional char(12) NOT NULL UNIQUE,
cargo TEXT NOT NULL,
salario DECIMAL(10,2) NOT NULL CHECK(salario>0),
data_admissao timestamp NOT NULL,
data_demissao timestamp,
jornada_trabalho TEXT NOT NULL,
tipo_contrato TEXT NOT NULL CHECK(tipo_contrato IN ('CLT','PJ','ESTAGIARIO','TEMPORARIO')),
ctps_numero TEXT,
situacao_funcionario TEXT NOT NULL CHECK(situacao_funcionario IN ('ATIVO','AFASTADO','DESLIGADO')),
FOREIGN KEY(cpf) REFERENCES pessoa(cpf),
FOREIGN KEY(id_departamento) REFERENCES departamento(id_departamento));

CREATE TABLE turma_professor (
id_turma INTEGER NOT NULL,
id_funcionario INTEGER NOT NULL,
data_inicio timestamp NOT NULL,
data_fim timestamp,
situacao_vinculo TEXT NOT NULL CHECK(situacao_vinculo IN ('ATIVO','INATIVO')),
observacao TEXT,
primary key(id_turma,id_funcionario),
FOREIGN KEY(id_turma) REFERENCES turma(id_turma),
FOREIGN KEY(id_funcionario) REFERENCES funcionario(id_funcionario),
UNIQUE(id_turma,id_funcionario,data_inicio));


CREATE TABLE matricula (
id_matricula INTEGER PRIMARY KEY,
id_atleta INTEGER NOT NULL,
id_turma INTEGER NOT NULL,
data_matricula timestamp NOT NULL,
situacao_matricula TEXT NOT NULL CHECK(situacao_matricula IN ('ATIVA','CANCELADA','CONCLUIDA')),
observacao TEXT,
FOREIGN KEY(id_atleta) REFERENCES atleta(id_atleta),
FOREIGN KEY(id_turma) REFERENCES turma(id_turma),
UNIQUE(id_atleta,id_turma,data_matricula));


CREATE TABLE medico (
id_medico INTEGER PRIMARY KEY,
crm_medico TEXT NOT NULL UNIQUE,
nome_medico TEXT NOT NULL);

CREATE TABLE exame_medico (
id_exame_medico INTEGER PRIMARY KEY,
cpf char(11) NOT NULL,
id_medico INTEGER NOT NULL,
data_exame timestamp NOT NULL,
data_validade timestamp NOT NULL,
resultado TEXT NOT NULL CHECK(resultado IN ('APTO','INAPTO','COM_RESTRICAO')),
observacao TEXT,
FOREIGN KEY(cpf) REFERENCES pessoa(cpf),
FOREIGN KEY(id_medico) REFERENCES medico(id_medico));

CREATE TABLE dependencia_fisica (
id_dependencia INTEGER PRIMARY KEY,
nome_dependencia TEXT NOT NULL,
tipo_dependencia TEXT NOT NULL CHECK(tipo_dependencia IN ('QUADRA','PISCINA','SALAO','CAMPO')),
capacidade_maxima INTEGER CHECK(capacidade_maxima>0),
situacao_dependencia TEXT NOT NULL CHECK(situacao_dependencia IN ('DISPONIVEL','MANUTENCAO','DESATIVADA')),
observacao TEXT);

CREATE TABLE reserva (
id_reserva INTEGER PRIMARY KEY,
id_socio INTEGER NOT NULL,
id_dependencia INTEGER NOT NULL,
data_reserva timestamp NOT NULL,
hora_inicio char(5) NOT NULL,
hora_fim char(5) NOT NULL,
situacao_reserva TEXT NOT NULL CHECK(situacao_reserva IN ('CONFIRMADA','CANCELADA','CONCLUIDA')),
data_solicitacao timestamp NOT NULL,
observacao TEXT,
FOREIGN KEY(id_socio) REFERENCES socio(id_socio),
FOREIGN KEY(id_dependencia) REFERENCES dependencia_fisica(id_dependencia));

CREATE TABLE evento (
id_evento INTEGER PRIMARY KEY,
nome_evento TEXT NOT NULL,
descricao TEXT,
data_evento timestamp NOT NULL,
hora_inicio char(5) NOT NULL,
hora_fim char(5),
id_dependencia INTEGER,
capacidade_maxima INTEGER NOT NULL CHECK(capacidade_maxima>0),
valor_inscricao DECIMAL(10,2) CHECK(valor_inscricao>=0),
tipo_evento TEXT NOT NULL CHECK(tipo_evento IN ('ABERTO','RESTRITO')),
situacao_evento TEXT NOT NULL CHECK(situacao_evento IN ('PLANEJADO','INSCRICOES_ABERTAS','ENCERRADO','CANCELADO','REALIZADO')),
observacao TEXT,
FOREIGN KEY(id_dependencia) REFERENCES dependencia_fisica(id_dependencia));

CREATE TABLE inscricao (
id_inscricao INTEGER PRIMARY KEY,
id_evento INTEGER NOT NULL,
cpf char(11) NOT NULL,
data_inscricao timestamp NOT NULL,
preco_contratado DECIMAL(10,2) NOT NULL CHECK(preco_contratado>=0),
desconto_aplicado DECIMAL(10,2) NOT NULL CHECK(desconto_aplicado>=0),
situacao_inscricao TEXT NOT NULL CHECK(situacao_inscricao IN ('CONFIRMADA','CANCELADA','LISTA_ESPERA')),
pagamento_confirmado INTEGER CHECK(pagamento_confirmado IN (0,1)),
observacao TEXT,
FOREIGN KEY(id_evento) REFERENCES evento(id_evento),
FOREIGN KEY(cpf) REFERENCES pessoa(cpf),
UNIQUE(id_evento,cpf));

CREATE TABLE funcao_diretoria (
id_funcao_diretoria INTEGER PRIMARY KEY,
nome_funcao TEXT NOT NULL UNIQUE,
descricao TEXT,
ordem_hierarquica INTEGER,
situacao_funcao TEXT NOT NULL CHECK(situacao_funcao IN ('ATIVA','INATIVA')));

CREATE TABLE diretoria (
id_diretoria INTEGER PRIMARY KEY,
id_socio INTEGER NOT NULL,
id_funcao_diretoria INTEGER NOT NULL,
data_inicio_mandato timestamp NOT NULL,
data_fim_mandato timestamp,
situacao_mandato TEXT NOT NULL CHECK(situacao_mandato IN ('EM_ANDAMENTO','CONCLUIDO','RENUNCIADO')),
observacao TEXT,
FOREIGN KEY(id_socio) REFERENCES socio(id_socio),
FOREIGN KEY(id_funcao_diretoria) REFERENCES funcao_diretoria(id_funcao_diretoria),
UNIQUE(id_funcao_diretoria,data_inicio_mandato));

CREATE TABLE convite_visitante (
id_convite INTEGER PRIMARY KEY,
id_socio INTEGER NOT NULL,
cpf_visitante char(11) NOT NULL,
codigo_convite char(20) NOT NULL UNIQUE,
data_emissao timestamp NOT NULL,
data_validade timestamp NOT NULL,
situacao_convite TEXT NOT NULL CHECK(situacao_convite IN ('ATIVO','UTILIZADO','EXPIRADO','CANCELADO')),
observacao TEXT,
FOREIGN KEY(id_socio) REFERENCES socio(id_socio),
FOREIGN KEY(cpf_visitante) REFERENCES pessoa(cpf));

CREATE TABLE registro_acesso (
id_registro_acesso INTEGER PRIMARY KEY,
cpf char(11) NOT NULL,
id_convite INTEGER,
data_acesso timestamp NOT NULL,
hora_acesso char(5) NOT NULL,
tipo_acesso TEXT NOT NULL CHECK(tipo_acesso IN ('ENTRADA','SAIDA')),
meio_acesso TEXT CHECK(meio_acesso IN ('CARTEIRINHA','QR_CODE','BIOMETRIA')),
observacao TEXT,
FOREIGN KEY(cpf) REFERENCES pessoa(cpf),
FOREIGN KEY(id_convite) REFERENCES convite_visitante(id_convite));

CREATE TABLE ocorrencia (
id_ocorrencia INTEGER PRIMARY KEY,
cpf char(11) NOT NULL,
id_funcionario INTEGER NOT NULL,
id_ocorrencia_principal INTEGER,
data_ocorrencia timestamp NOT NULL,
hora_ocorrencia char(5) NOT NULL,
tipo_ocorrencia TEXT NOT NULL CHECK(tipo_ocorrencia IN ('ACIDENTE','ADVERTENCIA','DANO','OUTRO')),
descricao TEXT NOT NULL,
gravidade TEXT CHECK(gravidade IN ('BAIXA','MEDIA','ALTA')),
situacao_ocorrencia TEXT NOT NULL CHECK(situacao_ocorrencia IN ('ABERTA','EM_ANALISE','RESOLVIDA')),
providencia_tomada TEXT,
FOREIGN KEY(cpf) REFERENCES pessoa(cpf),
FOREIGN KEY(id_funcionario) REFERENCES funcionario(id_funcionario),
FOREIGN KEY(id_ocorrencia_principal) REFERENCES ocorrencia(id_ocorrencia));

CREATE TABLE produto (
id_produto INTEGER PRIMARY KEY,
nome_produto TEXT NOT NULL,
descricao TEXT,
categoria_produto TEXT,
valor_unitario DECIMAL(10,2) NOT NULL CHECK(valor_unitario>=0),
codigo_produto char(30) NOT NULL UNIQUE,
situacao_produto TEXT NOT NULL CHECK(situacao_produto IN ('ATIVO','INATIVO')),
observacao TEXT);


CREATE TABLE estoque (
id_estoque INTEGER PRIMARY KEY,
id_produto INTEGER NOT NULL UNIQUE,
quantidade_disponivel INTEGER NOT NULL CHECK(quantidade_disponivel>=0),
quantidade_minima INTEGER NOT NULL CHECK(quantidade_minima>=0),
data_atualizacao timestamp NOT NULL,
observacao TEXT,
FOREIGN KEY(id_produto) REFERENCES produto(id_produto));

CREATE TABLE venda (
id_venda INTEGER PRIMARY KEY,
cpf char(11) NOT NULL,
id_funcionario INTEGER NOT NULL,
data_venda timestamp NOT NULL,
valor_total DECIMAL(10,2) NOT NULL CHECK(valor_total>=0),
forma_pagamento TEXT NOT NULL CHECK(forma_pagamento IN ('PIX','DINHEIRO','CARTAO','A_PRAZO')),
situacao_venda TEXT NOT NULL CHECK(situacao_venda IN ('CONCLUIDA','CANCELADA')),
observacao TEXT,
FOREIGN KEY(cpf) REFERENCES pessoa(cpf),
FOREIGN KEY(id_funcionario) REFERENCES funcionario(id_funcionario));


CREATE TABLE item_venda (
id_venda INTEGER NOT NULL,
id_produto INTEGER NOT NULL,
quantidade INTEGER NOT NULL CHECK(quantidade>0),
valor_unitario DECIMAL(10,2) NOT NULL CHECK(valor_unitario>=0),
observacao TEXT,
PRIMARY KEY(id_venda,id_produto),
FOREIGN KEY(id_venda) REFERENCES venda(id_venda),
FOREIGN KEY(id_produto) REFERENCES produto(id_produto),
UNIQUE(id_venda,id_produto));


CREATE TABLE mensalidade (
id_mensalidade INTEGER PRIMARY KEY,
id_socio INTEGER NOT NULL,
mes_referencia char(7) NOT NULL,
valor_base DECIMAL(10,2) NOT NULL CHECK(valor_base>=0),
valor_acrescimos DECIMAL(10,2) NOT NULL CHECK(valor_acrescimos>=0),
valor_descontos DECIMAL(10,2) NOT NULL CHECK(valor_descontos>=0),
data_vencimento timestamp NOT NULL,
situacao_mensalidade TEXT NOT NULL CHECK(situacao_mensalidade IN ('PENDENTE','PAGO','ATRASADO','CANCELADO')),
data_geracao timestamp NOT NULL,
observacao TEXT,
FOREIGN KEY(id_socio) REFERENCES socio(id_socio),
UNIQUE(id_socio,mes_referencia));

CREATE TABLE contraparte_financeira (
id_contraparte INTEGER PRIMARY KEY,
tipo_pessoa char(2) NOT NULL CHECK(tipo_pessoa IN ('PF','PJ')),
cpf char(11),
cnpj char(14),
razao_social TEXT,
FOREIGN KEY(cpf) REFERENCES pessoa(cpf));

CREATE TABLE conta_financeira (
id_conta INTEGER PRIMARY KEY,
nome_conta TEXT NOT NULL UNIQUE,
tipo_conta TEXT NOT NULL CHECK(tipo_conta IN ('BANCARIA','CAIXA')),
banco TEXT,
agencia TEXT,
numero_conta TEXT,
saldo_inicial DECIMAL(12,2) NOT NULL,
situacao_conta TEXT NOT NULL CHECK(situacao_conta IN ('ATIVA','INATIVA')));

CREATE TABLE titulo_financeiro (
id_titulo INTEGER PRIMARY KEY,
natureza TEXT NOT NULL CHECK(natureza IN ('RECEBER','PAGAR')),
id_contraparte INTEGER NOT NULL,
origem_tipo TEXT NOT NULL CHECK(origem_tipo IN ('MENSALIDADE','INSCRICAO','VENDA','RECEITA_MANUAL','DESPESA')),
id_mensalidade INTEGER UNIQUE,
id_inscricao INTEGER UNIQUE,
id_venda INTEGER UNIQUE,
descricao TEXT,
valor_original DECIMAL(10,2) NOT NULL CHECK(valor_original>0),
valor_desconto DECIMAL(10,2) NOT NULL CHECK(valor_desconto>=0),
valor_acrescimo DECIMAL(10,2) NOT NULL CHECK(valor_acrescimo>=0),
saldo_aberto DECIMAL(10,2) NOT NULL CHECK(saldo_aberto>=0),
data_emissao timestamp NOT NULL,
data_vencimento timestamp NOT NULL,
situacao_titulo TEXT NOT NULL CHECK(situacao_titulo IN ('ABERTO','PARCIAL','LIQUIDADO','CANCELADO')),
FOREIGN KEY(id_contraparte) REFERENCES contraparte_financeira(id_contraparte),
FOREIGN KEY(id_mensalidade) REFERENCES mensalidade(id_mensalidade),
FOREIGN KEY(id_inscricao) REFERENCES inscricao(id_inscricao),
FOREIGN KEY(id_venda) REFERENCES venda(id_venda));

CREATE TABLE pagamento (
id_pagamento INTEGER PRIMARY KEY,
id_conta INTEGER NOT NULL,
id_contraparte INTEGER NOT NULL,
id_funcionario INTEGER NOT NULL,
id_pagamento_estornado INTEGER UNIQUE,
sentido TEXT NOT NULL CHECK(sentido IN ('ENTRADA','SAIDA')),
data_pagamento timestamp NOT NULL,
valor_pago DECIMAL(10,2) NOT NULL CHECK(valor_pago>0),
forma_pagamento TEXT NOT NULL CHECK(forma_pagamento IN ('BOLETO','CARTAO','PIX','DINHEIRO','TRANSFERENCIA')),
numero_recibo char(20) NOT NULL UNIQUE,
situacao_pagamento TEXT NOT NULL CHECK(situacao_pagamento IN ('PENDENTE','CONFIRMADO','ESTORNADO','ESTORNO')),
observacao TEXT,
FOREIGN KEY(id_conta) REFERENCES conta_financeira(id_conta),
FOREIGN KEY(id_contraparte) REFERENCES contraparte_financeira(id_contraparte),
FOREIGN KEY(id_funcionario) REFERENCES funcionario(id_funcionario),
FOREIGN KEY(id_pagamento_estornado) REFERENCES pagamento(id_pagamento));

CREATE TABLE baixa_financeira (
id_baixa INTEGER PRIMARY KEY,
id_pagamento INTEGER NOT NULL,
id_titulo INTEGER NOT NULL,
valor_baixa DECIMAL(10,2) NOT NULL CHECK(valor_baixa>0),
data_baixa timestamp NOT NULL,
FOREIGN KEY(id_pagamento) REFERENCES pagamento(id_pagamento),
FOREIGN KEY(id_titulo) REFERENCES titulo_financeiro(id_titulo),
UNIQUE(id_pagamento,id_titulo));

CREATE TABLE item_extrato (
id_item_extrato INTEGER PRIMARY KEY,
id_conta INTEGER NOT NULL,
identificador_externo TEXT NOT NULL,
data_lancamento timestamp NOT NULL,
descricao TEXT,
valor DECIMAL(12,2) NOT NULL CHECK(valor>0),
sentido TEXT NOT NULL CHECK(sentido IN ('ENTRADA','SAIDA')),
situacao_conciliacao TEXT NOT NULL CHECK(situacao_conciliacao IN ('PENDENTE','PARCIAL','CONCILIADO','DIVERGENTE')),
FOREIGN KEY(id_conta) REFERENCES conta_financeira(id_conta),
UNIQUE(id_conta,identificador_externo));

CREATE TABLE conciliacao (
id_conciliacao INTEGER PRIMARY KEY,
id_item_extrato INTEGER NOT NULL,
id_pagamento INTEGER NOT NULL,
id_funcionario INTEGER NOT NULL,
valor_conciliado DECIMAL(12,2) NOT NULL CHECK(valor_conciliado>0),
data_conciliacao timestamp NOT NULL,
observacao TEXT,
FOREIGN KEY(id_item_extrato) REFERENCES item_extrato(id_item_extrato),
FOREIGN KEY(id_pagamento) REFERENCES pagamento(id_pagamento),
FOREIGN KEY(id_funcionario) REFERENCES funcionario(id_funcionario),
UNIQUE(id_item_extrato,id_pagamento));
