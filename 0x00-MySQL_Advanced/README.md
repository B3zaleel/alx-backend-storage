# MySQL Advanced

This project contains tasks for learning advanced MySQL features.

## Tasks To Complete

+ [x] 0. **We are all unique!**<br/>[0-uniq_users.sql](0-uniq_users.sql) contains a SQL script that creates a table `users` following these requirements:
  + With these attributes:
    + `id`, integer, never null, auto increment and primary key.
    + `email`, string (255 characters), never null and unique.
    + `name`, string (255 characters).
  + If the table already exists, your script should not fail.
  + Your script can be executed on any database.
  + **Context**: Make an attribute unique directly in the table schema will enforced your business rules and avoid bugs in your application

+ [x] 1. **In and not out**<br/>[1-country_users.sql](1-country_users.sql) contains a SQL script that creates a table `users` following these requirements:
  + With these attributes:
    + `id`, integer, never null, auto increment and primary key.
    + `email`, string (255 characters), never null and unique.
    + `name`, string (255 characters).
    + `country`, enumeration of countries: `US`, `CO` and `TN`, never null (default value will be the first element of the enumeration, which is `US`).
  + If the table already exists, your script should not fail.
  + Your script can be executed on any database.

+ [x] 2. **Best band ever!**<br/>[2-fans.sql](2-fans.sql) contains a SQL script that ranks country origins of bands, ordered by the number of (non-unique) fans.
  + Import this table dump: [metal_bands.sql](metal_bands.sql).
  + Column names must be: `origin` and `nb_fans`.
  + Your script can be executed on any database.
  + Context: Context: Calculating/computing something is always power intensive… better to distribute the load!

+ [x] 3. **Old school band**<br/>[3-metal_bands.sql](3-metal_bands.sql) contains a SQL script that lists all bands with `Glam rock` as their main style, ranked by their longevity:
  + Import this table dump: [metal_bands.sql](metal_bands.sql).
  + Column names must be: `band_name` and `lifespan` (in years).
  + You should use attributes `formed` and `split` for computing the `lifespan`.
  + Your script can be executed on any database.

+ [x] 4. **Buy buy buy**<br/>[4-store.sql](4-store.sql) contains a SQL script that creates a trigger that decreases the quantity of an item after adding a new order:
  + Quantity in the table `items` can be negative.
  + A dump of the database and relevant table(s) is shown below:
    ```sql
    -- Initial
    DROP TABLE IF EXISTS items;
    DROP TABLE IF EXISTS orders;

    CREATE TABLE IF NOT EXISTS items (
      name VARCHAR(255) NOT NULL,
      quantity int NOT NULL DEFAULT 10
    );

    CREATE TABLE IF NOT EXISTS orders (
      item_name VARCHAR(255) NOT NULL,
      number int NOT NULL
    );

    INSERT INTO items (name) VALUES ("apple"), ("pineapple"), ("pear");
    ```
  + **Context**: Updating multiple tables for one action from your application can generate issue: network disconnection, crash, etc… to keep your data in a good shape, let MySQL do it for you!

+ [x] 5. **Email validation to sent**<br/>[5-sum_list.sql](5-valid_email.sql) contains a SQL script that creates a trigger that resets the attribute `valid_email` only when the `email` has been changed.
  + A dump of the database and relevant table(s) is shown below:
    ```sql
    -- Initial
    DROP TABLE IF EXISTS users;

    CREATE TABLE IF NOT EXISTS users (
      id int not null AUTO_INCREMENT,
      email varchar(255) not null,
      name varchar(255),
      valid_email boolean not null default 0,
      PRIMARY KEY (id)
    );

    INSERT INTO users (email, name) VALUES ("bob@dylan.com", "Bob");
    INSERT INTO users (email, name, valid_email) VALUES ("sylvie@dylan.com", "Sylvie", 1);
    INSERT INTO users (email, name, valid_email) VALUES ("jeanne@dylan.com", "Jeanne", 1);
    ```
  + **Context**: Nothing related to MySQL, but perfect for user email validation - distribute the logic to the database itself!

+ [x] 6. **Add bonus**<br/>[6-bonus.sql](6-bonus.sql) contains a SQL script that creates a stored procedure `AddBonus` that adds a new correction for a student:
  + The procedure `AddBonus` takes 3 inputs (in this order):
    + `user_id`, a `users.id` value (you can assume `user_id` is linked to an existing `users`).
    + `project_name`, a new or already exists `projects` - if no `projects.name` found in the table, you should create it.
    + `score`, the score value for the correction.
  + A dump of the database and relevant table(s) is shown below:
    ```sql
    -- Initial
    DROP TABLE IF EXISTS corrections;
    DROP TABLE IF EXISTS users;
    DROP TABLE IF EXISTS projects;

    CREATE TABLE IF NOT EXISTS users (
      id int not null AUTO_INCREMENT,
      name varchar(255) not null,
      average_score float default 0,
      PRIMARY KEY (id)
    );

    CREATE TABLE IF NOT EXISTS projects (
      id int not null AUTO_INCREMENT,
      name varchar(255) not null,
      PRIMARY KEY (id)
    );

    CREATE TABLE IF NOT EXISTS corrections (
      user_id int not null,
      project_id int not null,
      score int default 0,
      KEY `user_id` (`user_id`),
      KEY `project_id` (`project_id`),
      CONSTRAINT fk_user_id FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
      CONSTRAINT fk_project_id FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
    );

    INSERT INTO users (name) VALUES ("Bob");
    SET @user_bob = LAST_INSERT_ID();

    INSERT INTO users (name) VALUES ("Jeanne");
    SET @user_jeanne = LAST_INSERT_ID();

    INSERT INTO projects (name) VALUES ("C is fun");
    SET @project_c = LAST_INSERT_ID();

    INSERT INTO projects (name) VALUES ("Python is cool");
    SET @project_py = LAST_INSERT_ID();


    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_bob, @project_c, 80);
    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_bob, @project_py, 96);

    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_jeanne, @project_c, 91);
    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_jeanne, @project_py, 73);
    ```

+ [x] 7. **Average score**<br/>[7-average_score.sql](7-average_score.sql) contains a SQL script that creates a stored procedure `ComputeAverageScoreForUser` that computes and store the average score for a student.
  + **Note**: An average score can be a decimal.
  + The procedure `ComputeAverageScoreForUser` takes 1 input:
    + `user_id`, a `users.id` value (you can assume `user_id` is linked to an existing `users`).
  + A dump of the database and relevant table(s) is shown below:
    ```sql
    -- Initial
    DROP TABLE IF EXISTS corrections;
    DROP TABLE IF EXISTS users;
    DROP TABLE IF EXISTS projects;

    CREATE TABLE IF NOT EXISTS users (
      id int not null AUTO_INCREMENT,
      name varchar(255) not null,
      average_score float default 0,
      PRIMARY KEY (id)
    );

    CREATE TABLE IF NOT EXISTS projects (
      id int not null AUTO_INCREMENT,
      name varchar(255) not null,
      PRIMARY KEY (id)
    );

    CREATE TABLE IF NOT EXISTS corrections (
      user_id int not null,
      project_id int not null,
      score int default 0,
      KEY `user_id` (`user_id`),
      KEY `project_id` (`project_id`),
      CONSTRAINT fk_user_id FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
      CONSTRAINT fk_project_id FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
    );

    INSERT INTO users (name) VALUES ("Bob");
    SET @user_bob = LAST_INSERT_ID();

    INSERT INTO users (name) VALUES ("Jeanne");
    SET @user_jeanne = LAST_INSERT_ID();

    INSERT INTO projects (name) VALUES ("C is fun");
    SET @project_c = LAST_INSERT_ID();

    INSERT INTO projects (name) VALUES ("Python is cool");
    SET @project_py = LAST_INSERT_ID();


    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_bob, @project_c, 80);
    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_bob, @project_py, 96);

    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_jeanne, @project_c, 91);
    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_jeanne, @project_py, 73);
    ```

+ [x] 8. **Optimize simple search**<br/>[8-index_my_names.sql](8-index_my_names.sql) contains a SQL script that creates an index `idx_name_first` on the table `names` and the first letter of `name`:
  + Import this archived table dump: [names.7z](https://mega.nz/file/OVhTySJQ#ezfbZ1GT-06qQKl0yYz2yY3Gdlr8Vd3PTyBCixIc9d4).
  + Only the first letter of `name` must be indexed.

+ [x] 9. **Optimize search and score**<br/>[9-index_name_score.sql](9-index_name_score.sql) contains a SQL script that creates an index `idx_name_first_score` on the table `names` and the first letter of `name` and the `score`:
  + Import this archived table dump: [names.7z](https://mega.nz/file/OVhTySJQ#ezfbZ1GT-06qQKl0yYz2yY3Gdlr8Vd3PTyBCixIc9d4).
  + Only the first letter of `name` AND `score` must be indexed.

+ [x] 10. **Safe divide**<br/>[10-div.sql](10-div.sql) contains a SQL script that creates a function `SafeDiv` that divides (and returns) the first by the second number or returns 0 if the second number is equal to 0:
  + The function `SafeDiv` takes 2 arguments:
    + `a`, INT.
    + `b`, INT.
  + The function `SafeDiv` returns `a / b` or 0 if `b == 0`.
  + A dump of the database and relevant table(s) is shown below:
    ```sql
    -- Initial
    DROP TABLE IF EXISTS numbers;

    CREATE TABLE IF NOT EXISTS numbers (
        a int default 0,
        b int default 0
    );

    INSERT INTO numbers (a, b) VALUES (10, 2);
    INSERT INTO numbers (a, b) VALUES (4, 5);
    INSERT INTO numbers (a, b) VALUES (2, 3);
    INSERT INTO numbers (a, b) VALUES (6, 3);
    INSERT INTO numbers (a, b) VALUES (7, 0);
    INSERT INTO numbers (a, b) VALUES (6, 8);
    ```

+ [x] 11. **No table for a meeting**<br/>[11-need_meeting.sql](11-need_meeting.sql) contains a SQL script that creates a view `need_meeting` that lists all students that have a score under 80 (strict) and no `last_meeting` or more than 1 month.
  + The view `need_meeting` should return all students name when:
    + They score are under (strict) to 80.
    + **AND** no `last_meeting` date **OR** more than a month.
  + A dump of the database and relevant table(s) is shown below:
    ```sql
    -- Initial
    DROP TABLE IF EXISTS students;

    CREATE TABLE IF NOT EXISTS students (
      name VARCHAR(255) NOT NULL,
      score INT default 0,
      last_meeting DATE NULL
    );

    INSERT INTO students (name, score) VALUES ("Bob", 80);
    INSERT INTO students (name, score) VALUES ("Sylvia", 120);
    INSERT INTO students (name, score) VALUES ("Jean", 60);
    INSERT INTO students (name, score) VALUES ("Steeve", 50);
    INSERT INTO students (name, score) VALUES ("Camilia", 80);
    INSERT INTO students (name, score) VALUES ("Alexa", 130);
    ```

+ [x] 12. **Average weighted score**<br/>[100-average_weighted_score.sql](100-average_weighted_score.sql) contains a SQL script that creates a stored procedure `ComputeAverageWeightedScoreForUser` that computes and stores the  [average weighted score](https://www.wikihow.com/Calculate-Weighted-Average) for a student:
  + The procedure `ComputeAverageScoreForUser` takes 1 input:
    + `user_id`, a `users.id` value (you can assume `user_id` is linked to an existing `users`).
  + A dump of the database and relevant table(s) is shown below:
    ```sql
    -- Initial
    DROP TABLE IF EXISTS corrections;
    DROP TABLE IF EXISTS users;
    DROP TABLE IF EXISTS projects;

    CREATE TABLE IF NOT EXISTS users (
      id int not null AUTO_INCREMENT,
      name varchar(255) not null,
      average_score float default 0,
      PRIMARY KEY (id)
    );

    CREATE TABLE IF NOT EXISTS projects (
      id int not null AUTO_INCREMENT,
      name varchar(255) not null,
      weight int default 1,
      PRIMARY KEY (id)
    );

    CREATE TABLE IF NOT EXISTS corrections (
      user_id int not null,
      project_id int not null,
      score float default 0,
      KEY `user_id` (`user_id`),
      KEY `project_id` (`project_id`),
      CONSTRAINT fk_user_id FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
      CONSTRAINT fk_project_id FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
    );

    INSERT INTO users (name) VALUES ("Bob");
    SET @user_bob = LAST_INSERT_ID();

    INSERT INTO users (name) VALUES ("Jeanne");
    SET @user_jeanne = LAST_INSERT_ID();

    INSERT INTO projects (name, weight) VALUES ("C is fun", 1);
    SET @project_c = LAST_INSERT_ID();

    INSERT INTO projects (name, weight) VALUES ("Python is cool", 2);
    SET @project_py = LAST_INSERT_ID();


    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_bob, @project_c, 80);
    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_bob, @project_py, 96);

    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_jeanne, @project_c, 91);
    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_jeanne, @project_py, 73);
    ```

+ [x] 13. **Average weighted score for all!**<br/>[101-average_weighted_score.sql](101-average_weighted_score.sql) contains a SQL script that creates a stored procedure `ComputeAverageWeightedScoreForUsers` that computes and store the [average weighted score](https://www.wikihow.com/Calculate-Weighted-Average) for all students:
  + The procedure `ComputeAverageWeightedScoreForUsers` takes no input.
  + A dump of the database and relevant table(s) is shown below:
    ```sql
    -- Initial
    DROP TABLE IF EXISTS corrections;
    DROP TABLE IF EXISTS users;
    DROP TABLE IF EXISTS projects;

    CREATE TABLE IF NOT EXISTS users (
      id int not null AUTO_INCREMENT,
      name varchar(255) not null,
      average_score float default 0,
      PRIMARY KEY (id)
    );

    CREATE TABLE IF NOT EXISTS projects (
      id int not null AUTO_INCREMENT,
      name varchar(255) not null,
      weight int default 1,
      PRIMARY KEY (id)
    );

    CREATE TABLE IF NOT EXISTS corrections (
      user_id int not null,
      project_id int not null,
      score float default 0,
      KEY `user_id` (`user_id`),
      KEY `project_id` (`project_id`),
      CONSTRAINT fk_user_id FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
      CONSTRAINT fk_project_id FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE
    );

    INSERT INTO users (name) VALUES ("Bob");
    SET @user_bob = LAST_INSERT_ID();

    INSERT INTO users (name) VALUES ("Jeanne");
    SET @user_jeanne = LAST_INSERT_ID();

    INSERT INTO projects (name, weight) VALUES ("C is fun", 1);
    SET @project_c = LAST_INSERT_ID();

    INSERT INTO projects (name, weight) VALUES ("Python is cool", 2);
    SET @project_py = LAST_INSERT_ID();


    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_bob, @project_c, 80);
    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_bob, @project_py, 96);

    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_jeanne, @project_c, 91);
    INSERT INTO corrections (user_id, project_id, score) VALUES (@user_jeanne, @project_py, 73);
    ```
