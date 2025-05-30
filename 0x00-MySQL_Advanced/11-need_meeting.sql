-- no table for a meeting
-- creates a view 'need_meeting'
CREATE VIEW need_meeting AS
    SELECT `name` FROM students WHERE score < 80 AND last_meeting IS NULL || last_meeting < (CURDATE() - 30)
