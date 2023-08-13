-- Create a stored procedure ComputeAverageWeightedScoreForUser hat computes and store the average weighted score for a student.

DELIMITER $$

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(
    IN p_user_id INT
)
BEGIN
    DECLARE total_score DECIMAL(10, 2);
    DECLARE total_weight DECIMAL(10, 2);
    DECLARE average_weighted_score DECIMAL(10, 2);

    -- Calculate the total score and total weight
    SELECT SUM(score * weight), SUM(weight) INTO total_score, total_weight
    FROM scores
    WHERE user_id = p_user_id;

    -- Calculate the average weighted score
    IF total_weight > 0 THEN
        SET average_weighted_score = total_score / total_weight;
    ELSE
        SET average_weighted_score = 0;
    END IF;

    -- Update the average weighted score for the user in the users table
    UPDATE users
    SET average_weighted_score = average_weighted_score
    WHERE id = p_user_id;
END $$

DELIMITER ;
