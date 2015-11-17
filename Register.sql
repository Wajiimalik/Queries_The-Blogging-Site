USE [db_BLOGGING SITE]
GO
/****** Object:  StoredProcedure [dbo].[Register]    Script Date: 11/17/2015 7:40:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: Register.sql|15|0|C:\Users\wajiha\Documents\SQL Server Management Studio\Queries\db_The Blogging Site\Register.sql
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[Register]
	-- Add the parameters for the stored procedure here
	@FIRST_NAME varchar(50),
	@EMAIL varchar(50),
	@WHY_INTERESTED varchar(500),
	@JOB_FIELD varchar(15)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO dbo.REQUEST (FIRST_NAME, EMAIL, WHY_INTERESTED, JOB_FIELD) VALUES (@FIRST_NAME, @EMAIL, @WHY_INTERESTED, @JOB_FIELD );
	
END
