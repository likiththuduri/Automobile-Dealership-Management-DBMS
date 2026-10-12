CREATE OR REPLACE FUNCTION calculate_emi(
    p_amount NUMBER,
    p_rate   NUMBER,
    p_months NUMBER
) RETURN NUMBER IS
    v_monthly_rate NUMBER;
    v_emi          NUMBER;
BEGIN
    IF p_amount <= 0 OR p_months <= 0 OR p_rate < 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Invalid loan parameters');
    END IF;

    v_monthly_rate := p_rate / (12 * 100);

    IF v_monthly_rate = 0 THEN
        v_emi := p_amount / p_months;
    ELSE
        v_emi := p_amount * v_monthly_rate *
                 POWER(1 + v_monthly_rate, p_months) /
                 (POWER(1 + v_monthly_rate, p_months) - 1);
    END IF;

    RETURN ROUND(v_emi, 2);
END;
/
