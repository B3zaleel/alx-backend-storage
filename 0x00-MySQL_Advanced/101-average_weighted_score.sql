-- Creates a stored procedure ComputeAverageWeightedScoreForUsers that
-- computes and store the average weighted score for all students.
DROP PROCEDURE IF EXISTS ComputeAverageWeightedScoreForUsers;
DELIMITER $$
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers ()
BEGIN
    ALTER TABLE users ADD total_weighted_score FLOAT NOT NULL;
    ALTER TABLE users ADD total_weight INT NOT NULL;

    UPDATE users
        SET total_weighted_score = (
            SELECT CAST(SUM(corrections.score * projects.weight) AS FLOAT)
            FROM corrections
                INNER JOIN projects
                    ON corrections.project_id = projects.id
            WHERE corrections.user_id = users.id
            );

    UPDATE users
        SET total_weight = (
            SELECT SUM(projects.weight) AS total_weight
                FROM corrections
                    INNER JOIN projects
                        ON corrections.project_id = projects.id
                WHERE corrections.user_id = users.id
            );

    UPDATE users
        SET average_score = (total_weighted_score / total_weight);
    ALTER TABLE users
        DROP COLUMN total_weighted_score;
    ALTER TABLE users
        DROP COLUMN total_weight;
END $$
DELIMITER ;
