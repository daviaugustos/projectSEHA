DROP DATABASE BDSehaCREATE DATABASE BDSehaUSE BDSEHAGO/* CREATE DE TABELAS */
CREATE TABLE tblLembrete (
	LembreteId	int				NOT NULL primary key identity,	Data		date			NOT NULL,	Conteudo	varchar(MAX)	NOT NULL,)
GOCREATE TABLE tblPessoa (
	PessoaId			int				NOT NULL primary key identity, 
	Nome				varchar(50)		NOT NULL,	Email				varchar(100)	NOT NULL unique,	Senha				varchar(25)		NOT NULL,	Permissao_admin		bit				NOT NULL
)
GO

CREATE TABLE tblProfessor (
	CodPessoa			int				NOT NULL primary key references tblPessoa,	NomeGuerra			varchar(50)		NOT NULL,	HorasAula			int				NULL,	ProfessorExiste		bit				NOT NULL,	ProfessorAtivo		bit				NOT NULL,	Observacoes			varchar(MAX)	NULL)
GOCREATE TABLE tblSlot (
	SlotId		int		NOT NULL primary key,	HoraInicio	time	NOT NULL,	Status_slot bit		NOT NULL)GO
CREATE TABLE tblCurso (
	CursoId		int				NOT NULL primary key identity,	Titulo		varchar(100)	NOT NULL,	Turno		varchar(15)		NOT NULL)
GO
CREATE TABLE tblDisciplina (
	DisciplinaId	int				NOT NULL primary key identity,	CodCurso		int				NOT NULL references tblCurso,	Nome			varchar(100)	NOT NULL,	QtdAulas		int				NOT NULL,	Semestre		int				NOT NULL,	Sigla			varchar(3)		NOT NULL)
GOCREATE TABLE tblDisponibilidade (
	CodProfessor	int NOT NULL references tblProfessor,	CodSlot			int	NOT NULL references tblSlot,	PRIMARY KEY (CodProfessor, CodSlot) )
GO
CREATE TABLE tblAtribuicao (
	CodProfessor	int NOT NULL references tblProfessor,	CodDisciplina	int	NOT NULL unique references tblDisciplina,	CodCurso		int NOT NULL references tblCurso,	PRIMARY KEY (CodProfessor, CodDisciplina) 
)
GO
CREATE TABLE tblResultado (
	CodProfessor	int			NOT NULL,  	CodDisciplina	int			NOT NULL,	CodSlot			int			NOT NULL,	PRIMARY KEY (CodProfessor, CodDisciplina, CodSlot),	CONSTRAINT fkCodAtribuicaoResultado 		FOREIGN KEY					(CodProfessor, CodDisciplina) 		REFERENCES tblAtribuicao	(CodProfessor, CodDisciplina),	CONSTRAINT fkDisponibilidadeResultado 		FOREIGN KEY						(CodProfessor, CodSlot) 		REFERENCES tblDisponibilidade	(CodProfessor, CodSlot))
GO/*INSERTS*/--tblPessoaINSERT INTO tblPessoa VALUES ('Carlos Magnus', 'carlos@fatecriopreto.edu.br', 'fatecrp', 1);INSERT INTO tblPessoa VALUES ('Lucimar Sasso', 'lucimar@fatecriopreto.edu.br', 'fatecrp', 0);INSERT INTO tblPessoa VALUES ('Edes Costa', 'edes@fatecriopreto.edu.br', 'fatecrp', 0);--tblProfessorINSERT INTO tblProfessor VALUES (1, 'Carlos', 0, 1, 1, '')INSERT INTO tblProfessor VALUES (2, 'Lucimar', 0, 1, 1, '')INSERT INTO tblProfessor VALUES (3, 'Edes', 0, 1, 1, '')--tblCursoINSERT INTO tblCurso VALUES ('An�lise e Desenvolvimento de Sistemas', 'Tarde');INSERT INTO tblCurso VALUES ('Inform�tica para Neg�cios', 'Noite');INSERT INTO tblCurso VALUES ('Agroneg�cio', 'Manh�');--tblDisciplinaINSERT INTO tblDisciplina VALUES (1, 'Programa��o Orientada � Objetos', 4, 4, 'POO');INSERT INTO tblDisciplina VALUES (2, 'Administra��o Geral', 4, 1, 'ADM');INSERT INTO tblDisciplina VALUES (3, 'Fundamentos', 2, 1, 'FUN');--tblLembreteINSERT INTO tblLembrete VALUES ('11/07/2016', 'Preencher todos os hor�rios at� o dia 15/07');INSERT INTO tblLembrete VALUES ('15/07/2016', 'Verificar disponibilidade de aulas');INSERT INTO tblLembrete VALUES ('02/12/2016', 'Banca de avalia��o do interdisciplinar');--tblSlotINSERT INTO tblSlot VALUES (1, '13:00:00', 0);INSERT INTO tblSlot VALUES (2, '15:00:00', 0);INSERT INTO tblSlot VALUES (3, '16:50:00', 0);--tblAtribuicaoINSERT INTO tblAtribuicao VALUES (1, 1, 1);INSERT INTO tblAtribuicao VALUES (2, 2, 2);INSERT INTO tblAtribuicao VALUES (3, 3, 3);--tblDisponibilidadeINSERT INTO tblDisponibilidade VALUES (1, 1);INSERT INTO tblDisponibilidade VALUES (2, 2);INSERT INTO tblDisponibilidade VALUES (3, 3);--tblResultadoselect*from tblResultadoINSERT INTO tblResultado VALUES (1, 1, 1);INSERT INTO tblResultado VALUES (2, 2, 2);INSERT INTO tblResultado VALUES (3, 3, 3);/*VIEWS*/--tblLembrete	CREATE VIEW ViewLembretes	AS	SELECT LembreteId,		   Data,		   Conteudo				FROM tblLembrete	--Teste de Execu��o--	SELECT * FROM ViewLembretes	select * from tblslot--tblSlot	CREATE VIEW ViewSlots	AS	SELECT SlotId,		   HoraInicio,		   Status_slot				FROM tblSlot	--Teste de Execu��o--	SELECT * FROM ViewSlots--tblPessoa	CREATE VIEW ViewPessoas	AS	SELECT PessoaId,		   Nome,		   Email,		   Senha,		   Permissao_admin				FROM tblPessoa	--Teste de Execu��o--	SELECT * FROM ViewPessoas--tblProfessor (JOIN)	CREATE VIEW ViewProfessores	AS	SELECT p.PessoaId,		   p.Nome,		   p.Email,		   p.Senha,		   p.Permissao_admin,		   prof.NomeGuerra,		   prof.HorasAula,		   prof.ProfessorExiste,		   prof.ProfessorAtivo,		   prof.Observacoes					FROM tblPessoa p, tblProfessor prof	Where p.PessoaId = prof.CodPessoa	--Teste de Execu��o--	SELECT * FROM ViewProfessores--tblCurso	CREATE VIEW ViewCursos	AS	SELECT CursoId,		   Titulo,		   Turno				FROM tblCurso	--Teste de Execu��o--	SELECT * FROM ViewCursos--tblDisciplina	CREATE VIEW ViewDisciplinas	AS	SELECT d.CodCurso,		   d.DisciplinaId,		   d.Nome,		   d.QtdAulas,		   d.Semestre,		   d.Sigla				FROM tblDisciplina d	--Teste de Execu��o--	SELECT * FROM ViewDisciplinas--tblAtribuicao	CREATE VIEW ViewAtribuicoes	AS	SELECT a.CodProfessor,		   a.CodDisciplina,		   a.CodCurso	FROM tblAtribuicao a	--Teste de Execu��o--	SELECT * FROM ViewAtribuicoes--tblDisponibilidade	CREATE VIEW ViewDisponibilidades	AS	SELECT d.CodProfessor,		   d.CodSlot	FROM tblDisponibilidade d	--Teste de Execu��o--	SELECT * FROM ViewDisponibilidades	--tblResultado	CREATE VIEW ViewResultados	AS	SELECT r.CodProfessor,		   r.CodSlot	FROM tblDisponibilidade r	--Teste de Execu��o--	SELECT * FROM ViewDisponibilidades--(JOINS)--Professor - Disciplina - Curso	CREATE VIEW ViewProf_Disciplina_Curso	AS	SELECT p.CodPessoa,		   p.NomeGuerra,		   d.DisciplinaId,		   d.Nome,		   d.Semestre,		   d.QtdAulas,		   c.CursoId,			   c.Titulo		FROM tblProfessor p, tblDisciplina d, tblCurso c, tblAtribuicao a	Where p.CodPessoa = a.CodProfessor and d.DisciplinaId = a.CodDisciplina and c.CursoId = a.CodCurso	--Teste de Execu��o--	SELECT * FROM ViewProf_Disciplina_Curso--Professor - Disciplina	CREATE VIEW ViewProf_Disciplina	AS	SELECT p.CodPessoa,		   p.NomeGuerra,		   d.DisciplinaId,		   d.Nome,		   d.Sigla,		   d.QtdAulas	FROM tblProfessor p, tblDisciplina d, tblAtribuicao a	Where p.CodPessoa = a.CodProfessor and d.DisciplinaId = a.CodDisciplina	--Teste de Execu��o--	SELECT * FROM ViewProf_Disciplina--Professor - Curso	CREATE VIEW ViewProf_Curso	AS	SELECT p.CodPessoa,		   p.NomeGuerra,		   c.CursoId,			   c.Titulo,		   c.Turno	FROM tblProfessor p, tblCurso c, tblAtribuicao a	Where p.CodPessoa = a.CodProfessor and c.CursoId = a.CodCurso	--Teste de Execu��o--	SELECT * FROM ViewProf_Curso--Professor - Disponibilidade - Slot	CREATE VIEW ViewProf_Disponibilidade_Slot	AS	SELECT p.CodPessoa,		   p.NomeGuerra,		   s.SlotId,		   s.HoraInicio			FROM tblProfessor p, tblSlot s, tblDisponibilidade d	Where p.CodPessoa = d.CodProfessor and  s.SlotId = d.CodSlot	--Teste de Execu��o--	SELECT * FROM ViewProf_Disponibilidade_Slot--Disciplina - Curso	CREATE VIEW ViewDisciplina_Curso	AS	SELECT d.DisciplinaId,		   d.Nome,		   d.Semestre,		   c.CursoId,		   c.Titulo,		   c.Turno	FROM tblDisciplina d, tblCurso c	Where d.CodCurso = c.CursoId	--Teste de Execu��o--	SELECT * FROM ViewDisciplina_Curso--Disciplina - Prof - Slot	CREATE VIEW ViewDisciplina_Prof_Slot	AS	SELECT d.DisciplinaId,		   d.Nome,		   p.CodPessoa,		   p.NomeGuerra,		   s.SlotId,		   s.HoraInicio	FROM tblDisciplina d, tblProfessor p, tblSlot s, tblResultado r	Where d.DisciplinaId = r.CodDisciplina and p.CodPessoa = r.CodProfessor and s.SlotId = r.CodSlot	--Teste de Execu��o--	SELECT * FROM ViewDisciplina_Prof_Slot/*PROCEDURES*/		--Lembrete	--Insert	CREATE PROCEDURE ArmazenaLembrete(
		@data		date,
		@conteudo	varchar(MAX)
	)AS
	BEGIN
		INSERT INTO tblLembrete VALUES (@data, @conteudo)
	END	--Teste de Execu��o--	ArmazenaLembrete '11/08/12', 'Conte�do exemplo.'	--Update	CREATE PROCEDURE AlteraLembrete(		@id int,		@conteudo varchar(MAX)	)AS	BEGIN 		UPDATE tblLembrete SET			Conteudo = @conteudo		WHERE LembreteId = @id	END	--Teste de Execu��o--	AlteraLembrete  4, '12/08/12', 'Conte�do exemplo alterado.'		--Delete	CREATE PROCEDURE ApagaLembrete(		@id int	)AS	BEGIN		DELETE FROM tblLembrete 
		WHERE LembreteId = @id	END	--Teste de Execu��o--	ApagaLembrete 4--Pessoa
	--Insert
	CREATE PROCEDURE ArmazenaPessoa(
		@nome				varchar(50),		@email				varchar(100)
	)AS
	BEGIN
		INSERT INTO tblPessoa VALUES (@nome, @email, 'fatecrp', 0)
	END
	--Teste de Execu��o--
	ArmazenaPessoa 'Jo�o da Silva', 'joao@email.com'

	--Update
	CREATE PROCEDURE AlteraPessoa 
	(
		@id int,
		@nome varchar(50),		@email varchar(100)	)
	AS
	BEGIN
		UPDATE tblPessoa SET
			Nome = @nome,
			Email = @email
		WHERE PessoaId = @id
	END
	--Teste de Execu��o--
	AlteraPessoa 4, 'Maria da Silva', 'maria@email.com'

	--ValidaLogin
	CREATE PROCEDURE ValidaLogin(		@email varchar(100),		@senha varchar(25)
	)AS
	BEGIN
		SELECT * FROM tblPessoa WHERE Email = @email and Senha = @senha
	END
	--Teste de Execu��o--
	ValidaLogin	'maria@email.com', 'fatecrp'

	--UpdateSenha
	CREATE PROCEDURE AlteraSenha(
		@id int,
		@senhaNova varchar(25)
	)AS
	BEGIN
		UPDATE tblPessoa SET
			Senha = @senhaNova
		WHERE PessoaId = @id	
	END
	--Teste de Execu��o--
	AlteraSenha	4, 'maria1234'


--Professor
	--Insert
	CREATE PROCEDURE ArmazenaProfessor(
		@nome varchar(50),		@email varchar(100),		@nomeGuerra	varchar(50),		@professorExiste bit	)AS	BEGIN		EXEC ArmazenaPessoa @nome, @email		INSERT INTO tblProfessor VALUES (@@IDENTITY, @nomeGuerra, 0, @professorExiste, 1, '')	END	--Teste de Execu��o--
	ArmazenaProfessor 'Fulano da Silva', 'fulano@email.com', 'Fulano', 1
	
	--Update
	CREATE PROCEDURE AlteraProfessor 
	(
		@id int,
		@nome varchar(50),		@email varchar(100),		@nomeGuerra varchar(50),
		@professorExiste bit,
		@professorAtivo bit
	)
	AS
	BEGIN
		UPDATE tblPessoa SET
			Nome = @nome,
			Email = @email
		WHERE PessoaId = @id

		UPDATE tblProfessor SET 
			NomeGuerra = @nomeGuerra,
			ProfessorExiste = @professorExiste,
			ProfessorAtivo = @professorAtivo  
		WHERE CodPessoa = @id
	END
	--Teste de Execu��o--
	AlteraProfessor 5, 'Ciclano da Silva', 'ciclano@email.com', 'Ciclano', 1, 1

	--Delete
	CREATE PROCEDURE ApagaProfessor 
	(
		@id int
	)
	AS
	BEGIN
		DELETE FROM tblProfessor 
		WHERE CodPessoa = @id
		DELETE FROM tblPessoa 
		WHERE PessoaId = @id
	END
	--Teste de Execu��o--
	ApagaProfessor 5

--Slots
	--Insert
	CREATE PROCEDURE ArmazenaSlot(		@slotId		int,		@horaInicio time	)AS	BEGIN		INSERT INTO tblSlot VALUES (@slotId, @horaInicio, 0)	END	CREATE PROCEDURE PopulaTblSlots	AS	BEGIN		EXEC ArmazenaSlot 1, '13:10:00'		EXEC ArmazenaSlot 2, '15:00:00'		EXEC ArmazenaSlot 3, '16:50:00'		EXEC ArmazenaSlot 4, '13:10:00'		EXEC ArmazenaSlot 5, '15:00:00'		EXEC ArmazenaSlot 6, '16:50:00'		EXEC ArmazenaSlot 7, '13:10:00'		EXEC ArmazenaSlot 8, '15:00:00'		EXEC ArmazenaSlot 9, '16:50:00'		EXEC ArmazenaSlot 10, '13:10:00'		EXEC ArmazenaSlot 11, '15:00:00'		EXEC ArmazenaSlot 12, '16:50:00'		EXEC ArmazenaSlot 13, '13:10:00'		EXEC ArmazenaSlot 14, '15:00:00'		EXEC ArmazenaSlot 15, '16:50:00'	END	--Teste de Execu��o--	PopulaTblSlots					--Curso	--Insert	CREATE PROCEDURE ArmazenaCurso(
		@titulo	varchar(100),
		@turno varchar(15)
	)AS
	BEGIN
		INSERT INTO tblCurso VALUES (@titulo, @turno)
	END
	--Teste de Execu��o--
	ArmazenaCurso 'Medicina', 'Tarde'
	
	--Update
	CREATE PROCEDURE AlteraCurso
	(
		@id int,
		@titulo varchar(100),		@turno varchar(15)	)
	AS
	BEGIN
		UPDATE tblCurso SET
			Titulo = @titulo,
			Turno = @turno
		WHERE CursoId = @id
	END
	--Teste de Execu��o--
	AlteraCurso 4, 'Medicina', 'Noite'

	--Delete
	CREATE PROCEDURE ApagaCurso 
	(
		@id int
	)
	AS
	BEGIN
		DELETE FROM tblCurso 
		WHERE CursoId = @id
	END
	--Teste de Execu��o--
	ApagaCurso 4


--Disciplina 	--Insert	CREATE PROCEDURE ArmazenaDisciplina(		@codCurso		int,		@nome			varchar(100),		@qtdAulas		int,		@semestre		int,		@sigla			varchar(3)	)AS	BEGIN		INSERT INTO tblDisciplina VALUES (@CodCurso, @Nome, @QtdAulas, @Semestre, @Sigla)	END	--Teste de Execu��o--
	ArmazenaDisciplina 4, 'Anatomia', 4, 1, 'ANA'	--Update	CREATE PROCEDURE AlteraDisciplina(		@id				int,		@codCurso		int,		@nome			varchar(100),		@qtdAulas		int,		@semestre		int,		@sigla			varchar(3)	)AS	BEGIN		UPDATE tblDisciplina SET		CodCurso = @codCurso,		Nome = @nome,		QtdAulas = @qtdAulas,		Semestre = @semestre,		Sigla = @sigla	WHERE DisciplinaId = @id	END	--Teste de Execu��o--
	AlteraDisciplina 4, 4, 'Anatomia 2', 6, 1, 'ANA'	--Delete	CREATE PROCEDURE ApagaDisciplina 
	(
		@id int
	)
	AS
	BEGIN
		DELETE FROM tblDisciplina 
		WHERE DisciplinaId = @id
	END
	--Teste de Execu��o--
	ApagaDisciplina 4
--Disponibilidade	--Insert	CREATE PROCEDURE ArmazenaDisponibilidade(		@codProfessor		int,		@codSlot			int	)AS	BEGIN		INSERT INTO tblDisponibilidade VALUES (@codProfessor, @codSlot)	END	--Teste de Execu��o--
	ArmazenaDisponibilidade 4, 4	--Delete	CREATE PROCEDURE ApagaDisponibilidade
	(
		@ProfessorId int,
		@SlotId int
	)
	AS
	BEGIN
		DELETE FROM tblDisponibilidade
		WHERE CodProfessor = @ProfessorId AND CodSlot = @SlotId
	END	--Teste de Execu��o--	ApagaDisponibilidade 4, 4--Atribuicao	--Insert	CREATE PROCEDURE ArmazenaAtribuicao(		@codProfessor		int,		@codDisciplina		int,		@codCurso			int	)AS	BEGIN		INSERT INTO tblAtribuicao VALUES (@codProfessor, @codDisciplina, @codCurso)	END	--Teste de Execu��o--
	ArmazenaAtribuicao 4, 4, 4	--Delete	CREATE PROCEDURE ApagaAtribuicao
	(
		@ProfessorId int,
		@CursoId int
	)
	AS
	BEGIN
		DELETE FROM tblAtribuicao
		WHERE CodProfessor = @ProfessorId AND CodCurso = @CursoId
	END	--Teste de Execu��o--	ApagaAtribuicao 4, 4--Resultado	--Insert	CREATE PROCEDURE ArmazenaResultado(		@codProfessor		int,		@codDisciplina		int,		@codSlot			int	)AS	BEGIN		INSERT INTO tblResultado VALUES (@codProfessor, @codDisciplina, @codSlot)	END	--Teste de Execu��o--
	ArmazenaResultado 4, 4, 4	--Delete	CREATE PROCEDURE ApagaResultado
	(
		@codProfessor		int,		@codDisciplina		int,		@codSlot			int
	)
	AS
	BEGIN
		DELETE FROM tblResultado
		WHERE CodProfessor = @codProfessor AND CodDisciplina = @codDisciplina and CodSlot= @codSlot
	END	--Teste de Execu��o--	ApagaResultado 4, 4, 4