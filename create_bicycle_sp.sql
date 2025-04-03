create or replace procedure CREATE_BICYCLE_SP (
p_bicycle_id OUT INTEGER, -- an output parameter
p_bicycle_type IN VARCHAR, -- Must not be NULL.
p_capacity IN INTEGER,
p_make IN VARCHAR,
p_model IN VARCHAR,
p_color IN VARCHAR,
p_year_acquired IN INTEGER,
p_status IN VARCHAR, -- Must not be NULL
p_latitude IN INTEGER,
p_longitude IN INTEGER,
p_current_power IN NUMERIC, -- Must be between 0 and 100
p_current_range IN NUMERIC, -- Range in meters. Must not be a NEGATIV NUMPER
p_updated IN DATE
)

AS $$
BEGIN
	 IF p_bicycle_type IS NULL THEN 
    RAISE EXCEPTION 'Missing mandatory value for parameter bicycle_type in
	CREATE_BICYCLE_SP. No bicycle added';
    END IF;
	
	 IF p_status IS NULL THEN 
    RAISE EXCEPTION 'Missing mandatory value for parameter status in
	CREATE_BICYCLE_SP. No bicycle added';
    END IF;

	IF p_bicycle_type NOT IN ('classic', 'electric', 'cargo') THEN
	RAISE EXCEPTION 'Invalid bicycle Type %.', p_bicycle_type;
    END IF;


	IF NOT EXISTS (SELECT  1 FROM bc_bicycle_status WHERE bicycle_status = p_status) THEN
	RAISE EXCEPTION 'Invalid bicycle status %.', p_status;
    END IF;

	IF p_current_power <-1 OR  p_current_power>101 THEN
	RAISE EXCEPTION 'Invalid bicycle current power value %.',p_current_power;
    END IF;

	IF p_latitude <-91 OR  p_latitude>91 THEN
	RAISE EXCEPTION 'Invalid Latitude  %.',p_latitude;
    END IF;

	IF p_longitude <-181 OR  p_longitude>181 THEN
	RAISE EXCEPTION 'Invalid Longitude  %.',p_longitude;
    END IF;

	IF p_current_range <-1 THEN
	RAISE EXCEPTION 'Invalid bicycle rider capacity %.',p_current_range;
    END IF;
	
	Insert into bc_bicycle(bicycle_type,
	bicycle_rider_capacity,
	bicycle_make,
	bicycle_model,
	bicycle_color,
	bicycle_year_acquired,
	bicycle_status, 
	bicycle_latitude,
	bicycle_longitude,
	bicycle_current_power,
	bicycle_current_range,
	bicycle_status_updated)
	VALUES
	(p_bicycle_type, 
	p_capacity,
	p_make,
	p_model,
	p_color,
	p_year_acquired,
	p_status, 
	p_latitude,
	p_longitude,
	p_current_power,
	p_current_range,
	p_updated)
	
	RETURNING bicycle_id into p_bicycle_id;
	 RAISE NOTICE 'You have now registered bike %', p_bicycle_id;
	
	
END;
$$ LANGUAGE plpgsql
