

DELETE FROM Ratings ;
DELETE FROM Comments ;
DELETE FROM Posts ;
DELETE FROM Category ;
DELETE FROM Users ;

DROP INDEX id on Ratings;
DROP INDEX id on Comments;
DROP INDEX id on Posts;
DROP INDEX id on Category;
DROP INDEX id on Users;

DROP TABLE Ratings CASCADE;
DROP TABLE Comments CASCADE;
DROP TABLE Posts CASCADE;
DROP TABLE Category CASCADE;
DROP TABLE Users CASCADE;

CREATE TABLE Users 
(
	id int auto_increment primary key, 
	username VARCHAR(20),
	pass varchar(150),
	lastActionTime datetime
	
);

ALTER TABLE Users ADD INDEX (id);

CREATE TABLE Category 
(
	id int auto_increment primary key, 
	categoryName VARCHAR(20)
);

ALTER TABLE Category ADD INDEX (id);

CREATE TABLE Posts 
(
	id int auto_increment primary key, 
	title VARCHAR(20),
	userId int, 
	content VARCHAR(144),
	categoryId int,
	postTime datetime,
	active boolean,
	FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
	FOREIGN KEY (categoryId) REFERENCES Category(id) ON DELETE CASCADE
	
);

ALTER TABLE Posts ADD INDEX (id);

CREATE TABLE Comments 
(
	id int auto_increment primary key, 
	userId int, 
	content VARCHAR(144),
	postId int,
	commentTime datetime,
	active boolean,
	FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
	FOREIGN KEY (postId) REFERENCES Posts(id) ON DELETE CASCADE
);

ALTER TABLE Comments ADD INDEX (id);

CREATE TABLE Ratings 
(
	id int auto_increment primary key, 
	userId int, 
	postId int,
	rating int,
	FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
	FOREIGN KEY (postId) REFERENCES Posts(id) ON DELETE CASCADE
);

ALTER TABLE Ratings ADD INDEX (id);

INSERT INTO Category (categoryName) VALUES ('Management');
INSERT INTO Category (categoryName) VALUES ('Colleagues');
INSERT INTO Category (categoryName) VALUES ('Project');
INSERT INTO Category (categoryName) VALUES ('Clients');
INSERT INTO Category (categoryName) VALUES ('Others');
