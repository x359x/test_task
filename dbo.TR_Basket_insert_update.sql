CREATE TRIGGER [dbo].[TR_Basket_insert_update] ON
[dbo].[Basket]
INSTEAD OF
INSERT
	AS 
IF EXISTS(
	SELECT
		ID_SKU,
		COUNT(ID_SKU)
	FROM
		inserted
	GROUP BY
		ID_SKU
	HAVING
		COUNT(ID_SKU)>1)
BEGIN
INSERT
	INTO
	Basket (ID_SKU,
	ID_Family,
	Quantity,
	Value,
	DiscountValue,
	PurchaseDate)
SELECT
	ID_SKU,
	ID_Family,
	Quantity,
	Value,
	Value * 0.05,
	PurchaseDate
FROM
	inserted
WHERE
	ID_SKU IN (
	SELECT
		ID_SKU
	FROM
		inserted
	GROUP BY
		ID_SKU
	HAVING
		COUNT(ID_SKU)>1);

INSERT
	INTO
	Basket (ID_SKU,
	ID_Family,
	Quantity,
	Value,
	DiscountValue,
	PurchaseDate)
SELECT
	ID_SKU,
	ID_Family,
	Quantity,
	Value,
	0,
	PurchaseDate
FROM
	inserted
WHERE
	ID_SKU NOT IN (
	SELECT
		ID_SKU
	FROM
		inserted
	GROUP BY
		ID_SKU
	HAVING
		COUNT(ID_SKU)>1)
END;
ELSE 
BEGIN
INSERT
	INTO
	Basket (ID_SKU,
	ID_Family,
	Quantity,
	Value,
	DiscountValue,
	PurchaseDate)
SELECT
	ID_SKU,
	ID_Family,
	Quantity,
	Value,
	0,
	PurchaseDate
FROM
	inserted;
END;