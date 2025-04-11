-- Opprett en logg-tabell for inflasjonsoppdateringer
CREATE TABLE inflasjon_update (
    pass_id INTEGER,
    pass_cost NUMERIC,
    new_pass_cost NUMERIC,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Opprett trigger-funksjonen for logging
CREATE OR REPLACE FUNCTION log_update_inflation()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO inflasjon_update (
        pass_id,
        pass_cost,
        new_pass_cost,
        updated_at
    )
    VALUES (
        OLD.pass_id,
        OLD.pass_cost,
        NEW.pass_cost,
        NOW()
    );

    RAISE NOTICE 'Updated pass_id % with new cost %', OLD.pass_id, NEW.pass_cost;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Opprett triggeren som utløses etter oppdatering av pass_cost
CREATE OR REPLACE TRIGGER update_inflasjon
AFTER UPDATE OF pass_cost ON bc_pass
FOR EACH ROW
EXECUTE FUNCTION log_update_inflation();
