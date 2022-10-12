CREATE TABLE Employee(
	id_employee int not null primary key,
	name varchar(30),
	--added later id_position foreign key
	            --position varchar(30)
	
);

CREATE TABLE Contact_Employee(
	id_contact_empl int not null primary key,
	phone varchar(12),
	CONSTRAINT chk_phone CHECK (phone like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'), -- check that no number is not a digit 
	email varchar(30),
	birth_year int check(birth_year<=2003),
	id_employee int foreign key references Employee(id_employee)
);

CREATE TABLE Product(
	id_product int not null primary key,
	product_description varchar(30),
	color varchar(30),
	price int check(price>=0)
);

CREATE TABLE Origin(
	id_origin int not null primary key,
	country varchar(30),
	shipping varchar(30),
	constraint chk_shipping CHECK(shipping in ('naval', 'plane', 'train'))
);

CREATE TABLE ProductOrigin(
	id_product int foreign key references Product(id_product),
	id_origin int foreign key references Origin(id_origin),
	primary key(id_product, id_origin)

);
INSERT INTO Employee (id_employee, name) VALUES (1, 'alina', 'manager');
SELECT * FROM Employee;

ALTER TABLE Employee
DROP COLUMN position;

CREATE TABLE positions(
	id_position int not null primary key,
	position_name varchar(30)
);
ALTER TABLE Employee
ADD foreign key (id_position) references positions(id_position);

SELECT * FROM Employee;

DROP TABLE positions;

CREATE TABLE Positions(
	id_position int not null primary key,
	position_name varchar(30)
);

ALTER TABLE Employee
ADD foreign key (id_position) references Positions(id_position);
SELECT * from Positions;

ALTER TABLE Employee
ADD id_position int;

SELECT * from Employee;

-- Introducere date TABEL POSITIONS
INSERT INTO Positions(id_position, position_name) VALUES ('1','manager'),('2','relatii clienti'),('3','operator marfa'),('4','curier');
SELECT * from Positions;

-- Introducere date TABEL EMPLOYEE
INSERT INTO Employee(id_employee, name, id_position) VALUES ('7','Delia','1'),
('2','Denisa','2'),
('3', 'Andreea','2'),
('4','Criss','3'),
('5','Ioana', '3'),
('6','Tudor','4');
SELECT * from Employee;

-- Introducere date TABEL Contact_Employee
INSERT INTO Contact_Employee VALUES ('1', '0745678990','delia@gmail.com','1990','7'),
                                    ('2', '0745642190','criss@gmail.com','1992','4');
SELECT * FROM Contact_Employee;
INSERT INTO Contact_Employee VALUES ('3', '0745674560','denisa@gmail.com','1997','2'),
                                    ('4', '0736878990','andre@gmail.com','1993','3'),
									('5', '0787678324','tudor@gmail.com','2000','6');

-- Introducere date TABEL Product
INSERT INTO Product VALUES
('1','rochie Marisa','alb','150'),
('2','fusta Zina','gri','80'), 
('3','pantaloni Tessa','negru','100');
SELECT * FROM Product;
INSERT INTO Product VALUES
('4','rochie Anna','verde','100'),
('5','top Sia','alb','55'),
('6','top Cara','mov','90');

-- Introducere date TABEL Origin
INSERT INTO Origin VALUES ('1','China','plane'),
('2','SUA','plane'),
('3','Canada','naval');
SELECT * FROM Origin;

--Introducere date TABLE ProductOrigin
INSERT INTO ProductOrigin values ('1','1');
SELECT * FROM ProductOrigin;
INSERT INTO ProductOrigin values ('1','2'), 
('2','3'), 
('2','1'),
('3','1');
SELECT * FROM ProductOrigin;

--DELETE WHERE IS NULL
DELETE FROM Employee WHERE id_position IS NULL;
SELECT * FROM Employee;

--UPDATE WHERE <=
UPDATE Product set price='60' WHERE price<='90';
SELECT * FROM Product;

--UPDATE WHERE AND
UPDATE Origin set country='Spania', shipping = 'train' WHERE country = 'SUA' AND shipping = 'plane';
SELECT * FROM Origin;

--LAB3
--INTERSECT:afisam idurile angajatilor din Employee care au informatii despre ei in Contact_Employee 
SELECT id_employee FROM Employee
INTERSECT
SELECT id_employee FROM Contact_Employee;

--INNER JOIN Sa vedem ce posturi au angajatii
SELECT * FROM Employee
INNER JOIN Positions ON Employee.id_position = PositionS.id_position;
 
 --FULL JOIN 
 SELECT * FROM Product
 RIGHT JOIN ProductOrigin ON Product.id_product = ProductOrigin.id_product;

 --GROUP BY. Una dintre acestea va conține clauza HAVING. Se vor folosi cel puțin trei funcții de agregare, la alegere, 
--dintre: COUNT, SUM, AVG, MIN, MAX

SELECT id_product, AVG (price) from Product
Group by id_product;

--GROUP BY COUNT 
SELECT id_origin, COUNT(*)  as [nr] FROM ProductOrigin
GROUP BY id_origin;

--GROUP BY HAVING SUM
SELECT id_product, COUNT(*) AS [nr produse], SUM(price) [pret] FROM Product
GROUP BY id_product HAVING SUM(price)>90;

