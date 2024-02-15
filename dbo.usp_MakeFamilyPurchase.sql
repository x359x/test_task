CREATE PROC [dbo].[usp_MakeFamilyPurchase] @FamilySurName varchar(255)
AS 
DECLARE 
	@sum decimal(10,2);

IF @FamilySurName NOT IN (
SELECT
	SurName
FROM
	Family)
PRINT N'Такой семьи нет.'
ELSE
SELECT
	@sum = SUM(Basket.Value)
FROM
	Basket
INNER JOIN Family ON
	Basket.ID_Family = Family.ID
WHERE
	SurName = @FamilySurName;

IF @sum IS NOT NULL
BEGIN
UPDATE
	Family
SET
	BudgetValue = BudgetValue - @sum
WHERE
	SurName = @FamilySurName;
END;