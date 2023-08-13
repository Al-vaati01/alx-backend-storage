-- Create a stored procedure ComputeAverageWeightedScoreForUsers that computes and store the average weighted score for all students.

DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE p_user_id INT;
    DECLARE total_score DECIMAL(10, 2);
    DECLARE total_weight DECIMAL(10, 2);
    DECLARE average_weighted_score DECIMAL(10, 2);

    DECLARE cur CURSOR FOR
        SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO p_user_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT IFNULL(SUM(score * weight), 0), IFNULL(SUM(weight), 0) INTO total_score, total_weight
        FROM scores
        WHERE user_id = p_user_id;

        IF total_weight > 0 THEN
            SET average_weighted_score = total_score / total_weight;
        ELSE
            SET average_weighted_score = 0;
        END IF;

        UPDATE users
        SET average_weighted_score = average_weighted_score
        WHERE id = p_user_id;
    END LOOP;

    CLOSE cur;
END $$

DELIMITER ;
