/* Duplicate rows and trailing spaces
 */
-- There are trailing whitespaces in certain columns of 10_STATE_AQI.
--  Specifically, all COUNTY_NAMEs of the state Alaska.
-- For good measure, we will be trimming every NVARCHAR columns.
--  The process will be handled in SSIS.

-- 194964 distinct rows over 194971 rows.
SELECT * FROM [21BI11_STAGE].[dbo].[10_STATE_AQI]
SELECT DISTINCT STATE_CODE, COUNTY_CODE, [DATE],
    AQI, CATEGORY, DEFINING_PARAMETER, DEFINING_SITE,
    NUMBER_OF_SITES_REPORTING, CREATED, LAST_UPDATED
FROM [21BI11_STAGE].[dbo].[10_STATE_AQI]

-- The affected rows have exactly matching data, albeit different SOURCE_ID.
--   Still, this should be addressed during ETL to the NDS.
SELECT * FROM [21BI11_STAGE].[dbo].[10_STATE_AQI]
WHERE STATE_CODE=78 AND COUNTY_CODE=20 AND [DATE]='2021-12-18'
SELECT * FROM [21BI11_STAGE].[dbo].[10_STATE_AQI]
WHERE STATE_CODE=51 AND COUNTY_CODE=61 AND [DATE]='2022-03-29'

-- NO duplication for 2B_USCOUNTIES.
SELECT * FROM [21BI11_STAGE].[dbo].[2B_USCOUNTIES]
SELECT DISTINCT STATE_ID, COUNTY_FIPS FROM [21BI11_STAGE].dbo.[2B_USCOUNTIES]

/* Mismatches
 */
-- NO problem with CATEGORY and DEFINING_PARAMETER, they conform with the
--  chart given by the project, and WHO's polutant measures.
--      + https://www.who.int/news-room/fact-sheets/detail/ambient-(outdoor)-air-quality-and-health?gad_source=1&gclid=EAIaIQobChMI25_274WfiQMVPGQPAh1Q_AXyEAAYASAAEgKFmPD_BwE
SELECT DISTINCT CATEGORY FROM [21BI11_STAGE].[dbo].[10_STATE_AQI]
SELECT DISTINCT DEFINING_PARAMETER FROM [21BI11_STAGE].[dbo].[10_STATE_AQI]

-- Certain (State, County) pairs from Air Quality data doesn't align with
--  (or exist in) US Counties list.
SELECT DISTINCT AQ.STATE_NAME, AQ.COUNTY_NAME, AQ.STATE_CODE, AQ.COUNTY_CODE
FROM [21BI11_STAGE].[dbo].[10_STATE_AQI] AQ
    LEFT JOIN [21BI11_STAGE].[dbo].[2B_USCOUNTIES] US
    ON AQ.STATE_NAME = US.STATE_NAME AND AQ.COUNTY_NAME = US.COUNTY
WHERE US.STATE_NAME IS NULL
ORDER BY AQ.STATE_CODE, AQ.COUNTY_CODE

-- FIXING AQI's COUNTY_NAME to match with USCOUNTIES's.
--  Looking up, we learn that Connecticut's Tolland is part of the Southeastern
--    Connecticut Planning Region, and Windham the Capitol Planning Region.
--      + https://en.wikipedia.org/wiki/Tolland,_Connecticut
--      + https://en.wikipedia.org/wiki/Windham,_Connecticut
--  Despite these regions consisting of many small towns and cities, our
--    USCOUNTIES list doesn't go to that level of detail, we might as well
--    map Tolland and Windham to their respective region's name.
SELECT * FROM [21BI11_STAGE].[dbo].[2B_USCOUNTIES]
WHERE STATE_NAME LIKE '%CONNECTICUT%'

UPDATE [21BI11_STAGE].[dbo].[10_STATE_AQI]
SET COUNTY_NAME='Southeastern Connecticut' WHERE STATE_CODE=9 AND COUNTY_CODE=13
UPDATE [21BI11_STAGE].[dbo].[10_STATE_AQI]
SET COUNTY_NAME='Capitol' WHERE STATE_CODE=9 AND COUNTY_CODE=15

--  For Illinois' Saint Clair, it should be St. Clair.
--  Virginia's "Bristol City" is the county's full name but for AQI, all
--    the counties use shortened name, so we will change to match that.
SELECT * FROM [21BI11_STAGE].[dbo].[2B_USCOUNTIES]
WHERE STATE_NAME='ILLINOIS' AND COUNTY_FULL LIKE '%CLAIR%'
UNION ALL
SELECT * FROM [21BI11_STAGE].[dbo].[2B_USCOUNTIES]
WHERE STATE_NAME='VIRGINIA' AND COUNTY_FULL LIKE '%BRISTOL%'

UPDATE [21BI11_STAGE].[dbo].[10_STATE_AQI]
SET COUNTY_NAME='St. Clair' WHERE STATE_CODE=17 AND COUNTY_CODE=163
UPDATE [21BI11_STAGE].[dbo].[10_STATE_AQI]
SET COUNTY_NAME='Bristol' WHERE STATE_CODE=51 AND COUNTY_CODE=520

--  Country of Mexico is not a state of the US so all its entries will be
--    removed during ETL to the NDS.
--  There is 1472 Mexico rows, so the final result should be,
--    194964 - 1472 = 193492.
SELECT * FROM [21BI11_STAGE].[dbo].[10_STATE_AQI] WHERE STATE_CODE=80

--  However, Virgin Islands is certainly in the US so we consider manually
--    creating data for it in the USCOUNTIES list, otherwise its AQI data
--    might be lost, and our estimate for US's air quality would be skewed.
--  Data for St Croix and St John will be compiled from multiple sources.
--    However, USPS doesn't have an abbrev. for Virgin Islands since it lies
--    outside the US's Customs Territory, but notice that there isn't a state
--    with an ID of "VI" in our current USCOUNTIES table, we will use that.
--      + https://about.usps.com/publications/pub14/pub14_ch7_004.htm
--      + https://en.wikipedia.org/wiki/Saint_Croix
--      + https://en.wikipedia.org/wiki/Saint_John,_U.S._Virgin_Islands
--      + https://en.wikipedia.org/wiki/United_States_Virgin_Islands
--      + https://latitude.to/map/vi/virgin-islands-us/cities/st-croix
--      + https://latitude.to/articles-by-country/vi/virgin-islands-us/4260/saint-john-us-virgin-islands
INSERT INTO [21BI11_STAGE].[dbo].[2B_USCOUNTIES] VALUES
    ('St. Croix', 'St. Croix', 'St. Croix County', '78010', 'VI', 'Virgin Islands', 17.7275, -64.747, 41004, GETDATE(), GETDATE(), 5),
    ('St. John', 'St. John', 'St. John County', '78020', 'VI', 'Virgin Islands', 18.3333, -64.7333, 3881, GETDATE(), GETDATE(), 5)

--  The current ones are "St Croix" and "St John", so alter to "St." for
--    conformity.
UPDATE [21BI11_STAGE].[dbo].[10_STATE_AQI]
SET COUNTY_NAME='St. Croix' WHERE STATE_CODE=78 AND COUNTY_CODE=10
UPDATE [21BI11_STAGE].[dbo].[10_STATE_AQI]
SET COUNTY_NAME='St. John' WHERE STATE_CODE=78 AND COUNTY_CODE=20

GO