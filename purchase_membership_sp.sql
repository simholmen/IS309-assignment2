CREATE OR REPLACE PROCEDURE PURCHASE_MEMBERSHIP_SP(
p_membership_id OUT INTEGER, -- an output parameter
p_pass_type IN VARCHAR, -- Must not be NULL. Must match a pass_type value IN BC_PASS
p_pass_total IN NUMERIC, -- Must not be NULL
p_start_time IN DATE, -- Must not be NULL
p_end_time IN DATE, -- Must not be NULL. In a more sophisticated vesion of this procedure,
-- we could have the end time calculated based on the pass type.
p_account_id IN INTEGER -- Must not be NULL. Must match an account_id value in BC_ACCOUNT
)

AS $$
BEGIN
IF p_pass_type IS NULL THEN
RAISE EXCEPTION 'Missing mandatory value for parameter p_pass_type in PURCHASE_MEMBERSHIP_SP.  No membership added.' ;
END IF;

IF p_pass_total IS NULL THEN
	RAISE EXCEPTION 'Missing mandatory value for parameter p_pass_ttotal in PURCHASE_MEMBERSHIP_SP.  No membership added.';
END IF;

IF p_start_time IS NULL THEN
	RAISE EXCEPTION 'Missing mandatory value for parameter p_start_time in PURCHASE_MEMBERSHIP_SP.  No membership added.';
END IF;

IF p_end_time IS NULL THEN
	RAISE EXCEPTION 'Missing mandatory value for parameter p_end_time in PURCHASE_MEMBERSHIP_SP.  No membership added.';
END IF;

IF p_account_id IS NULL THEN
	RAISE EXCEPTION 'Missing mandatory value for parameter p_account_id in PURCHASE_MEMBERSHIP_SP.  No membership added.';
END IF;

IF NOT EXISTS (SELECT 1 FROM BC_PASS WHERE pass_type = p_pass_type) THEN
	RAISE EXCEPTION 'invalid membership pass type (%).', p_pass_type;
END IF;

IF NOT EXISTS (SELECT 1 FROM BC_ACCOUNT WHERE account_id = p_account_id) THEN
	RAISE EXCEPTION 'invalid account (%).', p_account_id;
END IF;
	
INSERT INTO BC_MEMBERSHIP (member_pass_total, member_pass_start_time, member_pass_end_time, account_id)
VALUES (p_pass_total, p_start_time, p_end_time, p_account_id)
RETURNING membership_id INTO p_membership_id;

END;
$$ LANGUAGE plpgsql;
