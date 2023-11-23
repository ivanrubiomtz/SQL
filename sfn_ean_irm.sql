CREATE  FUNCTION sfn_ean_irm
(    
    @barcode    varchar(20)
)
RETURNS CHAR(1)
AS
BEGIN
    DECLARE
        @chk_digit    int,
        @chk        int
 
    DECLARE    @num TABLE
    (
        num    int
    )
 
    IF    LEN(@barcode) NOT IN (7, 12)
    BEGIN
        RETURN     NULL
    END
 
    INSERT INTO @num 
    SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL  SELECT  5 UNION ALL SELECT  6 UNION ALL
    SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
 
    SELECT    @chk_digit = SUM(CONVERT(int, SUBSTRING(@barcode, LEN(@barcode) - num + 1, 1)) * CASE WHEN num % 2 = 1 THEN 3 ELSE 1 END)
    FROM    @num
    WHERE    num    <= LEN(@barcode)
 
    SELECT    @chk_digit = (10 - (@chk_digit % 10)) % 10
 
     RETURN  CHAR(ASCII('0') + @chk_digit)
END

--SELECT dbo.sfn_ean_IRM(770211180998)
