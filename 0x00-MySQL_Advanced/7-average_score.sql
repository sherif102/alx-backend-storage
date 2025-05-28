-- average score
-- creates a stored procudre 'ComputeAverageScoreForUser'
DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;
DELIMITER //
CREATE PROCEDURE ComputeAverageScoreForUser(IN user_id INT)
BEGIN
    UPDATE users SET average_score = (SELECT AVG(score) FROM corrections WHERE user_id = corrections.user_id) WHERE users.id = user_id;
END //
DELIMITER ;
