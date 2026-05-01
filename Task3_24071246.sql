CREATE DATABASE Social_media;
USE Social_media;

DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS posts;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO users (username, email) VALUES
('Ronak', 'ronak12@example.com'),
('Bhabya', 'bhabya34@example.com'),
('Raya', 'raya45@example.com');

INSERT INTO posts (user_id, content, created_at) VALUES
(1, 'Hello Everyone!', NOW() - INTERVAL 10 DAY),
(2, 'My first IG Post!', NOW() - INTERVAL 5 DAY),
(3, 'Good Day!', NOW() - INTERVAL 40 DAY);

INSERT INTO comments (post_id, user_id, comment_text, created_at) VALUES
(1, 2, 'Nice post!', NOW() - INTERVAL 2 DAY),
(1, 3, 'Agreed!', NOW() - INTERVAL 1 DAY),
(2, 1, 'Welcome!', NOW() - INTERVAL 3 DAY),
(2, 3, 'Great!', NOW() - INTERVAL 2 DAY),
(2, 1, 'Keep posting!', NOW() - INTERVAL 1 DAY);

EXPLAIN 
SELECT p.post_id, COUNT(c.comment_id) AS total_comments
FROM posts p
JOIN comments c ON p.post_id = c.post_id
WHERE c.created_at >= NOW() - INTERVAL 30 DAY
GROUP BY p.post_id
ORDER BY total_comments DESC
LIMIT 10;

CREATE INDEX idx_comments_post_created 
ON comments(post_id, created_at);

SELECT 
    p.post_id,
    p.content,
    COUNT(*) AS total_comments
FROM comments c
JOIN posts p 
    ON p.post_id = c.post_id
WHERE c.created_at >= NOW() - INTERVAL 30 DAY
GROUP BY p.post_id, p.content
ORDER BY total_comments DESC
LIMIT 10;

EXPLAIN 
SELECT 
    p.post_id,
    p.content,
    COUNT(*) AS total_comments
FROM comments c
JOIN posts p 
    ON p.post_id = c.post_id
WHERE c.created_at >= NOW() - INTERVAL 30 DAY
GROUP BY p.post_id, p.content
ORDER BY total_comments DESC
LIMIT 10;


SELECT SQL_NO_CACHE 
    p.post_id,
    p.content,
    COUNT(*) AS total_comments
FROM comments c
JOIN posts p ON p.post_id = c.post_id
WHERE c.created_at >= NOW() - INTERVAL 30 DAY
GROUP BY p.post_id, p.content
ORDER BY total_comments DESC
LIMIT 10;

SELECT 
    p.post_id,
    p.content,
    COUNT(*) AS total_comments
FROM comments c
JOIN posts p ON p.post_id = c.post_id
WHERE c.created_at >= NOW() - INTERVAL 30 DAY
GROUP BY p.post_id, p.content
ORDER BY total_comments DESC
LIMIT 10;
