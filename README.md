# Hierarquia-de-Pessoas-da-Universidade

Este repositório contém um esquema de banco de dados SQL para gerenciamento acadêmico. O esquema foi projetado para uma instituição educacional e inclui tabelas para gerenciar informações sobre unidades acadêmicas, professores, funcionários, turmas, alunos e muito mais.

## Estrutura do Banco de Dados

O banco de dados é composto por várias tabelas:

- **turma**: Armazena informações sobre as turmas, como disciplina e horário.
- **formacao**: Contém dados sobre as qualificações acadêmicas dos professores.
- **unidade_academica**: Registra detalhes das unidades acadêmicas.
- **contratados**: Mantém registros dos contratados pelas unidades acadêmicas.
- **professores**: Armazena informações sobre os professores, incluindo suas qualificações e contratos.
- **turma_professor**: Estabelece a relação entre turmas e professores.
- **funcao**: Contém informações sobre os cargos dos funcionários.
- **funcionarios**: Registra dados sobre os funcionários não docentes, incluindo seus cargos e contratos.
- **dependentes**: Contém informações sobre os dependentes dos contratados.
- **alunos**: Armazena informações sobre os alunos matriculados.

## Visualizações e Consultas

Além das tabelas, o esquema inclui uma visualização e várias consultas:

- **vw_unidade_academica_colaboradores**: Uma visualização que apresenta um resumo das unidades acadêmicas juntamente com os nomes dos professores e funcionários associados a cada unidade.
- Consultas para obter informações sobre alunos, turmas, professores, funcionários e unidades acadêmicas.
- Consultas para cálculos de agregação, como a soma e média de mensalidades pagas pelos alunos.

## Uso

Este esquema de banco de dados pode ser usado como base para sistemas de gerenciamento acadêmico em instituições de ensino. Ele fornece uma estrutura sólida para armazenar e gerenciar informações essenciais sobre alunos, professores, funcionários e turmas.
