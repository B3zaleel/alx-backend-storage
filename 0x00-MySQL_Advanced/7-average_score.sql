-- Creates a stored procedure ComputeAverageScoreForUser that
-- computes and stores the average score for a student.
DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;
DELIMITER $$
CREATE PROCEDURE ComputeAverageScoreForUser (user_id INT)
BEGIN
    DECLARE total_score INT DEFAULT 0;
    DECLARE projects_count INT DEFAULT 0;

    SELECT SUM(score)
        INTO total_score
        FROM corrections
        WHERE corrections.user_id = user_id;
    SELECT COUNT(*)
        INTO projects_count
        FROM corrections
        WHERE corrections.user_id = user_id;

    IF projects_count = 0 THEN
        UPDATE users
            SET users.average_score = total_score / projects_count
            WHERE users.id = user_id;
    ELSE
        UPDATE users
            SET users.average_score = 0
            WHERE users.id = user_id;
    END IF;
END $$
DELIMITER ;
