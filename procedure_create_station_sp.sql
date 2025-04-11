CREATE OR REPLACE PROCEDURE CREATE_STATION_SP(
    IN p_station_id VARCHAR, -- Must not be NULL.
    IN p_station_name VARCHAR, -- Must not be NULL.
    IN p_station_short_name VARCHAR,
    IN p_latitude NUMERIC, -- Must not be NULL
    IN p_longitude NUMERIC, -- Must not be NULL
    IN p_address VARCHAR,
    IN p_postal_code VARCHAR,
    IN p_contact_phone VARCHAR,
    IN p_capacity INTEGER, -- Must not be NULL
    IN p_vehicles_available INTEGER, -- Must not be NULL
    IN p_docks_available INTEGER, -- Must not be NULL
    IN p_is_renting NUMERIC, -- Must not be NULL.
    IN p_is_returning NUMERIC, -- Must not be NULL.
    IN p_last_report DATE, -- Must not be NULL
    IN p_program_id VARCHAR -- Must not be NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Check for mandatory values
    IF p_station_id IS NULL OR p_station_name IS NULL OR p_latitude IS NULL 
       OR p_longitude IS NULL OR p_capacity IS NULL OR p_vehicles_available IS NULL 
       OR p_docks_available IS NULL OR p_is_renting IS NULL OR p_is_returning IS NULL 
       OR p_last_report IS NULL THEN
        RAISE EXCEPTION 'Missing mandatory value in CREATE_STATION_SP. No station added.';
    END IF;

    -- Check for valid latitude and longitude values
    IF p_latitude < -90 OR p_latitude > 90 THEN
        RAISE EXCEPTION 'Invalid Latitude (%). No station added.', p_latitude;
    END IF;

    IF p_longitude < -180 OR p_longitude > 180 THEN
        RAISE EXCEPTION 'Invalid Longitude (%). No station added.', p_longitude;
    END IF;

    -- Check if the station already exists
    IF EXISTS (SELECT 1 FROM BC_STATION WHERE STATION_ID = p_station_id) THEN
        RAISE EXCEPTION 'Station with ID % already exists.', p_station_id;
    END IF;

    -- Check if the program ID exists in BC_PROGRAM
    IF NOT EXISTS (SELECT 1 FROM BC_PROGRAM WHERE PROGRAM_ID = p_program_id) THEN
        RAISE EXCEPTION 'Invalid Program (%). No station added.', p_program_id;
    END IF;

    -- Check capacity constraints
    IF p_vehicles_available + p_docks_available > p_capacity THEN
        RAISE EXCEPTION 'Capacity exceeded: Vehicles (%) + Docks (%) > Capacity (%). No station added.',
                        p_vehicles_available, p_docks_available, p_capacity;
    END IF;

    -- Insert new station into the database
    INSERT INTO BC_STATION (
        STATION_ID, STATION_NAME, STATION_SHORT_NAME, STATION_LATITUDE, STATION_LONGITUDE, STATION_ADDRESS, 
        STATION_POSTAL_CODE, STATION_CONTACT_PHONE, STATION_CAPACITY, STATION_VEHICLES_AVAILABLE, STATION_DOCKS_AVAILABLE, 
        STATION_IS_RENTING, STATION_IS_RETURNING, STATION_LAST_REPORTED, PROGRAM_ID
    ) VALUES (
        p_station_id, p_station_name, p_station_short_name, p_latitude, p_longitude, p_address,
        p_postal_code, p_contact_phone, p_capacity, p_vehicles_available, p_docks_available,
        p_is_renting, p_is_returning, p_last_report, p_program_id
    );

    -- Confirm that insertion was successful
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No station added.';
    END IF;
    
END;
$$;
