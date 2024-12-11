USE [21BI11_DDS]
GO

CREATE TABLE [MINING_AIR_QUALITY] (
    AQI_ID INT,
    GEO_ID INT,
    DATE_ID INT,
    AQI INT,
    CATEGORY NVARCHAR(50),
    DEFINING_PARAMETER NVARCHAR(50),
    DEFINING_SITE NVARCHAR(50),
    NUMBER_OF_SITES_REPORTING INT,
	STATE_NAME NVARCHAR(150),
    COUNTY NVARCHAR(150),
	[YEAR] INT,
    [QUARTER] INT,
    [MONTH] INT,
    [DAY] INT,

    CONSTRAINT PK_MINING_AIR_QUALITY
    PRIMARY KEY(AQI_ID),
)

INSERT INTO MINING_AIR_QUALITY (AQI_ID, GEO_ID, DATE_ID, AQI, CATEGORY, DEFINING_PARAMETER, DEFINING_SITE, NUMBER_OF_SITES_REPORTING, STATE_NAME, COUNTY, [YEAR], [QUARTER], [MONTH], [DAY])
SELECT 
	AQI_ID,
    GEO_ID, 
	DATE_ID,
	AQI,	
	CATEGORY,
	DEFINING_PARAMETER,
	DEFINING_SITE,
	NUMBER_OF_SITES_REPORTING,
	'PLACEHOLDER' AS STATE_NAME,
	'PLACEHOLDER' AS COUNTY,
	0 AS [YEAR],
	0 AS [QUARTER],
	0 AS [MONTH],
	0 AS [DAY]
FROM dbo.FACT_AIR_QUALITY

UPDATE MINING_AIR_QUALITY
SET STATE_NAME = (SELECT TOP(1) STATE_NAME FROM DIM_GEO WHERE MINING_AIR_QUALITY.GEO_ID = DIM_GEO.GEO_ID)

UPDATE MINING_AIR_QUALITY
SET COUNTY = (SELECT TOP(1) COUNTY FROM DIM_GEO WHERE  MINING_AIR_QUALITY.GEO_ID = DIM_GEO.GEO_ID)

UPDATE MINING_AIR_QUALITY
SET [YEAR] = (SELECT [YEAR] FROM DIM_DATE WHERE MINING_AIR_QUALITY.DATE_ID = DIM_DATE.DATE_ID)

UPDATE MINING_AIR_QUALITY
SET [QUARTER] = (SELECT [QUARTER] FROM DIM_DATE WHERE MINING_AIR_QUALITY.DATE_ID = DIM_DATE.DATE_ID)

UPDATE MINING_AIR_QUALITY
SET [MONTH] = (SELECT [MONTH] FROM DIM_DATE WHERE MINING_AIR_QUALITY.DATE_ID = DIM_DATE.DATE_ID)

UPDATE MINING_AIR_QUALITY
SET [DAY] = (SELECT [DAY] FROM DIM_DATE WHERE MINING_AIR_QUALITY.DATE_ID = DIM_DATE.DATE_ID)


