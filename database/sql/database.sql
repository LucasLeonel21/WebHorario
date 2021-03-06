/*
	DATABASE VERSÃO FINAL
	FEITO COMENTÁRIOS NO CÓDIGO SQL PARA MELHOR ENTENDIMENTO.
*/

DROP DATABASE IF EXISTS nexvf4wcb2h7psvd;
CREATE DATABASE nexvf4wcb2h7psvd DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
USE nexvf4wcb2h7psvd;

/*TABELA REFERENTE A INSTITUIÇÃO CADASTRADA NO SISTEMA*/
CREATE TABLE instituicoes(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
	cep CHAR(9) NOT NULL,
	endereco VARCHAR(255) NOT NULL,
	telefone VARCHAR(20) NOT NULL,
	CONSTRAINT PRIMARY KEY(id)
);

/* TABELA REFERENTE AOS CARGOS QUE UM FUNCIONÁRIO PODE TER*/
CREATE TABLE cargos(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
	sigla VARCHAR(6),
	CONSTRAINT PRIMARY KEY(id)
);

/* TABELA REFERENTE AO FUNCIONÁRIO DA EMPRESA */
CREATE TABLE funcionarios(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
	sexo ENUM('M', 'F', 'I') NOT NULL,
	cpf CHAR(11) NOT NULL UNIQUE,
	rg CHAR(9),
	data_nascimento DATE NOT NULL,
	endereco VARCHAR(255) NOT NULL,
	foto VARCHAR(255),
	prontuario VARCHAR(255) NOT NULL UNIQUE,
	email VARCHAR(255) NOT NULL UNIQUE,
	`password` VARCHAR(255) NOT NULL,
	remember_token CHAR(100),	
	deleted_at TIMESTAMP NULL,
	CONSTRAINT PRIMARY KEY(id)
);

/* TABELA REFERENTE AOS TELEFONES QUE O FUNCIONÁRIO PODE TER */
CREATE TABLE telefones(
	id INT NOT NULL AUTO_INCREMENT,
	numero VARCHAR(16) NOT NULL,
	funcionario_id INT NOT NULL,
	CONSTRAINT PRIMARY KEY(id),
	CONSTRAINT FOREIGN KEY(funcionario_id)
	REFERENCES funcionarios(id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

/* TABELA ONDE É DEFINIDO O CARGO QUE O FUNCIONÁRIO POSSUI*/
CREATE TABLE cargos_funcionarios(
	cargo_id INT NOT NULL,
	funcionario_id INT NOT NULL,
	CONSTRAINT PRIMARY KEY(cargo_id, funcionario_id),
	CONSTRAINT FOREIGN KEY(cargo_id)
	REFERENCES cargos(id)
	ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY(funcionario_id)
	REFERENCES funcionarios(id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

/*TABELA REFERENTE AOS TURNOS ESCOLARES (MANHÃ, TARDE, NOITE E INTEGRAL)*/
CREATE TABLE turnos(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
	CONSTRAINT PRIMARY KEY(id)
);

/*TABELA REFERENTE AOS HORÁRIOS DE AULAS*/
CREATE TABLE horarios(
	id INT NOT NULL AUTO_INCREMENT,
	inicio TIME NOT NULL,
	fim TIME NOT NULL,
	CONSTRAINT PRIMARY KEY(id)
);
/* TABELA COM O RELACIONAMENTO ENTRE O HORÁRIO E TURNO, PARA SABER DE QUAL TURNO É AQUELE HORÁRIO E VICE-VERSA */
CREATE TABLE turnos_horarios(
	turno_id INT NOT NULL,
	horario_id INT NOT NULL,
	CONSTRAINT PRIMARY KEY(turno_id, horario_id),
	CONSTRAINT FOREIGN KEY(turno_id)
	REFERENCES turnos(id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY(horario_id)
	REFERENCES horarios(id)
	ON DELETE RESTRICT ON UPDATE RESTRICT
);

/* TABELA REFERENTE AOS CURSOS OFERTADOS NAQUELA INSTITUIÇÃO */
CREATE TABLE cursos(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
	sigla CHAR(5) NOT NULL UNIQUE,
	turno_id INT NOT NULL,
	funcionario_id INT,
	CONSTRAINT PRIMARY KEY(id),
	CONSTRAINT FOREIGN KEY(turno_id)
	REFERENCES turnos(id)
	ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY(funcionario_id)
	REFERENCES funcionarios(id)
	ON DELETE RESTRICT ON UPDATE CASCADE
);

/* TABELA REFERENTE AOS MÓDULOS QUE AQUELE CURSO POSSUI (MÓDULO É UM PERIODO DO CURSO) */
CREATE TABLE modulos(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	curso_id INT NOT NULL,
	CONSTRAINT PRIMARY KEY(id),
	CONSTRAINT FOREIGN KEY(curso_id)
	REFERENCES cursos(id)
);

/* TABELA REFERENTE AS DISCIPLINAS DE UM DETERMINADO MÓDULO DE UM DETERMINADO CURSO*/
CREATE TABLE disciplinas(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
	sigla CHAR(5) NOT NULL UNIQUE,
	aulas_semanais INT NOT NULL,
	quantidade_professores INT,
	modulo_id INT NOT NULL,
	CONSTRAINT PRIMARY KEY(id),
	CONSTRAINT FOREIGN KEY(modulo_id)
	REFERENCES modulos(id)
);

/* TABELA REFERENTE A UM PERIODO DO ANO (DE JUNHO À DEZEMBRO) */
CREATE TABLE semestres(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
	inicio DATE NOT NULL,
	fim DATE NOT NULL,
	fpa_inicio DATE NOT NULL,
	fpa_fim DATE NOT NULL,
	CONSTRAINT PRIMARY KEY(id)
);

/* TABELA REFERENTE AS TURMAS DAQUELE SEMESTRE */
CREATE TABLE turmas(
	id INT NOT NULL AUTO_INCREMENT,
	semestre_id INT NOT NULL,
	disciplina_id INT NOT NULL,
	quantidade_alunos INT NOT NULL,
	CONSTRAINT PRIMARY KEY(id),
	CONSTRAINT FOREIGN KEY(semestre_id)
	REFERENCES semestres(id)
	ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY(disciplina_id)
	REFERENCES disciplinas(id)
	ON DELETE RESTRICT ON UPDATE CASCADE
);

/* TABELA REFERENTE AOS MÓDULOS QUE SERÃO OFERTADOS NAQUELE SEMESTRE(PERIODO), PROVENIENTE DA FPA */
CREATE TABLE modulos_semestres(
	semestre_id INT NOT NULL,
	modulo_id INT NOT NULL,
	CONSTRAINT FOREIGN KEY(semestre_id)
	REFERENCES semestres(id),
	CONSTRAINT FOREIGN KEY(modulo_id)
	REFERENCES modulos(id)
);

/* TABELA REFERENTE AO TIPO DE SALA QUE A SALA SERÁ (COM COMPUTADOR, ENGENHARIA) */
CREATE TABLE tiposSala(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
	descricao VARCHAR(255) NOT NULL,
	CONSTRAINT PRIMARY KEY(id)
);

/*TABELA REFERENTE AS SALAS QUE PERTENCEM A INSTITUIÇÃO*/
CREATE TABLE salas(
	id INT NOT NULL AUTO_INCREMENT,
	numero INT NOT NULL,
	capacidade INT NOT NULL,
	tiposala_id INT NOT NULL,
	CONSTRAINT PRIMARY KEY(id),
	CONSTRAINT FOREIGN KEY(tiposala_id)
	REFERENCES tiposSala(id)
);

/* TABELA ONDE ESTÁ RELACIONADO AS DISCIPLINAS E AS SALAS QUE ELAS PRECISAM*/
CREATE TABLE disciplinas_tiposSala(
	disciplina_id INT NOT NULL,
	tipoSala_id INT NOT NULL,
	CONSTRAINT PRIMARY KEY(disciplina_id, tipoSala_id),
	CONSTRAINT FOREIGN KEY(disciplina_id)
	REFERENCES disciplinas(id)
	ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY(tipoSala_id)
	REFERENCES tiposSala(id)
	ON DELETE RESTRICT ON UPDATE CASCADE
);

/* TABELA PRINCIPAL PARA REALIZAR AS LIGAÇÕES COM AS PREFERENCIAS DO PROFESSOR PARA A DEFINIÇÃO DO HORÁRIO ESCOLAR*/
CREATE TABLE fpas(
	id INT NOT NULL AUTO_INCREMENT,
	carga_horaria INT NOT NULL,
	semestre_id INT NOT NULL,
	funcionario_id INT NOT NULL,
	CONSTRAINT PRIMARY KEY(id),
	CONSTRAINT FOREIGN KEY(semestre_id)
	REFERENCES semestres(id),
	CONSTRAINT FOREIGN KEY(funcionario_id)
	REFERENCES funcionarios(id)
);

/* TABELA PARA RELACIONAR OS HORÁRIOS QUE O PROFESSOR DESEJA LECIONAR COM A FPA */
CREATE TABLE horarios_fpas(
	horario_id INT NOT NULL,
	fpa_id INT NOT NULL,
	dia_semana ENUM('SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB'),
	CONSTRAINT PRIMARY KEY(horario_id, fpa_id, dia_semana),
	CONSTRAINT FOREIGN KEY(horario_id)
	REFERENCES horarios(id),
	CONSTRAINT FOREIGN KEY(fpa_id)
	REFERENCES fpas(id)
);

/* TABELA PARA RELACIONAR AS DISCIOPLINAS QUE O PROFESSOR DESEJA LECIONAR COM A FPA */
CREATE TABLE disciplinas_fpas(
	disciplina_id INT NOT NULL,
	fpa_id INT NOT NULL,
	prioridade INT NOT NULL,
	CONSTRAINT PRIMARY KEY(disciplina_id, fpa_id),
	CONSTRAINT FOREIGN KEY(disciplina_id)
	REFERENCES disciplinas(id),
	CONSTRAINT FOREIGN KEY(fpa_id)
	REFERENCES fpas(id)
);

/* TABELA REFERENTE A ATRIBUIÇÃO POR PARTE DO COORDENADOR DOS PROFESSORES QUE VÃO LECIONAR A DISCIPLINA X NO SEMESTRE X*/
CREATE TABLE atribuicoes_disciplinas(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	disciplina_id INT NOT NULL,
	semestre_id INT NOT NULL,
	funcionario_id INT NOT NULL,
	CONSTRAINT FOREIGN KEY(disciplina_id)
	REFERENCES disciplinas(id),
	CONSTRAINT FOREIGN KEY(semestre_id)
	REFERENCES semestres(id),
	CONSTRAINT FOREIGN KEY(funcionario_id)
	REFERENCES funcionarios(id)
);

/* TABELA REFERENTE A ATRIBUIÇÃO POR PARTE DO COORDENADOR DAS DISCIPLINAS COM OS HORÁRIOS REFERENTE AO SEMESTRE X*/
CREATE TABLE atribuicoes_horarios(
	id INT NOT NULL AUTO_INCREMENT,
    horario_id INT NOT NULL,
    semestre_id INT NOT NULL,
    disciplina_id INT NOT NULL,
    dia_semana ENUM('SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB') NOT NULL,
    CONSTRAINT PRIMARY KEY(id),
    CONSTRAINT FOREIGN KEY(horario_id)
	REFERENCES horarios(id),
    CONSTRAINT FOREIGN KEY(semestre_id)
	REFERENCES semestres(id),
    CONSTRAINT FOREIGN KEY(disciplina_id)
	REFERENCES disciplinas(id)
);


INSERT INTO `funcionarios` 
(`id`, `nome`, `sexo`, `cpf`, `rg`, `data_nascimento`, `endereco`, `foto`, `prontuario`, `email`, `password`, `remember_token`, `deleted_at`) 
VALUES 
(NULL, 'Vitr', 'M', '654654', '321', '2017-05-25', 'asdasd', 'asdasd.png', '1501111', 'akshgd@asds.com', '$2y$10$8bhPBEPB4mwGOvE.GLC7cOj8xKC7VgTBM43JgcfcF9oYJzX8lUQuS', '$2y$10$8bhPBEPB4mwGOvE.GLC7cOj8xKC7VgTBM43JgcfcF9oYJzX8lUQuS', NULL);
