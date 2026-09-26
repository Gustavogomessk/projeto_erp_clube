# Projeto ERP — Clube Social e Esportivo

**Modelagem Conceitual de Banco de Dados**

---

## 1. Identificação da Equipe

| Nome | Função | Responsabilidade |
|---|---|---|
| Guilherme Hiroshi | Coordenador | Gestão do projeto e documentação |
| Juan, Pedro Elias, Paola e Jonathan | Analista de Requisitos | Levantamento de requisitos, regras de Negócio e cardinalidades |
| Vitor, Gustavo Gomes e Danilo | Modelador de Dados | DER e dicionário de dados |
| Lucas e João Victor | Revisor Técnico | Validação e consistência |

---

## 3. Justificativa da Escolha

Escolhemos um clube social e esportivo porque apresenta:

| Critério | Justificativa |
|---|---|
| **Complexidade de dados** | Envolve múltiplos perfis de pessoas (sócios, dependentes, atletas, funcionários) |
| **Relacionamentos ricos** | Sócios possuem dependentes, atletas praticam várias modalidades, funcionários trabalham em departamentos |
| **Processos variados** | Cadastro, mensalidades, reservas, eventos, aulas esportivas |
| **Regras de negócio claras** | Categorias de sócio, mensalidades em dia, limitação de dependentes |
| **Situações N:N reais** | Atleta × Modalidade, Sócio × Evento, Funcionário × Turma |
| **Escalabilidade** | O modelo pode crescer para incluir financeiro, estoque, manutenção |
| **Aplicabilidade prática** | Representa um negócio real com necessidades reais de banco de dados |

---

## 4. Problemas Identificados

| # | Problema | Impacto | Solução Proposta |
|---|---|---|---|
| 1 | Cadastro de sócios em planilhas Excel | Dados duplicados e inconsistentes | Entidade PESSOA e SÓCIO com identificação única |
| 2 | Controle manual de mensalidades | Pagamentos não rastreados, inadimplência | Entidade MENSALIDADE e PAGAMENTO |
| 3 | Dependência de sócios sem controle | Dependentes sem vínculo identificado | Entidade DEPENDENTE com vínculo a SÓCIO |
| 4 | Atletas sem registro de modalidades | Dificuldade de gerenciar equipes | Entidade MODALIDADE e relacionamento N:N |
| 5 | Reservas de quadras em caderno físico | Conflitos de horário, perda de reservas | Entidade RESERVA com controle de data/hora |
| 6 | Eventos divulgados sem controle | Sem controle de participantes | Entidade EVENTO e INSCRIÇÃO |
| 7 | Funcionários sem vínculo a departamentos | Falta de organização administrativa | Entidade DEPARTAMENTO |
| 8 | Turmas de aulas sem controle de alunos | Dificuldade de gerenciar vagas | Entidade TURMA e MATRÍCULA |

---

## 5. Processos de Negócio

### Processo 1: Cadastro de Sócio

1- A pessoa procura o clube.

2- Ela preenche o formulário de cadastro.

3- O funcionário verifica o CPF informado.

Se o CPF já estiver cadastrado:

-Verifica se a pessoa já é sócia.

Se já for sócia:

-Os dados são atualizados, se necessário.

-O processo é encerrado.

Se não for sócia:

-É criada uma nova matrícula.

-A categoria do sócio é definida.

-A data de associação é registrada.

-É emitido o boleto da primeira mensalidade.

-O processo é encerrado.

Se o CPF não estiver cadastrado:

-A nova pessoa é cadastrada no sistema.

-Em seguida, é criada uma nova matrícula.

-A categoria do sócio é definida.

-A data de associação é registrada.

-É emitido o boleto da primeira mensalidade.

-O processo é encerrado.


### Processo 2: Matrícula em Modalidade Esportiva


Processo de Matrícula em Modalidade
1- O sócio ou dependente deseja praticar uma modalidade.
2- O funcionário verifica a categoria do sócio.
3- O sistema verifica se o sócio está ativo.
Se o sócio não estiver ativo:
-As pendências são informadas.
-O processo é encerrado.
Se o sócio estiver ativo:
-O funcionário verifica se existem vagas disponíveis na modalidade.
Se não houver vaga:
-O sócio ou dependente é colocado na lista de espera.
-O processo é encerrado.
Se houver vaga:
-A matrícula é registrada.
-O participante é vinculado a uma turma.
-O nível é definido como iniciante, intermediário ou avançado.
-A data de início é registrada.
-Caso exista alguma taxa adicional, a cobrança é gerada.
-O processo é encerrado.



### Processo 3: Reserva de Dependência Física


svgsvg

INÍCIO
↓
[Sócio solicita reserva]
↓
[Funcionário verifica disponibilidade]
↓
[Dependência disponível na data/hora?]
├── NÃO → [Informa horários disponíveis] → FIM
└── SIM → [Verifica situação do sócio]
↓
[Mensalidade em dia?]
├── NÃO → [Bloqueia reserva] → FIM
└── SIM → [Registra reserva]
↓
[Confirma com sócio]
↓
[Registra responsável pela reserva] → FIM

text

### Processo 4: Contratação de Funcionário


svgsvg

INÍCIO
↓
[Departamento solicita contratação]
↓
[Diretoria aprova vaga]
↓
[RH recebe candidatos]
↓
[Seleciona candidato]
↓
[Cadastra dados pessoais (PESSOA)]
↓
[Vincula como FUNCIONÁRIO]
↓
[Define cargo e departamento]
↓
[Registra data de admissão]
↓
[Define salário e jornada]
↓
[Gera matrícula funcional] → FIM

text

### Processo 5: Organização de Evento


svgsvg

INÍCIO
↓
[Diretoria aprova evento]
↓
[Define data, local e público-alvo]
↓
[Funcionário cadastra evento]
↓
[Define capacidade máxima]
↓
[Define valor da inscrição (se houver)]
↓
[Abre inscrições para sócios]
↓
[Sócios se inscrevem]
↓
[Vagas preenchidas?]
├── NÃO → [Aguarda mais inscrições]
└── SIM → [Encerra inscrições]
↓
[Registra participantes]
↓
[Realiza evento] → FIM

text

---

## 6. Requisitos Funcionais

### RF01 — Cadastro de Pessoas

**Descrição:** O sistema deve permitir o cadastro de pessoas com os seguintes dados: nome completo, CPF, data de nascimento, telefone, email e endereço completo.

**Regras:**
- CPF deve ser único e validado
- Nome é obrigatório
- Telefone pode ser informado posteriormente

### RF02 — Cadastro de Sócios

**Descrição:** O sistema deve permitir vincular uma pessoa como sócio do clube.

**Regras:**
- Toda pessoa cadastrada pode se tornar sócio
- Número de matrícula é gerado automaticamente e único
- Categoria do sócio deve ser definida no momento do cadastro
- Data de associação é obrigatória
- Situação inicial: Ativo

### RF03 — Cadastro de Dependentes

**Descrição:** O sistema deve permitir o cadastro de dependentes vinculados a um sócio titular.

**Regras:**
- Dependente deve possuir vínculo com apenas um sócio titular
- Tipos de dependência: Cônjuge, Filho(a), Enteado(a), Pais
- Dependente menor de idade deve possuir responsável legal
- Dependente pode se tornar sócio titular futuramente

### RF04 — Cadastro de Funcionários

**Descrição:** O sistema deve permitir o cadastro de funcionários do clube.

**Regras:**
- Funcionário deve ser vinculado a um departamento
- Cargo deve ser definido no cadastro
- Data de admissão é obrigatória
- Data de demissão é opcional
- CTPS é obrigatória para funcionários CLT

### RF05 — Cadastro de Atletas

**Descrição:** O sistema deve permitir identificar pessoas como atletas do clube.

**Regras:**
- Atleta pode ser sócio, dependente ou pessoa externa
- Atleta deve estar vinculado a pelo menos uma modalidade
- Nível do atleta deve ser definido
- Registro em federação é opcional

### RF06 — Gestão de Modalidades

**Descrição:** O sistema deve permitir o cadastro de modalidades esportivas oferecidas.

**Regras:**
- Cada modalidade possui nome único
- Modalidade pode estar ativa ou inativa
- Modalidade pode exigir taxa adicional

### RF07 — Gestão de Turmas

**Descrição:** O sistema deve permitir a criação de turmas para cada modalidade.

**Regras:**
- Turma pertence a uma única modalidade
- Turma possui faixa etária definida
- Turma possui capacidade máxima de alunos
- Turma pode ter um ou mais professores

### RF08 — Controle de Mensalidades

**Descrição:** O sistema deve permitir o controle de mensalidades dos sócios.

**Regras:**
- Mensalidade é gerada mensalmente para cada sócio titular
- Valor varia conforme categoria do sócio
- Dependentes podem gerar acréscimo na mensalidade
- Mensalidade pode ter desconto
- Status: Pendente, Pago, Atrasado, Cancelado

### RF09 — Gestão de Pagamentos

**Descrição:** O sistema deve registrar os pagamentos de mensalidades.

**Regras:**
- Pagamento é vinculado a uma mensalidade
- Pagamento possui data, valor e forma de pagamento
- Pagamento pode ser parcial
- Pagamento gera recibo

### RF10 — Reserva de Dependências

**Descrição:** O sistema deve permitir a reserva de dependências físicas do clube.

**Regras:**
- Reserva é feita por um sócio titular
- Reserva é vinculada a uma dependência física
- Reserva possui data, hora de início e hora de término
- Reserva não pode conflitar com outra
- Sócio inadimplente não pode realizar reserva

### RF11 — Gestão de Eventos

**Descrição:** O sistema deve permitir o cadastro e controle de eventos do clube.

**Regras:**
- Evento possui nome, data, horário, local e capacidade máxima
- Evento pode ser gratuito ou pago
- Evento pode ser aberto ao público ou restrito a sócios
- Status: Planejado, Inscrições abertas, Encerrado, Cancelado, Realizado

### RF12 — Inscrição em Eventos

**Descrição:** O sistema deve permitir a inscrição de sócios e dependentes em eventos.

**Regras:**
- Inscrição é vinculada a um evento e a uma pessoa
- Inscrição possui data de realização
- Inscrição pode ser cancelada
- Evento com capacidade lotada não aceita novas inscrições

### RF13 — Gestão de Departamentos

**Descrição:** O sistema deve permitir o cadastro de departamentos administrativos do clube.

**Regras:**
- Departamento possui nome único
- Departamento possui responsável (funcionário)
- Departamento pode ter subdivisões

### RF14 — Gestão de Diretoria

**Descrição:** O sistema deve permitir o registro de mandatos da diretoria do clube.

**Regras:**
- Cargo diretivo é ocupado por um sócio
- Mandato possui data de início e data de término
- Um sócio pode ocupar vários cargos em mandatos diferentes
- Um cargo pode ser ocupado por vários sócios ao longo do tempo

---

## 7. Requisitos Não Funcionais

### RNF01 — Segurança
- O sistema deve exigir autenticação para acesso
- Senhas devem ser armazenadas de forma criptografada
- Acesso por perfil (administrador, funcionário, sócio)
- Dados de CPF devem ser mascarados para consulta pública

### RNF02 — Desempenho
- Consultas devem responder em menos de 3 segundos
- Relatórios mensais devem ser gerados em menos de 10 segundos
- Sistema deve suportar 50 usuários simultâneos

### RNF03 — Disponibilidade
- Sistema deve estar disponível 99% do tempo
- Manutenções programadas em horários de baixo uso

### RNF04 — Usabilidade
- Interface intuitiva
- Formulários com validação de dados
- Mensagens de erro claras
- Responsivo para dispositivos móveis

### RNF05 — Compatibilidade
- Funcionar nos navegadores: Chrome, Firefox, Edge
- Compatível com Windows 10/11 e Linux
- Compatível com dispositivos móveis (Android e iOS)

### RNF06 — Backup e Recuperação
- Backup automático diário
- Backup semanal completo
- Capacidade de restauração em até 24 horas

### RNF07 — Escalabilidade
- Arquitetura modular
- Capacidade de adicionar novos módulos
- Capacidade de expandir número de sócios sem perda de desempenho

---

## 8. Regras de Negócio

| # | Regra | Impacto no Modelo |
|---|---|---|
| **RN01** | Toda pessoa cadastrada deve possuir CPF único e válido | Atributo CPF na entidade PESSOA deve ser único |
| **RN02** | Todo dependente deve estar vinculado a exatamente um sócio titular | Relacionamento SÓCIO (0,N) — POSSUI — DEPENDENTE (1,1) |
| **RN03** | Categorias de sócio definem valor da mensalidade e benefícios | Entidade CATEGORIA_SOCIO com atributos de valor |
| **RN04** | Sócio pode estar: Ativo, Inadimplente, Suspenso, Inativo, Em análise | Atributo situacao_socio na entidade SÓCIO |
| **RN05** | Atleta deve estar matriculado em pelo menos uma modalidade | Relacionamento N:N entre ATLETA e MODALIDADE |
| **RN06** | Cada turma possui número máximo de alunos | Atributo capacidade_maxima na entidade TURMA |
| **RN07** | Somente sócios titulares Ativos podem realizar reservas | Regra de validação na entidade RESERVA |
| **RN08** | Cargos de diretoria são ocupados por sócios com mandato definido | Entidade DIRETORIA com atributos de período |
| **RN09** | Dependente pode se tornar sócio titular | Atributo situacao_dependente e histórico |
| **RN10** | Valor da mensalidade é definido pela categoria do sócio | Relacionamento entre CATEGORIA_SOCIO e MENSALIDADE |
| **RN11** | Pagamento pode ser parcial | Atributos valor_pago e valor_total em MENSALIDADE |
| **RN12** | Eventos podem ser restritos a sócios ou abertos ao público | Atributo tipo_evento na entidade EVENTO |
| **RN13** | Funcionário pode também ser sócio | PESSOA pode ter vínculo com SÓCIO e FUNCIONÁRIO |
| **RN14** | Atleta externo pode ser convidado sem ser sócio | ATLETA pode existir sem vínculo com SÓCIO |
| **RN15** | Reservas com mínimo 24h e máximo 30 dias de antecedência | Regra de validação na entidade RESERVA |
| **RN16** | Um sócio pode cadastrar vários dependentes | Relacionamento SÓCIO (0,N) — POSSUI — DEPENDENTE (1,1) |
| **RN17** | Um dependente pertence a apenas um sócio	|Chave estrangeira id_socio_titular na entidade DEPENDENTE |
| **RN18** | Dependente perde o vínculo ao atingir a idade limite da categoria do plano.	| Regra de validação de idade e atualização de situacao_dependente |
| **RN19** | Um sócio pode participar de várias atividades | Relacionamento SÓCIO × ATIVIDADE com cardinalidade N	 |
| **RN20** | Um professor pode ministrar várias atividades | Relacionamento PROFESSOR/FUNCIONÁRIO × ATIVIDADE	 |
| **RN21** | Uma mensalidade pode possuir vários pagamentos parciais até sua quitação | Relacionamento MENSALIDADE (0,N) — RECEBE — PAGAMENTO (1,1) |
| **RN22** | Não é permitida a reserva de uma dependência já reservada no mesmo horário | Validação de conflito de data e horário na entidade RESERVA |
| **RN23** | Toda reserva deve estar vinculada a um sócio responsável | Toda reserva deve estar vinculada a um sócio responsável |
| **RN24** | A reserva é automaticamente cancelada se a mensalidade do sócio responsável não for paga | Regra automática de atualização de situacao_reserva |
| **RN25** | A categoria do plano define quais dependências o sócio pode reservar | Relacionamento/regra de permissão entre CATEGORIA_SOCIO e DEPENDENCIA_FISICA |





### Tabela de Categorias de Sócio (RN03)

| Categoria | Valor Mensalidade | Benefícios |
|---|---|---|
| Titular | R$ 200,00 | Acesso total ao clube |
| Dependente | R$ 100,00 | Acesso vinculado ao titular |
| Convidado | R$ 150,00 | Acesso limitado |
| Atleta | R$ 180,00 | Acesso total + esportes |
| Sênior | R$ 120,00 | Acesso total (acima de 60 anos) |
| Infantil | R$ 80,00 | Acesso limitado (até 12 anos) |

---

## 9. Restrições e Políticas Organizacionais

### 9.1 Restrições Legais
- Dados pessoais devem seguir a LGPD (Lei Geral de Proteção de Dados)
- CPF não pode ser exibido publicamente
- Menores de idade precisam de responsável legal cadastrado

### 9.2 Restrições Operacionais
- Reservas só podem ser feitas no horário de funcionamento (6h às 22h)
- O clube fecha às segundas-feiras para manutenção
- Eventos com mais de 100 pessoas precisam de autorização da diretoria
- Uso da churrasqueira requer reserva com mínimo de 48 horas de antecedência

### 9.3 Políticas Organizacionais
- Dependentes de sócios titulares têm prioridade em vagas de modalidades
- Funcionários têm desconto de 50% na mensalidade de sócio
- Sócios com mais de 10 anos de associação recebem desconto de 10%
- Cancelamento de inscrição em evento com menos de 48 horas não gera reembolso

---

## 10. Entidades Identificadas

| # | Entidade | Justificativa | Origem |
|---|---|---|---|
| 1 | **PESSOA** | Entidade central que armazena dados básicos de todas as pessoas | RF01 |
| 2 | **SÓCIO** | Especialização de PESSOA com dados de associação | RF02 |
| 3 | **DEPENDENTE** | Pessoa vinculada a um sócio titular | RF03 |
| 4 | **FUNCIONÁRIO** | Especialização de PESSOA com dados trabalhistas | RF04 |
| 5 | **ATLETA** | Especialização de PESSOA com dados esportivos | RF05 |
| 6 | **MODALIDADE** | Esportes oferecidos pelo clube | RF06 |
| 7 | **CATEGORIA_SOCIO** | Tipos de sócio com valores de mensalidade | RN03 |
| 8 | **DEPARTAMENTO** | Setores administrativos do clube | RF13 |
| 9 | **DEPENDENCIA_FISICA** | Estruturas físicas do clube | RF10 |
| 10 | **RESERVA** | Registro de reservas de dependências | RF10 |
| 11 | **EVENTO** | Eventos realizados pelo clube | RF11 |
| 12 | **INSCRIÇÃO** | Inscrição de pessoas em eventos | RF12 |
| 13 | **MENSALIDADE** | Mensalidades geradas para sócios | RF08 |
| 14 | **PAGAMENTO** | Pagamentos de mensalidades | RF09 |
| 15 | **TURMA** | Turmas de modalidades esportivas | RF07 |
| 16 | **MATRÍCULA** | Matrícula de atletas em turmas | RF05 |
| 17 | **DIRETORIA** | Cargos diretivos ocupados por sócios | RF14 |
| 18 | **FUNCAO_DIRETORIA** | Funções/cargos da diretoria | RF14 |
| 19* | **ATLETA_MODALIDADE** | Entidade associativa (ATLETA × MODALIDADE) | RN05 |
| 20* | **TURMA_PROFESSOR** | Entidade associativa (FUNCIONÁRIO × TURMA) | RF07 |

> *Entidades associativas para resolver relacionamentos N:N

### Nota sobre "POLÍTICO"

Após análise, substituímos a entidade "Político" por **DIRETORIA** e **FUNCAO_DIRETORIA**, pois:
- O termo "político" é vago e não representa claramente o contexto
- O clube possui uma diretoria eleita com cargos definidos
- Os cargos são ocupados por sócios titulares com mandato definido
- Essa modelagem representa melhor a realidade do clube

---

## 11. Atributos

### 11.1 PESSOA

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_pessoa | Identificador | Sim | Sim | Identificador único da pessoa |
| nome_completo | Texto(100) | Sim | Não | Nome completo da pessoa |
| cpf | Texto(11) | Sim | Sim | Cadastro de Pessoa Física |
| data_nascimento | Data | Sim | Não | Data de nascimento |
| telefone | Texto(15) | Não | Não | Telefone de contato |
| email | Texto(100) | Não | Não | Endereço de email |
| endereco_logradouro | Texto(100) | Sim | Não | Rua, avenida |
| endereco_numero | Texto(10) | Sim | Não | Número do endereço |
| endereco_complemento | Texto(50) | Não | Não | Complemento |
| endereco_bairro | Texto(50) | Sim | Não | Bairro |
| endereco_cidade | Texto(50) | Sim | Não | Cidade |
| endereco_estado | Texto(2) | Sim | Não | UF |
| endereco_cep | Texto(8) | Sim | Não | CEP |
| status_pessoa | Texto(10) | Sim | Não | Ativa, Inativa, Bloqueada |
| data_cadastro | Data/Hora | Sim | Não | Data de cadastro no sistema |

### 11.2 SÓCIO

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_socio | Identificador | Sim | Sim | Identificador único do sócio |
| id_pessoa | Referência | Sim | Sim | FK para PESSOA |
| numero_matricula | Texto(12) | Sim | Sim | Formato: CSEU-0000 |
| id_categoria_socio | Referência | Sim | Não | FK para CATEGORIA_SOCIO |
| data_associacao | Data | Sim | Não | Data em que se tornou sócio |
| data_desligamento | Data | Não | Não | Somente se situação = Inativo |
| situacao_socio | Texto(15) | Sim | Não | Ativo, Inadimplente, Suspenso, Inativo |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 11.3 DEPENDENTE

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_dependente | Identificador | Sim | Sim | Identificador único |
| id_socio_titular | Referência | Sim | Não | FK para SÓCIO |
| id_pessoa | Referência | Sim | Sim | FK para PESSOA |
| tipo_dependencia | Texto(20) | Sim | Não | Cônjuge, Filho(a), Enteado(a), Pais |
| data_inicio_dependencia | Data | Sim | Não | Data de início do vínculo |
| data_fim_dependencia | Data | Não | Não | Somente se desvinculado |
| situacao_dependente | Texto(10) | Sim | Não | Ativo, Inativo |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 11.4 FUNCIONÁRIO

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_funcionario | Identificador | Sim | Sim | Identificador único |
| id_pessoa | Referência | Sim | Sim | FK para PESSOA |
| id_departamento | Referência | Sim | Não | FK para DEPARTAMENTO |
| matricula_funcional | Texto(12) | Sim | Sim | Formato: FUNC-0000 |
| cargo | Texto(50) | Sim | Não | Ex: Professor, Porteiro |
| salario | Decimal(10,2) | Sim | Não | Valor > 0 |
| data_admissao | Data | Sim | Não | Data de contratação |
| data_demissao | Data | Não | Não | Somente se desligado |
| jornada_trabalho | Texto(10) | Sim | Não | Ex: 40h, 20h |
| tipo_contrato | Texto(15) | Sim | Não | CLT, PJ, Estagiário, Temporário |
| ctps_numero | Texto(20) | Não | Não | Obrigatório para CLT |
| situacao_funcionario | Texto(15) | Sim | Não | Ativo, Afastado, Desligado |

### 11.5 ATLETA

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_atleta | Identificador | Sim | Sim | Identificador único |
| id_pessoa | Referência | Sim | Sim | FK para PESSOA |
| id_socio | Referência | Não | Não | FK para SÓCIO (pode ser nulo) |
| nivel_atleta | Texto(15) | Sim | Não | Iniciante, Intermediário, Avançado, Profissional |
| registro_federacao | Texto(30) | Não | Não | Registro em federação |
| data_inicio_atividade | Data | Sim | Não | Data de início no clube |
| situacao_atleta | Texto(15) | Sim | Não | Ativo, Afastado, Lesionado, Inativo |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 11.6 MODALIDADE

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_modalidade | Identificador | Sim | Sim | Identificador único |
| nome_modalidade | Texto(50) | Sim | Sim | Ex: Natação, Futebol, Tênis |
| descricao | Texto(500) | Não | Não | Descrição da modalidade |
| taxa_adicional | Decimal(10,2) | Não | Não | Valor >= 0 |
| idade_minima | Inteiro | Não | Não | Idade mínima para participação |
| idade_maxima | Inteiro | Não | Não | Idade máxima para participação |
| situacao_modalidade | Texto(10) | Sim | Não | Ativa, Inativa |

### 11.7 CATEGORIA_SOCIO

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_categoria_socio | Identificador | Sim | Sim | Identificador único |
| nome_categoria | Texto(50) | Sim | Sim | Ex: Titular, Dependente, Atleta |
| valor_mensalidade | Decimal(10,2) | Sim | Não | Valor > 0 |
| descricao_beneficios | Texto(500) | Não | Não | Descrição dos benefícios |
| situacao_categoria | Texto(10) | Sim | Não | Ativa, Inativa |

### 11.8 DEPARTAMENTO

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_departamento | Identificador | Sim | Sim | Identificador único |
| nome_departamento | Texto(50) | Sim | Sim | Ex: Financeiro, RH, Esportes |
| descricao | Texto(500) | Não | Não | Descrição das responsabilidades |
| id_responsavel | Referência | Não | Não | FK para FUNCIONÁRIO |
| situacao_departamento | Texto(10) | Sim | Não | Ativo, Inativo |

### 11.9 DEPENDENCIA_FISICA

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_dependencia | Identificador | Sim | Sim | Identificador único |
| nome_dependencia | Texto(50) | Sim | Sim | Ex: Quadra 1, Piscina Adulto |
| tipo_dependencia | Texto(20) | Sim | Não | Quadra, Piscina, Salão, Campo |
| capacidade_maxima | Inteiro | Não | Não | Valor > 0 |
| situacao_dependencia | Texto(15) | Sim | Não | Disponivel, Manutencao, Desativada |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 11.10 RESERVA

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_reserva | Identificador | Sim | Sim | Identificador único |
| id_socio | Referência | Sim | Não | FK para SÓCIO |
| id_dependencia | Referência | Sim | Não | FK para DEPENDENCIA_FISICA |
| data_reserva | Data | Sim | Não | Data futura |
| hora_inicio | Hora | Sim | Não | Entre 6h e 22h |
| hora_fim | Hora | Sim | Não | Maior que hora_inicio |
| situacao_reserva | Texto(15) | Sim | Não | Confirmada, Cancelada, Concluida |
| data_solicitacao | Data/Hora | Sim | Não | Gerada automaticamente |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 11.11 EVENTO

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_evento | Identificador | Sim | Sim | Identificador único |
| nome_evento | Texto(100) | Sim | Não | Mínimo 3 caracteres |
| descricao | Texto(500) | Não | Não | Descrição do evento |
| data_evento | Data | Sim | Não | Data futura |
| hora_inicio | Hora | Sim | Não | Hora de início |
| hora_fim | Hora | Não | Não | Maior que hora_inicio |
| id_dependencia | Referência | Não | Não | FK para DEPENDENCIA_FISICA |
| capacidade_maxima | Inteiro | Sim | Não | Valor > 0 |
| valor_inscricao | Decimal(10,2) | Não | Não | Valor >= 0 |
| tipo_evento | Texto(20) | Sim | Não | Aberto, Restrito_Socios, Restrito_Dependentes |
| situacao_evento | Texto(20) | Sim | Não | Planejado, Inscricoes_Abertas, Encerrado, Cancelado, Realizado |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 11.12 INSCRIÇÃO

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_inscricao | Identificador | Sim | Sim | Identificador único |
| id_evento | Referência | Sim | Não | FK para EVENTO |
| id_pessoa | Referência | Sim | Não | FK para PESSOA |
| data_inscricao | Data/Hora | Sim | Não | Gerada automaticamente |
| situacao_inscricao | Texto(15) | Sim | Não | Confirmada, Cancelada, Lista_Espera |
| pagamento_confirmado | Booleano | Não | Não | Sim/Não |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 11.13 MENSALIDADE

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_mensalidade | Identificador | Sim | Sim | Identificador único |
| id_socio | Referência | Sim | Não | FK para SÓCIO |
| mes_referencia | Mês/Ano | Sim | Não | Ex: 01/2024 |
| valor_base | Decimal(10,2) | Sim | Não | Valor > 0 |
| valor_acrescimos | Decimal(10,2) | Não | Não | Valor >= 0 |
| valor_descontos | Decimal(10,2) | Não | Não | Valor >= 0 |
| valor_total | Decimal(10,2) | Sim | Não | Calculado |
| data_vencimento | Data | Sim | Não | Ex: dia 10 de cada mês |
| situacao_mensalidade | Texto(15) | Sim | Não | Pendente, Pago, Atrasado, Cancelado |
| data_geracao | Data/Hora | Sim | Não | Gerada automaticamente |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 11.14 PAGAMENTO

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_pagamento | Identificador | Sim | Sim | Identificador único |
| id_mensalidade | Referência | Sim | Não | FK para MENSALIDADE |
| data_pagamento | Data | Sim | Não | Data do pagamento |
| valor_pago | Decimal(10,2) | Sim | Não | Valor > 0 |
| forma_pagamento | Texto(15) | Sim | Não | Boleto, Cartão, PIX, Dinheiro |
| numero_recibo | Texto(20) | Sim | Sim | Gerado automaticamente |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 11.15 TURMA

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_turma | Identificador | Sim | Sim | Identificador único |
| id_modalidade | Referência | Sim | Não | FK para MODALIDADE |
| nome_turma | Texto(50) | Sim | Não | Ex: Natação Infantil Turma A |
| faixa_etaria | Texto(20) | Sim | Não | Ex: 6-8 anos, Adulto |
| capacidade_maxima | Inteiro | Sim | Não | Valor > 0 |
| dia_semana | Texto(30) | Sim | Não | Ex: Segunda e Quarta |
| hora_inicio | Hora | Sim | Não | Hora de início |
| hora_fim | Hora | Sim | Não | Maior que hora_inicio |
| situacao_turma | Texto(10) | Sim | Não | Ativa, Inativa |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 11.16 MATRÍCULA

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_matricula | Identificador | Sim | Sim | Identificador único |
| id_atleta | Referência | Sim | Não | FK para ATLETA |
| id_turma | Referência | Sim | Não | FK para TURMA |
| data_matricula | Data | Sim | Não | Gerada automaticamente |
| situacao_matricula | Texto(15) | Sim | Não | Ativa, Cancelada, Concluida |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 11.17 DIRETORIA

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_diretoria | Identificador | Sim | Sim | Identificador único |
| id_socio | Referência | Sim | Não | FK para SÓCIO |
| id_funcao_diretoria | Referência | Sim | Não | FK para FUNCAO_DIRETORIA |
| data_inicio_mandato | Data | Sim | Não | Data de início do mandato |
| data_fim_mandato | Data | Não | Não | Maior que data_inicio |
| situacao_mandato | Texto(15) | Sim | Não | Em_Andamento, Concluido, Renunciado |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 11.18 FUNCAO_DIRETORIA

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_funcao_diretoria | Identificador | Sim | Sim | Identificador único |
| nome_funcao | Texto(50) | Sim | Sim | Ex: Presidente, Tesoureiro |
| descricao | Texto(500) | Não | Não | Descrição das responsabilidades |
| ordem_hierarquica | Inteiro | Não | Não | Valor > 0 |
| situacao_funcao | Texto(10) | Sim | Não | Ativa, Inativa |

---

## 12. Relacionamentos

| # | Entidade A | Cardinalidade | Verbo | Cardinalidade | Entidade B | Tipo |
|---|---|---|---|---|---|---|
| 1 | PESSOA | (0,1) | É | (1,1) | SÓCIO | Especialização |
| 2 | PESSOA | (0,1) | É | (1,1) | FUNCIONÁRIO | Especialização |
| 3 | PESSOA | (0,1) | É | (1,1) | ATLETA | Especialização |
| 4 | SÓCIO | (0,N) | POSSUI | (1,1) | DEPENDENTE | 1:N |
| 5 | ATLETA | (0,1) | VINCULADO A | (0,1) | SÓCIO | 1:1 opcional |
| 6 | SÓCIO | (1,1) | PERTENCE A | (0,N) | CATEGORIA_SOCIO | N:1 |
| 7 | FUNCIONÁRIO | (1,1) | TRABALHA EM | (0,N) | DEPARTAMENTO | N:1 |
| 8 | DEPARTAMENTO | (0,1) | GERENCIADO POR | (0,1) | FUNCIONÁRIO | 1:1 opcional |
| 9 | ATLETA | (0,N) | PRATICA | (0,N) | MODALIDADE | **N:N** |
| 10 | MODALIDADE | (0,N) | POSSUI | (1,1) | TURMA | 1:N |
| 11 | ATLETA | (0,N) | MATRICULADO EM | (0,N) | TURMA | **N:N** |
| 12 | FUNCIONÁRIO | (0,N) | MINISTRA | (0,N) | TURMA | **N:N** |
| 13 | SÓCIO | (0,N) | GERA | (1,1) | MENSALIDADE | 1:N |
| 14 | MENSALIDADE | (0,N) | RECEBE | (1,1) | PAGAMENTO | 1:N |
| 15 | SÓCIO | (0,N) | REALIZA | (1,1) | RESERVA | 1:N |
| 16 | DEPENDENCIA_FISICA | (0,N) | RECEBE | (1,1) | RESERVA | 1:N |
| 17 | EVENTO | (0,N) | RECEBE | (1,1) | INSCRIÇÃO | 1:N |
| 18 | PESSOA | (0,N) | REALIZA | (1,1) | INSCRIÇÃO | 1:N |
| 19 | SÓCIO | (0,N) | OCUPA | (1,1) | DIRETORIA | 1:N |
| 20 | DIRETORIA | (1,1) | REFERENTE A | (0,N) | FUNCAO_DIRETORIA | N:1 |

### Entidades Associativas (para N:N)

| Entidade Associativa | Substitui | Atributos Próprios |
|---|---|---|
| **ATLETA_MODALIDADE** | ATLETA — PRATICA — MODALIDADE | data_inicio_pratica, nivel_na_modalidade, frequencia_semanal |
| **MATRÍCULA** | ATLETA — MATRICULADO EM — TURMA | data_matricula, situacao_matricula |
| **TURMA_PROFESSOR** | FUNCIONÁRIO — MINISTRA — TURMA | funcao_na_turma, carga_horaria_semanal |

---

## 13. Cardinalidades

### Representações Textuais

| Relacionamento | Representação | Regra de Negócio |
|---|---|---|
| PESSOA — É — SÓCIO | `PESSOA (0,1) ——— É —— SÓCIO (1,1)` | RN01 |
| PESSOA — É — FUNCIONÁRIO | `PESSOA (0,1) ——— É —— FUNCIONÁRIO (1,1)` | RN13 |
| PESSOA — É — ATLETA | `PESSOA (0,1) ——— É —— ATLETA (1,1)` | RN14 |
| SÓCIO — POSSUI — DEPENDENTE | `SÓCIO (0,N) ——— POSSUI —— DEPENDENTE (1,1)` | RN02 |
| ATLETA — VINCULADO A — SÓCIO | `ATLETA (0,1) ——— VINCULADO A —— SÓCIO (0,1)` | RN14 |
| SÓCIO — PERTENCE A — CATEGORIA | `SÓCIO (1,1) ——— PERTENCE A —— CATEGORIA_SOCIO (0,N)` | RN03 |
| FUNCIONÁRIO — TRABALHA EM — DEPTO | `FUNCIONÁRIO (1,1) ——— TRABALHA EM —— DEPARTAMENTO (0,N)` | — |
| DEPTO — GERENCIADO POR — FUNC. | `DEPARTAMENTO (0,1) ——— GERENCIADO POR —— FUNCIONÁRIO (0,1)` | — |
| ATLETA — PRATICA — MODALIDADE | `ATLETA (0,N) ——— PRATICA —— MODALIDADE (0,N)` | RN05 |
| MODALIDADE — POSSUI — TURMA | `MODALIDADE (0,N) ——— POSSUI —— TURMA (1,1)` | RN06 |
| ATLETA — MATRICULADO EM — TURMA | `ATLETA (0,N) ——— MATRICULADO EM —— TURMA (0,N)` | — |
| FUNCIONÁRIO — MINISTRA — TURMA | `FUNCIONÁRIO (0,N) ——— MINISTRA —— TURMA (0,N)` | — |
| SÓCIO — GERA — MENSALIDADE | `SÓCIO (0,N) ——— GERA —— MENSALIDADE (1,1)` | RN10 |
| MENSALIDADE — RECEBE — PAGAMENTO | `MENSALIDADE (0,N) ——— RECEBE —— PAGAMENTO (1,1)` | RN11 |
| SÓCIO — REALIZA — RESERVA | `SÓCIO (0,N) ——— REALIZA —— RESERVA (1,1)` | RN07 |
| DEPENDENCIA — RECEBE — RESERVA | `DEPENDENCIA_FISICA (0,N) ——— RECEBE —— RESERVA (1,1)` | RN15 |
| EVENTO — RECEBE — INSCRIÇÃO | `EVENTO (0,N) ——— RECEBE —— INSCRIÇÃO (1,1)` | RN12 |
| PESSOA — REALIZA — INSCRIÇÃO | `PESSOA (0,N) ——— REALIZA —— INSCRIÇÃO (1,1)` | — |
| SÓCIO — OCUPA — DIRETORIA | `SÓCIO (0,N) ——— OCUPA —— DIRETORIA (1,1)` | RN08 |
| DIRETORIA — REFERENTE A — FUNÇÃO | `DIRETORIA (1,1) ——— REFERENTE A —— FUNCAO_DIRETORIA (0,N)` | RN08 |

---

## 14. Dicionário de Dados Conceitual

> O dicionário de dados completo está documentado na seção 11 (Atributos) com todos os detalhes de tipo, tamanho, obrigatoriedade e regras de cada atributo.

---

## 15. DER — Diagrama Entidade-Relacionamento


`modelagem_DER.pdf`

---

## 16. Justificativas Técnicas

### Justificativa 1: Substituição de "Político" por "Diretoria"

**Decisão:** A entidade "Político" foi substituída por "DIRETORIA" e "FUNCAO_DIRETORIA".

**Por quê:** O termo "político" é ambíguo e não representa adequadamente o contexto de um clube. Um clube possui uma diretoria eleita com cargos específicos (Presidente, Tesoureiro, Secretário). Modelar como "DIRETORIA" permite registrar o período do mandato, vincular o cargo ao sócio, manter histórico e representar a estrutura hierárquica.

### Justificativa 2: PESSOA como Entidade Central

**Decisão:** Criar PESSOA como entidade genérica com SÓCIO, FUNCIONÁRIO e ATLETA como especializações.

**Por quê:** Diversas entidades compartilham os mesmos dados básicos (nome, CPF, telefone, endereço). A generalização evita duplicação, inconsistência e dificuldade de manutenção. Uma mesma pessoa pode assumir múltiplos papéis.

### Justificativa 3: ATLETA pode não ser SÓCIO

**Decisão:** O relacionamento ATLETA → SÓCIO é opcional (0,1).

**Por quê:** A regra RN14 estabelece que atletas externos podem ser convidados sem ser sócios. Se ATLETA tivesse vínculo obrigatório com SÓCIO, não seria possível representar esta situação.

### Justificativa 4: Relacionamento N:N entre ATLETA e MODALIDADE

**Decisão:** ATLETA e MODALIDADE possuem relacionamento N:N.

**Por quê:** Um atleta pode praticar várias modalidades simultaneamente. O relacionamento possui atributos próprios (nível, frequência semanal), justificando uma entidade associativa.

### Justificativa 5: MENSALIDADE separada de PAGAMENTO

**Decisão:** Criar entidades separadas para MENSALIDADE e PAGAMENTO.

**Por quê:** Uma mensalidade pode receber múltiplos pagamentos (pagamento parcial). Separar permite rastrear histórico, controlar parciais, gerar recibos individuais e manter registro de inadimplência.

### Justificativa 6: DEPENDENTE como entidade separada de SÓCIO

**Decisão:** Criar entidade DEPENDENTE separada de SÓCIO.

**Por quê:** Dependentes possuem características próprias (tipo de dependência, datas de vínculo, situação). Um dependente pode se tornar sócio titular futuramente, exigindo histórico separado.

---

## 17. Conclusão

Este documento apresenta a modelagem conceitual completa do **Clube Social e Esportivo União (CSEU)**, seguindo rigorosamente as 18 etapas do método proposto.

### Resumo dos Elementos

| Elemento | Quantidade |
|---|---|
| Entidades principais | 18 |
| Entidades associativas | 3 |
| Relacionamentos | 20 |
| Atributos documentados | ~120 |
| Requisitos funcionais | 14 |
| Requisitos não funcionais | 7 |
| Regras de negócio | 25 |
| Processos documentados | 5 |
| Justificativas técnicas | 6 |

___
