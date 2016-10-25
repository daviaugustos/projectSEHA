DROP DATABASE BDSeha
CREATE TABLE tblLembrete (
	LembreteId	int				NOT NULL primary key identity,
GO
	PessoaId			int				NOT NULL primary key identity, 
	Nome				varchar(50)		NOT NULL,
)
GO

CREATE TABLE tblProfessor (
	CodPessoa			int				NOT NULL primary key references tblPessoa,
GO
	SlotId		int		NOT NULL primary key,
CREATE TABLE tblCurso (
	CursoId	int				NOT NULL primary key identity,
GO
CREATE TABLE tblDisciplina (
	DisciplinaId	int				NOT NULL primary key identity,
GO
	CodProfessor	int NOT NULL references tblProfessor,
GO
CREATE TABLE tblAtribuicao (
	CodProfessor	int NOT NULL references tblProfessor,
)
GO
CREATE TABLE tblResultado (
	CodProfessor	int			NOT NULL,  
GO
		@data		date,
		@conteudo	varchar(MAX)
	)AS
	BEGIN
		INSERT INTO tblLembrete VALUES (@data, @conteudo)
	END
	SELECT * FROM tblLembrete

	--Insert
	CREATE PROCEDURE ArmazenaPessoa(
		@nome				varchar(50),
	)AS
	BEGIN
		INSERT INTO tblPessoa VALUES (@nome, @email, @senha, 0)
	END

	EXEC ArmazenaPessoa 'Davi Augusto Leme dos Santos', 'davi@mail.com', '12345'
	SELECT * FROM tblPessoa

	--Outros
	CREATE PROCEDURE ValidaLogin(
	)AS
	BEGIN
		SELECT * FROM tblPessoa WHERE Email = @email and Senha = @senha
	END
	EXEC ValidaLogin 'davi@mail.com', '12345'

	--Avaliar no model se haver� mudan�a no m�todo UpdateSenha e alterar na proc depois
	CREATE PROCEDURE AlteraSenha(
		@PessoaId int,
		@senhaNova varchar(25)
	)AS
	BEGIN
		UPDATE tblPessoa SET
			Senha = @senhaNova,
		WHERE PessoaId = @id	
	END


--Professor
	--Insert
	CREATE PROCEDURE ArmazenaProfessor(
		@nome varchar(50),
	SELECT * FROM tblProfessor

	--Update
	CREATE PROCEDURE AlteraProfessor 
	(
		@id int,
		@nome varchar(50),
		@professorExiste bit,
		@professorAtiva bit
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
			ProfessorAtivo = @professorAtiva  
		WHERE CodPessoa = @id
	END

	EXEC AlteraProfessor 2, 'Tobias', 'tobias@mail.com', 'TobiasEditado', 1, 1
	SELECT * FROM tblProfessor

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

	EXEC ApagaProfessor 2
	SELECT * FROM tblProfessor


--Slots: Fixos e inseridos manualmente.
	CREATE PROCEDURE ArmazenaSlot(
		@titulo	varchar(100),
		@turno int
		-- 1: Diurno, 2: Vespertino, 3: Noturno
		--por defini��o para o inter, o turno ser� o da tarde
	)AS
	BEGIN
		INSERT INTO tblCurso VALUES (@titulo, @turno)
	END
	
	EXEC ArmazenaCurso 'An�lise e desenvolvimento de sistemas', 1
	SELECT * FROM tblCurso
		

--Disciplina