CREATE OR REPLACE PROCEDURE CREATE_STATION_SP(
    IN p_station_id VARCHAR,
    IN p_station_name VARCHAR,
    IN p_station_short_name VARCHAR,
    IN p_latitude NUMERIC,
    IN p_longitude NUMERIC,
    IN p_address VARCHAR,
    IN p_postal_code VARCHAR,
    IN p_contact_phone VARCHAR,
    IN p_capacity INTEGER,
    IN p_vehicles_available INTEGER,
    IN p_docks_available INTEGER,
    IN p_is_renting NUMERIC,
    IN p_is_returning NUMERIC,
    IN p_last_report DATE,
    IN p_program_id VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Sjekk at obligatoriske verdier ikke er NULL
    IF p_station_id IS NULL OR p_station_name IS NULL OR p_latitude IS NULL 
       OR p_longitude IS NULL OR p_capacity IS NULL OR p_vehicles_available IS NULL 
       OR p_docks_available IS NULL OR p_is_renting IS NULL OR p_is_returning IS NULL 
       OR p_last_report IS NULL THEN
        RAISE EXCEPTION 'Manglende obligatorisk verdi i CREATE_STATION_SP. Ingen stasjon lagt til.';
    END IF;

    -- Sjekk gyldig breddegrad og lengdegrad
    IF p_latitude < -90 OR p_latitude > 90 THEN
        RAISE EXCEPTION 'Ugyldig breddegrad (%). Ingen stasjon lagt til.', p_latitude;
    END IF;

    IF p_longitude < -180 OR p_longitude > 180 THEN
        RAISE EXCEPTION 'Ugyldig lengdegrad (%). Ingen stasjon lagt til.', p_longitude;
    END IF;

    -- Sjekk om stasjonen allerede finnes
    IF EXISTS (SELECT 1 FROM BC_STATION WHERE STATION_ID = p_station_id) THEN
        RAISE EXCEPTION 'Stasjonen med ID % finnes allerede.', p_station_id;
    END IF;

    -- Sjekk om program-ID finnes i BC_PROGRAM
    IF NOT EXISTS (SELECT 1 FROM BC_PROGRAM WHERE PROGRAM_ID = p_program_id) THEN
        RAISE EXCEPTION 'Program-ID % finnes ikke.', p_program_id;
    END IF;

    -- Sjekk kapasitet
    IF p_vehicles_available + p_docks_available > p_capacity THEN
        RAISE EXCEPTION 'Kapasitet overskredet: Kjøretøy (%) + Dokker (%) > Kapasitet (%). Ingen stasjon lagt til.',
                        p_vehicles_available, p_docks_available, p_capacity;
    END IF;

    -- Sett inn ny stasjon
    INSERT INTO BC_STATION (
        STATION_ID, STATION_NAME, STATION_SHORT_NAME, LATITUDE, LONGITUDE, ADDRESS, 
        POSTAL_CODE, CONTACT_PHONE, CAPACITY, VEHICLES_AVAILABLE, DOCKS_AVAILABLE, 
        IS_RENTING, IS_RETURNING, LAST_REPORT, PROGRAM_ID
    ) VALUES (
        p_station_id, p_station_name, p_station_short_name, p_latitude, p_longitude, p_address,
        p_postal_code, p_contact_phone, p_capacity, p_vehicles_available, p_docks_available,
        p_is_renting, p_is_returning, p_last_report, p_program_id
    );

    -- Bekreft at innsettingen var vellykket
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Ingen stasjon lagt til.';
    END IF;
    
END;
$$;
