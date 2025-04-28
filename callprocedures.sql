--Purchase membership stored procedure
--This procedure will add a new membership to the BC_MEMBERSHIP table
CALL purchase_membership_sp(NULL, 'Heartland Monthly Pass', 20, DATE'2022-01-19', DATE'2022-01-19', 1)
--This procedure will add a new membership to the BC_Bicycle table
CALL create_bicycle_sp(NULL, 'classic',null, null, null, null, 2023, 'available', 40, 40,50, 50, null)

