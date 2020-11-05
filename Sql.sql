IF DB_ID('DB_PAHANITTO_1234321') IS NOT NULL --права должны быть и такое имя не совпадет
	DROP DATABASE DB_PAHANITTO_1234321
GO
CREATE DATABASE DB_PAHANITTO_1234321
GO
USE DB_PAHANITTO_1234321
GO

SET NOCOUNT ON
SET ANSI_NULLS ON 
SET QUOTED_IDENTIFIER ON
GO

CREATE SCHEMA [DB]
GO

---------------------------------------------------------------------------------------------------------------
--табличка
CREATE TABLE [DB].[Test_Tab](
	[ID_] INT NOT NULL IDENTITY(1 ,1)
	,[Obj_ID] INT NOT NULL
	,[Name] NVARCHAR(128) NOT NULL
	,[Description] NVARCHAR(60) NUll
	,[Date] DATETIME NOT NULL
	,CONSTRAINT [PK_Test_Tab_ID_] PRIMARY KEY CLUSTERED ([ID_])
)
GO
CREATE UNIQUE INDEX UQ_Test_Tab_Obj_ID ON [DB].[Test_Tab] ([Obj_ID] ASC)
GO

--возьмем пусть такие данные
INSERT INTO [DB].[Test_Tab]
([Obj_ID] ,[Name] ,[Description] ,[Date])
SELECT TOP 100 [Object_ID] ,[Name] ,[Type_Desc] ,[Create_Date]
FROM sys.[all_objects]  
ORDER BY [Name] DESC

/*
SELECT * FROM [DB].[Test_Tab] ORDER BY [ID_] ASC
*/