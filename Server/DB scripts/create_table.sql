
DROP TABLE Comments CASCADE;
DROP TABLE Ratings CASCADE;
DROP TABLE Posts CASCADE;
DROP TABLE Category CASCADE;
DROP TABLE Users CASCADE;


CREATE TABLE Users 
(
	id int auto_increment primary key, 
	username VARCHAR(20) not null,
	pass varchar(150) not null,
	LastActionTime datetime not null,
	UNIQUE KEY (username)
	
	
);



CREATE TABLE Category 
(
	id int auto_increment primary key, 
	categoryName VARCHAR(20) not null,
	UNIQUE KEY (categoryName)
);





CREATE TABLE Posts 
(
	id int auto_increment not null primary key, 
	title VARCHAR(20) not null,
	userId int not null, 
	content VARCHAR(144),
	categoryId int not null,
	postTime datetime not null,
	active boolean default 1,
	FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
	FOREIGN KEY (categoryId) REFERENCES Category(id) ON DELETE CASCADE
	
);



CREATE TABLE Comments 
(
	id int auto_increment not null primary key, 
	userId int not null, 
	content VARCHAR(144),
	postId int not null,
	commentTime datetime not null,
	active boolean default 1,
	FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
	FOREIGN KEY (postId) REFERENCES Posts(id) ON DELETE CASCADE
);




CREATE TABLE Ratings 
(
	id int auto_increment not null primary key, 
	userId int not null, 
	postId int not null,
	rating int not null,
	FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE CASCADE,
	FOREIGN KEY (postId) REFERENCES Posts(id) ON DELETE CASCADE
);



insert into Users(username, pass,lastActionTime) values ('anonymous','pass',CURRENT_TIMESTAMP);

INSERT INTO Category (categoryName) VALUES ('All');
INSERT INTO Category (categoryName) VALUES ('Hot Summer Time');
INSERT INTO Category (categoryName) VALUES ('The Godfathers');
INSERT INTO Category (categoryName) VALUES ('Client Browser');
INSERT INTO Category (categoryName) VALUES ('Brothers in Arms');
INSERT INTO Category (categoryName) VALUES ('Hall of Fame');
INSERT INTO Category (categoryName) VALUES ('Everything else');
INSERT INTO Category (categoryName) VALUES ('Life is Good');





