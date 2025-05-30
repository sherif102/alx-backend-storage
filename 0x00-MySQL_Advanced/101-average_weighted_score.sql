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


-- average weighted score for all
-- create a stored procedure 'ComputeAverageWeightedScoreForUsers'
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE `uid` INT;

    -- Declare cursor
    DECLARE user_cursor CURSOR FOR SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN user_cursor;
    read_loop: LOOP
        FETCH user_cursor INTO `uid`;
        IF done THEN
            LEAVE read_loop;
        END IF;

        CALL ComputeAverageWeightedScoreForUser(`uid`);
    END LOOP;

    CLOSE user_cursor;
    -- SET @initial = 0;
    -- SET @total_user = (SELECT COUNT(id) FROM users);
    -- WHILE @initial < @total_user DO
    --     SET @current = (SELECT (id) FROM users LIMIT @initial, 1);
    --     CALL ComputeAverageWeightedScoreForUser(@current);
    --     SET @initial = @initial + 1;
    -- END WHILE
END //
DELIMITER ;
