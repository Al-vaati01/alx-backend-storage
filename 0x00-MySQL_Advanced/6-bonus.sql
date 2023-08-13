-- Task: Create a stored procedure AddBonus

DELIMITER $$

CREATE PROCEDURE AddBonus(
    IN user_id INT,
    IN project_name VARCHAR(255),
    IN score DECIMAL(10, 2)
)
BEGIN
    DECLARE project_id INT;

    -- Check if the project exists; if not, create it
    SELECT project_id INTO project_id FROM projects WHERE name = project_name;
    IF project_id IS NULL THEN
        INSERT INTO projects (name) VALUES (project_name);
        SET project_id = LAST_INSERT_ID();
    END IF;

    -- Insert the correction with the given user_id, project_id, and score
    INSERT INTO corrections (user_id, project_id, score) VALUES (user_id, project_id, score);
END $$

DELIMITER ;
