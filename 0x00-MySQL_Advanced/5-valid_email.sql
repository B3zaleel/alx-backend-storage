-- Creates a trigger that resets the attribute valid_email
-- only when the email has been changed.
DROP TRIGGER IF EXISTS validate_email;
DELIMITER $$
CREATE TRIGGER validate_email
AFTER UPDATE ON users
FOR EACH ROW
BEGIN
    IF OLD.email != NEW.email THEN
        UPDATE users
            SET users.valid_email = ABS(OLD.valid_email - 1)
            WHERE users.id = NEW.id;
    END IF;
END $$
DELIMITER ;
