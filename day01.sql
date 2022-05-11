CREATE TABLE publisher(
	id int PRIMARY KEY AUTO_INCREMENT,
	name text NOT NULL,
	phone varchar(10) NOT NULL,
	email text NOT NULL,
	fax text,
	address text
	
)

CREATE TABLE category(
	id int PRIMARY KEY AUTO_INCREMENT,
	name text NOT NULL,
	description text
)

CREATE TABLE author(
	id int PRIMARY KEY AUTO_INCREMENT,
	name text NOT NULL,
	birthday DATE,
	hometown text,
	gender bit
)

CREATE TABLE book(
	id int PRIMARY KEY AUTO_INCREMENT,
	title text NOT NULL,
	year_release text,
	id_publisher int NOT NULL,
	id_author  int NOT NULL,
	poster text,
	id_category int NOT NULL,
	FOREIGN KEY (id_publisher) REFERENCES publisher(id)
)

CREATE TABLE book_category(
	id_book int,
	id_category int,
	PRIMARY KEY (id_book, id_category),
	FOREIGN KEY (id_book) REFERENCES book(id),
	FOREIGN KEY (id_category) REFERENCES category(id)
)

CREATE TABLE book_author(
	id_book int,
	id_author int,
	PRIMARY KEY (id_book, id_author),
	FOREIGN KEY (id_book) REFERENCES book(id),
	FOREIGN KEY (id_author) REFERENCES author(id)
)
