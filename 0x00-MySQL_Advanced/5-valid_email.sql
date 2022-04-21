-- Creates a trigger that resets the attribute valid_email
-- only when the email has been changed.
DROP TRIGGER IF EXISTS validate_email;
DELIMITER $$
CREATE TRIGGER validate_email
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    IF IFNULL(OLD.email, "") != IFNULL(NEW.email, "") THEN
        SET NEW.valid_email = NEW.valid_email;
    ELSE
        SET NEW.valid_email = OLD.valid_email;
    END IF;
END $$
DELIMITER ;
