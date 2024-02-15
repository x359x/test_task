CREATE FUNCTION [dbo].[udf_GetSKUPrice](@ID_SKU int) RETURNS DECIMAL(18,2)
AS
BEGIN
	DECLARE
        @res decimal (18, 2);

SELECT
	@res = (SUM(Value)/ SUM(Quantity))
FROM
	Basket
WHERE
	ID_SKU = @ID_SKU;

IF @res IS NULL
    SET
@res = 0;

RETURN @res;
END;