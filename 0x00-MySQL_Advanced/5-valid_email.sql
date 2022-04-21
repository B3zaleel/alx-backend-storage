-- Creates a trigger that resets the attribute valid_email
-- only when the email has been changed.
DROP TRIGGER IF EXISTS validate_email;
DELIMITER $$
CREATE TRIGGER validate_email
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    SET NEW.valid_email = IF(IFNULL(OLD.email, "") != IFNULL(NEW.email, ""), NOT NEW.valid_email, OLD.valid_email);
END $$
DELIMITER ;
