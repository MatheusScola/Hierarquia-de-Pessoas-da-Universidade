create table turma
(
 id_turma serial primary key,
 ds_disciplina varchar(40) not null,
 hr_horario time,
 cd_cred VARCHAR(20)
 )
 
 create table formacao
 (
  id_formacao serial primary key,
  ds_formacao varchar(50),
  nm_ano_formacao varchar(4)
 ) 
  
 create table unidade_academica
 (
  id_unidade serial primary key,
  ds_nome varchar(40)
 )
 
 create table contratados
 (
  id_contratado serial primary key,
  id_unidade int,
  dt_inicio date,
  foreign key (id_unidade) references unidade_academica(id_unidade)
 )
 
 create table professores
 (
  nm_matricula serial primary key,
  ds_nome varchar(30) not null,
  ds_email varchar(50) not null,
  vl_salario decimal(10,2) not null,
  id_formacao int not null,
  id_contratado int not null,
  foreign key (id_formacao) references formacao(id_formacao),
  foreign key (id_contratado) references contratados(id_contratado)
 )
 
 create table turma_professor
 (
  id_turma int,
  nm_matricula_professor int,
  foreign key (id_turma) references turma(id_turma),
  foreign key (nm_matricula_professor) references professores(nm_matricula)
 )
 
 create table funcao
 (
  id_funcao serial primary key,
  ds_funcao varchar(30)
 )
 
 create table funcionarios 
 (
  nm_matricula serial primary key,
  ds_nome varchar(30) not null,
  ds_email varchar(50) not null,
  vl_salario decimal(10,2) not null,
  id_funcao int not null,
  id_contratado int not null,
  foreign key (id_funcao) references funcao(id_funcao),
  foreign key (id_contratado) references contratados(id_contratado)
 )
 
 create table dependentes
 (
  id_dependente serial primary key,
  ds_nome varchar(30),
  ds_email varchar(50),
  id_contratado int,
  foreign key (id_contratado) references contratados(id_contratado)
 )
 
 create table alunos
 (
  nm_matricula serial primary key,
  ds_nome varchar(30) not null,
  ds_email varchar(50) not null,
  vl_mensalidade decimal(10,2) not null,
  id_turma int not null,
  foreign key (id_turma) references turma(id_turma)
 )
 
create view vw_unidade_academica_colaboradores as select 
	ua.ds_nome, 
	p.ds_nome  as nome_professor, 
	f.ds_nome  as nome_funcionario
from 
	unidade_academica ua 
left join 
	contratados c on ua.id_unidade = c.id_unidade
left join 
	professores p on c.id_contratado = p.id_contratado
left join 
	funcionarios f on c.id_contratado = f.id_contratado
order by 
	ua.ds_nome, p.ds_nome, f.ds_nome

select * from vw_unidade_academica_colaboradores
 
select a.ds_nome "Aluno", t.ds_disciplina, p.ds_nome "Professor" from alunos a
inner join turma t on a.id_turma = t.id_turma
inner join turma_professor tp on t.id_turma = tp.id_turma
inner join professores p on tp.nm_matricula_professor = p.nm_matricula
where t.ds_disciplina = 'Literatura Brasileira'

select
	t.ds_disciplina,
	sum(a.vl_mensalidade) "Soma das mensalidades",
	avg(a.vl_mensalidade) "Média do valor da mensalidade",
	max(a.vl_mensalidade) "Maior valor pago na mensalidade", 
	min(a.vl_mensalidade) "Menor valor pago na mensalidade" 
from 
	turma t
inner join
	alunos a on t.id_turma = a.id_turma
group by t.ds_disciplina 

select ua.ds_nome, sum(p.vl_salario) "Soma dos Salários" from unidade_academica ua
inner join contratados c on ua.id_unidade = c.id_unidade
inner join professores p on c.id_contratado = p.id_contratado
group by ua.ds_nome
order by ua.ds_nome 


update professores set
	vl_salario = (vl_salario * 1.10)
from contratados
where professores.id_contratado = contratados.id_contratado 
and (extract('Year' from Now()) - extract('Year' from contratados.dt_inicio)) >= 10

select ua.ds_nome "Unidade Acadêmica", count(d.ds_nome) "Quantidade de dependentees" from unidade_academica ua 
inner join contratados c on ua.id_unidade = c.id_unidade 
inner join dependentes d on c.id_contratado = d.id_contratado
group by ua.ds_nome
having count(d.ds_nome) > 5
order by "Quantidade de dependentees" desc

delete FROM dependentes
WHERE id_contratado in (
		SELECT c.id_contratado 
		FROM contratados c 
		inner join dependentes d on c.id_contratado = d.id_contratado
		group by c.id_contratado
		having count(d.id_contratado) > 4
);

select ua.ds_nome, f.ds_nome "Funcionários", p.ds_nome "Professores" from unidade_academica ua 
inner join contratados c on ua.id_unidade = c.id_unidade
left join funcionarios f on c.id_contratado = f.id_contratado
left join professores p on c.id_contratado = p.id_contratado 
where f.ds_nome is null or p.ds_nome is null

select t.ds_disciplina, p.ds_nome 
FROM turma_professor tp
INNER JOIN turma t ON tp.id_turma = t.id_turma
INNER JOIN professores p ON tp.nm_matricula_professor = p.nm_matricula

SELECT t.ds_disciplina,
       SUM(a.vl_mensalidade) AS total_mensalidades
FROM turma t
INNER JOIN alunos a ON t.id_turma = a.id_turma
GROUP BY t.ds_disciplina;