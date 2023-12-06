-- DROP DATABASE Exercise3;

CREATE DATABASE Exercise3;

USE Exercise3;

CREATE TABLE
    users (
        user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        user_name VARCHAR(30) NOT NULL,
        first_name VARCHAR(30),
        last_name VARCHAR(30),
        email VARCHAR(80) NOT NULL,
        password VARCHAR(30) NOT NULL
    );

CREATE TABLE
    posts (
        post_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(30) NOT NULL,
        post_content VARCHAR(800) NOT NULL,
        date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        created_by INT NOT NULL,
        FOREIGN KEY (created_by) REFERENCES Users(user_id)
    );

CREATE TABLE
    user_post_likes (
        user_post_like_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        post_id INT NOT NULL,
        user_id INT NOT NULL,
        date_liked TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE
    user_post_comments (
        user_post_comment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        post_id INT NOT NULL,
        user_id INT NOT NULL,
        date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        comment_content VARCHAR(300) NOT NULL
    );

INSERT INTO
    users (
        user_name,
        first_name,
        last_name,
        email,
        password
    )
VALUES (
        'hsewell',
        "Henry",
        "Sewell",
        "HSewell@mail.com",
        "coolbananas12"
    ), (
        'foxywill',
        "William",
        "Fox",
        "william.fox@gmail.com",
        "123456789"
    ), (
        'danny_p75',
        "Daniel",
        "Pollen",
        "daniel@owlpost.com",
        "06071875"
    );

INSERT INTO
    posts (
        title,
        post_content,
        created_by
    )
VALUES (
        "A found a cool book",
        "Check out this cool book I found the other day!!",
        1
    );

INSERT INTO user_post_likes (post_id, user_id) VALUES (1,2), (1,3);

INSERT INTO
    user_post_comments (
        post_id,
        user_id,
        comment_content
    )
VALUES (
        1,
        2,
        "Ah yes, think I've read that one... you like it huh?"
    ), (
        1,
        1,
        "Actually, book wasn't as great as I thought it would be. Bit dull"
    ), (1, 2, "Lol, yeah");

SELECT
    p.title AS "Post Title",
    p.post_content AS "Post Content",
    c.comment_content AS "Comment",
    u.user_name AS "Comment User",
    c.date_created AS "Time Commented"
FROM posts AS p
    JOIN user_post_comments AS c ON c.post_id = p.post_id
    JOIN users AS u ON u.user_id = c.user_id;

-- Dates will all be the same as they are default values and were all generated at the same time.

SELECT
    p.title AS "Post Title",
    p.post_content AS "Post Content",
    COUNT(l.post_id) AS "Likes"
FROM posts AS p
    JOIN user_post_likes AS l ON l.post_id = p.post_id
GROUP BY
    p.title,
    p.post_content;

-- shows the total amount of likes of each post