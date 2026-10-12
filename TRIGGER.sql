CREATE OR REPLACE TRIGGER trg_vehicle_sold
AFTER INSERT ON Sale
FOR EACH ROW
BEGIN
    UPDATE Vehicle
    SET Status = 'SOLD'
    WHERE Vehicle_ID = :NEW.Vehicle_ID;
END;
/