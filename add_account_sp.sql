BEGIN
	IF p_account_first_name IS NULL
	THEN RAISE EXCEPTION 'Everyone needs a first name';
	END IF;
	IF p_account_last_name IS NULL
	THEN RAISE EXCEPTION 'Everyone needs a last name';
	END IF;
	IF p_account_email IS NULL
	THEN RAISE EXCEPTION 'Everyone needs an email';
	END IF;
	IF p_account_password IS NULL
	THEN RAISE EXCEPTION 'Everyone needs a password';
	END IF;
	IF p_account_mobile_phone IS NULL
	THEN RAISE EXCEPTION 'Everyone needs a phone number';
	END IF;
	IF p_account_street IS NULL
	THEN RAISE EXCEPTION 'Everyone needs a street to live on';
	END IF;
	IF p_account_city IS NULL
	THEN RAISE EXCEPTION 'Everyone needs a city to live in';
	END IF;
	IF p_account_state_province IS NULL
	THEN RAISE EXCEPTION 'Everyone needs a province/state to live in';
	END IF;
	IF p_account_postal_code IS NULL
	THEN RAISE EXCEPTION 'Everyone has a postal code';
	END IF;

	IF EXISTS (SELECT 1 FROM bc_account WHERE account_email = p_account_email) THEN
    RAISE EXCEPTION 'Email already exists, log in or use a new email';
	END IF;
	 
	INSERT INTO bc_account(account_first_name, 
	account_last_name,
	account_email,
	account_password,
	account_mobile_phone,
	account_street, 
	account_apartment,
	account_city, 
	account_state_province,
	account_postal_code
	)
	VALUES (p_account_first_name,
	p_account_last_name,
	p_account_email,
	p_account_password,
	p_account_mobile_phone,
	p_account_street,
	p_account_apartment,
	p_account_city,
	p_account_state_province,
	p_account_postal_code
	)

	RETURNING account_id INTO p_account_id;
	RAISE NOTICE 'Du har fått en bruker med id %', p_account_id;
	COMMIT;
END;
