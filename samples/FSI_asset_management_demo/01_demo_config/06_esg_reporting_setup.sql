/* ESG Data Integration:
   For augmenting ESG analysis, data is sourced from the Snowflake Marketplace. Access this data through the following link: 
   https://app.snowflake.com/marketplace/listing/GZT0Z12DXAX4/gist-impact-sustainability-raw-data-disclosed-modelled-sample?businessNeed=12&pricing=free
   This dataset provides ESG metrics across up to 44 impact KPIs for 50 leading companies, distinguishing between company-disclosed data and GIST Impact models.*/


-- Views Creation for ESG Analysis:

-- Energy and Water Consumption View
CREATE OR REPLACE VIEW SNOW_INVEST.GOLD.EQUITY_ESG_ENERGY_WATER_CONSUMPTION_JOINED (
	LP,
	FUND,
	COMPANY_NAME,
	REPORTING_YEAR,
	CONSUMPTION_TOTAL_ENERGY,
	CONSUMPTION_TOTAL_WATER
) as
SELECT
    inv.LP,
    lpe.FUND,
    lpe.COMPANY_NAME,
    TO_DATE(esg.REPORTING_YEAR || '-01-01', 'YYYY-MM-DD') AS REPORTING_YEAR,
    SUM(esg.CONSUMPTION_TOTAL_ENERGY) AS CONSUMPTION_TOTAL_ENERGY,
    SUM(esg.CONSUMPTION_TOTAL_WATER) AS CONSUMPTION_TOTAL_WATER
FROM
    SNOW_INVEST.SILVER.LP_EQUITY AS lpe
JOIN
    SUSTAINABILITY_RAW_DATA_DISCLOSED__MODELLED__SAMPLE.MARKETPLACE_SAMPLE.GI_RAW_DATA AS esg ON lpe.COMPANY_NAME = esg.COMPANY_NAME
JOIN
    SNOW_INVEST.SILVER.LP_INVESTMENTS AS inv ON lpe.FUND = inv.FUND
GROUP BY
    inv.LP,
    lpe.FUND,
    lpe.COMPANY_NAME,
    esg.REPORTING_YEAR;

CREATE OR REPLACE VIEW SNOW_INVEST.GOLD.EQUITY_ESG_GENDER_DISTRIBUTION_JOINED(
	LP,
	FUND,
	COMPANY_NAME,
	REPORTING_YEAR,
	TOTAL_MALE_EMPLOYEES,
	TOTAL_FEMALE_EMPLOYEES,
	AVG_PERCENTAGE_FEMALE_EMPLOYEES
) as
SELECT
    inv.LP,
    lpe.FUND,
    lpe.COMPANY_NAME,
    TO_DATE(esg.REPORTING_YEAR || '-01-01', 'YYYY-MM-DD') AS REPORTING_YEAR,
    SUM(esg.NUMBER_OF_MALE_EMPLOYEES) AS TOTAL_MALE_EMPLOYEES,
    SUM(esg.NUMBER_OF_FEMALE_EMPLOYEES) AS TOTAL_FEMALE_EMPLOYEES,
    AVG(esg.PERCENTAGE_OF_FEMALE_EMPLOYEES) AS AVG_PERCENTAGE_FEMALE_EMPLOYEES
FROM
    SNOW_INVEST.SILVER.LP_EQUITY AS lpe
JOIN
    SUSTAINABILITY_RAW_DATA_DISCLOSED__MODELLED__SAMPLE.MARKETPLACE_SAMPLE.GI_RAW_DATA AS esg ON lpe.COMPANY_NAME = esg.COMPANY_NAME
JOIN
    SNOW_INVEST.SILVER.LP_INVESTMENTS AS inv ON lpe.FUND = inv.FUND
GROUP BY
    inv.LP,
    lpe.FUND,
    lpe.COMPANY_NAME,
    esg.REPORTING_YEAR;

CREATE OR REPLACE VIEW SNOW_INVEST.GOLD.EQUITY_ESG_GHG_EMISSIONS_SUMMARY_JOINED(
	LP,
	FUND,
	COMPANY_NAME,
	REPORTING_YEAR,
	SCOPE_1_EMISSIONS_TOTAL,
	SCOPE_2_EMISSIONS_LOCATION_BASED,
	SCOPE_2_EMISSIONS_MARKET_BASED,
	TOTAL_GHG_EMISSIONS_DIRECT_AND_INDIRECT_EMISSIONS
) as
SELECT
    inv.LP,
    lpe.FUND,
    lpe.COMPANY_NAME,
    TO_DATE(esg.REPORTING_YEAR || '-01-01', 'YYYY-MM-DD') AS REPORTING_YEAR,
    SUM(esg.SCOPE_1_EMISSIONS_TOTAL) AS SCOPE_1_EMISSIONS_TOTAL,
    SUM(esg.SCOPE_2_EMISSIONS_LOCATION_BASED) AS SCOPE_2_EMISSIONS_LOCATION_BASED,
    SUM(esg.SCOPE_2_EMISSIONS_MARKET_BASED) AS SCOPE_2_EMISSIONS_MARKET_BASED,
    SUM(esg.TOTAL_GHG_EMISSIONS_DIRECT_AND_INDIRECT_EMISSIONS) AS TOTAL_GHG_EMISSIONS_DIRECT_AND_INDIRECT_EMISSIONS
FROM
    SNOW_INVEST.SILVER.LP_EQUITY AS lpe
JOIN
    SUSTAINABILITY_RAW_DATA_DISCLOSED__MODELLED__SAMPLE.MARKETPLACE_SAMPLE.GI_RAW_DATA AS esg ON lpe.COMPANY_NAME = esg.COMPANY_NAME
JOIN
    SNOW_INVEST.SILVER.LP_INVESTMENTS AS inv ON lpe.FUND = inv.FUND
GROUP BY
    inv.LP,
    lpe.FUND,
    lpe.COMPANY_NAME,
    esg.REPORTING_YEAR;

CREATE OR REPLACE VIEW SNOW_INVEST.GOLD.EQUITY_ESG_WASTE_MANAGEMENT_JOINED(
	LP,
	FUND,
	COMPANY_NAME,
	REPORTING_YEAR,
	TOTAL_WASTE_GENERATED,
	RECOVERED_OR_RECYCLED_TOTAL_WASTE,
	WASTE_TO_LANDFILL,
	TOTAL_HAZARDOUS_WASTE_GENERATED,
	TOTAL_NON_HAZARDOUS_WASTE_GENERATED
) as
SELECT
    inv.LP,
    lpe.FUND,
    lpe.COMPANY_NAME,
    TO_DATE(esg.REPORTING_YEAR || '-01-01', 'YYYY-MM-DD') AS REPORTING_YEAR,
    SUM(esg.TOTAL_WASTE_GENERATED) AS TOTAL_WASTE_GENERATED,
    SUM(esg.RECOVERED_OR_RECYCLED_TOTAL_WASTE) AS RECOVERED_OR_RECYCLED_TOTAL_WASTE,
    SUM(esg.WASTE_TO_LANDFILL) AS WASTE_TO_LANDFILL,
    SUM(esg.TOTAL_HAZARDOUS_WASTE_GENERATED) AS TOTAL_HAZARDOUS_WASTE_GENERATED,
    SUM(esg.TOTAL_NON_HAZARDOUS_WASTE_GENERATED) AS TOTAL_NON_HAZARDOUS_WASTE_GENERATED
FROM
    SNOW_INVEST.SILVER.LP_EQUITY AS lpe
JOIN
    SUSTAINABILITY_RAW_DATA_DISCLOSED__MODELLED__SAMPLE.MARKETPLACE_SAMPLE.GI_RAW_DATA AS esg ON lpe.COMPANY_NAME = esg.COMPANY_NAME
JOIN
    SNOW_INVEST.SILVER.LP_INVESTMENTS AS inv ON lpe.FUND = inv.FUND
GROUP BY
    inv.LP,
    lpe.FUND,
    lpe.COMPANY_NAME,
    esg.REPORTING_YEAR;