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

## 2. Justificativa da Escolha

Escolhemos um clube social e esportivo porque ele reúne vários processos diferentes dentro de um mesmo ambiente. Além de lidar com pessoas, o clube também precisa organizar pagamentos, reservas, eventos, atividades esportivas e setores administrativos.

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

## 3. Problemas Identificados

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

## 4. Processos de Negócio

### Processo 1: Cadastro de Sócio

1- A pessoa procura o clube para realizar o cadastro.

2- Ela preenche o formulário com seus dados.

3- O funcionário consulta o CPF informado.

Se o CPF já estiver cadastrado:

- O funcionário verifica se essa pessoa já é sócia.

Se já for sócia:

- Os dados são conferidos e atualizados, caso seja necessário.
- O atendimento é finalizado.

Se não for sócia:

- É criada uma nova matrícula.
- A categoria do sócio é definida.
- A data de associação é registrada.
- O boleto da primeira mensalidade é gerado.
- O cadastro é concluído.

Se o CPF não estiver cadastrado:

- Primeiro é feito o cadastro da pessoa.
- Depois, é criada a matrícula de sócio.
- A categoria é definida.
- A data de associação é registrada.
- O boleto da primeira mensalidade é gerado.
- O cadastro é concluído.

### Processo 2: Matrícula em Modalidade Esportiva

1- O sócio ou dependente escolhe a modalidade que deseja praticar.

2- O funcionário confere a categoria do sócio responsável.

3- Depois, verifica se o sócio está ativo.

Se o sócio não estiver ativo:

- As pendências são informadas.
- A matrícula não é realizada naquele momento.

Se o sócio estiver ativo:

- O funcionário verifica se ainda existem vagas na modalidade.

Se não houver vaga:

- O sócio ou dependente pode ser colocado na lista de espera.
- O processo fica encerrado até surgir uma vaga.

Se houver vaga:

- A matrícula é registrada.
- O participante é colocado em uma turma.
- O nível é definido como iniciante, intermediário ou avançado.
- A data de início é registrada.
- Se houver alguma taxa adicional, a cobrança também é gerada.

### Processo 3: Reserva de Dependência Física

1- O sócio solicita a reserva de uma dependência do clube.

2- O funcionário consulta se o local está disponível na data e no horário pedidos.

Se a dependência não estiver disponível:

- O funcionário informa outros horários disponíveis.
- Se o sócio não escolher outra opção, o processo é encerrado.

Se a dependência estiver disponível:

- O funcionário verifica a situação do sócio.
- Também confere se a mensalidade está em dia.

Se a mensalidade estiver atrasada:

- A reserva não é liberada.
- O sócio é informado da pendência.

Se a mensalidade estiver em dia:

- A reserva é registrada.
- O sócio recebe a confirmação.
- O responsável pela reserva fica registrado no sistema.

### Processo 4: Contratação de Funcionário

1- Um departamento informa a necessidade de contratar um novo funcionário.

2- A diretoria analisa a solicitação e aprova a abertura da vaga.

3- O RH recebe os candidatos.

4- Depois da seleção, um candidato é escolhido.

Após a seleção:

- Os dados pessoais são cadastrados na entidade PESSOA.
- Esse cadastro é vinculado à entidade FUNCIONÁRIO.
- O cargo e o departamento são definidos.
- A data de admissão é registrada.
- O salário e a jornada de trabalho são informados.
- A matrícula funcional é gerada.

### Processo 5: Organização de Evento

1- A diretoria aprova a realização do evento.

2- São definidos a data, o local e o público-alvo.

3- O funcionário cadastra o evento no sistema.

4- A capacidade máxima é informada.

5- Se houver cobrança, o valor da inscrição também é definido.

6- Depois disso, as inscrições são abertas.

Durante o período de inscrições:

- Os interessados realizam suas inscrições.
- O sistema acompanha a quantidade de vagas ocupadas.

Se ainda houver vagas:

- As inscrições continuam abertas.

Se todas as vagas forem preenchidas:

- As inscrições são encerradas.
- Os participantes ficam registrados.
- Na data definida, o evento é realizado.

### Processo 6: Cadastro de Dependente

1- O sócio solicita o cadastro de um dependente.

2- O funcionário confere os dados apresentados.

3- Depois, verifica se essa pessoa já possui cadastro.

Se a pessoa já estiver cadastrada:

- O cadastro existente é utilizado.
- O dependente é vinculado ao sócio responsável.

Se a pessoa não estiver cadastrada:

- Os dados pessoais são cadastrados primeiro.
- Em seguida, é feito o vínculo com o sócio responsável.

Após o vínculo:

- A categoria do plano é conferida.
- A data e a situação do vínculo são registradas.

### Processo 7: Geração e Pagamento de Mensalidade

1- O sistema identifica os sócios que devem receber a mensalidade.

2- O valor é definido de acordo com a categoria do sócio.

3- A mensalidade é registrada.

4- A data de vencimento é informada.

5- A cobrança é disponibilizada para o sócio.

Quando o pagamento é realizado:

- O pagamento é registrado no sistema.
- O valor recebido é conferido.

Se o pagamento for parcial:

- O valor pago fica registrado.
- O restante continua pendente.
- A mensalidade só é considerada quitada quando o valor total for pago.

Se o pagamento completar o valor da mensalidade:

- A situação é alterada para paga.
- O recibo é gerado.

### Processo 8: Criação e Gestão de Turma

1- O funcionário escolhe a modalidade da nova turma.

2- A turma é cadastrada no sistema.

3- São definidos os dias e horários.

4- A faixa etária é informada.

5- É definida a capacidade máxima de alunos.

6- Um ou mais professores são vinculados à turma.

Após a criação:

- A turma passa a ficar disponível para novas matrículas.
- O sistema acompanha a quantidade de participantes.

Se a capacidade máxima for atingida:

- Novas matrículas são bloqueadas ou direcionadas para uma lista de espera.

Se ainda houver vagas:

- As matrículas continuam sendo aceitas normalmente.

### Processo 9: Cadastro e Vinculação de Atleta

1- A pessoa demonstra interesse em participar como atleta do clube.

2- O funcionário verifica se ela já possui cadastro.

Se a pessoa não estiver cadastrada:

- Os dados pessoais são cadastrados.

Se a pessoa já estiver cadastrada:

- O cadastro existente é utilizado.

Em seguida:

- A pessoa é vinculada como atleta.
- São escolhidas as modalidades em que ela irá participar.
- Os vínculos com essas modalidades são registrados.
- A data de início da atividade também é informada.

### Processo 10: Gestão de Diretoria e Mandatos

1- O clube define quem fará parte da diretoria.

2- É verificado se cada integrante já possui cadastro no sistema.

3- Os membros são vinculados à diretoria.

4- Para cada integrante, é informado o cargo ocupado.

5- A data de início do mandato é registrada.

6- Também é definida a previsão de término.

Quando houver alteração na diretoria:

- O mandato anterior é encerrado.
- O novo responsável é vinculado ao cargo.
- Um novo período de mandato é registrado.

## 5. Requisitos Funcionais

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

## 6. Requisitos Não Funcionais

### RNF01 — Segurança
- O sistema deve exigir autenticação para acesso
- Senhas devem ser armazenadas de forma criptografada
- Acesso por perfil (administrador, funcionário, sócio)
- Dados de CPF devem ser mascarados para consulta pública
- Dados de exames médicos devem possuir acesso restrito a usuários autorizados
- Registros de ocorrências devem ser acessíveis apenas por funcionários autorizados
- Registros de acesso ao clube não devem poder ser alterados por usuários sem permissão
- Convites de visitantes devem possuir código único para validação
- Operações de venda devem registrar o funcionário responsável

### RNF02 — Desempenho
- Consultas devem responder em menos de 3 segundos
- Relatórios mensais devem ser gerados em menos de 10 segundos
- Sistema deve suportar 50 usuários simultâneos
- Consultas de estoque devem apresentar a quantidade disponível de forma rápida
- O registro de vendas deve atualizar o estoque sem atrasos perceptíveis
- A validação de convites e registros de acesso deve ocorrer em poucos segundos

### RNF03 — Disponibilidade
- Sistema deve estar disponível 99% do tempo
- Manutenções programadas em horários de baixo uso
- O módulo de registro de acesso deve permanecer disponível durante o horário de funcionamento do clube
- Os módulos de vendas e estoque devem permanecer acessíveis durante as atividades comerciais do clube
- Em caso de indisponibilidade, registros críticos devem poder ser recuperados após o restabelecimento do sistema

### RNF04 — Usabilidade
- Interface intuitiva
- Formulários com validação de dados
- Mensagens de erro claras
- Responsivo para dispositivos móveis
- O cadastro de endereços deve possuir campos organizados e de fácil preenchimento
- O registro de vendas deve permitir inclusão simples de produtos e quantidades
- A consulta de estoque deve apresentar claramente produtos disponíveis e indisponíveis
- A tela de ocorrências deve facilitar o registro de descrição, data e pessoas envolvidas
- A validação de convites deve apresentar claramente se o convite está válido, utilizado ou expirado

### RNF05 — Compatibilidade
- Funcionar nos navegadores: Chrome, Firefox, Edge
- Compatível com Windows 10/11 e Linux
- Compatível com dispositivos móveis (Android e iOS)

### RNF06 — Backup e Recuperação
- Backup automático diário
- Backup semanal completo
- Capacidade de restauração em até 24 horas
- Registros de vendas e movimentações de estoque devem ser incluídos nos backups
- Registros de acesso, exames médicos e ocorrências devem ser preservados nos backups
- Dados de convites utilizados ou expirados devem ser mantidos para consulta histórica
- A restauração deve preservar os vínculos entre vendas, itens, produtos e estoque

### RNF07 — Escalabilidade
- Arquitetura modular
- Capacidade de adicionar novos módulos
- Capacidade de expandir número de sócios sem perda de desempenho
- O sistema deve permitir aumento do número de produtos e vendas sem perda significativa de desempenho
- O histórico de acessos e ocorrências deve poder crescer sem comprometer as consultas
- Novos tipos de produtos, convites, ocorrências e exames devem poder ser adicionados sem grandes alterações na estrutura do sistema

---

## 7. Regras de Negócio

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
| **RN15** | Reservas com mínimo 24h e máximo 30 dias de antecedencia | Regra de validação na entidade RESERVA |
| **RN16** | Um sócio pode cadastrar vários dependentes | Relacionamento SÓCIO (0,N) — POSSUI — DEPENDENTE (1,1) |
| **RN17** | Um dependente pertence a apenas um sócio	|Chave estrangeira id_socio_titular na entidade DEPENDENTE |
| **RN18** | Dependente perde o vínculo ao atingir a idade limite da categoria do plano.	| Regra de validação de idade e atualização de situacao_dependente |
| **RN19** | Um sócio pode participar de varias atividades | Relacionamento SÓCIO × MODALIDADE com cardinalidade N	 |
| **RN20** | Um professor pode ministrar várias atividades | Relacionamento PROFESSOR/FUNCIONÁRIO × MODALILDADE	 |
| **RN21** | Uma mensalidade pode possuir vários pagamentos parciais até sua quitação | Relacionamento MENSALIDADE (0,N) — RECEBE — PAGAMENTO (1,1) |
| **RN22** | Não é permitida a reserva de uma dependência já reservada no mesmo horário | Validação de conflito de data e horario na entidade RESERVA |
| **RN23** | Toda reserva deve estar vinculada a um sócio responsável | Um sócio responsável pode estar vinculado a várias reservas. |
| **RN24** | A reserva é automaticamente cancelada se a mensalidade do sócio responsável não for paga | Regra automatica de atualização de situacao_reserva |
| **RN25** | A categoria do plano define quais dependências o sócio pode reservar | Relacionamento/regra de permissão entre CATEGORIA_SOCIO e DEPENDENCIA_FISICA |
| **RN26** | Uma pessoa pode possuir vários endereços | Cada endereço pertence a apenas uma pessoa |
| **RN27** | Uma pessoa pode possuir vários registros de acesso | Cada registro de acesso pertence a apenas uma pessoa. |
| **RN28** | Um sócio pode emitir vários convites para visitantes | Cada convite é emitido por apenas um sócio. |
|**RN29** | Uma pessoa pode estar vinculada a vários convites como visitante | Cada convite pertence a apenas uma pessoa visitante | 
| **RN30** | Uma pessoa pode possuir varios exames médicos | Cada exame médico pertence a apenas uma pessoa. | 
| **RN31** | Uma pessoa pode realizar várias compras | Cada venda pertence a apenas uma pessoa compradora. |
| **RN32** | Um funcionário pode registrar várias vendas | Cada venda é registrada por apenas um funcionário. |
| **RN33** | Uma venda pode possuir vários itens | Cada item de venda pertence a apenas uma venda. |
| **RN34** | Um produto pode aparecer em vários itens de venda | Cada item de venda está vinculado a apenas um produto |
| **RN35** | Um produto pode possuir vários registros de estoque | Cada registro de estoque pertence a apenas um produto |
| **RN36** | Uma pessoa pode estar envolvida em várias ocorrências | Cada ocorrência deve estar vinculada a uma pessoa envolvida | 
| **RN37** | Um funcionário pode registrar varias ocorrências | Cada ocorrência é registrada por apenas um funcionario |
| **RN38** | Todo registro de acesso deve possuir data, horário e tipo de movimentação |
| **RN39** | Convites só podem ser utilizados dentro do período de validade |
|**RN40** | Algumas modalidades podem exigir exame médico válido | 
|**RN41** | A quantidade vendida não pode ultrapassar o estoque disponível|
| **RN42** | Toda venda deve atualizar a quantidade disponível no estoque|
| **RN43** | Toda ocorrência deve possuir data e descrição. | 



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

## 8. Restrições e Políticas Organizacionais

### 8.1 Restrições Legais
- Dados pessoais devem seguir a LGPD (Lei Geral de Proteção de Dados)
- CPF não pode ser exibido publicamente
- Menores de idade precisam de responsável legal cadastrado

### 8.2 Restrições Operacionais
- Reservas só podem ser feitas no horário de funcionamento (6h às 22h)
- O clube fecha às segundas-feiras para manutenção
- Eventos com mais de 100 pessoas precisam de autorização da diretoria
- Uso da churrasqueira requer reserva com mínimo de 48 horas de antecedência

### 8.3 Políticas Organizacionais
- Dependentes de sócios titulares têm prioridade em vagas de modalidades
- Funcionários têm desconto de 50% na mensalidade de sócio
- Sócios com mais de 10 anos de associação recebem desconto de 10%
- Cancelamento de inscrição em evento com menos de 48 horas não gera reembolso

---

## 9. Entidades Identificadas

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
| 19 | **ATLETA_MODALIDADE** | Entidade associativa (ATLETA × MODALIDADE) | RN05 |
| 20 | **TURMA_PROFESSOR** | Entidade associativa (FUNCIONÁRIO × TURMA) | RF07 |
| 21 | **ENDEREÇO** | Armazena um ou mais endereços vinculados às pessoas cadastradas | RN26 |
| 22 | **REGISTRO_ACESSO** | Registra os acessos das pessoas ao clube, incluindo data e horário | RN27, RN38|
| 23 | **VENDA** | Registra as compras realizadas por pessoas e o funcionário responsável | RN31, RN31 |
| 24 | **PRODUTO** | Armazena os produtos comercializados pelo clube | RN34, RN41 |
| 25 | **ITEM_VENDA** | Registra os produtos e quantidades que compõem cada venda | RN33, RN34 | 
| 26 | **ESTOQUE**  | Controla a quantidade disponível dos produtos | RN35, RN41, RN42 | 
| 27 | **EXAME_MEDICO** | Registra exames médicos realizados pelas pessoas do clube | RN30, RN40 | 
| 28 | **CONVITE_VISITANTE** | Registra convites emitidos por sócios para visitantes | RN28, RN29, RN39 |
| 29 | **OCORRENCIA** | Registra ocorrências, envolvidos e o funcionário responsável pelo relato | RN36, RN37, RN43 | 

> *Entidades associativas para resolver relacionamentos N:N

### Nota sobre "POLÍTICO"

No início do projeto usamos o termo "Político", mas depois percebemos que ele não representava bem o contexto de um clube. Por isso, substituímos essa ideia por **DIRETORIA** e **FUNCAO_DIRETORIA**.

- "Político" era um termo muito genérico para o que queríamos representar
- O clube possui uma diretoria com cargos definidos
- Esses cargos são ocupados por sócios durante um período de mandato
- Dessa forma, a modelagem ficou mais próxima da organização real do clube

---

## 10. Atributos

### 10.1 PESSOA

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

### 10.2 SÓCIO

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

### 10.3 DEPENDENTE

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

### 10.4 FUNCIONÁRIO

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

### 10.5 ATLETA

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

### 10.6 MODALIDADE

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_modalidade | Identificador | Sim | Sim | Identificador único |
| nome_modalidade | Texto(50) | Sim | Sim | Ex: Natação, Futebol, Tênis |
| descricao | Texto(500) | Não | Não | Descrição da modalidade |
| taxa_adicional | Decimal(10,2) | Não | Não | Valor >= 0 |
| idade_minima | Inteiro | Não | Não | Idade mínima para participação |
| idade_maxima | Inteiro | Não | Não | Idade máxima para participação |
| situacao_modalidade | Texto(10) | Sim | Não | Ativa, Inativa |

### 10.7 CATEGORIA_SOCIO

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_categoria_socio | Identificador | Sim | Sim | Identificador único |
| nome_categoria | Texto(50) | Sim | Sim | Ex: Titular, Dependente, Atleta |
| valor_mensalidade | Decimal(10,2) | Sim | Não | Valor > 0 |
| descricao_beneficios | Texto(500) | Não | Não | Descrição dos benefícios |
| situacao_categoria | Texto(10) | Sim | Não | Ativa, Inativa |

### 10.8 DEPARTAMENTO

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_departamento | Identificador | Sim | Sim | Identificador único |
| nome_departamento | Texto(50) | Sim | Sim | Ex: Financeiro, RH, Esportes |
| descricao | Texto(500) | Não | Não | Descrição das responsabilidades |
| id_responsavel | Referência | Não | Não | FK para FUNCIONÁRIO |
| situacao_departamento | Texto(10) | Sim | Não | Ativo, Inativo |

### 10.9 DEPENDENCIA_FISICA

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_dependencia | Identificador | Sim | Sim | Identificador único |
| nome_dependencia | Texto(50) | Sim | Sim | Ex: Quadra 1, Piscina Adulto |
| tipo_dependencia | Texto(20) | Sim | Não | Quadra, Piscina, Salão, Campo |
| capacidade_maxima | Inteiro | Não | Não | Valor > 0 |
| situacao_dependencia | Texto(15) | Sim | Não | Disponivel, Manutencao, Desativada |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 10.10 RESERVA

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

### 10.11 EVENTO

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

### 10.12 INSCRIÇÃO

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_inscricao | Identificador | Sim | Sim | Identificador único |
| id_evento | Referência | Sim | Não | FK para EVENTO |
| id_pessoa | Referência | Sim | Não | FK para PESSOA |
| data_inscricao | Data/Hora | Sim | Não | Gerada automaticamente |
| situacao_inscricao | Texto(15) | Sim | Não | Confirmada, Cancelada, Lista_Espera |
| pagamento_confirmado | Booleano | Não | Não | Sim/Não |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 10.13 MENSALIDADE

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

### 10.14 PAGAMENTO

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_pagamento | Identificador | Sim | Sim | Identificador único |
| id_mensalidade | Referência | Sim | Não | FK para MENSALIDADE |
| data_pagamento | Data | Sim | Não | Data do pagamento |
| valor_pago | Decimal(10,2) | Sim | Não | Valor > 0 |
| forma_pagamento | Texto(15) | Sim | Não | Boleto, Cartão, PIX, Dinheiro |
| numero_recibo | Texto(20) | Sim | Sim | Gerado automaticamente |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 10.15 TURMA

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

### 10.16 MATRÍCULA

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_matricula | Identificador | Sim | Sim | Identificador único |
| id_atleta | Referência | Sim | Não | FK para ATLETA |
| id_turma | Referência | Sim | Não | FK para TURMA |
| data_matricula | Data | Sim | Não | Gerada automaticamente |
| situacao_matricula | Texto(15) | Sim | Não | Ativa, Cancelada, Concluida |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 10.17 DIRETORIA

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_diretoria | Identificador | Sim | Sim | Identificador único |
| id_socio | Referência | Sim | Não | FK para SÓCIO |
| id_funcao_diretoria | Referência | Sim | Não | FK para FUNCAO_DIRETORIA |
| data_inicio_mandato | Data | Sim | Não | Data de início do mandato |
| data_fim_mandato | Data | Não | Não | Maior que data_inicio |
| situacao_mandato | Texto(15) | Sim | Não | Em_Andamento, Concluido, Renunciado |
| observacao | Texto(500) | Não | Não | Observações gerais |

### 10.18 FUNCAO_DIRETORIA

| Atributo | Tipo | Obrigatório | Único | Descrição |
|---|---|---|---|---|
| id_funcao_diretoria | Identificador | Sim | Sim | Identificador único |
| nome_funcao | Texto(50) | Sim | Sim | Ex: Presidente, Tesoureiro |
| descricao | Texto(500) | Não | Não | Descrição das responsabilidades |
| ordem_hierarquica | Inteiro | Não | Não | Valor > 0 |
| situacao_funcao | Texto(10) | Sim | Não | Ativa, Inativa |


## 10.19 ATLETA_MODALIDADE ###
| Atributo |	Tipo |	Obrigatório |	Único |	Descrição |
|---|---|---|---|---|
| id_atleta_modalidade |	Identificador| Sim |	Sim |	Identificador único do vínculo |
| id_atleta |	Referência |	Sim| 	Não |	FK para ATLETA |
|id_modalidade	|Referência	|Sim	|Não	|FK para MODALIDADE|
|data_inicio|	Data|	Sim|	Não|	Data de início na modalidade|
|data_fim	|Data	|Não	|Não	|Data de encerramento do vínculo|
|situacao_vinculo|	Texto(15)|	Sim|	Não|	Ativo, Inativo, Suspenso|
|observacao	|Texto(500)	|Não	|Não|	Observações gerais|


## 10.20 TURMA_PROFESSOR ##
| Atributo |	Tipo |	Obrigatório |	Único |	Descrição |
|---|---|---|---|---|
| id_turma_professor|	Identificador|Sim|	Sim|	Identificador único do vínculo|
|id_turma	|Referência	|Sim	|Não	|FK para TURMA|
|id_funcionario|	Referência|	Sim|	Não|	FK para FUNCIONÁRIO|
|data_inicio	|Data	|Sim|	Não	|Data de início do professor na turma|
|data_fim|	Data|	Não|	Não	|Data de encerramento do vínculo|
|situacao_vinculo|	Texto(15)	|Sim	|Não	|Ativo, Inativo|
|observacao|	Texto(500)|	Não|	Não|	Observações gerais|

## 10.21 ENDEREÇO ##
|Atributo|	Tipo|	Obrigatório|	Único|	Descrição|
|---|---|---|---|---|
|id_endereco	|Identificador	|Sim|	Sim|	Identificador único do endereço|
|id_pessoa	Referência	|Sim|	Não	|FK para PESSOA|
|logradouro|	Texto(100)|	Sim	|Não|	Rua, avenida ou outro logradouro|
|numero	|Texto(10)	|Sim	|Não	|Número do imóvel|
|complemento|	Texto(50)|	Não|	Não|	Complemento do endereço|
|bairro	|Texto(50)	|Sim	|Não	|Bairro|
|cidade	|Texto(50)|	Sim	|Não|	Cidade|
|estado	|Texto(2)	|Sim	|Não|	UF|
|cep|	Texto(8)|	Sim|	Não|	CEP|
|tipo_endereco|	Texto(15)|	Sim	|Não|	Residencial, Comercial, Outro|
|endereco_principal	|Booleano	|Sim	|Não	|Indica se é o endereço principal|

## 10.22 REGISTRO_ACESSO ##
|Atributo|	Tipo|	Obrigatório	|Único	|Descrição|
|---|---|---|---|---|
|id_registro_acesso	|Identificador|	Sim|	Sim	|Identificador único do registro|
|id_pessoa	|Referência	|Sim	|Não	|FK para PESSOA|
|data_acesso|	Data	|Sim|	Não|	Data do acesso|
|hora_acesso	|Hora	|Sim	|Não	|Horário do acesso|
|tipo_acesso|	Texto(10)	|Sim	|Não|	Entrada ou Saída|
|meio_acesso	|Texto(20)	|Não	|Não	|Carteirinha, QR Code, Biometria|
|observacao	|Texto(500)	|Não|	Não|	Observações sobre o acesso|

## 10.23 VENDA ##
|Atributo	|Tipo|	Obrigatório	|Único|	Descrição|
|---|---|---|---|---|
|id_venda	|Identificador|	Sim	|Sim	|Identificador único da venda|
|id_pessoa	Referência	|Sim|	Não	|FK para PESSOA compradora|
|id_funcionario|	Referência|	Sim	|Não|	FK para FUNCIONÁRIO responsável|
|data_venda|	Data/Hora	|Sim|	Não	|Data e horário da venda|
|valor_total	|Decimal(10,2)|	Sim	|Não	|Valor total da venda|
|forma_pagamento|	Texto(15)|	Sim	|Não	|PIX, Dinheiro, Cartão|
|situacao_venda	|Texto(15)|	Sim	|Não	|Concluída, Cancelada|
|observacao	|Texto(500)	|Não	|Não	|Observações gerais|

## 10.24 PRODUTO ##
|Atributo	|Tipo|	Obrigatório|	Único|	Descrição|
|---|---|---|---|---|
|id_produto	|Identificador|	Sim	|Sim	|Identificador único do produto|
|nome_produto	|Texto(100)|	Sim	|Não	|Nome do produto|
|descricao	|Texto(500)|	Não|	Não|	Descrição do produto|
|categoria_produto	|Texto(50)	|Não|	Não	|Categoria do produto|
|valor_unitario	|Decimal(10,2)|	Sim|	Não|	Preço unitário de venda|
|codigo_produto	|Texto(30)|	Sim	|Sim	|Código único do produto|
|situacao_produto	|texto(15)|	Sim	|Não	|Ativo, Inativo|
|observacao	|Texto(500)|	Não	|Não	|Observações gerais|

## 10.25 ITEM_VENDA ##
|Atributo|	Tipo|	Obrigatório	|Único|	Descrição|
|---|---|---|---|---|
|id_item_venda	|Identificador	|Sim	|Sim|	Identificador único do item|
|id_venda	|Referência	|Sim	|Não|	FK para VENDA|
|id_produto|	Referência|	Sim	|Não	|FK para PRODUTO|
|quantidade|	Inteiro|	Sim	|Não	|Quantidade adquirida|
|valor_unitario|	Decimal(10,2)|	Sim	|Não	|Valor do produto no momento da venda|
|subtotal	|Decimal(10,2)|	Sim	|Não	|Quantidade × valor unitário|
|observacao	|Texto(500)	|Não	|Não|	Observações sobre o item|

## 10.26 ESTOQUE ##
|Atributo	|Tipo|	Obrigatório|	Único	|Descrição|
|---|---|---|---|---|
|id_estoque	|Identificador	|Sim	|Sim	|Identificador único do registro|
|id_produto|	Referência|	Sim	|Não	|FK para PRODUTO|
|quantidade_disponivel	|Inteiro	|Sim	|Não	|Quantidade atual disponível|
|quantidade_minima	|Inteiro|	Sim	|Não|	Quantidade mínima recomendada|
|data_atualizacao	|Data/Hora	|Sim|	Não|	Última atualização do estoque|
|situacao_estoque|	Texto(15)	|Sim|	Não	|Disponível, Baixo, Esgotado|
|observacao	|Texto(500)|	Não	|Não	|Observações gerais|

## 10.27 EXAME_MEDICO ##
|Atributo	|Tipo|	Obrigatório	|Único	|Descrição|
|---|---|---|---|---|
|id_exame_medico|	Identificador	|Sim|	Sim|	Identificador único do exame|
|id_pessoa	|Referência	|Sim|	Não|	FK para PESSOA|
|data_exame	|Data	|Sim	|Não	|Data de realização do exame|
|data_validade	|Data|	Sim	|Não	|Data de validade do exame|
|resultado	|Texto(15)	|Sim	|Não	|Apto, Inapto, Com restrição|
|nome_medico	|Texto(100)|	Sim	|Não|	Médico responsável|
|crm_medico	|Texto(20)	|Sim	|Não	|Registro profissional do médico|
|observacao	|Texto(500)	|Não|	Não	|Observações ou restrições|

## 10.28 CONVITE_VISITANTE ## 
|Atributo	|Tipo|	Obrigatório	|Único	|Descrição|
|---|---|---|---|---|
|id_convite	|Identificador	|Sim|	Sim	|Identificador único do convite|
|id_socio|	Referência	|Sim|	Não	|FK para SÓCIO responsável|
|id_pessoa_visitante|	Referência|	Sim	|Não	|FK para PESSOA visitante|
|codigo_convite|	Texto(20)	|Sim	|Sim	|Código único do convite|
|data_emissao	|Data/Hora	|Sim|	Não	|Data de emissão|
|data_validade|	Data	|Sim|	Não	|Data limite para utilização|
|situacao_convite|	Texto(15)|	Sim	|Não	|Ativo, Utilizado, Expirado, Cancelado|
|observacao	|Texto(500)	|Não|	Não|	Observações gerais|

## 10.29 OCORRENCIA ##
|Atributo	|Tipo	|Obrigatório	|Único	|Descrição|
|---|---|---|---|---|
|id_ocorrencia	|Identificador	|Sim|	Sim	|Identificador único da ocorrência|
|id_pessoa	Referência|	Sim	|Não	|FK para PESSOA envolvida|
|id_funcionario|	Referência|	Sim	|Não	|FK para FUNCIONÁRIO que registrou|
|data_ocorrencia	|Data|	Sim	|Não	|Data da ocorrência|
|hora_ocorrencia	|Hora|	Sim	|Não	|Horário da ocorrência|
|tipo_ocorrencia|	Texto(30)|	Sim|	Não	|Acidente, Advertência, Dano, Outro|
|descricao	|Texto(500)|	Sim	|Não | Descrição detalhada da ocorrência|
|gravidade|	Texto(15)	|Não|	Não	|Baixa, Média, Alta|
|situacao_ocorrencia	|Texto(20)|	Sim|	Não	|Aberta, Em análise, Resolvida|
|providencia_tomada|	Texto(500)	|Não	|Não|	Medidas adotadas após a ocorrência|
---

## 11. Relacionamentos

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
| 21 | PESSOA | (1,1) | POSSUI | (0,N) | ENDEREÇO | 1:N |
| 22 | PESSOA | (1,1) | REGISTRA | (0,N) |REGISTRO_ACESSO | 1:N |
| 23 | SÓCIO | (1,1) | EMITE | (0,N) | CONVITE_VISITANTE | 1:N |
| 24 | PESSOA | (1,1) | VISITA | (0,n) | CONVITE_VISITANTE | 1;N |
| 25 | PESSOA | (1,1) | REALIZA | (0,N) | EXAME_MEDICO | 1:N | 
| 26 | PESSOA | (1,1) |COMPRA | (0,N) | VENDA  | 1:N |
| 27 | FUNCIONÁRIO | (1,1) | REGISTRA | (0,N) | VENDA | 1:N |
| 28 | VENDA | (1,1) | CONTEM | (0,N) | ITEM_VENDA | 1:N |
| 29 | ITEM_VENDA | (1,1) | INDICA | (0,N) | PRODUTO | 1:N |
| 30 | PRODUTO | (1,1) | MANTEM | (0,N) |  ESTOQUE | 1:N |
| 31 | PESSOA | (1,1) | ENVOLVE | (0,N) |  OCORRENCIA | 1:N |
| 32 | FUNCIONÁRIO | (1,1) | RELATA | (0,N) |  OCORRENCIA | 1:N | 


### Entidades Associativas (para N:N)

| Entidade Associativa | Substitui | Atributos Próprios |
|---|---|---|
| **ATLETA_MODALIDADE** | ATLETA — PRATICA — MODALIDADE | data_inicio_pratica, nivel_na_modalidade, frequencia_semanal |
| **MATRÍCULA** | ATLETA — MATRICULADO EM — TURMA | data_matricula, situacao_matricula |
| **TURMA_PROFESSOR** | FUNCIONÁRIO — MINISTRA — TURMA | funcao_na_turma, carga_horaria_semanal |
| **INSCRIÇÃO**| 	PESSOA — PARTICIPA DE — EVENTO	|data_inscricao, situacao_inscricao, valor_pago|
|**DIRETORIA**	|SÓCIO — EXERCE — FUNCAO_DIRETORIA	|data_inicio_mandato, data_fim_mandato|
|**ITEM_VENDA**|	VENDA — CONTÉM — PRODUTO|	quantidade, valor_unitario, subtotal|

---

## 12. Cardinalidades

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
| PESSOA — REPRESENTA — DEPENDENTE | `PESSOA (0,1) ——— É —— DEPENDENTE (1,1)`| RN02 |
| PESSOA — POSSUI — ENDEREÇO | `PESSOA (1,1) ——— POSSUI —— ENDEREÇO (0,N)` | RN26  |
| PESSOA — REGISTRA — REGISTRO_ACESSO | `PESSOA (1,1) ——— REGISTRA —— REGISTRO_ACESSO (0,N)`| RN27|
| SÓCIO — EMITE — CONVITE_VISITANTE | `SÓCIO (1,1) ——— EMITE —— CONVITE_VISITANTE (0,N)`| RN28 |
| PESSOA — VISITA — CONVITE_VISITANTE | `PESSOA (1,1) ——— VISITA COMO —— CONVITE_VISITANTE (0,N)` | RN29 |
| PESSOA — REALIZA — EXAME_MEDICO | `PESSOA (1,1) ——— REALIZA —— EXAME_MEDICO (0,N)` | RN30 |
| PESSOA — COMPRA EM — VENDA | `PESSOA (1,1) ——— COMPRA EM —— VENDA (0,N)` | RN31 |
| FUNCIONÁRIO — REGISTRA — VENDA | `FUNCIONÁRIO (1,1) ——— REGISTRA —— VENDA (0,N)` | RN32 |
| VENDA — CONTÉM — ITEM_VENDA | `VENDA (1,1) ——— CONTÉM —— ITEM_VENDA (1,N)`| RN33 |
| ITEM_VENDA — REFERE-SE A — PRODUTO | `ITEM_VENDA (0,N) ——— REFERE-SE A —— PRODUTO (1,1)` | RN34 | 
| PRODUTO — MANTÉM — ESTOQUE | `PRODUTO (1,1) ——— MANTÉM —— ESTOQUE (0,N)`| RN35 |
| PESSOA — ENVOLVE-SE — OCORRENCIA | `PESSOA (1,1) ——— ENVOLVE-SE —— OCORRENCIA (0,N)` | RN36 |
| FUNCIONÁRIO — RELATA — OCORRENCIA | `FUNCIONÁRIO (1,1) ——— RELATA —— OCORRENCIA (0,N)`| RN37 |
| DEPENDENCIA_FISICA — SEDIA — EVENTO | `DEPENDENCIA_FISICA (1,1) ——— SEDIA —— EVENTO (0,N)` |
| ATLETA — PRATICA — ATLETA_MODALIDADE | `ATLETA (1,1) ——— PRATICA —— ATLETA_MODALIDADE (0,N)`| RN05 | 
| ATLETA_MODALIDADE — COMPÕE — TURMA| `ATLETA_MODALIDADE (1,1) ——— COMPÕE —— TURMA (0,N)` |
| FUNCIONÁRIO — LECIONA EM — TURMA_PROFESSOR | `FUNCIONÁRIO (1,1) ——— LECIONA EM —— TURMA_PROFESSOR (0,N)`| RN20 |
| TURMA_PROFESSOR — ALOCA — TURMA | `TURMA_PROFESSOR (1,1) ——— ALOCA —— TURMA (0,N)`| RN20 |

---

## 13. Dicionário de Dados Conceitual

> O dicionário de dados completo está documentado na seção 11 (Atributos) com todos os detalhes de tipo, tamanho, obrigatoriedade e regras de cada atributo.

---

## 14. DER — Diagrama Entidade-Relacionamento


`modelagem_DER.pdf`

---

## 15. Justificativas Técnicas

### Justificativa 1: Substituição de "Político" por "Diretoria"

**Decisão:** Substituir a entidade "Político" por **DIRETORIA** e **FUNCAO_DIRETORIA**.

**Por quê:** Durante a revisão do modelo, percebemos que "Político" não descrevia bem o que existe dentro de um clube. A diretoria possui cargos definidos e cada cargo pode ser ocupado por um sócio durante determinado período. Dessa forma, conseguimos registrar melhor os mandatos e manter o histórico de quem ocupou cada função.

### Justificativa 2: PESSOA como Entidade Central

**Decisão:** Utilizar PESSOA como cadastro principal e relacionar SÓCIO, FUNCIONÁRIO e ATLETA a ela.

**Por quê:** Esses perfis compartilham vários dados, como nome, CPF e telefone. Se cada entidade guardasse essas informações separadamente, haveria muita repetição. Com PESSOA no centro, um mesmo cadastro pode assumir mais de um papel dentro do clube.

### Justificativa 3: ATLETA pode não ser SÓCIO

**Decisão:** Deixar o vínculo entre ATLETA e SÓCIO como opcional.

**Por quê:** Nem todo atleta precisa ser sócio do clube. O projeto considera a participação de atletas externos, então esse vínculo não pode ser obrigatório.

### Justificativa 4: Relacionamento N:N entre ATLETA e MODALIDADE

**Decisão:** Manter o relacionamento entre ATLETA e MODALIDADE como N:N.

**Por quê:** Um atleta pode praticar várias modalidades e cada modalidade pode ter vários atletas. Como esse vínculo também possui informações próprias, foi usada uma entidade associativa.

### Justificativa 5: MENSALIDADE separada de PAGAMENTO

**Decisão:** Manter MENSALIDADE e PAGAMENTO como entidades separadas.

**Por quê:** Uma mensalidade pode ser paga em mais de uma parte. Separando os pagamentos, conseguimos registrar cada valor recebido e acompanhar corretamente o que ainda está pendente.

### Justificativa 6: DEPENDENTE como entidade separada de SÓCIO

**Decisão:** Criar DEPENDENTE separado de SÓCIO.

**Por quê:** O dependente possui informações próprias do vínculo com o titular, como tipo de dependência, período do vínculo e situação. Além disso, futuramente ele pode deixar de ser dependente e passar a ser sócio.

### Justificativa 7: ENDEREÇO separado de PESSOA

**Decisão:** Criar ENDEREÇO fora da entidade PESSOA.

**Por quê:** Dessa forma, uma pessoa pode ter mais de um endereço sem repetir vários campos dentro do cadastro principal. Também fica mais simples atualizar essas informações quando necessário.

### Justificativa 8: REGISTRO_ACESSO como entidade própria

**Decisão:** Criar REGISTRO_ACESSO para controlar entradas e saídas.

**Por quê:** Cada acesso precisa guardar informações como data, horário e tipo de movimentação. Mantendo esses dados separados, o clube consegue consultar o histórico de acesso de cada pessoa.

### Justificativa 9: VENDA separada de ITEM_VENDA e PRODUTO

**Decisão:** Trabalhar com VENDA, ITEM_VENDA e PRODUTO separadamente.

**Por quê:** Uma venda pode possuir vários produtos e um mesmo produto pode aparecer em várias vendas. ITEM_VENDA faz essa ligação e também guarda informações como quantidade e valor do item.

### Justificativa 10: ESTOQUE separado de PRODUTO

**Decisão:** Separar ESTOQUE de PRODUTO.

**Por quê:** PRODUTO guarda as informações do item vendido, enquanto ESTOQUE controla sua quantidade disponível. Assim, alterações no estoque não precisam mexer nos dados principais do produto.

### Justificativa 11: EXAME_MEDICO como entidade própria

**Decisão:** Criar EXAME_MEDICO ligado a PESSOA.

**Por quê:** Uma pessoa pode realizar vários exames ao longo do tempo. Com uma entidade própria, é possível guardar a data, validade, resultado e manter o histórico desses exames.

### Justificativa 12: CONVITE_VISITANTE como entidade própria

**Decisão:** Criar CONVITE_VISITANTE separado de SÓCIO e PESSOA.

**Por quê:** O convite possui informações próprias, como código, validade e situação. Também é necessário saber qual sócio emitiu o convite e qual visitante está relacionado a ele.

### Justificativa 13: OCORRENCIA como entidade própria

**Decisão:** Criar OCORRENCIA para registrar situações ocorridas dentro do clube.

**Por quê:** Uma ocorrência precisa ter informações próprias, como data, descrição, gravidade e responsáveis envolvidos. Mantê-la separada facilita a consulta do histórico.

### Justificativa 14: Entidades associativas para relacionamentos N:N

**Decisão:** Utilizar entidades associativas nos relacionamentos N:N do projeto.

**Por quê:** Em alguns relacionamentos, além do vínculo entre as entidades, também existem dados específicos desse vínculo. Por isso foram usadas entidades como ATLETA_MODALIDADE, MATRÍCULA, TURMA_PROFESSOR, INSCRIÇÃO e ITEM_VENDA.

### Justificativa 15: INSCRIÇÃO separada de PESSOA e EVENTO

**Decisão:** Utilizar INSCRIÇÃO para ligar PESSOA e EVENTO.

**Por quê:** Uma pessoa pode participar de vários eventos e um evento pode receber várias pessoas. A inscrição ainda possui informações próprias, como data e situação, então faz sentido manter esse vínculo em uma entidade.

### Justificativa 16: MATRÍCULA separada do vínculo ATLETA–TURMA

**Decisão:** Utilizar MATRÍCULA para representar a participação do atleta em uma turma.

**Por quê:** Além de ligar o atleta à turma, a matrícula possui informações próprias, como data e situação. Isso ajuda a acompanhar matrículas ativas, canceladas ou concluídas.

## 16. Conclusão

Este documento apresenta a modelagem conceitual completa do **Clube Social e Esportivo União (CSEU)**, seguindo rigorosamente as 18 etapas do método proposto.

### Resumo dos Elementos

| Elemento | Quantidade |
|---|---|
| Entidades principais | 26 |
| Entidades associativas | 3 |
| Relacionamentos | 37 |
| Atributos documentados | ~150 |
| Requisitos funcionais | 14 |
| Requisitos não funcionais | 7 |
| Regras de negócio | 43 |
| Processos documentados | 10 |
| Justificativas técnicas | 6 |

___
