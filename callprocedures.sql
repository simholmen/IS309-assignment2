--Purchase membership stored procedure
--This procedure will add a new membership to the BC_MEMBERSHIP table
CALL purchase_membership_sp(NULL, 'Heartland Monthly Pass', 20, DATE'2022-01-19', DATE'2022-01-19', 1)
--This procedure will add a new bicycle to the BC_Bicycle table
CALL create_bicycle_sp(NULL, 'classic',null, null, null, null, 2023, 'available', 40, 40,50, 50, null)
--This procedure will add a new account to the BC_Account table
CALL create_account_sp( null, 'ola','normand','ola.normand@email.com','1234', '47474747', 'Norges vei 5',null, 'Stavanger','Rogaland','4022')
--This procedure will call add_dock_sp to add a new dock to the BC_Dock table
CALL add_dock_sp('bcycle_heartland_1917', 26, 'occupied', 1003)
--This procedure will add a new station to the BC_Station table
CALL create_station_sp('test6', 'Heartland Station', 'C123', 59.9139, 10.7522, 'Norges vei 5', '4022', '47474748', 50, 10, 40, 1, 1, CURRENT_DATE, 'bergen-city-bike')