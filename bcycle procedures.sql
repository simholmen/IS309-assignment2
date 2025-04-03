/* 
CREATE_ACCOUNT_SP.  Add a new account to the BC_ACCOUNT table. The procedure should take as input account-related attributes 
and create a new account.  The procedure returns the identifier of the new account.

PARAMETERS: described below
RETURNS:    the identifier for the new account, using the p_account_id output parameter.
ERROR MESSAGES:
    Error text:  "Missing mandatory value for parameter (x) in CREATE_ACCOUNT_SP.  No account added."
    Error meaning:  A mandatory value is missing.  Here x = the name of the parameter whose value is missing.
    Error effect:  Because a mandatory value is not provided, no data are inserted into the CP_ACCOUNT table.  The 
       p_account_id value returned is NULL.
       
    Error text: "Duplicate email address.  Account email addresses must be unique."
    Error meaning:  The email address provided has already been associated with another account.
    Error effect:  No new account inserted into the BC_ACCOUNT table.  The value of p_account_id returned is NULL.
*/

create or replace procedure CREATE_ACCOUNT_SP (
    p_account_id            OUT INTEGER,        -- an output parameter
    p_account_first_name    IN VARCHAR,         -- Must not be NULL
    p_account_last_name     IN VARCHAR,         -- Must not be NULL
    p_account_email         IN VARCHAR,         -- Must be unique
    p_account_password      IN VARCHAR,         -- Must not be NULL
    p_account_mobile_phone  IN VARCHAR,         -- Must not be NULL
    p_account_street        IN VARCHAR,         -- Must not be NULL
    p_account_apartment     IN VARCHAR,
    p_account_city          IN VARCHAR,         -- Must not be NULL
    p_account_state_province IN VARCHAR,       -- Must not be NULL
    p_account_postal_code   IN VARCHAR         -- Must not be NULL
    )
IS
BEGIN
    NULL;
END CREATE_ACCOUNT_SP;
/

/* 
PURCHASE_MEMBERSHIP_SP.  Add a new membership to the BC_MEMBERSHIP table.  Given an account and membership-related attributes 
add the membership to the account.  The procedure returns the identifier of the new membership.

PARAMETERS: described below
RETURNS:    the identifier for the new membership, using the p_membership_id output parameter.
ERROR MESSAGES:
    Error text:  "Missing mandatory value for parameter (x) in PURCHASE_MEMBERSHIP_SP.  No membership added."
    Error meaning:  A mandatory value is missing.  Here x = the name of the parameter whose value is missing.
    Error effect:  Because a mandatory value is not provided, no data are inserted into the BC_MEMBERSHIP table.  The 
       p_membership_id value returned is NULL.
       
    Error text: "Invalid membership pass type (x)."
    Error meaning:  The value of the pass_type parameter is not found in the BC_PASS table.  Foreign key violation.  Here,
                    x = the value of pass_type passed into the procedure.
    Error effect:  No new membership inserted into the BC_MEMBERSHIP table.  The value of p_membership_id returned is NULL.
    
    Error text: "Invalid account (x)."
    Error meaning:  The value of the account_id parameter is not found in the BC_ACCOUNT table.  Foreign key violation.  Here,
                    x = the value of account_id passed into the procedure.
    Error effect:  No new membership inserted into the BC_MEMBERSHIP table.  The value of p_membership_id returned is NULL.
    
    Error text: "Invalid pass (x)."
    Error meaning:  The value of the pass_id parameter is not found in the BC_PASS table.  Foreign key violation.  Here,
                    x = the value of pass_id passed into the procedure.
    Error effect:  No new membership inserted into the BC_MEMBERSHIP table.  The value of p_membership_id returned is NULL.

*/

create or replace procedure PURCHASE_MEMBERSHIP_SP (
    p_membership_id         OUT INTEGER,        -- an output parameter
    p_pass_type             IN VARCHAR,         -- Must not be NULL.   Must match a pass_type value in BC_PASS
    p_pass_total            IN NUMBER,          -- Must not be NULL
    p_start_time            IN DATE,            -- Must not be NULL
    p_end_time              IN DATE,            -- Must not be NULL.   In a more sophisticated vesion of this procedure, 
                                                -- we could have the end time calculated based on the pass type.
    p_account_id            IN INTEGER          -- Must not be NULL.  Must match an account_id value in BC_ACCOUNT
    )
IS
BEGIN
    NULL;
END PURCHASE_MEMBERSHIP_SP;
/

/* 
CREATE_STATION_SP.  Add a new station to the BC_STATION table.  The procedure should take as input station-related attributes 
and create a new station.  

PARAMETERS: described below
RETURNS:    
ERROR MESSAGES:
    Error text:  "Missing mandatory value for parameter (x) in CREATE_STATION_SP.  No station added."
    Error meaning:  A mandatory value is missing.  Here x = the name of the parameter whose value is missing.
    Error effect:  Because a mandatory value is not provided, no data are inserted into the BC_STATION table.  
       
    Error text: "Invalid Program (x)."
    Error meaning:  The value of the program_id parameter is not found in the BC_PROGRAM table.  Foreign key violation.  Here,
                    x = the value of program id passed into the procedure.
    Error effect:  No new station inserted into the BC_STATION table.  
    
    Error text: "Invalid Latitude (x)."
    Error meaning:  The value of the p_latitude parameter is not within the range of valid latitude values (between -90 and 90).    
                   Here, x = the value of p_latitude parameter passed into the procedure.
    Error effect:  No new station inserted into the BC_STATION table.  
    
    Error text:  "Invalid longitude (x)."
    Error meaning:  The value of the p_longitiude parameter is not within the range of valid longitude values (between -180 and 180).    
                   Here, x = the value of p_longitude parameter passed into the procedure.
    Error effect:  No new station inserted into the BC_STATION table.  
    
    Error text:     "Capacity exceeded.  The sum of the number of vehicles (x) and available docks (y) exceeds the capacity 
                    (z) of the station."
    Error meaning:  A station has a finite capacity.  The sum of the number of vehicles available and the number of docks
                    available should equal the capacity of the station.
    Error effect:   No new station created.
                    

*/

create or replace procedure CREATE_STATION_SP (
    p_station_id            IN VARCHAR,         -- Must not be NULL.  
    p_station_name          IN VARCHAR,         -- Must not be NULL.
    p_station_short_name    IN VARCHAR,
    p_latitude              IN NUMBER,          -- Must not be NULL
    p_longitude             IN NUMBER,          -- Must not be NULL
    p_address               IN VARCHAR,
    p_postal_code           IN VARCHAR,
    p_contact_phone         IN VARCHAR, 
    p_capacity              IN INTEGER,         -- Must not be NULL
    p_vehicles_available    IN INTEGER,         -- Must not be NULL
    p_docks_available       IN INTEGER,         -- Must not be NULL
    p_is_renting            IN NUMBER,            -- Must not be NULL.  
    p_is_returning          IN NUMBER,            -- Must not be NULL.
    p_last_report           IN DATE,            -- Must not be NULL
    p_program_id            IN VARCHAR          -- Must not be NULL
    )
IS
BEGIN
    NULL;
END CREATE_STATION_SP;
/
/* 
CREATE_BICYCLE_SP.  Add a new bicycle to the BC_BICYCLE table.  The procedure should take as input bicycle-related attributes 
and create a new bicycle.  The procedure returns the identifier of the new bicycle.

PARAMETERS: described below
RETURNS:    new bicycle identifier
ERROR MESSAGES:
    Error text:  "Missing mandatory value for parameter (x) in CREATE_BICYCLE_SP.  No bicycle added."
    Error meaning:  A mandatory value is missing.  Here x = the name of the parameter whose value is missing.
    Error effect:  Because a mandatory value is not provided, no data are inserted into the BC_BICYCLE table.  
       
    Error text: "Invalid bicycle type (x)."
    Error meaning:  The value of the bicycle type parameter is not one of the values permitted by the CHECK constraint on 
                    bicycle_type.  Here, x = the value of bicycle type passed into the procedure.
    Error effect:  No new bicycle inserted into the BC_BICYCLE table.  
    
    Error text: "Invalid bicycle status (x)."
    Error meaning:  The value of the bicycle status parameter is not one of the values permitted by the CHECK constraint on 
                    bicycle_type.  Here, x = the value of bicycle status passed into the procedure.
    Error effect:  No new bicycle inserted into the BC_BICYCLE table.  
    
    Error text: "Invalid bicycle current power value (x)."
    Error meaning:  The value of the bicycle current power  parameter is not a value between 0 and 100.  Here, x = the value 
                    of bicycle current power  passed into the procedure.
    Error effect:  No new bicycle inserted into the BC_BICYCLE table.  
     
    Error text: "Invalid Latitude (x)."
    Error meaning:  The value of the p_latitude parameter is not within the range of valid latitude values (between -90 and 90).    
                   Here, x = the value of p_latitude parameter passed into the procedure.
    Error effect:  No new bicycle inserted into the BC_BICYCLE table.  
    
    Error text:  "Invalid longitude (x)."
    Error meaning:  The value of the p_longitiude parameter is not within the range of valid longitude values (between -180 and 180).    
                   Here, x = the value of p_longitude parameter passed into the procedure.
    Error effect:  No new bicycle inserted into the BC_BICYCLE table.  
    
    Error text:     "Invalid bicycle rider capacity (x)"
    Error meaning:  A bicycle rider capacity less than zero has been passed to the procedure.  Here, x = the value of the rider 
                    capacity passed into the procedure.
    Error effect:   No new bicycle created.
                    

*/

create or replace procedure CREATE_BICYCLE_SP (
    p_bicycle_id            OUT INTEGER,        -- an output parameter
    p_bicycle_type          IN VARCHAR,         -- Must not be NULL.
    p_capacity              IN INTEGER, 
    p_make                  IN VARCHAR,
    p_model                 IN VARCHAR,
    p_color                 IN VARCHAR,
    p_year_acquired         IN INTEGER,
    p_status                IN VARCHAR,         -- Must not be NULL
    p_latitude              IN INTEGER, 
    p_longitude             IN INTEGER,
    p_current_power         IN NUMBER,          -- Must be between 0 and 100
    p_current_range         IN NUMBER,          -- Range in meters.  Must not be a negative number
    p_updated               IN DATE             
    )
IS
BEGIN
    NULL;
END CREATE_BICYCLE_SP;
/

/* 
ADD_DOCK_SP.  Add a new dock to the BC_DOCK table.  The procedure should take as input dock-related attributes and create a 
new dock.  This procedure is used when a new station is created to register each of the station�s docks.

PARAMETERS: described below
RETURNS:    
ERROR MESSAGES:
    Error text:  "Missing mandatory value for parameter (x) in ADD_DOCK_SP.  No dock added."
    Error meaning:  A mandatory value is missing.  Here x = the name of the parameter whose value is missing.
    Error effect:  Because a mandatory value is not provided, no data are inserted into the BC_DOCK table.  
       
    Error text: "Invalid station identifier (x)."
    Error meaning:  The value of the station identifier is not found in the BC_STATION table.  Foreign key violation.  
                Here, x = the value of station id passed into the procedure.
    Error effect:  No new dock inserted into the BC_DOCK table.  
    
    Error text: "Invalid bicycle identifier (x)."
    Error meaning:  The value of the bicycle identifier parameter is not found in the BC_BICYCLE table.  
                Here, x = the value of bicycle identifier passed into the procedure.
    Error effect:  No new bicycle inserted into the BC_BICYCLE table.  
    
    Error text: "Invalid dock number (x)."
    Error meaning:  The dock numbers are integers starting with 1, 2, ... etc.  Here, x = the value 
                    of dock number passed into the procedure.
    Error effect:  No new dock inserted into the BC_DOCK table.  
    
    Error text: "Invalid dock status (x)."
    Error meaning:  The dock status must be one of 'occupied', 'out of service', 'unoccupied'  Here, x = the value 
                    of dock status passed into the procedure.
    Error effect:  No new dock inserted into the BC_DOCK table.  
    


    Error text: "Dock number (x) already exists."
    Error meaning:  There already exists a row in BC_DOCK with the dock number and station identifier.  Here, x = the value 
                    of dock number passed into the procedure.
    Error effect:  No new dock inserted into the BC_DOCK table.  
     
*/

create or replace procedure ADD_DOCK_SP (
    p_station_id            IN VARCHAR,         -- Must not be NULL.  Must match a station in BC_STATION table.
    p_dock_id               IN INTEGER,         -- Must not be NULL.  Small integer (1,2,3,...)
    p_dock_status           IN VARCHAR,         -- Must not be NULL.  Value must match check constraint. 
    p_bicycle_id            IN INTEGER          -- May be NULL. Any value must match existing value in BC_BICYCLE.
    )
IS
BEGIN
    NULL;
END ADD_DOCK_SP;
/

/* 
START_TRIP_SP.  Add a new trip to the BC_TRIP table.  When a trip begins, the bicycle, start station, and applicable membership 
are recorded. The procedure 

* updates the BC_DOCK and BC_STATION tables to reflect the change in dock status and any change in the station returning and 
  renting status. For example, the status of the dock at which the bicycle had been parked will be set to 'available'.  
* determines the start station.  The start station is not passed in as a parameter.  The start station will be determined by 
  the procedure by determining the station associated with the dock at which the bicycle is currently docked.  
* updates the station status.  If the station had been full (station_is_returning = 0) then station_is_returning is set to true 
  (1). 
* updates the status of the bicycle to 'in use'.
* returns the identifier of the new trip.

PARAMETERS: described below
RETURNS:    new trip identifier
ERROR MESSAGES:
    Error text:  "Missing mandatory value for parameter (x) in BEGIN_TRIP_SP.  No trip added."
    Error meaning:  A mandatory value is missing.  Here x = the name of the parameter whose value is missing.
    Error effect:  Because a mandatory value is not provided, no data are inserted into the BC_TRIP table.  
       
    Error text: "Invalid membership (x)."
    Error meaning:  The indicated membership is either not found in the BC_MEMBERSHIP table, or the trip start time passed 
                into the procedure is not between the member pass start time and member pass end time for this membership.  
                Here, x = the value of station id passed into the procedure.
    Error effect:  No new trip inserted into the BC_TRIP table.  
    
    Error text: "Invalid bicycle identifier (x)."
    Error meaning:  The value of the bicycle identifier parameter is not found in the BC_BICYCLE table.  
                Here, x = the value of bicycle identifier passed into the procedure.
    Error effect:  No new trip inserted into the BC_TRIP table.  
    
    Error text: "Bicycle (x) is not currently docked."
    Error meaning:  The indicated bicycle is not currently docked anywhere (is not found in the bicycle_id column in the BC_DOCK
                    table) and therefore cannot be used to start a trip.  Here, x = the value of dock number passed into the procedure.
    Error effect:  No new dock inserted into the BC_DOCK table.  
    
*/

create or replace procedure BEGIN_TRIP_SP (
    p_trip_id               OUT INTEGER,        -- an output parameter
    p_bicycle_id            IN INTEGER,         -- Must not be NULL.  Must match value value in BC_BICYCLE and BC_DOCK tables.
    p_start_time            IN DATE,            -- If NULL, use CURRENT_DATE system date value
    p_membership_id         IN INTEGER          -- Must not be NULL.  Must match value in BC_MEMBERSHIP table.
    )
IS
BEGIN
    NULL;
END BEGIN_TRIP_SP;
/

/* 
END_TRIP_SP.  Update an existing trip to indicate the trip end time, duration, distance, cost, and end station.  
The procedure also updates the BC_DOCK and BC_STATION to reflect changes in status.

The procedure 
* Find the trip identifier for the current trip using the indicated bicycle
* checks to determine whether the indicated dock is unoccupied, and throws an error if it is not.  
* Calculates the duration of the trip by taking the difference between the end time and the start time
* updates the BC_DOCK and BC_STATION tables to reflect the change in dock status and any change in the station returning and 
  renting status. For example, if the dock is unoccupied, update the bicycle_id column for the dock to be equal to the 
  identifier of the bicycle and change the dock status to 'occupied'.
* updates the station status.  If all of the docks associated with the end station are now occupied or out of service, then 
  station_is_returning is set to false (0).  The station_is_renting is set to true (1).  
* updates the status of the bicycle to 'available'.

PARAMETERS: described below
RETURNS:    identifier of the trip just completed
ERROR MESSAGES:
    Error text:  "Missing mandatory value for parameter (x) in BEGIN_TRIP_SP.  Trip not ended."
    Error meaning:  A mandatory value is missing.  Here x = the name of the parameter whose value is missing.
    Error effect:  Because a mandatory value is not provided, no data are updated into the BC_TRIP table.  
       
    Error text: "Invalid bicycle identifier (x)."
    Error meaning:  The value of the bicycle identifier parameter is not found in the BC_BICYCLE table.  
                Here, x = the value of bicycle identifier passed into the procedure.
    Error effect:  No new trip inserted into the BC_TRIP table.  
    
    Error text: "Dock not available."
    Error meaning:  The indicated docking point is not 'unoccupied' or is not recognized and therefore cannot be used to end 
                the trip.  Here, x = the value of dock number passed into the procedure.
    Error effect:  No updates made to the trip.
    
    Error text:  "Error in return time.  End time (x) cannot be earlier than start time (y)."  
    Error meaning:  The end time comes before the start time.
    Error effect:  No updates made to the trip.
    
*/

create or replace procedure END_TRIP_SP (
    p_trip_id               OUT INTEGER,        -- Return the identifier of the trip completed
    p_bicycle_id            IN INTEGER,         -- Must not be NULL.  Must match value value in BC_BICYCLE and BC_DOCK tables.
    p_station_id            IN VARCHAR,         -- The station where the trip ends
    p_dock_id               IN INTEGER,         -- The number of the docking point where the trip ends
    p_end_time              IN DATE,            -- If NULL, use CURRENT_DATE system date value
    p_distance              IN NUMBER,
    p_cost                  IN NUMBER
    )
IS
BEGIN
    NULL;
END END_TRIP_SP;
/
