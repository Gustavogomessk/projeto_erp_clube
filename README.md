# Projeto ERP - Clube Social e Esportivo

## Modelagem Conceitual de Banco de Dados

## 1. Identificação da Equipe

| Nome                                | Função                  | Responsabilidade                                               |
| ----------------------------------- | ----------------------- | -------------------------------------------------------------- |
| Guilherme Hiroshi                   | Coordenador             | Gestão do projeto e documentação                               |
| Juan, Pedro Elias, Paola e Jonathan | Analistas de Requisitos | Levantamento de requisitos, regras de negócio e cardinalidades |
| Vitor, Gustavo Gomes e Danilo       | Modeladores de Dados    | DER e dicionário de dados                                      |
| Lucas e João Victor                 | Revisores Técnicos      | Validação e consistência do modelo                             |

## 2. Justificativa da Escolha

Escolhemos um clube social e esportivo porque esse cenário permite trabalhar diferentes processos dentro do mesmo sistema. O clube precisa controlar informações de pessoas, sócios, dependentes, funcionários, modalidades esportivas, reservas, eventos e pagamentos.


| Critério                  | Justificativa                                                                         |
| ------------------------- | ------------------------------------------------------------------------------------- |
| Complexidade de dados     | O sistema envolve sócios, dependentes, atletas, funcionários e visitantes             |
| Relacionamentos           | Existem relações entre pessoas, modalidades, turmas, eventos, pagamentos e reservas   |
| Processos variados        | Cadastro, mensalidades, reservas, eventos, matrículas e vendas                        |
| Regras de negócio         | Existem regras para categorias, pagamentos, dependentes, reservas e modalidades       |
| Situações N:N             | Atletas podem praticar várias modalidades e funcionários podem atuar em várias turmas |
| Possibilidade de expansão | O modelo pode receber novos módulos posteriormente                                    |
| Aplicabilidade            | O cenário representa situações que podem existir na administração de um clube         |

## 3. Problemas Identificados

| # | Problema                                      | Impacto                                                | Solução Proposta                                               |
| - | --------------------------------------------- | ------------------------------------------------------ | -------------------------------------------------------------- |
| 1 | Cadastro de sócios em planilhas               | Dados duplicados e inconsistentes                      | Centralização dos dados na entidade PESSOA e vínculo com SÓCIO |
| 2 | Controle manual de mensalidades               | Dificuldade para acompanhar pagamentos e inadimplência | Entidades MENSALIDADE e PAGAMENTO                              |
| 3 | Dependentes sem vínculo organizado            | Dificuldade para identificar o responsável             | Entidade DEPENDENTE vinculada ao sócio titular                 |
| 4 | Atletas sem controle de modalidades           | Dificuldade para organizar atividades esportivas       | Entidades ATLETA, MODALIDADE e ATLETA_MODALIDADE               |
| 5 | Reservas realizadas manualmente               | Possibilidade de conflitos de horário                  | Entidade RESERVA com controle de data e horário                |
| 6 | Eventos sem controle de participantes         | Dificuldade para acompanhar inscrições e vagas         | Entidades EVENTO e INSCRIÇÃO                                   |
| 7 | Funcionários sem organização por departamento | Dificuldade na administração interna                   | Entidade DEPARTAMENTO                                          |
| 8 | Turmas sem controle de participantes          | Dificuldade para controlar vagas                       | Entidades TURMA e MATRÍCULA                                    |

## 4. Processos de Negócio

### Processo 1: Cadastro de Sócio

1. A pessoa procura o clube para realizar o cadastro.
2. O funcionário solicita os dados necessários.
3. O CPF informado é consultado no sistema.

Se o CPF já estiver cadastrado:

* O funcionário verifica se a pessoa já possui vínculo como sócia.
* Caso já seja sócia, os dados podem ser atualizados quando necessário.
* O atendimento é encerrado.

Se a pessoa estiver cadastrada, mas ainda não for sócia:

* É criada a matrícula de sócio.
* A categoria é definida.
* A data de associação é registrada.
* A primeira mensalidade é gerada.
* O cadastro é concluído.

Se o CPF ainda não estiver cadastrado:

* Os dados da pessoa são cadastrados.
* O vínculo com SÓCIO é criado.
* A categoria é definida.
* A data de associação é registrada.
* A primeira mensalidade é gerada.

### Processo 2: Matrícula em Modalidade Esportiva

1. O sócio ou dependente escolhe a modalidade.
2. O funcionário verifica a situação do sócio responsável.
3. O sistema verifica se existem vagas disponíveis.

Se o sócio estiver inadimplente ou suspenso:

* As pendências são informadas.
* A matrícula não é realizada.

Se não houver vaga:

* O interessado é orientado a aguardar nova vaga; a lista de espera de turmas não será persistida nesta versão.

Se houver vaga:

* O participante é identificado ou cadastrado como ATLETA.
* A matrícula é registrada após as validações da RN55.
* O participante é vinculado a uma turma.
* O nível do atleta é conferido.
* A data de início é registrada.
* Caso exista uma taxa adicional, ela é incluída na cobrança.

### Processo 3: Reserva de Dependência Física

1. O sócio solicita uma reserva.
2. O funcionário verifica a disponibilidade do local.
3. O sistema verifica a situação do sócio.

Se a dependência estiver ocupada:

* Outros horários disponíveis podem ser apresentados.
* Caso nenhum horário seja escolhido, a solicitação é encerrada.

Se a mensalidade estiver atrasada:

* A reserva não é liberada.
* A pendência é informada ao sócio.

Se o sócio estiver regular:

* A reserva é registrada.
* O responsável pela reserva fica armazenado no sistema.
* A confirmação é disponibilizada ao sócio.

### Processo 4: Contratação de Funcionário

1. Um departamento identifica a necessidade de contratação.
2. A diretoria analisa a solicitação.
3. O RH recebe e avalia os candidatos.
4. Após a seleção, o candidato escolhido é cadastrado.

Depois da contratação:

* Os dados pessoais são cadastrados em PESSOA.
* O vínculo com FUNCIONÁRIO é criado.
* O cargo e o departamento são definidos.
* A data de admissão é registrada.
* O salário e a jornada são informados.
* A matrícula funcional é gerada.

### Processo 5: Organização de Evento

1. A diretoria aprova a realização do evento.
2. São definidos data, horário, local e público.
3. O evento é cadastrado no sistema.
4. A capacidade máxima é informada.
5. Caso exista cobrança, o valor da inscrição é definido.
6. As inscrições são abertas.

Durante as inscrições:

* Os participantes são registrados.
* O sistema acompanha a quantidade de vagas ocupadas.

Quando a capacidade máxima é atingida:

* Novas inscrições são bloqueadas.
* Os participantes já inscritos permanecem registrados.

Após a realização:

* O evento passa para a situação correspondente no histórico.

### Processo 6: Cadastro de Dependente

1. O sócio solicita o cadastro.
2. Os dados do dependente são conferidos.
3. O CPF é consultado no sistema.
Se a pessoa já estiver cadastrada:
* O cadastro existente é utilizado.
* O vínculo com o sócio titular é criado.
Se a pessoa ainda não estiver cadastrada:
* O cadastro de PESSOA é criado.
* Depois, o vínculo com o sócio titular é registrado.
Após o vínculo:
* O tipo de dependência é informado.
* A data de início é registrada.
* A situação do dependente é definida e validada contra outros períodos da pessoa.

### Processo 7: Geração e Pagamento de Mensalidade

1. O sistema identifica os sócios que devem receber a cobrança.
2. O valor é calculado conforme a categoria e os possíveis acréscimos ou descontos.
3. A mensalidade é criada.
4. A data de vencimento é registrada.
5. A cobrança é disponibilizada.

Quando o pagamento acontece:

* O recebimento é registrado em PAGAMENTO.
* Uma BAIXA_FINANCEIRA associa o valor ao título da mensalidade.
Se o pagamento for parcial:
* O valor pago fica registrado.
* O saldo restante permanece pendente.
* A mensalidade continua em aberto.
Quando o valor total é pago:
* A mensalidade passa para a situação "Pago".
* O recibo é gerado.

### Processo 8: Criação e Gestão de Turma

1. O funcionário escolhe a modalidade.
2. A turma é cadastrada.
3. São definidos os dias e horários.
4. A faixa etária é informada.
5. A capacidade máxima é definida.
6. Os professores são vinculados.

Após a criação:

* A turma fica disponível para matrículas.
* O sistema acompanha a quantidade de participantes.

Quando a capacidade é atingida:

* Novas matrículas são bloqueadas.
* Novos interessados são orientados a aguardar nova vaga; não há cadastro de espera de turmas nesta versão.

### Processo 9: Cadastro e Vinculação de Atleta

1. A pessoa demonstra interesse em participar como atleta.
2. O sistema verifica se já existe um cadastro.

Se não existir:

* Os dados pessoais são cadastrados.

Se já existir:

* O cadastro existente é utilizado.

Depois:

* O vínculo com ATLETA é criado.
* As modalidades são selecionadas.
* Os vínculos com as modalidades são registrados.
* A data de início da atividade é informada.

### Processo 10: Gestão de Diretoria e Mandatos

1. O clube define os integrantes da diretoria.
2. O sistema verifica se cada integrante possui cadastro.
3. Os sócios são vinculados aos cargos.
4. O cargo ocupado é informado.
5. A data de início do mandato é registrada.
6. A data prevista para término é definida.

Quando ocorre uma alteração:

* O mandato anterior é encerrado.
* O novo responsável é vinculado ao cargo.
* Um novo período é registrado.

## Processo 11: Venda e movimentação de estoque

1. O funcionário registra comprador e itens com preço e quantidade.
2. Na confirmação, o sistema verifica o saldo e grava venda, saídas e título a receber na mesma transação.
3. Na venda à vista, registra também recebimento e baixa do título.
4. Uma devolução gera movimento inverso e, quando houver dinheiro devolvido, estorno financeiro. Registros originais permanecem.

## Processo 12: Cobranças, pagamentos e conciliação

1. Mensalidade, inscrição paga ou venda gera um título a receber; uma despesa gera título a pagar.
2. O funcionário registra a entrada ou saída na conta financeira e aloca seu valor aos títulos por baixas.
3. Recebimentos ou pagamentos parciais mantêm saldo em aberto.
4. O extrato é importado e seus lançamentos são relacionados às operações internas.
5. Diferenças permanecem pendentes para conferência. Tarifas bancárias são despesas próprias, com título e pagamento.

## Processo 13: Encerramento e recriação de dependência

1. O funcionário informa o fim do vínculo vigente, sem excluir o registro.
2. Um retorno ou troca de titular cria outro registro, com nova data de início e novo identificador.
3. O sistema rejeita períodos sobrepostos para a mesma pessoa e permite consultar toda a sequência histórica.

## 5. Requisitos Funcionais

### RF01 - Cadastro de Pessoas

**Descrição:** O sistema deve permitir o cadastro de pessoas com nome completo, CPF, data de nascimento, telefone, e-mail e endereço.

**Regras:**

* CPF deve ser único e validado.
* Nome é obrigatório.
* Telefone pode ser informado posteriormente.

### RF02 - Cadastro de Sócios

**Descrição:** O sistema deve permitir transformar uma pessoa cadastrada em sócio do clube.

**Regras:**

* Uma pessoa cadastrada pode possuir vínculo de sócio.
* O número de matrícula deve ser único.
* A categoria deve ser definida no cadastro.
* A data de associação é obrigatória.
* A situação inicial será "Ativo".

### RF03 - Cadastro de Dependentes

**Descrição:** O sistema deve permitir cadastrar dependentes vinculados a um sócio titular.

**Regras:**

* Cada dependente possui um sócio titular.
* Tipos de dependência: Cônjuge, Filho(a), Enteado(a) e Pais.
* Dependente menor de idade deve possuir responsável legal.
* O dependente pode se tornar sócio futuramente.
* Vínculos encerrados são preservados; novo período recebe novo identificador.

### RF04 - Cadastro de Funcionários

**Descrição:** O sistema deve permitir cadastrar funcionários do clube.

**Regras:**

* Funcionário deve estar vinculado a um departamento.
* Cargo deve ser informado.
* Data de admissão é obrigatória.
* Data de demissão pode ser nula enquanto o funcionário estiver ativo.
* CTPS é obrigatória para funcionários CLT.

### RF05 - Cadastro de Atletas

**Descrição:** O sistema deve permitir identificar pessoas como atletas.

**Regras:**

* O atleta pode ser sócio, dependente ou pessoa externa.
* O atleta deve estar vinculado a pelo menos uma modalidade ativa.
* O nível do atleta deve ser informado.
* Registro em federação é opcional.

### RF06 - Gestão de Modalidades

**Descrição:** O sistema deve permitir cadastrar as modalidades esportivas oferecidas pelo clube.

**Regras:**

* O nome da modalidade deve ser único.
* Modalidade pode estar ativa ou inativa.
* Modalidade pode possuir taxa adicional.

### RF07 - Gestão de Turmas

**Descrição:** O sistema deve permitir criar turmas vinculadas às modalidades.

**Regras:**

* Cada turma pertence a uma modalidade.
* A turma possui faixa etária.
* A turma possui capacidade máxima.
* Uma turma ativa deve possuir ao menos um professor com vínculo vigente.

### RF08 - Controle de Mensalidades

**Descrição:** O sistema deve controlar as mensalidades dos sócios.

**Regras:**

* A mensalidade é gerada para cada sócio titular.
* O valor considera a categoria do sócio.
* Dependentes podem gerar acréscimos.
* A mensalidade pode possuir desconto.
* Situações: Pendente, Pago, Atrasado e Cancelado.

### RF09 - Gestão de Pagamentos

**Descrição:** O sistema deve registrar pagamentos relacionados às mensalidades.

**Regras:**

* A operação pode receber mensalidades, inscrições, vendas ou receitas manuais, ou pagar despesas.
* O vínculo com a obrigação ocorre por BAIXA_FINANCEIRA e TITULO_FINANCEIRO.
* Deve possuir data, valor e forma de pagamento.
* Pode ser parcial.
* Deve gerar comprovante na confirmação e identificar a conta financeira.

### RF10 - Reserva de Dependências

**Descrição:** O sistema deve permitir que sócios titulares reservem dependências físicas.

**Regras:**

* A reserva deve estar vinculada a um sócio titular.
* Deve estar vinculada a uma dependência.
* Deve possuir data, horário inicial e horário final.
* Não pode existir conflito de horário para a mesma dependência.
* Sócio inadimplente não pode realizar novas reservas.

### RF11 - Gestão de Eventos

**Descrição:** O sistema deve permitir cadastrar e acompanhar eventos.

**Regras:**

* Evento possui nome, data, horário, local e capacidade.
* Pode ser gratuito ou pago.
* Pode ser aberto ao público ou restrito.
* Situações: Planejado, Inscrições Abertas, Encerrado, Cancelado e Realizado.

### RF12 - Inscrição em Eventos

**Descrição:** O sistema deve permitir registrar pessoas em eventos.

**Regras:**

* A inscrição deve estar vinculada a uma pessoa e a um evento.
* A data da inscrição deve ser registrada.
* A inscrição pode ser cancelada.
* Evento lotado não aceita novas inscrições.

### RF13 - Gestão de Departamentos

**Descrição:** O sistema deve permitir cadastrar departamentos administrativos.

**Regras:**

* Departamento possui nome único.
* Pode possuir um funcionário responsável.
* Subdivisões não serão controladas nesta versão.

### RF14 - Gestão de Diretoria

**Descrição:** O sistema deve permitir registrar os mandatos da diretoria.

**Regras:**

* O cargo diretivo é ocupado por um sócio.
* O mandato possui data de início.
* A data de término pode ser registrada.
* Um sócio pode ocupar diferentes cargos em períodos diferentes.
* Um cargo pode ser ocupado por diferentes sócios ao longo do tempo.

## RF15 - Gestão de Vendas
**Descrição:** O sistema deve permitir registrar vendas de produtos ou serviços.

**Regras:**

* Toda venda deve conter comprador, funcionário responsável e itens vendidos.
* O preço praticado na venda deve preservar o valor contratado no momento da operação.
* A conclusão da venda exige ao menos um item selecionado.
* A venda exige estoque disponível suficiente para os itens.
* A conclusão da venda gera automaticamente a saída do estoque e o título a receber correspondente.
* Caso a venda seja à vista, o recebimento e a baixa financeira devem ser gerados na mesma operação.

## RF16 - Estoque e Movimentações

**Descrição:** O sistema deve manter o controle do saldo de produtos e registrar suas movimentações.

**Regras:**

* O sistema deve manter um saldo global por produto.
* Devem ser registradas movimentações de entrada, saída, perda, devolução e ajuste.
* Toda movimentação deve conter quantidade, sentido, responsável, data e origem.
* O saldo do produto não pode ficar negativo em nenhuma hipótese.
* Correções de estoque devem ser feitas mediante a geração de novos movimentos.

## RF17 - Convites de Visitantes
**Descrição:** O sistema deve permitir emitir e controlar convites de acesso para visitantes.

**Regras:**

* Cada convite deve possuir um sócio responsável, a pessoa visitante, um código único, prazo de validade e situação.
* O sistema deve validar o prazo de validade e o uso do convite no momento do acesso.
* O convite utilizado não pode ser reutilizado.
*  sistema deve manter o histórico completo de convites cancelados, expirados e utilizados.

## RF18 - Controle de Acesso

**Descrição:** O sistema deve registrar e validar os acessos de pessoas ao local.

**Regras:**

* Todo acesso deve registrar a pessoa, data, hora, tipo (entrada ou saída) e meio de acesso.
* O acesso deve validar a situação cadastral da pessoa.
* O acesso deve validar o vínculo autorizador da pessoa ou o convite associado, quando aplicável.
* Tentativas de acesso negadas podem ser registradas como ocorrências.

## RF19 - Gestão de Exames Médicos

**Descrição:** O sistema deve gerenciar o histórico de exames médicos e condicionar matrículas e participações à aptidão.

**Regras:**

* O sistema deve manter o histórico de exames contendo resultado, validade e médico responsável.
* Devem ser identificadas as modalidades esportivas ou atividades que exigem exame médico.
* O sistema deve impedir a matrícula ou participação em modalidades exigentes sem exame vigente e resultado de aptidão compatível.
* Qualquer avaliação de restrição médica deve ser realizada exclusivamente por usuário autorizado.

## RF20 - Gestão de Ocorrências

**Descrição:** O sistema deve permitir registrar eventos e incidentes ocorridos nas dependências.

**Regras:**

* Toda ocorrência deve registrar a pessoa envolvida, o funcionário responsável, data, hora, tipo, descrição, gravidade e providências tomadas.
* Cada ocorrência deve possuir obrigatoriamente uma pessoa envolvida principal.
* Registros correlatos podem ser agrupados para descrever o mesmo incidente.

## RF21 - Contas a Receber

**Descrição:** O sistema deve gerenciar os títulos e valores a serem recebidos.

**Regras:**

* O sistema deve gerar e acompanhar títulos originados de mensalidades, inscrições pagas, vendas e receitas manuais.
* Todo título a receber deve registrar devedor, data de vencimento, valor, descontos, acréscimos e saldo restante.
* O sistema deve permitir a realização de recebimentos parciais.
* O sistema deve impedir a liquidação em duplicidade de um mesmo título.

## RF22 - Contas a Pagar

**Descrição:** O sistema deve registrar e controlar as obrigações financeiras e despesas.

**Regras:**

* Devem ser registrados títulos de despesas informando fornecedor/favorecido (inclusive pessoa jurídica), descrição, valor e vencimento.
* O sistema deve registrar pagamentos parciais, saldo devedor e liquidação do título.
* O cadastro financeiro de pessoa jurídica não deve criar perfil de sócio ou atleta.

## RF23 - Contas Financeiras e Fluxo de Caixa

**Descrição:** O sistema deve gerenciar contas bancárias, caixas e a visualização do fluxo de caixa.

**Regras:**

* O sistema deve manter o cadastro de contas bancárias e caixas com saldo inicial e movimentações de entrada e saída.
* Deve ser possível consultar o fluxo de caixa realizado por data de confirmação das operações.
* Deve ser possível consultar o fluxo de caixa projetado com base nos títulos em aberto.
* Transferências entre contas e parcelamento contratual não fazem parte do escopo desta versão.

## RF24 - Conciliação Financeira

**Descrição:** O sistema deve permitir conciliar os registros internos com o extrato bancário.

**Regras:**

* O sistema deve permitir importar ou registrar itens de extrato bancário.
* Deve-se impedir a duplicação de itens de extrato com base na conta e identificador externo.
* Os valores do extrato devem ser vinculados às operações financeiras internas.
* O sistema deve aceitar correspondências parciais e agrupadas de lançamentos.
* O sistema deve evidenciar divergências encontradas.
* Deve-se preservar o autor e o histórico de todas as conciliações realizadas.

## RF25 - Cobrança de Eventos

**Descrição:** O sistema deve gerenciar a cobrança e os valores associados às inscrições de eventos.

**Regras:**

* A inscrição no evento deve registrar o preço contratado e eventuais descontos aplicados.
* Inscrições gratuitas não devem gerar títulos a receber.
* Inscrições pagas devem gerar automaticamente um título a receber.
* Recebimentos e estornos devem ser registrados por meio de operações e baixas financeiras, com controle de valores e comprovantes.

## 6. Requisitos Não Funcionais

### RNF01 - Segurança

* O sistema deve exigir autenticação para acesso às áreas restritas.
* Senhas devem ser armazenadas utilizando mecanismo seguro de proteção.
* O acesso deve ser controlado por perfil.
* Dados de CPF não devem ficar expostos para usuários sem autorização.
* Dados de exames médicos devem possuir acesso restrito.
* Registros de ocorrências devem ser acessíveis apenas a usuários autorizados.
* Registros de acesso não devem ser alterados por usuários sem permissão.
* Convites de visitantes devem possuir código único.
* Operações de venda devem registrar o funcionário responsável.

### RNF02 - Desempenho

* As principais consultas devem apresentar resposta em até 3 segundos em condições normais de uso.
* Relatórios mensais devem ser gerados em até 10 segundos.
* A estrutura inicial deve suportar aproximadamente 50 usuários simultâneos.
* Consultas de estoque devem apresentar rapidamente a quantidade disponível.
* O registro de vendas deve atualizar o estoque sem atrasos perceptíveis.
* A validação de convites deve ocorrer em poucos segundos.

### RNF03 - Disponibilidade

* O sistema deve possuir disponibilidade mínima planejada de 99%.
* Manutenções programadas devem ocorrer preferencialmente fora dos horários de maior utilização.
* O registro de acesso deve permanecer disponível durante o funcionamento do clube.
* Os módulos de vendas e estoque devem permanecer disponíveis durante as atividades comerciais.
* Registros críticos devem poder ser recuperados após uma indisponibilidade.

### RNF04 - Usabilidade

* A interface deve ser simples de utilizar.
* Formulários devem possuir validação de dados.
* Mensagens de erro devem explicar o problema de forma clara.
* A interface deve funcionar em dispositivos móveis.
* O cadastro de endereços deve possuir campos organizados.
* O registro de vendas deve permitir incluir produtos e quantidades de forma simples.
* O estoque deve apresentar claramente produtos disponíveis e indisponíveis.
* O registro de ocorrências deve permitir informar descrição, data e envolvidos.
* A validação de convites deve informar se o convite está válido, utilizado ou expirado.

### RNF05 - Compatibilidade

* O sistema deve funcionar nos navegadores Chrome, Firefox e Edge.
* Deve ser compatível com Windows 10, Windows 11 e Linux.
* Deve possuir interface adaptada para Android e iOS.

### RNF06 - Backup e Recuperação

* Deve ser realizado backup automático diário.
* Deve existir um backup completo semanal.
* O sistema deve possuir capacidade planejada de restauração em até 24 horas.
* Dados de vendas e movimentações de estoque devem fazer parte dos backups.
* Registros de acesso, exames médicos e ocorrências devem ser preservados.
* Convites utilizados ou expirados devem permanecer disponíveis para consulta histórica.
* A restauração deve preservar os relacionamentos entre vendas, itens, produtos e estoque.

### RNF07 - Escalabilidade

* A arquitetura deve ser organizada em módulos.
* Novos módulos devem poder ser adicionados posteriormente.
* O sistema deve permitir o crescimento da quantidade de sócios.
* A quantidade de produtos e vendas poderá aumentar sem alterações significativas na estrutura principal.
* O histórico de acessos e ocorrências deve continuar consultável com o crescimento dos dados.

## 7. Regras de Negócio

| #    | Regra                                                                                                   | Impacto no Modelo                      |
| ---- | ------------------------------------------------------------------------------------------------------- | -------------------------------------- |
| RN01 | Toda pessoa cadastrada deve possuir CPF único e válido                                                  | CPF único em PESSOA                    |
| RN02 | Todo dependente deve estar vinculado a um sócio titular                                                 | FK id_socio_titular em DEPENDENTE      |
| RN03 | A categoria do sócio define o valor da mensalidade e os benefícios                                      | Relacionamento SÓCIO e CATEGORIA_SOCIO |
| RN04 | O sócio pode estar Ativo, Inadimplente, Suspenso ou Inativo                                             | situacao_socio em SÓCIO                |
| RN05 | Atleta deve estar vinculado a pelo menos uma modalidade                                                 | ATLETA_MODALIDADE                      |
| RN06 | Cada turma possui capacidade máxima                                                                     | capacidade_maxima em TURMA             |
| RN07 | Somente sócios titulares ativos e regulares podem realizar reservas                                     | Validação em RESERVA                   |
| RN08 | Cargos de diretoria são ocupados por sócios durante determinado mandato                                 | DIRETORIA                              |
| RN09 | Dependente pode se tornar sócio titular                                                                 | Histórico do vínculo                   |
| RN10 | Valor da mensalidade é definido pela categoria                                                          | CATEGORIA_SOCIO                        |
| RN11 | Pagamentos podem ser parciais                                                                           | TITULO_FINANCEIRO e BAIXA_FINANCEIRA      |
| RN12 | Eventos podem ser abertos ou restritos                                                                  | tipo_evento em EVENTO                  |
| RN13 | Funcionário também pode possuir vínculo como sócio                                                      | PESSOA pode possuir ambos os vínculos  |
| RN14 | Atleta pode ser sócio, dependente ou externo; o papel é identificado pela mesma PESSOA                                                           | Sem referência direta ATLETA–SÓCIO  |
| RN15 | Reserva deve ser solicitada com antecedência mínima de 24 horas e máxima de 30 dias                     | Validação em RESERVA                   |
| RN16 | Um sócio pode possuir vários dependentes                                                                | Relacionamento 1:N                     |
| RN17 | Um dependente pertence a apenas um sócio titular                                                        | FK id_socio_titular                    |
| RN18 | Dependente pode perder o vínculo quando atingir a idade limite definida para sua categoria              | Atualização da situação                |
| RN19 | Um atleta pode participar de várias modalidades                                                         | ATLETA_MODALIDADE                      |
| RN20 | Um funcionário pode ministrar várias turmas                                                             | TURMA_PROFESSOR                        |
| RN21 | Uma mensalidade pode possuir vários pagamentos parciais                                                 | Título da mensalidade e suas baixas                |
| RN22 | Não é permitida reserva conflitante para a mesma dependência                                            | Validação de data e horário            |
| RN23 | Toda reserva deve possuir um sócio responsável                                                          | FK id_socio em RESERVA                 |
| RN24 | Uma reserva pode ser cancelada caso o sócio responsável fique inadimplente, conforme as regras do clube | situacao_reserva                       |
| RN25 | A categoria do sócio pode definir quais dependências estão disponíveis para reserva                     | Regra de permissão                     |
| RN26 | Uma pessoa pode possuir vários endereços                                                                | ENDEREÇO                               |
| RN27 | Uma pessoa pode possuir vários registros de acesso                                                      | REGISTRO_ACESSO                        |
| RN28 | Um sócio pode emitir vários convites                                                                    | CONVITE_VISITANTE                      |
| RN29 | Uma pessoa pode estar vinculada a vários convites como visitante                                        | id_pessoa_visitante                    |
| RN30 | Uma pessoa pode possuir vários exames médicos                                                           | EXAME_MEDICO                           |
| RN31 | Uma pessoa pode realizar várias compras                                                                 | VENDA                                  |
| RN32 | Um funcionário pode registrar várias vendas                                                             | VENDA                                  |
| RN33 | Uma venda pode possuir vários itens                                                                     | ITEM_VENDA                             |
| RN34 | Um produto pode aparecer em várias vendas                                                               | ITEM_VENDA                             |
| RN35 | Cada produto possui exatamente um saldo global de estoque                                               |PRODUTO–ESTOQUE 1:1                     |
| RN36 | Uma pessoa pode estar envolvida em várias ocorrências                                                   | OCORRENCIA                             |
| RN37 | Um funcionário pode registrar várias ocorrências                                                        | OCORRENCIA                             |
| RN38 | Todo registro de acesso deve possuir data, horário e tipo de movimentação                               | REGISTRO_ACESSO                        |
| RN39 | Convites somente podem ser utilizados dentro do período de validade                                     | CONVITE_VISITANTE                      |
| RN40 | Algumas modalidades podem exigir exame médico válido                                                    | EXAME_MEDICO                           |
| RN41 | A quantidade vendida não pode ultrapassar o estoque disponível                                          | Validação da venda                     |
| RN42 | Toda venda concluída deve atualizar o estoque                                                           | ESTOQUE                                |
| RN43 | Toda ocorrência deve possuir data e descrição                                                           | OCORRENCIA                             |
| RN44 | 	Uma pessoa pode ser sócia, funcionária e atleta, enquanto a condição de dependente representa um vínculo com um sócio titular                   | PESSOA, SÓCIO, FUNCIONÁRIO, ATLETA e DEPENDENTE |
| RN45 |	Uma pessoa pode possuir vários vínculos históricos de dependência, mas apenas um titular vigente, sem ser dependente de si mesmar               | Períodos sem sobreposição em DEPENDENTE     |
| RN46 | 	Toda alteração de estoque deve registrar quantidade positiva, tipo, sentido, responsável e origem, preservando as movimentações anteriores e impedindo saldo negativo                                                                                                                     | MOVIMENTACAO_ESTOQUE e ESTOQUEO |
| RN47 | 	Toda venda concluída deve gerar uma única saída por item, e as devoluções não podem ultrapassar a quantidade vendida ainda não devolvida                                                                                                                                                 |ITEM_VENDA e MOVIMENTACAO_ESTOQUE |
| RN48 | 	Todo título financeiro deve indicar se é a receber ou a pagar, possuir uma contraparte e identificar uma única origem                           | TITULO_FINANCEIRO e CONTRAPARTE_FINANCEIRA |
| RN49 | 	Toda mensalidade, inscrição paga ou venda concluída deve gerar um título a receber, enquanto inscrições gratuitas não geram cobrança            |	MENSALIDADE, INSCRIÇÃO, VENDA e TITULO_FINANCEIRO |
| RN50 |Uma operação financeira pode liquidar vários títulos da mesma contraparte e natureza, sem ultrapassar seus saldos, e o total das baixas deve corresponder ao valor confirmado |  PAGAMENTO e BAIXA_FINANCEIRA  |
| RN51 | 	O fluxo de caixa realizado deve considerar somente operações confirmadas, enquanto o projetado considera os saldos dos títulos em aberto     | CONTA_FINANCEIRA, PAGAMENTO e TITULO_FINANCEIRO |
| RN52 | 	Toda correção de operação financeira confirmada deve ocorrer por estorno integral e único, preservando o registro original e respeitando a política de reembolso| PAGAMENTO e BAIXA_FINANCEIRA|
| RN53 |A conciliação deve relacionar operações e lançamentos de extrato da mesma conta e sentido, sem ultrapassar seus valores e mantendo divergências pendentes|CONCILIACAO, PAGAMENTO e ITEM_EXTRATO |
| RN54 | Não são permitidas reservas confirmadas com horários sobrepostos na mesma dependência, sendo permitidos horários consecutivos                | Validação de data e horário em RESERVA    |
| RN55 | Toda matrícula ativa deve atender às condições da turma, idade, modalidade, exame e vínculo do participante, sem duplicidade ou excesso de capacidade| Validação em MATRÍCULA e TURMA|
| RN56 |	Solicitações simultâneas não podem gerar reservas conflitantes nem matrículas acima da capacidade| Controle de concorrência em RESERVA e MATRÍCULA|
| RN57 | Não são permitidas permissões, lançamentos de extrato ou mensalidades duplicados, nem períodos sobrepostos nos vínculos esportivos equivalentes| Unicidade composta e validação de períodos  |
| RN58 | 	Valores e quantidades devem respeitar os limites permitidos, descontos não podem gerar saldo negativo e datas finais devem ser posteriores às iniciais| Validação de valores, quantidades e datas|
| RN59 | RUm dependente deve encerrar seu vínculo antes de se tornar sócio ativo, preservando seu histórico, enquanto funcionários e atletas podem também ser sócios| DEPENDENTE, SÓCIO, FUNCIONÁRIO e ATLETA|

### Tabela de Categorias de Sócio

| Categoria  | Valor Mensalidade | Benefícios                                       |
| ---------- | ----------------: | ------------------------------------------------ |
| Titular    |         R$ 200,00 | Acesso ao clube conforme as regras da categoria  |
| Dependente |         R$ 100,00 | Acesso vinculado ao titular                      |
| Convidado  |         R$ 150,00 | Acesso limitado                                  |
| Atleta     |         R$ 180,00 | Acesso ao clube e atividades esportivas          |
| Sênior     |         R$ 120,00 | Benefícios destinados a sócios acima de 60 anos  |
| Infantil   |          R$ 80,00 | Acesso conforme faixa etária definida pelo clube |

## 8. Restrições e Políticas Organizacionais

### 8.1 Restrições Legais

* O tratamento de dados pessoais deve seguir a LGPD.
* CPF não deve ser exibido publicamente.
* Menores de idade devem possuir responsável legal cadastrado.

### 8.2 Restrições Operacionais

* Reservas podem ser realizadas somente durante o horário de funcionamento definido pelo clube.
* O horário de funcionamento considerado no projeto é das 6h às 22h.
* O clube realiza manutenção geral às segundas-feiras.
* Eventos com mais de 100 participantes precisam de autorização da diretoria.
* O uso da churrasqueira exige reserva com pelo menos 48 horas de antecedência.

### 8.3 Políticas Organizacionais

* Dependentes de sócios titulares possuem prioridade em vagas de modalidades, quando previsto pelo clube.
* Funcionários possuem desconto de 50% na mensalidade de sócio.
* Sócios com mais de 10 anos de associação possuem desconto de 10%.
* Cancelamentos de inscrição realizados com menos de 48 horas de antecedência não geram reembolso.

## 9. Entidades Identificadas

| #  | Entidade           | Justificativa                                               | Origem           |
| -- | ------------------ | ----------------------------------------------------------- | ---------------- |
| 1  | PESSOA             | Armazena os dados básicos das pessoas cadastradas           | RF01             |
| 2  | SÓCIO              | Representa o vínculo da pessoa com o clube                  | RF02             |
| 3  | DEPENDENTE         | Representa o vínculo de dependência com um sócio titular    | RF03             |
| 4  | FUNCIONÁRIO        | Armazena informações trabalhistas                           | RF04             |
| 5  | ATLETA             | Representa pessoas que participam das atividades esportivas | RF05             |
| 6  | MODALIDADE         | Representa os esportes oferecidos                           | RF06             |
| 7  | CATEGORIA_SOCIO    | Define categorias e valores de mensalidade                  | RN03             |
| 8  | DEPARTAMENTO       | Representa setores administrativos                          | RF13             |
| 9  | DEPENDENCIA_FISICA | Representa locais que podem ser utilizados ou reservados    | RF10             |
| 10 | RESERVA            | Registra reservas de dependências                           | RF10             |
| 11 | EVENTO             | Registra eventos do clube                                   | RF11             |
| 12 | INSCRIÇÃO          | Registra a participação de pessoas em eventos               | RF12             |
| 13 | MENSALIDADE        | Registra cobranças dos sócios                               | RF08             |
| 14 | PAGAMENTO          | Registra pagamentos de mensalidades                         | RF09             |
| 15 | TURMA              | Representa turmas de modalidades                            | RF07             |
| 16 | MATRÍCULA          | Registra a matrícula de atletas em turmas                   | RF07             |
| 17 | DIRETORIA          | Registra os mandatos dos sócios em cargos diretivos         | RF14             |
| 18 | FUNCAO_DIRETORIA   | Armazena os cargos existentes na diretoria                  | RF14             |
| 19 | ATLETA_MODALIDADE  | Resolve o relacionamento N:N entre atleta e modalidade      | RN05             |
| 20 | TURMA_PROFESSOR    | Resolve o relacionamento entre funcionários e turmas        | RN20             |
| 21 | ENDEREÇO           | Permite armazenar um ou mais endereços por pessoa           | RN26             |
| 22 | REGISTRO_ACESSO    | Registra entradas e saídas do clube                         | RN27, RN38       |
| 23 | VENDA              | Registra compras realizadas no clube                        | RN31, RN32       |
| 24 | PRODUTO            | Armazena produtos comercializados                           | RN34, RN41       |
| 25 | ITEM_VENDA         | Registra os produtos de cada venda                          | RN33, RN34       |
| 26 | ESTOQUE            | Controla a quantidade disponível de produtos                | RN35, RN41, RN42 |
| 27 | EXAME_MEDICO       | Mantém o histórico de exames médicos                        | RN30, RN40       |
| 28 | CONVITE_VISITANTE  | Registra convites emitidos por sócios                       | RN28, RN29, RN39 |
| 29 | OCORRENCIA         | Registra ocorrências e seus responsáveis                    | RN36, RN37, RN43 |
| 30 | MOVIMENTACAO_ESTOQUE|Registra entradas, saídas, perdas, devoluções e ajustes de produtos|RF16, RN46|
| 31 | CATEGORIA_DEPENDENCIA|Define quais dependências cada categoria de sócio pode reservar|RN25|
| 32 | CONTRAPARTE_FINANCEIRA|Identifica clientes, fornecedores e favorecidos, incluindo pessoas jurídicas|RF21, RF22|
| 33 | TITULO_FINANCEIRO|Registra obrigações a receber ou a pagar, seus valores, vencimentos e origens|RF21, RF22, RF25|
| 34 | BAIXA_FINANCEIRA|Relaciona operações financeiras aos títulos e registra os valores liquidados ou estornados|RF09, RN50, RN52 |
| 35 | CONTA_FINANCEIRA|Representa contas bancárias e caixas utilizados pelo clube|RF23|
| 36 | ITEM_EXTRATO |Registra lançamentos bancários utilizados na conciliação |RF24|
| 37 | DEVOLUCAO_VENDA|Registra e controla as devoluções de produtos vendidos, identificando itens, quantidades, motivos e responsáveis|RF15, RF16, RN47|
| 38 | CONCILIACAO|Relaciona lançamentos do extrato às operações financeiras para conferir os valores|RF24, RN53|

### Nota sobre "Político"

No início do projeto foi utilizado o termo "Político", mas durante a revisão percebemos que ele não representava corretamente a estrutura de um clube.

Por isso, o conceito foi substituído por DIRETORIA e FUNCAO_DIRETORIA.

A alteração foi feita porque:

* O clube possui uma diretoria com cargos definidos.
* Esses cargos são ocupados por sócios.
* Cada ocupação possui um período de mandato.
* O modelo passa a representar melhor o histórico dos cargos.

## 10. Atributos

### 10.1 PESSOA

| Atributo        | Tipo          | Obrigatório | Único | Descrição                   |
| --------------- | ------------- | ----------- | ----- | --------------------------- |
| CPF       | Identificador | Sim         | Sim   | Identificador da pessoa     |
| nome_completo   | Texto(100)    | Sim         | Não   | Nome completo               |
| data_nascimento | Data          | Sim         | Não   | Data de nascimento          |
| telefone        | Texto(15)     | Não         | Não   | Telefone de contato         |
| email           | Texto(100)    | Não         | Não   | E-mail                      |
| status_pessoa   | Texto(10)     | Sim         | Não   | Ativa, Inativa ou Bloqueada |
| data_cadastro   | Data/Hora     | Sim         | Não   | Data de cadastro            |

### 10.2 SÓCIO

| Atributo           | Tipo          | Obrigatório | Único | Descrição                                |
| ------------------ | ------------- | ----------- | ----- | ---------------------------------------- |
| id_socio           | Identificador | Sim         | Sim   | Identificador do sócio                   |
| CPF          | Referência    | Sim         | Sim   | FK para PESSOA                           |
| numero_matricula   | Texto(12)     | Sim         | Sim   | Matrícula do sócio                       |
| id_categoria_socio | Referência    | Sim         | Não   | FK para CATEGORIA_SOCIO                  |
| data_associacao    | Data          | Sim         | Não   | Data de associação                       |
| data_desligamento  | Data          | Não         | Não   | Data do desligamento                     |
| situacao_socio     | Texto(15)     | Sim         | Não   | Ativo, Inadimplente, Suspenso ou Inativo |
| observacao         | Texto(500)    | Não         | Não   | Observações                              |

### 10.3 DEPENDENTE

| Atributo                | Tipo          | Obrigatório | Único | Descrição                             |
| ----------------------- | ------------- | ----------- | ----- | ------------------------------------- |
| id_dependente           | Identificador | Sim         | Sim   | Identificador                         |
| id_socio_titular        | Referência    | Sim         | Não   | FK para SÓCIO                         |
| CPF                     | Referência    | Sim         | Não   | FK para PESSOA dependente             |
| tipo_dependencia        | Texto(20)     | Sim         | Não   | Cônjuge, Filho(a), Enteado(a) ou Pais |
| data_inicio_dependencia | Data          | Sim         | Não   | Início do vínculo                     |
| data_fim_dependencia    | Data          | Não         | Não   | Fim do vínculo                        |
| situacao_dependente     | Texto(10)     | Sim         | Não   | Ativo ou Encerrado                    |
| observacao              | Texto(500)    | Não         | Não   | Observações                           |

### 10.4 FUNCIONÁRIO

| Atributo             | Tipo          | Obrigatório | Único | Descrição                         |
| -------------------- | ------------- | ----------- | ----- | --------------------------------- |
| id_funcionario       | Identificador | Sim         | Sim   | Identificador                     |
| CPF                  | Referência    | Sim         | Sim   | FK para PESSOA                    |
| id_departamento      | Referência    | Sim         | Não   | FK para DEPARTAMENTO              |
| matricula_funcional  | Texto(12)     | Sim         | Sim   | Matrícula funcional               |
| cargo                | Texto(50)     | Sim         | Não   | Cargo exercido                    |
| salario              | Decimal(10,2) | Sim         | Não   | Salário                           |
| data_admissao        | Data          | Sim         | Não   | Data de admissão                  |
| data_demissao        | Data          | Não         | Não   | Data de demissão                  |
| jornada_trabalho     | Texto(10)     | Sim         | Não   | Jornada de trabalho               |
| tipo_contrato        | Texto(15)     | Sim         | Não   | CLT, PJ, Estagiário ou Temporário |
| ctps_numero          | Texto(20)     | Não         | Não   | Número da CTPS                    |
| situacao_funcionario | Texto(15)     | Sim         | Não   | Ativo, Afastado ou Desligado      |

### 10.5 ATLETA

| Atributo              | Tipo          | Obrigatório | Único | Descrição                                          |
| --------------------- | ------------- | ----------- | ----- | -------------------------------------------------- |
| id_atleta             | Identificador | Sim         | Sim   | Identificador                                      |
| CPF                   | Referência    | Sim         | Sim   | FK para PESSOA                                     |
| nivel_atleta          | Texto(15)     | Sim         | Não   | Iniciante, Intermediário, Avançado ou Profissional |
| registro_federacao    | Texto(30)     | Não         | Não   | Registro esportivo                                 |
| data_inicio_atividade | Data          | Sim         | Não   | Início da atividade                                |
| situacao_atleta       | Texto(15)     | Sim         | Não   | Ativo, Afastado, Lesionado ou Inativo              |
| observacao            | Texto(500)    | Não         | Não   | Observações                                        |

### 10.6 MODALIDADE

| Atributo            | Tipo          | Obrigatório | Único | Descrição          |
| ------------------- | ------------- | ----------- | ----- | ------------------ |
| id_modalidade       | Identificador | Sim         | Sim   | Identificador      |
| nome_modalidade     | Texto(50)     | Sim         | Sim   | Nome da modalidade |
| descricao           | Texto(500)    | Não         | Não   | Descrição          |
| taxa_adicional      | Decimal(10,2) | Não         | Não   | Taxa adicional     |
| idade_minima        | Inteiro       | Não         | Não   | Idade mínima       |
| idade_maxima        | Inteiro       | Não         | Não   | Idade máxima       |
| situacao_modalidade | Texto(10)     | Sim         | Não   | Ativa ou Inativa   |

### 10.7 CATEGORIA_SOCIO

| Atributo             | Tipo          | Obrigatório | Único | Descrição         |
| -------------------- | ------------- | ----------- | ----- | ----------------- |
| id_categoria_socio   | Identificador | Sim         | Sim   | Identificador     |
| nome_categoria       | Texto(50)     | Sim         | Sim   | Nome da categoria |
| valor_mensalidade    | Decimal(10,2) | Sim         | Não   | Valor mensal      |
| descricao_beneficios | Texto(500)    | Não         | Não   | Benefícios        |
| situacao_categoria   | Texto(10)     | Sim         | Não   | Ativa ou Inativa  |

### 10.8 DEPARTAMENTO

| Atributo              | Tipo          | Obrigatório | Único | Descrição            |
| --------------------- | ------------- | ----------- | ----- | -------------------- |
| id_departamento       | Identificador | Sim         | Sim   | Identificador        |
| nome_departamento     | Texto(50)     | Sim         | Sim   | Nome do departamento |
| descricao             | Texto(500)    | Não         | Não   | Descrição            |
| id_responsavel        | Referência    | Não         | Não   | FK para FUNCIONÁRIO  |
| situacao_departamento | Texto(10)     | Sim         | Não   | Ativo ou Inativo     |

### 10.9 DEPENDENCIA_FISICA

| Atributo             | Tipo          | Obrigatório | Único | Descrição                            |
| -------------------- | ------------- | ----------- | ----- | ------------------------------------ |
| id_dependencia       | Identificador | Sim         | Sim   | Identificador                        |
| nome_dependencia     | Texto(50)     | Sim         | Sim   | Nome da dependência                  |
| tipo_dependencia     | Texto(20)     | Sim         | Não   | Quadra, Piscina, Salão ou Campo      |
| capacidade_maxima    | Inteiro       | Não         | Não   | Capacidade                           |
| situacao_dependencia | Texto(15)     | Sim         | Não   | Disponível, Manutenção ou Desativada |
| observacao           | Texto(500)    | Não         | Não   | Observações                          |

### 10.10 RESERVA

| Atributo         | Tipo          | Obrigatório | Único | Descrição                          |
| ---------------- | ------------- | ----------- | ----- | ---------------------------------- |
| id_reserva       | Identificador | Sim         | Sim   | Identificador                      |
| id_socio         | Referência    | Sim         | Não   | FK para SÓCIO                      |
| id_dependencia   | Referência    | Sim         | Não   | FK para DEPENDENCIA_FISICA         |
| data_reserva     | Data          | Sim         | Não   | Data da reserva                    |
| hora_inicio      | Hora          | Sim         | Não   | Início                             |
| hora_fim         | Hora          | Sim         | Não   | Término                            |
| situacao_reserva | Texto(15)     | Sim         | Não   | Confirmada, Cancelada ou Concluída |
| data_solicitacao | Data/Hora     | Sim         | Não   | Data da solicitação                |
| observacao       | Texto(500)    | Não         | Não   | Observações                        |

### 10.11 EVENTO

| Atributo          | Tipo          | Obrigatório | Único | Descrição                                                        |
| ----------------- | ------------- | ----------- | ----- | ---------------------------------------------------------------- |
| id_evento         | Identificador | Sim         | Sim   | Identificador                                                    |
| nome_evento       | Texto(100)    | Sim         | Não   | Nome                                                             |
| descricao         | Texto(500)    | Não         | Não   | Descrição                                                        |
| data_evento       | Data          | Sim         | Não   | Data                                                             |
| hora_inicio       | Hora          | Sim         | Não   | Horário inicial                                                  |
| hora_fim          | Hora          | Não         | Não   | Horário final                                                    |
| id_dependencia    | Referência    | Não         | Não   | FK para DEPENDENCIA_FISICA                                       |
| capacidade_maxima | Inteiro       | Sim         | Não   | Capacidade                                                       |
| valor_inscricao   | Decimal(10,2) | Não         | Não   | Valor                                                            |
| tipo_evento       | Texto(20)     | Sim         | Não   | Aberto ou Restrito                                               |
| situacao_evento   | Texto(20)     | Sim         | Não   | Planejado, Inscrições Abertas, Encerrado, Cancelado ou Realizado |
| observacao        | Texto(500)    | Não         | Não   | Observações                                                      |

### 10.12 INSCRIÇÃO

| Atributo             | Tipo          | Obrigatório | Único | Descrição                                |
| -------------------- | ------------- | ----------- | ----- | ---------------------------------------- |
| id_inscricao         | Identificador | Sim         | Sim   | Identificador                            |
| id_evento            | Referência    | Sim         | Não   | FK para EVENTO                           |
| CPF                  | Referência    | Sim         | Não   | FK para PESSOA                           |
| data_inscricao       | Data/Hora     | Sim         | Não   | Data da inscrição                        |
| situacao_inscricao   | Texto(15)     | Sim         | Não   | Confirmada, Cancelada ou Lista de Espera |
| pagamento_confirmado | Booleano      | Não         | Não   | Indica se o pagamento foi confirmado     |
| observacao           | Texto(500)    | Não         | Não   | Observações                              |

### 10.13 MENSALIDADE

| Atributo             | Tipo          | Obrigatório | Único | Descrição                             |
| -------------------- | ------------- | ----------- | ----- | ------------------------------------- |
| id_mensalidade       | Identificador | Sim         | Sim   | Identificador                         |
| id_socio             | Referência    | Sim         | Não   | FK para SÓCIO                         |
| mes_referencia       | Mês/Ano       | Sim         | Não   | Período da mensalidade                |
| valor_base           | Decimal(10,2) | Sim         | Não   | Valor inicial                         |
| valor_acrescimos     | Decimal(10,2) | Não         | Não   | Acréscimos                            |
| valor_descontos      | Decimal(10,2) | Não         | Não   | Descontos                             |
| valor_total          | Decimal(10,2) | Sim         | Não   | Valor final                           |
| data_vencimento      | Data          | Sim         | Não   | Vencimento                            |
| situacao_mensalidade | Texto(15)     | Sim         | Não   | Pendente, Pago, Atrasado ou Cancelado |
| data_geracao         | Data/Hora     | Sim         | Não   | Data de geração                       |
| observacao           | Texto(500)    | Não         | Não   | Observações                           |

### 10.14 PAGAMENTO

| Atributo           | Tipo          | Obrigatório | Único | Descrição                       |
| ------------------ | ------------- | ----------- | ----- | ------------------------------- |
| id_pagamento       | Identificador | Sim         | Sim   | Identificador                   |
| id_conta_financeira| Referência    | Sim         | Não   | FK para CONTA_FINANCEIRA        |
| data_pagamento     | Data          | Sim         | Não   | Data                            |
| valor_pago         | Decimal(10,2) | Sim         | Não   | Valor pago                      |
| forma_pagamento    | Texto(20)     | Sim         | Não   | Boleto, Cartão, PIX ou Dinheiro |
| numero_recibo      | Texto(20)     | Sim         | Sim   | Número do comprovante ou recibo |
| tipo_operacao      | Texto(15)     | SIM         | Não   | Recebimento ou Pagamento        |
| situacao_pagamento | Texto(15)     | Sim         | Não   | Confirmado ou Estornado         |
| observacao         | Texto(500)    | Não         | Não   | Observações                     |





### 10.15 TURMA

| Atributo          | Tipo          | Obrigatório | Único | Descrição          |
| ----------------- | ------------- | ----------- | ----- | ------------------ |
| id_turma          | Identificador | Sim         | Sim   | Identificador      |
| id_modalidade     | Referência    | Sim         | Não   | FK para MODALIDADE |
| nome_turma        | Texto(50)     | Sim         | Não   | Nome               |
| faixa_etaria      | Texto(20)     | Sim         | Não   | Faixa etária       |
| capacidade_maxima | Inteiro       | Sim         | Não   | Capacidade         |
| dia_semana        | Texto(30)     | Sim         | Não   | Dias da semana     |
| hora_inicio       | Hora          | Sim         | Não   | Início             |
| hora_fim          | Hora          | Sim         | Não   | Término            |
| situacao_turma    | Texto(10)     | Sim         | Não   | Ativa ou Inativa   |
| observacao        | Texto(500)    | Não         | Não   | Observações        |

### 10.16 MATRÍCULA

| Atributo           | Tipo          | Obrigatório | Único | Descrição                     |
| ------------------ | ------------- | ----------- | ----- | ----------------------------- |
| id_matricula       | Identificador | Sim         | Sim   | Identificador                 |
| id_atleta          | Referência    | Sim         | Não   | FK para ATLETA                |
| id_turma           | Referência    | Sim         | Não   | FK para TURMA                 |
| data_matricula     | Data          | Sim         | Não   | Data                          |
| situacao_matricula | Texto(15)     | Sim         | Não   | Ativa, Cancelada ou Concluída |
| observacao         | Texto(500)    | Não         | Não   | Observações                   |

### 10.17 DIRETORIA

| Atributo            | Tipo          | Obrigatório | Único | Descrição                             |
| ------------------- | ------------- | ----------- | ----- | ------------------------------------- |
| id_diretoria        | Identificador | Sim         | Sim   | Identificador                         |
| id_socio            | Referência    | Sim         | Não   | FK para SÓCIO                         |
| id_funcao_diretoria | Referência    | Sim         | Não   | FK para FUNCAO_DIRETORIA              |
| data_inicio_mandato | Data          | Sim         | Não   | Início                                |
| data_fim_mandato    | Data          | Não         | Não   | Término                               |
| situacao_mandato    | Texto(15)     | Sim         | Não   | Em Andamento, Concluído ou Renunciado |
| observacao          | Texto(500)    | Não         | Não   | Observações                           |

### 10.18 FUNCAO_DIRETORIA

| Atributo            | Tipo          | Obrigatório | Único | Descrição         |
| ------------------- | ------------- | ----------- | ----- | ----------------- |
| id_funcao_diretoria | Identificador | Sim         | Sim   | Identificador     |
| nome_funcao         | Texto(50)     | Sim         | Sim   | Nome do cargo     |
| descricao           | Texto(500)    | Não         | Não   | Responsabilidades |
| ordem_hierarquica   | Inteiro       | Não         | Não   | Ordem hierárquica |
| situacao_funcao     | Texto(10)     | Sim         | Não   | Ativa ou Inativa  |

### 10.19 ATLETA_MODALIDADE

| Atributo             | Tipo          | Obrigatório | Único | Descrição                  |
| -------------------- | ------------- | ----------- | ----- | -------------------------- |
| id_atleta_modalidade | Identificador | Sim         | Sim   | Identificador do vínculo   |
| id_atleta            | Referência    | Sim         | Não   | FK para ATLETA             |
| id_modalidade        | Referência    | Sim         | Não   | FK para MODALIDADE         |
| data_inicio          | Data          | Sim         | Não   | Início da prática          |
| data_fim             | Data          | Não         | Não   | Encerramento               |
| situacao_vinculo     | Texto(15)     | Sim         | Não   | Ativo, Inativo ou Suspenso |
| observacao           | Texto(500)    | Não         | Não   | Observações                |

### 10.20 TURMA_PROFESSOR

| Atributo           | Tipo          | Obrigatório | Único | Descrição                |
| ------------------ | ------------- | ----------- | ----- | ------------------------ |
| id_turma_professor | Identificador | Sim         | Sim   | Identificador do vínculo |
| id_turma           | Referência    | Sim         | Não   | FK para TURMA            |
| id_funcionario     | Referência    | Sim         | Não   | FK para FUNCIONÁRIO      |
| data_inicio        | Data          | Sim         | Não   | Início                   |
| data_fim           | Data          | Não         | Não   | Encerramento             |
| situacao_vinculo   | Texto(15)     | Sim         | Não   | Ativo ou Inativo         |
| observacao         | Texto(500)    | Não         | Não   | Observações              |

### 10.21 ENDEREÇO

| Atributo           | Tipo          | Obrigatório | Único | Descrição                       |
| ------------------ | ------------- | ----------- | ----- | ------------------------------- |
| id_endereco        | Identificador | Sim         | Sim   | Identificador                   |
| CPF                | Referência    | Sim         | Não   | FK para PESSOA                  |
| logradouro         | Texto(100)    | Sim         | Não   | Rua ou avenida                  |
| numero             | Texto(10)     | Sim         | Não   | Número                          |
| complemento        | Texto(50)     | Não         | Não   | Complemento                     |
| bairro             | Texto(50)     | Sim         | Não   | Bairro                          |
| cidade             | Texto(50)     | Sim         | Não   | Cidade                          |
| estado             | Texto(2)      | Sim         | Não   | UF                              |
| cep                | Texto(8)      | Sim         | Não   | CEP                             |
| tipo_endereco      | Texto(15)     | Sim         | Não   | Residencial, Comercial ou Outro |
| endereco_principal | Booleano      | Sim         | Não   | Indica o endereço principal     |

### 10.22 REGISTRO_ACESSO

| Atributo           | Tipo          | Obrigatório | Único | Descrição                         |
| ------------------ | ------------- | ----------- | ----- | --------------------------------- |
| id_registro_acesso | Identificador | Sim         | Sim   | Identificador                     |
| CPF                | Referência    | Sim         | Não   | FK para PESSOA                    |
| data_acesso        | Data          | Sim         | Não   | Data                              |
| hora_acesso        | Hora          | Sim         | Não   | Horário                           |
| tipo_acesso        | Texto(10)     | Sim         | Não   | Entrada ou Saída                  |
| meio_acesso        | Texto(20)     | Não         | Não   | Carteirinha, QR Code ou Biometria |
| observacao         | Texto(500)    | Não         | Não   | Observações                       |

### 10.23 VENDA

| Atributo        | Tipo          | Obrigatório | Único | Descrição                       |
| --------------- | ------------- | ----------- | ----- | ------------------------------- |
| id_venda        | Identificador | Sim         | Sim   | Identificador                   |
| CPF             | Referência    | Sim         | Não   | FK para PESSOA compradora       |
| id_funcionario  | Referência    | Sim         | Não   | FK para FUNCIONÁRIO responsável |
| data_venda      | Data/Hora     | Sim         | Não   | Data e horário                  |
| valor_total     | Decimal(10,2) | Sim         | Não   | Valor total                     |
| forma_pagamento | Texto(15)     | Sim         | Não   | PIX, Dinheiro ou Cartão         |
| situacao_venda  | Texto(15)     | Sim         | Não   | Concluída ou Cancelada          |
| observacao      | Texto(500)    | Não         | Não   | Observações                     |

### 10.24 PRODUTO

| Atributo          | Tipo          | Obrigatório | Único | Descrição        |
| ----------------- | ------------- | ----------- | ----- | ---------------- |
| id_produto        | Identificador | Sim         | Sim   | Identificador    |
| nome_produto      | Texto(100)    | Sim         | Não   | Nome             |
| descricao         | Texto(500)    | Não         | Não   | Descrição        |
| categoria_produto | Texto(50)     | Não         | Não   | Categoria        |
| valor_unitario    | Decimal(10,2) | Sim         | Não   | Preço            |
| codigo_produto    | Texto(30)     | Sim         | Sim   | Código           |
| situacao_produto  | Texto(15)     | Sim         | Não   | Ativo ou Inativo |
| observacao        | Texto(500)    | Não         | Não   | Observações      |

### 10.25 ITEM_VENDA

| Atributo       | Tipo          | Obrigatório | Único | Descrição                          |
| -------------- | ------------- | ----------- | ----- | ---------------------------------- |
| id_item_venda  | Identificador | Sim         | Sim   | Identificador                      |
| id_venda       | Referência    | Sim         | Não   | FK para VENDA                      |
| id_produto     | Referência    | Sim         | Não   | FK para PRODUTO                    |
| quantidade     | Inteiro       | Sim         | Não   | Quantidade                         |
| valor_unitario | Decimal(10,2) | Sim         | Não   | Valor no momento da venda          |
| subtotal       | Decimal(10,2) | Sim         | Não   | Quantidade multiplicada pelo valor |
| observacao     | Texto(500)    | Não         | Não   | Observações                        |

### 10.26 ESTOQUE

| Atributo              | Tipo          | Obrigatório | Único | Descrição                     |
| --------------------- | ------------- | ----------- | ----- | ----------------------------- |
| id_estoque            | Identificador | Sim         | Sim   | Identificador                 |
| id_produto            | Referência    | Sim         | Não   | FK para PRODUTO               |
| quantidade_disponivel | Inteiro       | Sim         | Não   | Quantidade disponível         |
| quantidade_minima     | Inteiro       | Sim         | Não   | Estoque mínimo                |
| data_atualizacao      | Data/Hora     | Sim         | Não   | Última atualização            |
| situacao_estoque      | Texto(15)     | Sim         | Não   | Disponível, Baixo ou Esgotado |
| observacao            | Texto(500)    | Não         | Não   | Observações                   |

### 10.27 EXAME_MEDICO

| Atributo        | Tipo          | Obrigatório | Único | Descrição                     |
| --------------- | ------------- | ----------- | ----- | ----------------------------- |
| id_exame_medico | Identificador | Sim         | Sim   | Identificador                 |
| CPF             | Referência    | Sim         | Não   | FK para PESSOA                |
| data_exame      | Data          | Sim         | Não   | Data                          |
| data_validade   | Data          | Sim         | Não   | Validade                      |
| resultado       | Texto(15)     | Sim         | Não   | Apto, Inapto ou Com Restrição |
| nome_medico     | Texto(100)    | Sim         | Não   | Médico responsável            |
| crm_medico      | Texto(20)     | Sim         | Não   | CRM                           |
| observacao      | Texto(500)    | Não         | Não   | Observações ou restrições     |

### 10.28 CONVITE_VISITANTE

| Atributo            | Tipo          | Obrigatório | Único | Descrição                               |
| ------------------- | ------------- | ----------- | ----- | --------------------------------------- |
| id_convite          | Identificador | Sim         | Sim   | Identificador                           |
| id_socio            | Referência    | Sim         | Não   | FK para SÓCIO responsável               |
| id_pessoa_visitante | Referência    | Sim         | Não   | FK para PESSOA visitante                |
| codigo_convite      | Texto(20)     | Sim         | Sim   | Código                                  |
| data_emissao        | Data/Hora     | Sim         | Não   | Emissão                                 |
| data_validade       | Data          | Sim         | Não   | Validade                                |
| situacao_convite    | Texto(15)     | Sim         | Não   | Ativo, Utilizado, Expirado ou Cancelado |
| observacao          | Texto(500)    | Não         | Não   | Observações                             |

### 10.29 OCORRENCIA

| Atributo            | Tipo          | Obrigatório | Único | Descrição                            |
| ------------------- | ------------- | ----------- | ----- | ------------------------------------ |
| id_ocorrencia       | Identificador | Sim         | Sim   | Identificador                        |
| CPF                 | Referência    | Sim         | Não   | FK para PESSOA envolvida             |
| id_funcionario      | Referência    | Sim         | Não   | FK para FUNCIONÁRIO responsável      |
| data_ocorrencia     | Data          | Sim         | Não   | Data                                 |
| hora_ocorrencia     | Hora          | Sim         | Não   | Horário                              |
| tipo_ocorrencia     | Texto(30)     | Sim         | Não   | Acidente, Advertência, Dano ou Outro |
| descricao           | Texto(500)    | Sim         | Não   | Descrição                            |
| gravidade           | Texto(15)     | Não         | Não   | Baixa, Média ou Alta                 |
| situacao_ocorrencia | Texto(20)     | Sim         | Não   | Aberta, Em análise ou Resolvida      |
| providencia_tomada  | Texto(500)    | Não         | Não   | Medidas tomadas                      |

### 10.30 MOVIMENTACAO_ESTOQUE

| Atributo              | Tipo          | Obrigatório | Único | Descrição                                                    |
| --------------------- | ------------- | ----------- | ----- | ------------------------------------------------------------ |
| id_movimentacao       | Identificador | Sim         | Sim   | Identificador da movimentação de estoque                     |
| id_estoque            | Referência    | Sim         | Não   | FK para ESTOQUE                                              |
| id_funcionario        | Referência    | Sim         | Não   | FK para FUNCIONÁRIO responsável pela movimentação            |
| id_item_venda         |Referência     | Não         | Não   | FK para ITEM_VENDA, quando originada de uma venda            |
| id_movimentacao_origem| Referência    | Não         | Não   | FK para MOVIMENTACAO_ESTOQUE original, quando houver reversão|
| tipo_movimentacao     | Texto(15)     | Sim         | Não   | Entrada, Saída, Perda, Devolução ou Ajuste                   |
| sentido               | Texto(10)     | Sim         | Não   | Crédito ou Débito                                            |
| quantidade            | Inteiro       | Não         | Não   | Quantidade positiva de produtos movimentados                 |
| data_movimentacao     | Data/Hora     | Sim         | Não   | Data e horário da movimentação                               |
| origem                | Texto(20)     | Não         | Não   | Venda, Compra, Perda, Devolução, Ajuste ou Saldo Inicial     |
| motivo                | Texto(500)    | Não         | Não   | Justificativa da movimentação                                |


### 10.31 CATEGORIA_DEPENDENCIA

| Atributo                   | Tipo          | Obrigatório | Único | Descrição                                    |
| -------------------------- | ------------- | ----------- | ----- | ---------------------------------------------|
| id_categoria_dependencia   | Identificador | Sim         | Sim   | Identificador da associação (PK)             |
| id_categoria_socio         | Referência    | Sim         | Não   | FK para CATEGORIA_SOCIO                      |
| id_dependencia_fisica      | Referência    | Sim         | Não   | FK para DEPENDENCIA_FISICA                   |
| situacao                   | texto(10)     | Sim         | Não   | Situação da permissão: Ativa ou Inativa      |
| observacao                 | texto(500)    | Não         | Não   | Observações sobre a permissão de utilização  |

### 10.32 CONTRAPARTE_FINANCEIRA

| Atributo            | Tipo          | Obrigatório | Único | Descrição                                         |
| ------------------- | ------------- | ----------- | ----- | ------------------------------------------------- |
| id_contraparte      | Identificador | Sim         | Sim   | Identificador do cliente, fornecedor ou favorecido|
| CPF                 | Referência    | Sim         | Sim   | FK para PESSOA, quando houver cadastro vinculado  |
| nome_razao_social   | Texto(150)    | Sim         | Não   | Nome da pessoa física ou razão social da empresa  |
| documento           | Texto(14)     | Sim         | Sim   | CPF ou CNPJ sem pontuação                         |
| tipo_pessoa         | Texto(10)     | Sim         | Não   | Física ou Jurídica                                |
| situacao            | Texto(10)     | Sim         | Não   | Ativa ou Inativa                                  |



### 10.33 TITULO_FINANCEIRO

| Atributo            | Tipo          | Obrigatório | Único | Descrição                                                      |
| ------------------- | ------------- | ----------- | ----- | -------------------------------------------------------------- |
| id_titulo           | Identificador | Sim         | Sim   | Identificador da conta a receber ou a pagar                    |
| id_contraparte      | Referência    | Sim         | Não   | FK para CONTRAPARTE_FINANCEIRA                                 |
| id_mensalidade      | Referência    | Não         | Sim   | FK para MENSALIDADE, quando for a origem da cobrança           |
| id_inscricao        | Referência    | Não         | Sim   | FK para INSCRIÇÃO, quando for a origem da cobrança             |
| id_venda            | Referência    | Não         | Sim   | FK para VENDA, quando for a origem da cobrança                 |
| natureza            | Texto(10)     | Sim         | Não   | Receber ou Pagar                                               |
| origem              | Texto(20)     | Sim         | Não   | Mensalidade, Evento, Venda ou Manual                           |
| descricao           | Texto(200)    | Sim         | Não   | Descrição da cobrança ou despesa                               |
| data_emissao        | Data          | Sim         | Não   | Data de criação do título financeiro                           |
| data_vencimento     | Data          | Sim         | Não   |Data prevista para pagamento ou recebimento                     |
| valor_original      | Decimal(10,2) | Sim         | Não   | Valor inicial da obrigação financeira                          |
| valor_acrescimos    | Decimal(10,2) | Sim         | Não   | Juros e acréscimos, com padrão zero                            |
| valor_descontos     | Decimal(10,2) | Sim         | Não   | Descontos concedidos, com padrão zero                          |
| situacao            | Texto(15)     | Sim         | Não   | Aberto, Parcial, Liquidado ou Cancelado                        |
| saldo_aberto        | Derivado      | Sim         | Não   | Valor devido menos as baixas efetivas, considerando os estornos|

### 10.34 BAIXA_FINANCEIRA

| Atributo            | Tipo          | Obrigatório | Único | Descrição                                        |
| ------------------- | ------------- | ----------- | ----- | ------------------------------------------------ |
| id_baixa            | Identificador | Sim         | Sim   | Identificador da baixa financeira                |
| id_titulo           | Referência    | Sim         | Não   | FK para TITULO_FINANCEIRO                        |
| id_pagamento        | Referência    | Sim         | Não   | FK para PAGAMENTO                                |
| valor_baixado       | Decimal(10,2) | Sim         | Não   | Valor positivo aplicado ao título                |
| tipo_baixa          | Texto(10)     | Sim         | Não   | Liquidação ou Estorno                            |
| data_baixa          | Data/Hora     | Sim         | Não   | Data e horário do registro da baixa              |
| id_baixa_origem     | Referência    | Não         | Não   | FK para BAIXA_FINANCEIRA que está sendo estornada|


### 10.35 CONTA_FINANCEIRA

| Atributo            | Tipo          | Obrigatório | Único | Descrição                                       |
| ------------------- | ------------- | ----------- | ----- | ----------------------------------------------- |
| id_conta_financeira | Identificador | Sim         | Sim   | Identificador                                   |
| nome_conta          | Texto(80)     | Sim         | Sim   |Nome utilizado para identificar a conta          |
| tipo_conta          | Texto(15)     | Sim         | Não   | Caixa ou Bancária                               |
| banco               | Texto(80)     | Sim         | Não   | Nome da instituição financeira                  |
| agencia             | Texto(20)     | Sim         | Não   | Número da agência bancária                      |
| numero_conta        | Texto(30)     | Sim         | Não   | Número da conta com dígito                      |
| data_saldo_inicial  | Data/Hora     | Sim         | Não   | Marco inicial do controle financeiro            |
| saldo_inicial       | Decimal(12,2) | Sim         | Não   | Saldo existente antes das operações controladas |
| situacao            | Texto(10)     | Sim         | Não   | Ativa ou Inativa                                |


### 10.36 ITEM_EXTRATO

| Atributo             | Tipo          | Obrigatório | Único | Descrição                                 |
| -------------------- | ------------- | ----------- | ----- | ----------------------------------------- |
| id_item_extrato      | Identificador | Sim         | Sim   | Identificador                             |
| id_conta_financeira  | Referência    | Sim         | Não   | FK para CONTA_FINANCEIRA                  | 
| identificador_externo| Texto(100)    | Sim         | Não   | Código do lançamento informado pelo banco |
| data_lancamento      | Data/Hora     | Sim         | Não   | Data e horário do lançamento bancário     |
| sentido              | Texto(10)     | Sim         | Não   | Crédito ou Débito                         |
| valor                | Decimal(10,2) | Sim         | Não   |Valor positivo do lançamento               |
| descricao            | Texto(200)    | Não         | Não   | Descrição apresentada no extrato bancário |
| situacao_conciliacao | Derivado      | Sim         | Não   | Não conciliado, Parcial ou Conciliado     |


### 10.37 DEVOLUCAO_VENDA

| Atributo                   | Tipo          | Obrigatório | Único | Descrição                                                            |
| -------------------------- | ------------- | ----------- | ----- | ---------------------------------------------------------------------|
| id_devolucao               | Identificador | Sim         | Sim   | Identificador da devolução                                           |
| id_item_venda              | Referência    | Sim         | Não   | FK para ITEM_VENDA                                                   |
| id_movimentacao_saida      | Referência    | Sim         | Não   | FK para MOVIMENTACAO_ESTOQUE referente à saída original              |
| id_movimentacao_devolucao  | Referência    | Não         | Sim   | FK para MOVIMENTACAO_ESTOQUE referente à entrada do produto devolvido|
| id_funcionario             | Referência    | Sim         | Não   | FK para FUNCIONÁRIO responsável pelo atendimento                     |
| data_devolucao             | Data/Hora     | Sim         | Não   | Data e horário da devolução                                          |
| quantidade_devolvida       | Inteiro       | Sim         | Não   | Quantidade de produtos devolvidos                                    |
| valor_reembolso            | Decimal(10,2) | Não         | Não   | Valor financeiro devolvido ao comprador                              |
| motivo                     | Texto(500)    | Sim         | Não   |Motivo informado para a devolução                                     |
| situacao                   | Texto(15)     | sim         | Não   | Solicitada, Confirmada ou Cancelada                                  |

### 10.38 CONCILIACAO

| Atributo            | Tipo          | Obrigatório | Único | Descrição                                                            |
| ------------------- | ------------- | ----------- | ----- | -------------------------------------------------------------------- |
| id_conciliacao      | Identificador | Sim         | Sim   | Identificador                                                        |
| id_item_extrato     | Referência    | Sim         | Não   | FK para ITEM_EXTRATO                                                 |
| id_pagamento        | Referência    | Sim         | Não   | FK para PAGAMENTO                                                    |
| id_funcionario      | Referência    | Sim         | Não   | FK para FUNCIONÁRIO responsável pela conferência                     |
| valor_conciliado    | Decimal(10,2) | Sim         | Não   | Valor positivo associado entre o lançamento e a operação financeira  |
| data_conciliacao    | Data/Hora     | Sim         | Não   | Data e horário da conferência                                        |
| situacao            | Texto(10)     | Sim         | Não   | Ativa ou Cancelada                                                   |
| justificativa       | Texto(500)    | Não         | Não   | Motivo de correção ou cancelamento                                   |

## 11. Relacionamentos

| #  | Entidade A         | Cardinalidade | Verbo             | Cardinalidade | Entidade B        | Tipo           |
| -- | ------------------ | ------------- | ----------------- | ------------- | ----------------- | -------------- |
| 1  | PESSOA             | (0,1)         | É                 | (1,1)         | SÓCIO             | Especialização |
| 2  | PESSOA             | (0,1)         | É                 | (1,1)         | FUNCIONÁRIO       | Especialização |
| 3  | PESSOA             | (0,1)         | É                 | (1,1)         | ATLETA            | Especialização |
| 4  | SÓCIO              | (0,N)         | POSSUI            | (1,1)         | DEPENDENTE        | 1:N            |
| 5  | SÓCIO              | (1,1)         | PERTENCE A        | (0,N)         | CATEGORIA_SOCIO   | N:1            |
| 6  | FUNCIONÁRIO        | (1,1)         | TRABALHA EM       | (0,N)         | DEPARTAMENTO      | N:1            |
| 7  | DEPARTAMENTO       | (0,1)         | É GERENCIADO POR  | (0,1)         | FUNCIONÁRIO       | 1:1 opcional   |
| 8  | ATLETA             | (0,N)         | PRATICA           | (0,N)         | MODALIDADE        | N:N            |
| 9 | MODALIDADE         | (0,N)         | POSSUI            | (1,1)         | TURMA             | 1:N            |
| 10 | ATLETA             | (0,N)         | MATRICULA-SE EM   | (0,N)         | TURMA             | N:N            |
| 11 | FUNCIONÁRIO        | (0,N)         | MINISTRA          | (0,N)         | TURMA             | N:N            |
| 12 | SÓCIO              | (0,N)         | GERA              | (1,1)         | MENSALIDADE       | 1:N            |
| 13 | MENSALIDADE        | (0,N)         | RECEBE            | (1,1)         | PAGAMENTO         | 1:N            |
| 14 | SÓCIO              | (0,N)         | REALIZA           | (1,1)         | RESERVA           | 1:N            |
| 15 | DEPENDENCIA_FISICA | (0,N)         | RECEBE            | (1,1)         | RESERVA           | 1:N            |
| 16 | EVENTO             | (0,N)         | RECEBE            | (1,1)         | INSCRIÇÃO         | 1:N            |
| 17 | PESSOA             | (0,N)         | REALIZA           | (1,1)         | INSCRIÇÃO         | 1:N            |
| 18 | SÓCIO              | (0,N)         | OCUPA             | (1,1)         | DIRETORIA         | 1:N            |
| 19 | DIRETORIA          | (1,1)         | UTILIZA           | (0,N)         | FUNCAO_DIRETORIA  | N:1            |
| 20 | PESSOA             | (1,1)         | POSSUI            | (0,N)         | ENDEREÇO          | 1:N            |
| 21 | PESSOA             | (1,1)         | POSSUI            | (0,N)         | REGISTRO_ACESSO   | 1:N            |
| 22 | SÓCIO              | (1,1)         | EMITE             | (0,N)         | CONVITE_VISITANTE | 1:N            |
| 23 | PESSOA             | (1,1)         | É VISITANTE EM    | (0,N)         | CONVITE_VISITANTE | 1:N            |
| 24 | PESSOA             | (1,1)         | REALIZA           | (0,N)         | EXAME_MEDICO      | 1:N            |
| 25 | PESSOA             | (1,1)         | REALIZA           | (0,N)         | VENDA             | 1:N            |
| 26 | FUNCIONÁRIO        | (1,1)         | REGISTRA          | (0,N)         | VENDA             | 1:N            |
| 27 | VENDA              | (1,1)         | CONTÉM            | (1,N)         | ITEM_VENDA        | 1:N            |
| 28 | ITEM_VENDA         | (1,1)         | REFERE-SE A       | (0,N)         | PRODUTO           | N:1            |
| 29 | PRODUTO            | (1,1)         | POSSUI            | (0,N)         | ESTOQUE           | 1:N            |
| 30 | PESSOA             | (1,1)         | ESTÁ ENVOLVIDA EM | (0,N)         | OCORRENCIA        | 1:N            |
| 31 | FUNCIONÁRIO        | (1,1)         | REGISTRA          | (0,N)         | OCORRENCIA        | 1:N            |
| 32 | DEPENDENCIA_FISICA | (0,N)         | SEDIA             | (0,1)         | EVENTO            | 1:N            |

### Entidades Associativas

| Entidade Associativa | Relacionamento           | Atributos Próprios                                       |
| -------------------- | ------------------------ | -------------------------------------------------------- |
| ATLETA_MODALIDADE    | ATLETA e MODALIDADE      | data_inicio, data_fim, situacao_vinculo                  |
| MATRÍCULA            | ATLETA e TURMA           | data_matricula, situacao_matricula                       |
| TURMA_PROFESSOR      | FUNCIONÁRIO e TURMA      | data_inicio, data_fim, situacao_vinculo                  |
| INSCRIÇÃO            | PESSOA e EVENTO          | data_inscricao, situacao_inscricao, pagamento_confirmado |
| DIRETORIA            | SÓCIO e FUNCAO_DIRETORIA | data_inicio_mandato, data_fim_mandato, situacao_mandato  |
| ITEM_VENDA           | VENDA e PRODUTO          | quantidade, valor_unitario, subtotal                     |

## 12. Cardinalidades

| Relacionamento                                | Representação                                           | Regra |
| --------------------------------------------- | ------------------------------------------------------- | ----- |
| PESSOA - É - SÓCIO                            | PESSOA (0,1) - É - SÓCIO (1,1)                          | RN01  |
| PESSOA - É - FUNCIONÁRIO                      | PESSOA (0,1) - É - FUNCIONÁRIO (1,1)                    | RN13  |
| PESSOA - É - ATLETA                           | PESSOA (0,1) - É - ATLETA (1,1)                         | RN14  |
| SÓCIO - POSSUI - DEPENDENTE                   | SÓCIO (0,N) - POSSUI - DEPENDENTE (1,1)                 | RN02  |
| SÓCIO - PERTENCE A - CATEGORIA                | SÓCIO (1,1) - PERTENCE A - CATEGORIA (0,N)              | RN03  |
| FUNCIONÁRIO - TRABALHA EM - DEPARTAMENTO      | FUNCIONÁRIO (1,1) - TRABALHA EM - DEPARTAMENTO (0,N)    | RN13  |
| DEPARTAMENTO - É GERENCIADO POR - FUNCIONÁRIO | DEPARTAMENTO (0,1) - GERENCIADO POR - FUNCIONÁRIO (0,1) | RN13  |
| ATLETA - PRATICA - MODALIDADE                 | ATLETA (0,N) - PRATICA - MODALIDADE (0,N)               | RN05  |
| MODALIDADE - POSSUI - TURMA                   | MODALIDADE (0,N) - POSSUI - TURMA (1,1)                 | RN06  |
| ATLETA - MATRICULA-SE EM - TURMA              | ATLETA (0,N) - MATRICULA-SE EM - TURMA (0,N)            | RN05  |
| FUNCIONÁRIO - MINISTRA - TURMA                | FUNCIONÁRIO (0,N) - MINISTRA - TURMA (0,N)              | RN20  |
| SÓCIO - GERA - MENSALIDADE                    | SÓCIO (0,N) - GERA - MENSALIDADE (1,1)                  | RN10  |
| MENSALIDADE - RECEBE - PAGAMENTO              | MENSALIDADE (0,N) - RECEBE - PAGAMENTO (1,1)            | RN11  |
| SÓCIO - REALIZA - RESERVA                     | SÓCIO (0,N) - REALIZA - RESERVA (1,1)                   | RN07  |
| DEPENDENCIA_FISICA - RECEBE - RESERVA         | DEPENDENCIA_FISICA (0,N) - RECEBE - RESERVA (1,1)       | RN15  |
| EVENTO - RECEBE - INSCRIÇÃO                   | EVENTO (0,N) - RECEBE - INSCRIÇÃO (1,1)                 | RN12  |
| PESSOA - REALIZA - INSCRIÇÃO                  | PESSOA (0,N) - REALIZA - INSCRIÇÃO (1,1)                | RN12  |
| SÓCIO - OCUPA - DIRETORIA                     | SÓCIO (0,N) - OCUPA - DIRETORIA (1,1)                   | RN08  |
| DIRETORIA - UTILIZA - FUNCAO_DIRETORIA        | DIRETORIA (1,1) - UTILIZA - FUNCAO_DIRETORIA (0,N)      | RN08  |
| PESSOA - POSSUI - ENDEREÇO                    | PESSOA (1,1) - POSSUI - ENDEREÇO (0,N)                  | RN26  |
| PESSOA - POSSUI - REGISTRO_ACESSO             | PESSOA (1,1) - POSSUI - REGISTRO_ACESSO (0,N)           | RN27  |
| SÓCIO - EMITE - CONVITE_VISITANTE             | SÓCIO (1,1) - EMITE - CONVITE_VISITANTE (0,N)           | RN28  |
| PESSOA - É VISITANTE EM - CONVITE_VISITANTE   | PESSOA (1,1) - É VISITANTE EM - CONVITE_VISITANTE (0,N) | RN29  |
| PESSOA - REALIZA - EXAME_MEDICO               | PESSOA (1,1) - REALIZA - EXAME_MEDICO (0,N)             | RN30  |
| PESSOA - REALIZA - VENDA                      | PESSOA (1,1) - REALIZA - VENDA (0,N)                    | RN31  |
| FUNCIONÁRIO - REGISTRA - VENDA                | FUNCIONÁRIO (1,1) - REGISTRA - VENDA (0,N)              | RN32  |
| VENDA - CONTÉM - ITEM_VENDA                   | VENDA (1,1) - CONTÉM - ITEM_VENDA (1,N)                 | RN33  |
| ITEM_VENDA - REFERE-SE A - PRODUTO            | ITEM_VENDA (1,1) - REFERE-SE A - PRODUTO (0,N)          | RN34  |
| PRODUTO - POSSUI - ESTOQUE                    | PRODUTO (1,1) - POSSUI - ESTOQUE (0,N)                  | RN35  |
| PESSOA - ESTÁ ENVOLVIDA EM - OCORRENCIA       | PESSOA (1,1) - ESTÁ ENVOLVIDA EM - OCORRENCIA (0,N)     | RN36  |
| FUNCIONÁRIO - REGISTRA - OCORRENCIA           | FUNCIONÁRIO (1,1) - REGISTRA - OCORRENCIA (0,N)         | RN37  |
| DEPENDENCIA_FISICA - SEDIA - EVENTO           | DEPENDENCIA_FISICA (0,N) - SEDIA - EVENTO (0,1)         | RF11  |

## 13. Dicionário de Dados Conceitual

O dicionário de dados está representado na seção 10 deste documento. Para cada entidade foram definidos os atributos, tipos de dados, obrigatoriedade, unicidade e descrição.

## 14. DER - Diagrama Entidade-Relacionamento

O Diagrama Entidade-Relacionamento será apresentado no arquivo:

`Conceptual model - BRMW.pdf](https://miro.com/app/board/uXjVHgJPWnY=/)

O diagrama deve representar as entidades, atributos principais, relacionamentos e cardinalidades descritos neste documento.

## 15. Justificativas Técnicas

### Justificativa 1: Substituição de "Político" por "Diretoria"

Durante a revisão do projeto percebemos que o termo "Político" não representava bem a estrutura administrativa de um clube. Por isso, o conceito foi dividido entre DIRETORIA e FUNCAO_DIRETORIA.

Dessa maneira, o modelo consegue registrar quem ocupou determinado cargo, qual era a função e durante qual período o mandato ocorreu.

### Justificativa 2: PESSOA como Entidade Central

PESSOA foi utilizada como cadastro principal porque sócios, funcionários e atletas possuem informações básicas em comum, como nome, CPF e data de nascimento.

Com essa estrutura, uma mesma pessoa pode possuir mais de um vínculo dentro do clube sem precisar repetir seus dados pessoais.

### Justificativa 3: ATLETA pode não ser SÓCIO

O vínculo entre ATLETA e SÓCIO foi definido como opcional porque o clube pode trabalhar com atletas externos.

Assim, uma pessoa pode participar das atividades esportivas sem necessariamente possuir uma matrícula de sócio.

### Justificativa 4: Relacionamento N:N entre ATLETA e MODALIDADE

Um atleta pode praticar mais de uma modalidade e uma modalidade pode possuir vários atletas.

Por esse motivo, foi criada a entidade ATLETA_MODALIDADE para representar esse relacionamento e guardar informações do vínculo.

### Justificativa 5: MENSALIDADE separada de PAGAMENTO

MENSALIDADE e PAGAMENTO foram separados porque uma mesma mensalidade pode ser paga em partes.

Com isso, cada pagamento pode ser registrado individualmente e o sistema consegue calcular quanto ainda falta para quitar a mensalidade.

### Justificativa 6: DEPENDENTE como entidade separada

DEPENDENTE possui informações próprias do relacionamento com o sócio titular, como tipo de dependência, início do vínculo e situação.

Além disso, o dependente pode futuramente deixar essa condição e se tornar sócio.

### Justificativa 7: ENDEREÇO separado de PESSOA

ENDEREÇO foi separado de PESSOA para permitir que uma pessoa possua mais de um endereço.

Isso também evita repetir vários campos dentro da entidade PESSOA caso novos endereços sejam cadastrados.

### Justificativa 8: REGISTRO_ACESSO como entidade própria

REGISTRO_ACESSO foi criado para armazenar as entradas e saídas das pessoas no clube.

Cada registro possui data, horário e tipo de movimentação, permitindo consultar o histórico posteriormente.

### Justificativa 9: VENDA, ITEM_VENDA e PRODUTO separados

Uma venda pode possuir vários produtos e um produto pode aparecer em várias vendas.

ITEM_VENDA foi utilizado para representar esse relacionamento e armazenar quantidade, valor unitário e subtotal.

### Justificativa 10: ESTOQUE separado de PRODUTO

PRODUTO guarda as informações do item comercializado, enquanto ESTOQUE controla sua quantidade disponível.

Essa separação permite atualizar a quantidade em estoque sem alterar os dados principais do produto.

### Justificativa 11: EXAME_MEDICO como entidade própria

Uma pessoa pode realizar vários exames ao longo do tempo.

Por isso, EXAME_MEDICO mantém cada exame separadamente, permitindo guardar data, validade, resultado e informações do médico responsável.

### Justificativa 12: CONVITE_VISITANTE como entidade própria

O convite possui informações que não pertencem diretamente ao sócio ou ao visitante, como código, validade e situação.

Por isso, CONVITE_VISITANTE foi criada para representar esse processo.

### Justificativa 13: OCORRENCIA como entidade própria

OCORRENCIA permite registrar situações que acontecem no clube e relacioná-las às pessoas envolvidas e ao funcionário responsável pelo registro.

Também permite manter histórico da situação e das providências tomadas.

### Justificativa 14: Entidades associativas

As entidades associativas foram utilizadas nos relacionamentos em que uma entidade pode estar relacionada a várias ocorrências da outra.

Além de resolver o relacionamento N:N, algumas dessas entidades possuem informações próprias, como data, situação e quantidade.

### Justificativa 15: INSCRIÇÃO separada de PESSOA e EVENTO

Uma pessoa pode participar de vários eventos e cada evento pode receber várias pessoas.

INSCRIÇÃO representa esse vínculo e permite controlar informações como data da inscrição, situação e confirmação do pagamento.

### Justificativa 16: MATRÍCULA separada do vínculo ATLETA e TURMA

MATRÍCULA foi criada para representar a participação do atleta em determinada turma.

Além do vínculo entre atleta e turma, a entidade permite controlar a data e a situação da matrícula.

## 16. Conclusão

O projeto apresenta uma proposta de modelagem para um sistema de gestão de um clube social e esportivo.

A estrutura contempla os principais processos definidos pelo grupo, incluindo cadastro de pessoas, sócios, dependentes, funcionários e atletas, além de modalidades, turmas, eventos, reservas, mensalidades, pagamentos, vendas, estoque, controle de acesso, exames médicos, convites e ocorrências.

Durante a elaboração, algumas decisões foram revistas para deixar o modelo mais próximo do funcionamento de um clube. Um exemplo foi a substituição do conceito "Político" por DIRETORIA e FUNCAO_DIRETORIA.

A utilização de PESSOA como entidade central também permite evitar a repetição de dados pessoais e facilita a criação de diferentes vínculos para uma mesma pessoa.

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
| Justificativas técnicas | 16 |

