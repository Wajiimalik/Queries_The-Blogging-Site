﻿	-- =============================================
-- Create database
-- =============================================

-- Drop the database if it already exists
IF  EXISTS (
	SELECT * 
		FROM sys.databases 
		WHERE name = 'BLOGGING_SITE'
)
DROP DATABASE BLOGGING_SITE
GO

-- Create Database

CREATE DATABASE BLOGGING_SITE
GO

-- Create Tables

CREATE TABLE ADMIN 
(
	ADMIN_ID tinyint  NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	PICTURE varchar(255) NOT NULL UNIQUE /*DEFAULT */,
	ACCOUNT_NUMBER varchar(50) NOT NULL UNIQUE
)
GO

CREATE TABLE WRITER 
(
	WRITER_ID int NOT NULL PRIMARY KEY IDENTITY(1,1), 
	FATHER_NAME varchar(25) NOT NULL, 
	CV varchar(max) NOT NULL UNIQUE, 
	WHY_INTERESTED varchar(500) NOT NULL, 
	JOB_FIELD varchar(20) NOT NULL CHECK(JOB_FIELD in ('Editor', 'Content Writer')),
	NIC varchar(20) NOT NULL UNIQUE, 
	W_ADDRESS varchar(75) NOT NULL, 
	ACCOUNT_NUMBER varchar(100) NOT NULL UNIQUE, 
	PICTURE varchar(100) NOT NULL UNIQUE,
	ARTICLES_PER_WEEK tinyint NOT NULL CHECK(ARTICLES_PER_WEEK > 5 AND ARTICLES_PER_WEEK < 50), 
)
GO

CREATE TABLE CONTENT_WRITER 
(
	CW_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY
)
GO

CREATE TABLE EDITOR 
(
	EDITOR_ID tinyint NOT NULL IDENTITY(1,1) PRIMARY KEY 
)
GO

CREATE TABLE REQUEST 
(
	REQUEST_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	FIRST_NAME varchar(10) NOT NULL, 
	LAST_NAME varchar(10) NOT NULL, 
	FATHER_NAME varchar(25) NOT NULL, 
	CV varchar(max) NOT NULL UNIQUE, 
	CONTACT_NUMBER varchar(15) NOT NULL UNIQUE, 
	EMAIL varchar(320) NOT NULL UNIQUE, 
	WHY_INTERESTED varchar(500) NOT NULL, 
	JOB_FIELD varchar(20) NOT NULL CHECK(JOB_FIELD in ('Editor', 'Content Writer')), 
	R_STATUS varchar(20) NOT NULL CHECK(R_STATUS in ('Pending','Selected' /* others*/))
)
GO


CREATE TABLE DRAFT_ARTCLE 
(
	DRAFT_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	TITLE varchar(255) NOT NULL UNIQUE,
	SUBTITLE varchar(255) NOT NULL UNIQUE, 
	CONTENT varchar(max) NOT NULL UNIQUE, 
	DATE_TIME smalldatetime DEFAULT GETDATE() CHECK( DATE_TIME <= GETDATE() )
)
GO


CREATE TABLE SUBMITTED_ARTICLE 
( 
	SUB_BLOG_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	TITLE varchar(255) NOT NULL UNIQUE, 
	SUBTITLE varchar(255) NOT NULL UNIQUE, 
	BLOG_CONTENT varchar(max) NOT NULL UNIQUE, 
	DATE_TIME smalldatetime DEFAULT GETDATE() CHECK( DATE_TIME <= GETDATE()),

	CW_ID int NOT NULL FOREIGN KEY REFERENCES CONTENT_WRITER(CW_ID)
)
GO

CREATE TABLE PUBLISHED_ARTICLE 
(
	BLOG_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	TITLE varchar(255) NOT NULL UNIQUE, 
	SUBTITLE varchar(255) NOT NULL UNIQUE, 
	CONTENT varchar(max) NOT NULL UNIQUE, 
	DATE_TIME smalldatetime DEFAULT GETDATE() CHECK( DATE_TIME <= GETDATE()), 
	NO_OF_LIKES int DEFAULT 0
) 
GO 

CREATE TABLE COMMENT 
(
	COMMENT_ID tinyint NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	FIRST_NAME varchar(10) NOT NULL, 
	LAST_NAME varchar(10),
	EMAIL varchar(320) NOT NULL, 
	DATE_TIME smalldatetime DEFAULT GETDATE() CHECK( DATE_TIME <= GETDATE()), 
	BODY varchar(max) NOT NULL, 

	BLOG_ID int FOREIGN KEY REFERENCES PUBLISHED_ARTICLE(BLOG_ID), 
	
	CONSTRAINT EmailValidator CHECK 
		( 
			CHARINDEX(' ',LTRIM(RTRIM(EMAIL) ) ) = 0
			AND LEFT(LTRIM(EMAIL),1) <> '@' AND RIGHT(RTRIM(EMAIL),1) <> '.'  AND CHARINDEX('.', EMAIL,CHARINDEX('@', EMAIL)) - CHARINDEX('@', EMAIL) > 1
			AND LEN(LTRIM(RTRIM(EMAIL))) - LEN(REPLACE(LTRIM(RTRIM(EMAIL)),'@','')) = 1 AND CHARINDEX('.',REVERSE(LTRIM(RTRIM(EMAIL)))) >= 3 AND (CHARINDEX('.@', EMAIL) = 0 
			AND CHARINDEX('..', EMAIL) = 0) 
		)
)
GO

CREATE TABLE EDITOR_COMMENT 
(
	SUBMITTED_BLOG_ID int NOT NULL PRIMARY KEY, 
	EDITOR_ID int NOT NULL, 
	COMMENT_BODY varchar(1000) NOT NULL, 
	DATE_TIME smalldatetime DEFAULT GETDATE() CHECK( DATE_TIME <= GETDATE())
)
GO

CREATE TABLE PUBLISHED_CONTENT 
(
	PUBLISHED_ARTICLE_ID int NOT NULL PRIMARY KEY, 
	CW_ID int NOT NULL
)
GO

CREATE TABLE EDITOR_PUBLISH 
(
	PUBLISHED_ARTICLE_ID int NOT NULL PRIMARY KEY, 
	EDITOR_ID tinyint NOT NULL
)
GO

CREATE TABLE PUBLIC_PUBLISHED 
(
	PUBLISHED_ARTICLE_ID int NOT NULL  PRIMARY KEY, 
	WRITER_ID int NOT NULL
)
GO

CREATE TABLE BLOG_USER 
(
	USER_ID int NOT NULL IDENTITY(1,1) PRIMARY KEY, 
	FIRST_NAME varchar(10) NOT NULL,
	LAST_NAME varchar(10) NOT NULL, 
	DOB varchar(10) NOT NULL, 
	CONTACT_NUMBER varchar(15) NOT NULL UNIQUE, 
	EMAIL varchar(320) NOT NULL UNIQUE, 
	COUNTRY varchar(20) NOT NULL, 
	CITY varchar(15) NOT NULL, 
	
	CONSTRAINT EmailCheck CHECK
		( 
			CHARINDEX(' ',LTRIM(RTRIM(EMAIL))) = 0
			AND LEFT(LTRIM(EMAIL),1) <> '@' AND RIGHT(RTRIM(EMAIL),1) <> '.'  AND CHARINDEX('.', EMAIL,CHARINDEX('@', EMAIL)) - CHARINDEX('@', EMAIL) > 1
			AND LEN(LTRIM(RTRIM(EMAIL))) - LEN(REPLACE(LTRIM(RTRIM(EMAIL)),'@','')) = 1 AND CHARINDEX('.',REVERSE(LTRIM(RTRIM(EMAIL)))) >= 3 
			AND (CHARINDEX('.@', EMAIL) = 0 AND CHARINDEX('..', EMAIL) = 0) 
		)
)
GO

CREATE TABLE PAST_EXPERIENCE 
(
	PE_ID int NOT NULL IDENTITY(1,1)  PRIMARY KEY, 
	USER_ID int NOT NULL, 
	EXPERIENCE varchar(200) NOT NULL
)
GO
