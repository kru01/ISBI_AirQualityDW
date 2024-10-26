USE master
GO

IF DB_ID('21BI11_DDS') IS NOT NULL
BEGIN
    ALTER DATABASE [21BI11_DDS]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE [21BI11_DDS]
END
GO

CREATE DATABASE [21BI11_DDS]
GO
USE [21BI11_DDS]
GO

CREATE TABLE [DIM_GEO] (
    GEO_ID INT IDENTITY,
    STATE_ID NVARCHAR(2),
    COUNTY_FIPS NVARCHAR(5),
    STATE_NAME NVARCHAR(150),
    COUNTY NVARCHAR(150),
    LAT FLOAT,
    LNG FLOAT,
    [POPULATION] INT,
    CREATED DATETIME,
    LAST_UPDATED DATETIME,
    [STATUS] INT,
    SOURCE_ID INT,

    CONSTRAINT PK_DIM_GEO
    PRIMARY KEY(GEO_ID)
)

CREATE TABLE [DIM_DATE] (
    DATE_ID INT IDENTITY,
    [DATE] DATE,
    [YEAR] INT,
    [QUARTER] INT,
    [MONTH] INT,
    [DAY] INT,

    CONSTRAINT PK_DIM_DATE
    PRIMARY KEY(DATE_ID)
)

CREATE TABLE [FACT_AIR_QUALITY] (
    AQI_ID INT IDENTITY,
    GEO_ID INT,
    DATE_ID INT,
    AQI INT,
    CATEGORY NVARCHAR(50),
    DEFINING_PARAMETER NVARCHAR(50),
    DEFINING_SITE NVARCHAR(50),
    NUMBER_OF_SITES_REPORTING INT,
    CREATED DATETIME,
    LAST_UPDATED DATETIME,
    SOURCE_ID INT,

    CONSTRAINT PK_FACT_AIR_QUALITY
    PRIMARY KEY(AQI_ID),

    CONSTRAINT FK_FACT_AIR_QUALITY_DIM_GEO
    FOREIGN KEY(GEO_ID) REFERENCES [DIM_GEO](GEO_ID),

    CONSTRAINT FK_FACT_AIR_QUALITY_DIM_DATE
    FOREIGN KEY(DATE_ID) REFERENCES [DIM_DATE](DATE_ID)
)
GO

TRUNCATE TABLE [21BI11_METADATA].dbo.DDS

INSERT INTO [21BI11_METADATA].dbo.DDS
    SELECT TABLE_NAME, '2000-01-01 00:00:00.000'
    FROM [21BI11_DDS].INFORMATION_SCHEMA.TABLES
    WHERE TABLE_TYPE='BASE TABLE'

GO

CREATE OR ALTER PROC USP_DIM_DATE_GEN
    @YEAR_ST VARCHAR(4) = 2021, @YEAR_ED VARCHAR(4) = 2023
AS BEGIN
    DECLARE @DATE_ST DATE = @YEAR_ST + '0101',
            @DATE_ED DATE = @YEAR_ED + '1231';

    INSERT INTO DIM_DATE
    SELECT DT, YEAR(DT), DATEPART(QUARTER, DT), MONTH(DT), DAY(DT)
    FROM (SELECT TOP (DATEDIFF(DAY, @DATE_ST, @DATE_ED) + 1)
            DT = DATEADD(DAY, ROW_NUMBER() OVER(ORDER BY A.object_id) - 1,
                @DATE_ST)
        FROM sys.all_objects A CROSS JOIN sys.all_objects B) GEN;
END
GO

EXEC [21BI11_DDS].[dbo].USP_DIM_DATE_GEN
GO