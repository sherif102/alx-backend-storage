-- email validation to sent
-- create trigger that resets 'valid_email' when email has been changed
DROP TRIGGER IF EXISTS email_reset;
DELIMITER //
CREATE TRIGGER email_reset BEFORE UPDATE ON users
    FOR EACH ROW
    BEGIN
        IF NEW.email IS NOT NULL AND NEW.email <> OLD.email THEN
        SET NEW.valid_email = 0;
        END IF;
    END //
DELIMITER ;
