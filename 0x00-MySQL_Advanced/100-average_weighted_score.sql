-- average weighted score
-- create a stored procedure 'ComputeAverageWeightedScoreForUser'
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUser;
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    -- UPDATE users SET average_score = (SELECT (SELECT SUM(p.weight * c.score) FROM projects AS p LEFT JOIN corrections AS c ON p.id = c.project_id WHERE c.user_id = user_id) / (SELECT SUM(weight) FROM projects JOIN users WHERE users.id = user_id)) WHERE id = user_id;

    SET @aggregate_score = (SELECT (SELECT SUM(p.weight * c.score) FROM projects AS p LEFT JOIN corrections AS c ON p.id = c.project_id WHERE c.user_id = user_id) / (SELECT SUM(weight) FROM projects JOIN users WHERE users.id = user_id));
    UPDATE users SET average_score = (SELECT @aggregate_score) WHERE id = user_id;
END //
DELIMITER ;
