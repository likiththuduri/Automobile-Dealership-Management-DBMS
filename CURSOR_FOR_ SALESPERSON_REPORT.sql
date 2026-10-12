SET SERVEROUTPUT ON;
DECLARE
    CURSOR sales_cursor IS
        SELECT sp.Name,
               COUNT(s.Sale_ID) AS Cars_Sold,
               NVL(SUM(s.Sale_Price),0) AS Total_Sales
        FROM Salesperson sp
        LEFT JOIN Sale s ON sp.Salesperson_ID = s.Salesperson_ID
        GROUP BY sp.Salesperson_ID, sp.Name
        ORDER BY sp.Salesperson_ID;
BEGIN
    FOR rec IN sales_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(rec.Name || ' - Cars: ' || rec.Cars_Sold ||
                             ' - Sales: ' || rec.Total_Sales);
    END LOOP;
END;
/