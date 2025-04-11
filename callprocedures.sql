--Purchase membership stored procedure
--This procedure will add a new membership to the BC_MEMBERSHIP table
CALL purchase_membership_sp(NULL, 'Heartland Monthly Pass', 20, DATE'2022-01-19', DATE'2022-01-19', 1)

