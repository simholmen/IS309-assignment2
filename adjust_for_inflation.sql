CREATE OR REPLACE FUNCTION ADJUST_FOR_INFLATION()
RETURNS TABLE (adjusted_cost NUMERIC) AS $$

BEGIN
	UPDATE bc_pass 
    SET pass_cost = ROUND(pass_cost * 1.10, 3);

	RETURN QUERY 
	SELECT pass_cost FROM bc_pass;

END;
$$ LANGUAGE plpgsql;