-- Opprett trigger-funksjonen 
CREATE OR REPLACE FUNCTION log_membership_update()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'New update on table % at % with operation %', TG_TABLE_NAME, current_timestamp, TG_OP;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Opprett trigger som utløsen når noen gjør endiringer på bc_membership
CREATE OR REPLACE TRIGGER trigger_log_membership_update
AFTER INSERT OR UPDATE OR DELETE ON bc_membership
FOR EACH STATEMENT
EXECUTE FUNCTION log_membership_update();