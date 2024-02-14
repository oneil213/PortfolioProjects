
/*
2Market customers' purchase behaviour

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

SELECT "Country", 
SUM("AmtLiq" +"AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates"+ "AmtComm") AS "TotalAmountSpent"
FROM marketing_data
GROUP BY "Country"
ORDER BY "TotalAmountSpent" DESC;

--  Determining The total spend per country

SELECT "Country",
SUM ("AmtLiq") AS "TSpentLiq",
SUM ("AmtVege") AS "TSpentVege",
SUM ("AmtNonVeg") AS "TSpentNonVeg",
SUM ("AmtPes") AS "TSpentPes",
SUM ("AmtChocolates") AS "SpentChoc",
SUM ("AmtComm") AS "TSpentComm",
SUM ("AmtLiq" +"AmtVege" + "AmtNonVeg" + "AmtPes" + "AmtChocolates"+ "AmtComm") AS "TotalAmountSpent"
FROM marketing_data
GROUP BY "Country"
ORDER BY "TotalAmountSpent"DESC;

--  Determining The total spend per product per country

SELECT
  "Country",
  MAX("AmtLiq_count") AS "MaxAmtLiqCount",
  MAX("AmtPes_count") AS "MaxAmtPesCount",
  MAX("AmtVege_count") AS "MaxAmtVegeCount",
  MAX("AmtNonVeg_count") AS "MaxAmtNonVegCount",
  MAX("AmtChocolates_count") AS "MaxAmtChocolatesCount",
  MAX("AmtComm_count") AS "MaxAmtCommCount"
FROM
  (
    SELECT
      "Country",
      "AmtLiq_count",
      "AmtPes_count",
      "AmtVege_count",
	  "AmtNonVeg_count",
	  "AmtChocolates_count",
	  "AmtComm_count"
    FROM
     (
		SELECT
      "Country",
      COUNT( CASE WHEN "AmtLiq" <> '$0.00' THEN "AmtLiq" END) AS "AmtLiq_count",
      COUNT( CASE WHEN "AmtPes" <> '$0.00' THEN "AmtPes" END) AS "AmtPes_count",
      COUNT( CASE WHEN "AmtVege" <> '$0.00' THEN "AmtVege" END) AS "AmtVege_count",
      COUNT( CASE WHEN "AmtNonVeg" <> '$0.00' THEN "AmtNonVeg" END) AS "AmtNonVeg_count",
	  COUNT( CASE WHEN "AmtChocolates" <> '$0.00' THEN "AmtChocolates" END) AS "AmtChocolates_count",
      COUNT( CASE WHEN "AmtComm" <> '$0.00' THEN "AmtComm" END) AS "AmtComm_count"
    FROM
      "marketing_data"
    GROUP BY
      "Country"
	 
	 ) AS "boo"
  ) AS "foo"
GROUP BY
  "Country"
ORDER BY
  "MaxAmtLiqCount" DESC,
  "MaxAmtPesCount" DESC,
  "MaxAmtNonVegCount" DESC,
  "MaxAmtCommCount" DESC,
  "MaxAmtChocolatesCount" DESC,
  "MaxAmtVegeCount" DESC;
  
  --  Determining Which products are the most popular in each country
  
  SELECT
  "MaritalStatus",
  MAX("AmtLiq_count") AS "MaxAmtLiqCount",
  MAX("AmtPes_count") AS "MaxAmtPesCount",
  MAX("AmtVege_count") AS "MaxAmtVegeCount",
  MAX("AmtNonVeg_count") AS "MaxAmtNonVegCount",
  MAX("AmtChocolates_count") AS "MaxAmtChocolatesCount",
  MAX("AmtComm_count") AS "MaxAmtCommCount"
FROM
  (
    SELECT
      "MaritalStatus",
      "AmtLiq_count",
      "AmtPes_count",
      "AmtVege_count",
	  "AmtNonVeg_count",
	  "AmtChocolates_count",
	  "AmtComm_count"
    FROM
     (
		SELECT
      "MaritalStatus",
      COUNT( CASE WHEN "AmtLiq" <> '$0.00' THEN "AmtLiq" END) AS "AmtLiq_count",
      COUNT( CASE WHEN "AmtPes" <> '$0.00' THEN "AmtPes" END) AS "AmtPes_count",
      COUNT( CASE WHEN "AmtVege" <> '$0.00' THEN "AmtVege" END) AS "AmtVege_count",
      COUNT( CASE WHEN "AmtNonVeg" <> '$0.00' THEN "AmtNonVeg" END) AS "AmtNonVeg_count",
	  COUNT( CASE WHEN "AmtChocolates" <> '$0.00' THEN "AmtChocolates" END) AS "AmtChocolates_count",
      COUNT( CASE WHEN "AmtComm" <> '$0.00' THEN "AmtComm" END) AS "AmtComm_count"
    FROM
      "marketing_data"
    GROUP BY
      "MaritalStatus"
	 
	 ) AS "boo"
  ) AS "foo"
GROUP BY
  "MaritalStatus"
ORDER BY
  "MaxAmtLiqCount" DESC,
  "MaxAmtPesCount" DESC,
  "MaxAmtNonVegCount" DESC,
  "MaxAmtCommCount" DESC,
  "MaxAmtChocolatesCount" DESC,
  "MaxAmtVegeCount" DESC;
  
 --  Determining Which products are the most popular based on marital status
 
 SELECT
(CASE WHEN "Dependants" = 0 THEN 'WithoutDependants' ELSE 'WithDependants' END) AS "Dependants_group",
 SUM("AmtLiq_count") AS "Alcoholic beverages",
 SUM("AmtPes_count") AS "Fish products",
 SUM("AmtVege_count") AS "Vegetables",
 SUM("AmtNonVeg_count") AS "Meat items",
 SUM("AmtChocolates_count") AS "Chocolates",
 SUM("AmtComm_count") AS "Commodities"
FROM (
	SELECT
      m."Kidhome" + m."Teenhome" AS "Dependants",
      COUNT( CASE WHEN "AmtLiq" <> '$0.00' THEN "AmtLiq" END) AS "AmtLiq_count",
      COUNT( CASE WHEN "AmtPes" <> '$0.00' THEN "AmtPes" END) AS "AmtPes_count",
      COUNT( CASE WHEN "AmtVege" <> '$0.00' THEN "AmtVege" END) AS "AmtVege_count",
      COUNT( CASE WHEN "AmtNonVeg" <> '$0.00' THEN "AmtNonVeg" END) AS "AmtNonVeg_count",
	  COUNT( CASE WHEN "AmtChocolates" <> '$0.00' THEN "AmtChocolates" END) AS "AmtChocolates_count",
      COUNT( CASE WHEN "AmtComm" <> '$0.00' THEN "AmtComm" END) AS "AmtComm_count"
    FROM
      "marketing_data" m
    GROUP BY
      "Dependants"
) AS foo
GROUP BY "Dependants_group";

--  Determining Which products are the most popular based on whether or not there are children or teens in the home.

CREATE TABLE two_martket
AS
SELECT *
FROM ad_data
LEFT JOIN marketing_data
USING("ID")

 --  Using the appropriate SQL queries to join the tables

CREATE TABLE two_martket
AS
SELECT *
FROM ad_data
LEFT JOIN marketing_data
USING("ID")

 --  creating new table using a LEFT join considering data population on each table to assign the left table
 
SELECT "Country", 
SUM("Bulkmail_ad") AS "Bulk_leads", 
SUM("Twitter_ad") AS "Twit_leads",
SUM("Instagram_ad") AS "Insta_leads", 
SUM("Facebook_ad") AS "Face_leads",
SUM("Brochure_ad") AS "Brochure_leads"
FROM two_market
GROUP BY "Country"
ORDER BY 1

-- Determining which social media platform is the most effective method of advertising in each country

SELECT "MaritalStatus", 
SUM("Bulkmail_ad") AS "Bulk_leads", 
SUM("Twitter_ad") AS "Twit_leads",
SUM("Instagram_ad") AS "Insta_leads", 
SUM("Facebook_ad") AS "Face_leads",
SUM("Brochure_ad") AS "Brochure_leads"
FROM two_market
GROUP BY "MaritalStatus"
ORDER BY 1

-- Determining Which social media platform is the most effective method of advertising based on marital status?

SELECT "Country" , 
SUM("AmtLiq") AS "TAmtLiq", 
SUM("AmtVege") AS "TAmtVege", 
SUM("AmtNonVeg") AS "TAmtNonVeg", 
SUM("AmtPes") AS "TAmtPes", 
SUM("AmtChocolates") AS "TAmChoco", 
SUM("AmtComm") AS "TAmtComm",
COUNT("Bulkmail_ad") AS "TBulk_Ads", 
COUNT("Twitter_ad") AS "TTwit_Ads",
COUNT("Instagram_ad") AS "TInsta_Ads", 
COUNT("Facebook_ad") AS "TFace_Ads",
COUNT("Brochure_ad") AS "TBrochure_Ads"
FROM two_market
GROUP BY "Country"
ORDER BY 1

-- Determining Which social media platform(s) seem to be the most effective per country?
