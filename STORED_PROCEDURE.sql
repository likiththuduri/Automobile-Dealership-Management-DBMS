CREATE OR REPLACE PROCEDURE process_sale(
    p_sale_id        NUMBER,
    p_vehicle_id     NUMBER,
    p_customer_id    NUMBER,
    p_salesperson_id NUMBER,
    p_sale_price     NUMBER
) IS
    v_status VARCHAR2(15);
BEGIN
    SELECT Status INTO v_status
    FROM Vehicle
    WHERE Vehicle_ID = p_vehicle_id FOR UPDATE;

    IF v_status <> 'AVAILABLE' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Vehicle is not available');
    END IF;

    INSERT INTO Sale (Sale_ID, Vehicle_ID, Customer_ID, Salesperson_ID, Sale_Date, Sale_Price)
    VALUES (p_sale_id, p_vehicle_id, p_customer_id, p_salesperson_id, SYSDATE, p_sale_price);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Sale processed successfully. Sale ID: ' || p_sale_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20002, 'Vehicle ID not found');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/