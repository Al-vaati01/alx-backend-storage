-- Task: Create a trigger to reset valid_email when the email is changed

DELIMITER $$

CREATE TRIGGER reset_valid_email
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    -- Check if the email column has been updated
    IF NEW.email != OLD.email THEN
        SET NEW.valid_email = 0; -- Reset valid_email to 0 when the email changes
    END IF;
END $$

DELIMITER ;
