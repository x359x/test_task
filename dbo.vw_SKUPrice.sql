CREATE VIEW [dbo].[vw_SKUPrice] (ID,
Code,
Name,
Sum) AS 
SELECT
	ID,
	Code,
	Name,
	[dbo].[udf_GetSKUPrice](ID)
FROM
	SKU
GROUP BY
	ID,
	Code,
	Name;