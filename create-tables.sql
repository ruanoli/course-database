CREATE DATABASE [rncourse]
GO

USE [rncourse]
GO

CREATE TABLE [Student](
	[Id] uniqueidentifier NOT NULL,
	[Name] NVARCHAR(60) NOT NULL,
	[Email] NVARCHAR(120) NOT NULL,
	[Document] NVARCHAR(20) NOT NULL,
	[PHONE] NVARCHAR(20) NOT NULL,
	[BithDate] DATETIME NULL ,
	[CreateDate] DATETIME NOT NULL DEFAULT(GETDATE()),

	CONSTRAINT [PK_Student] PRIMARY KEY ([Id])
)
GO

CREATE TABLE [Author](
	[Id] uniqueidentifier NOT NULL,
	[Name] NVARCHAR(80) NOT NULL,
	[Title] NVARCHAR(120) NOT NULL,
	[Image] NVARCHAR(1024) NOT NULL,
	[Bio] NVARCHAR(1200) NOT NULL,
	[Url] NVARCHAR(450) NOT NULL,
	[Email] NVARCHAR(60) NOT NULL,
	[Type] TINYINT NOT NULL, --TINYINT valores de 0 a 255

	CONSTRAINT [PK_Author] PRIMARY KEY ([Id])
)
GO

CREATE TABLE [Career](
	[Id] uniqueidentifier NOT NULL,
	[Title] NVARCHAR(120) NOT NULL,
	[Summary] NVARCHAR(1024) NOT NULL,
	[Url] NVARCHAR(450) NOT NULL,
	[DurationInMinutes] INT NOT NULL,
	[Active] BIT NOT NULL,
	[Featured] BIT NOT NULL,
	[Tags] NVARCHAR(160) NOT NULL,

	CONSTRAINT [PK_Career] PRIMARY KEY ([Id])
)
GO

CREATE TABLE [Category](
	[Id] uniqueidentifier NOT NULL,
	[Title] NVARCHAR(120) NOT NULL,
	[Url] NVARCHAR(450) NOT NULL,
	[Summary] NVARCHAR(1024) NOT NULL,
	[Order] INT NOT NULL,
	[Description] TEXT NOT NULL,
	[Featured] BIT NOT NULL,

	CONSTRAINT [PK_Category] PRIMARY KEY ([Id])
)
GO

CREATE TABLE [Course](
	[Id] uniqueidentifier NOT NULL,
	[Tag] NVARCHAR(20) NOT NULL,
	[Title] NVARCHAR(60) NOT NULL,
	[Summary] NVARCHAR(2000) NOT NULL,
	[Url] NVARCHAR(1024) NOT NULL,
	[Level] TINYINT NOT NULL,
	[DurationInMinutes] INT NOT NULL,
	[CreateDate] DATETIME NOT NULL,
	[LastUpdateDate] DATETIME NULL,
	[Active] BIT NOT NULL,
	[Free] BIT NOT NULL,
	[Featured] BIT NOT NULL,
	[AuthorId] uniqueidentifier NOT NULL,
	[CategoryId] uniqueidentifier NOT NULL,
	[Tags] NVARCHAR(60) NOT NULL,

	CONSTRAINT [PK_Course] PRIMARY KEY ([Id]),
	CONSTRAINT [FK_Course_Author_AuthorId] FOREIGN KEY ([AuthorId]) REFERENCES [Author] ([Id]), --Quando um curso for excluído, os autores não serão excluidos juntos.
	CONSTRAINT [FK_Course_Category_CategoryId] FOREIGN KEY ([CategoryId]) REFERENCES [Category] ([Id]) --Quando um curso for excluído, as categorias não serão excluidos juntos.
)
GO

CREATE TABLE [CareerItem](
	[CareerId] uniqueidentifier NOT NULL,
	[CourseId] uniqueidentifier NOT NULL,
	[Title] NVARCHAR(100) NOT NULL,
	[Description] TEXT NOT NULL,
	[Order] TINYINT NOT NULL,

	CONSTRAINT [PK_CareerItem] PRIMARY KEY ([CourseId], [CareerId]),
	CONSTRAINT [FK_CareerItem_Course_CourseId] FOREIGN KEY ([CourseId]) REFERENCES [Career] ([Id]),
	CONSTRAINT [FK_CareerItem_Career_CareerId] FOREIGN KEY ([CourseId]) REFERENCES [Career] ([Id]),
)
GO

CREATE TABLE [StudentCourse](
	[StudentId] uniqueidentifier NOT NULL,
	[CourseId] uniqueidentifier NOT NULL,
	[Progress] TINYINT NOT NULL,
	[Favorite] BIT NOT NULL,
	[StartDate] DATETIME NOT NULL,
	[LastUpdateDate] DATETIME NULL DEFAULT(GETDATE()),

	CONSTRAINT [PK_StudentCourse] PRIMARY KEY ([CourseId], [StudentId]),
	CONSTRAINT [FK_StudentCourse_Course_CourseId] FOREIGN KEY ([CourseId]) REFERENCES [Course] ([Id]),
	CONSTRAINT [FK_StudentCourse_Student_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Student] ([Id]),
)
GO
