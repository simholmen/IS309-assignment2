/* This file contains the PL/SQL code for the procedures

ADD_DOCK_SP. Add a new dock to the BC_DOCK table. The procedure
should take as input dock-related attributes and create a
new dock. This procedure is used when a new station is created to register
each of the stations docks.
PARAMETERS: described below
RETURNS:
ERROR MESSAGES:


Error text: "Missing mandatory value for parameter (x) in ADD_DOCK_SP.
No dock added."
Error meaning: A mandatory value is missing. Here x = the name of the
parameter whose value is missing.
Error effect: Because a mandatory value is not provided, no data are
inserted into the BC_DOCK table.
--

Error text: "Invalid station identifier (x)."
Error meaning: The value of the station identifier is not found in the BC_STATION table. Foreign key violation.
Here, x = the value of station id passed into the procedure.
Error effect: No new dock inserted into the BC_DOCK table.
--

Error text: "Invalid bicycle identifier (x)."
Error meaning: The value of the bicycle identifier parameter is not found in the BC_BICYCLE table.
Here, x = the value of bicycle identifier passed into the procedure.
Error effect: No new bicycle inserted into the BC_BICYCLE table.
--

Error text: "Invalid dock number (x)."
Error meaning: The dock numbers are integers starting with 1, 2, ... etc.
Here, x = the value of dock number passed into the procedure.
Error effect: No new dock inserted into the BC_DOCK table.
--

Error text: "Invalid dock status (x)."
Error meaning: The dock status must be one of 'occupied', 'out of service', 'unoccupied' Here, 
    x = the value of dock status passed into the procedure.
Error effect: No new dock inserted into the BC_DOCK table.
--

Error text: "Dock number (x) already exists."
Error meaning: There already exists a row in BC_DOCK with the dock number and station identifier. Here, x = the value
    of dock number passed into the procedure.
Error effect: No new dock inserted into the BC_DOCK table.
*/

create or replace procedure ADD_DOCK_SP (
p_station_id IN VARCHAR, -- Must not be NULL. Must match a station in BC_STATION table.
p_dock_id IN INTEGER, -- Must not be NULL. Small integer (1,2,3,...)
p_dock_status IN VARCHAR, -- Must not be NULL. Value must match check constraint.
p_bicycle_id IN INTEGER -- May be NULL. Any value must match existing value in BC_BICYCLE.
)
AS $$
BEGIN
    -- Check if mandatory values are provided
    IF p_station_id IS NULL THEN
        RAISE EXCEPTION 'Missing mandatory value for parameter (station_id) in ADD_DOCK_SP. No dock added.';
    END IF;
    IF p_dock_id IS NULL THEN
        RAISE EXCEPTION 'Missing mandatory value for parameter (dock_id) in ADD_DOCK_SP. No dock added.';
    END IF;
    IF p_dock_status IS NULL THEN
        RAISE EXCEPTION 'Missing mandatory value for parameter (dock_status) in ADD_DOCK_SP. No dock added.';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM bc_station WHERE station_id = p_station_id) THEN
        RAISE EXCEPTION 'Invalid station identifier';
    END IF;
    IF NOT EXISTS (SELECT 1 FROM bc_bicycle WHERE bicycle_id = p_bicycle_id) THEN
        RAISE EXCEPTION 'Invalid bicycle identifier';
    END IF;
	IF p_dock_id <= 0 THEN
		RAISE EXCEPTION 'Invalid dock number';
	END IF;
	IF p_dock_status NOT IN ('occupied', 'out of service', 'unoccupied') THEN
        RAISE EXCEPTION 'Invalid dock status %', p_dock_status;
    END IF;
    IF EXISTS (SELECT 1 FROM bc_dock WHERE dock_id = p_dock_id) 
    AND EXISTS (SELECT 1 FROM bc_station WHERE station_id = p_station_id) THEN
        RAISE EXCEPTION 'Dock number % already exists.', p_dock_id;
    END IF;

    INSERT INTO bc_dock(
        station_id,
        dock_id,
        dock_status,
        bicycle_id
    )
    VALUES (
        p_station_id,
        p_dock_id,
        p_dock_status,
        p_bicycle_id
    );

END;
$$ LANGUAGE plpgsql;
