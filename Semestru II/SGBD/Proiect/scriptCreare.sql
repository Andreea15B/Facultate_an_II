DROP TABLE  promotions CASCADE CONSTRAINTS
/
DROP TABLE categories CASCADE CONSTRAINTS
/
DROP TABLE products CASCADE CONSTRAINTS
/
DROP TABLE users CASCADE CONSTRAINTS
/
DROP TABLE orders CASCADE CONSTRAINTS
/

CREATE TABLE categories (
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR2(15),
	season VARCHAR2(10)
)
/

CREATE TABLE users (
	id INT NOT NULL PRIMARY KEY,
	type VARCHAR2(15),
	organization_name VARCHAR2(15),
	name  VARCHAR2(15),
	surname VARCHAR2(30),
	username VARCHAR2(255) UNIQUE,
	password VARCHAR2(100),
	email VARCHAR2(100),
	address VARCHAR2(100),
	country VARCHAR2(15)
)
/

CREATE TABLE products (
	id INT NOT NULL PRIMARY KEY,
	id_category INT NOT NULL,
	name VARCHAR2(100),
	price INT NOT NULL,
	id_producer INT,
	rating INT,
	imagePath VARCHAR2(100) NOT NULL,
	color VARCHAR2(10),
	sizeProduct VARCHAR2(5),
	materialType VARCHAR2(15),
	stock INT,
	gender VARCHAR2(10),
	CONSTRAINT fk_products_id_category FOREIGN KEY (id_category) REFERENCES categories(id),
	CONSTRAINT fk_products_id_producer FOREIGN KEY (id_producer) REFERENCES users(id)
)
/

CREATE TABLE promotions (
	id INT NOT NULL PRIMARY KEY,
	id_category INT,
	id_product INT,
	nrLimitedOrders INT,
	percent INT NOT NULL,
	CONSTRAINT fk_promotions_id_category FOREIGN KEY (id_category) REFERENCES categories(id),
	CONSTRAINT fk_promotions_id_product FOREIGN KEY (id_product) REFERENCES products(id)
)
/

CREATE TABLE orders (
	id INT NOT NULL PRIMARY KEY,
	id_product INT NOT NULL,
	id_user INT NOT NULL,
	data_order_placed DATE,
	quantity INT,
	order_status_code VARCHAR2(50),
	CONSTRAINT fk_orders_id_product FOREIGN KEY (id_product) REFERENCES products(id),
	CONSTRAINT fk_orders_id_user FOREIGN KEY (id_user) REFERENCES users(id)
)
/

SET SERVEROUTPUT ON;
SET DEFINE OFF; 
-- so that '&' symbol doesn't ask for substitution
DECLARE 
	 TYPE varr IS VARRAY(1000) OF varchar2(255);
	 list_name_users varr := varr('Morrison','Bennett','Brady','Coleman','Ford','Rios','Poole','Walters','Guerrero','Flores','Lee','Miller','Francis','French','Martin','Sherman','Graham','Garner','Maxwell','Estrada','Morales','Owen','Lawson','Benson','Hammond','Greene','Lamb','Castro','Perkins','Hughes','Barnes','Mckenzie','Watts','Anderson','Gregory','Alvarez','Yates','Fowler','Wilkins','Warren','Burns','Boone','Goodwin','Porter','Wheeler','Brock','Howard','Barton','Zimmerman','Hodges','Massey','Norton','Gibson','Strickland','Bell','Robinson','Graves','Craig','Howell','Hunt','Malone','Richards','Murphy','Nash','West','Lloyd','Paul','Fuller','Holloway','Goodman','Ryan','Reeves','Cole','Parker','Cohen','Ingram','Scott','Byrd','Hart','Casey','Franklin','Morgan','Mclaughlin','Lyons','Montgomery','Stephens','Glover','Roberts','Erickson','Allison','Ramos','Holland','Hawkins','Williamson','Edwards','Mccoy','Swanson','Delgado','Ellis','Collins','Boyd','Myers','Nichols','Wood','Rice','Wolfe','Stokes','Ortiz','Haynes','Mccormick');
	 list_surname_users_women varr := varr('Abbie', 'Abby', 'Gail', 'Nabby','Berenice','Bernice','Camille','Catherine','Cathryn', 'Catheryn','Catharine','Cathleen','Daisy','Fan','Fannie',
	 'Fanny', 'Fran', 'Frannie', 'Franny', 'Francie', 'Francy', 'France', 'Frankie', 'Franky','Helen', 'Helena','Lillian', 'Lilian','Margaret','Margarita','Marguerite',
	 'Margret','Maggie','Marge', 'Margie', 'Marjorie', 'Margery', 'Madge', 'Margot', 'Margo', 'Magsie','Maisie', 'Daisy', 'Mamie', 'Maidie', 'Mae','May', 'Meg', 'Megan', 
	 'Peggy', 'Greta', 'Gretchen', 'Rita','Selina', 'Selena', 'Selene', 'Celine', 'Celina', 'Celena','Lena', 'Lina');
	 list_surname_users_men varr := varr('Alister', 'Allister', 'Alistair', 'Alastair', 'Alaster','Albert', 'Adelbert', 'Bertram', 'Delbert', 'Egbert', 'Elbert', 'Gilbert', 'Herbert', 
	 'Hubert', 'Lambert','Osbert', 'Robert', 'Wilbert','Christopher', 'Kristopher','Dominic', 'Dominick', 'Domenic', 'Domenick' ,'Dom', 'Nick', 'Nicky','Edmund', 'Edmond','Frederick', 'Frederic', 
	 'Fredrick', 'Fredric', 'Fred', 'Freddie','Freddy', 'Rick', 'Ricky');
	 list_address varr := varr('123 Smith Street, Brunswick, VIC, 3056','Nieuwstraat 123, 1000 Brussel','123-789 Any Street, Hawkesbury, ON K6A 5B6',
	 'Del Puente 2782, Miraflores Bajo, 2561618 (Optional), Viña del Mar','12 Abbey Street, Killaskully, Co. Mayo','145 Larkfield Way, Rathfarnam, Dublin 4',
	 'Via Garibaldi 123, 00100','1600 Main Street Unit 123');
	 list_countries varr := varr('Australia','Belgia','Brazil','Chile','China','Cuba','Greece','Haiti','Romania','Qatar','Russia','Palau','Oman','Nigeria','Nauru','Ukraine','Uruguay','Yemen','Vatican');
	 list_company varr := varr('H&M','Bershka','New Yorker','Zara','Stradivarius','Pull&Bear');
	 
	 v_name VARCHAR2(255);
	 v_surname VARCHAR2(255);
	 v_address VARCHAR2(255);
	 v_country VARCHAR2(255);
	 v_type VARCHAR2(25);
	 v_organization_name VARCHAR2(255);
	 v_password VARCHAR2(25);
	 v_email VARCHAR2(255);
	 v_username VARCHAR(255);
	 
	 
	 list_category_name varr := varr('jacket','jeans','pajamas','pants','raincoat','scarf','shirt','socks','stockings','suit','sweater','sweatshirt','t-shirt', 'skirt');
	 list_category_season varr := varr('summer','winter','autumn','spring');
	
	 c_name VARCHAR2(255);
	 c_season VARCHAR2(25);

	 list_colors varr := varr('red', 'green', 'white', 'black', 'purple', 'brown', 'gray', 'yellow', 'blue', 'pink', 'orange');
	 list_size varr := varr('S', 'M', 'XS', 'L', 'XL', 'XXL');
	 list_material varr := varr('silk', 'cotton', 'wool', 'leather', 'fur', 'denim');
	 p_name VARCHAR2(255);
	 p_price INT;
	 p_rating INT;
	 p_id_category INT;
	 p_id_producer INT; 
	 p_color VARCHAR2(100);
	 p_size VARCHAR(5);
	 p_material VARCHAR2(100);
	 p_stock INT;
	 p_image VARCHAR2(255);
	 p_gender VARCHAR2(25);
	 nrProducts INT;
	 p_id INT;
	 category_name VARCHAR2(255);

	 pr_limited INT;
	 pr_id_category INT;
	 pr_id_product INT;
	 pr_percent INT;


	 list_status varr := varr('Placed', 'In transit', 'Ready for delivery', 'Delivered');
	 o_product INT;
	 o_user INT;
	 o_data DATE;
	 o_quantity INT;
	 o_status VARCHAR2(50);

BEGIN 
	DBMS_OUTPUT.PUT_LINE('Adding 1000000 users...');
	FOR id IN 1..1000000 LOOP
		-- choosing name
		v_name := list_name_users(TRUNC(DBMS_RANDOM.VALUE(0, list_name_users.count))+1);
		-- choosing surname
		IF (DBMS_RANDOM.VALUE(0, 100) < 50) THEN   
			v_surname := list_surname_users_women(TRUNC(DBMS_RANDOM.VALUE(0, list_surname_users_women.count))+1);
			else
			v_surname := list_surname_users_men(TRUNC(DBMS_RANDOM.VALUE(0, list_surname_users_men.count))+1);
		END IF;
		-- choosing if company or person
		IF (DBMS_RANDOM.VALUE(0, 100) < 40) THEN  
			v_type := 'company';
			v_organization_name := list_company(TRUNC(DBMS_RANDOM.VALUE(0, list_company.count))+1);
		else
			v_type :='person';
			v_organization_name :='';
		END IF;
		--choosing address and country
		v_address := list_address(TRUNC(DBMS_RANDOM.VALUE(0, list_address.count))+1);
		v_country := list_countries(TRUNC(DBMS_RANDOM.VALUE(0, list_countries.count))+1);
		-- choosing email
		v_email := LOWER(v_name ||'.'|| v_surname);
		IF (DBMS_RANDOM.VALUE(0, 100) < 50) THEN 
				v_email := v_email || '@yahoo.com';
			else 
				v_email := v_email || '@gmail.com';
		END IF;
		-- choosing username and password
		v_username := LOWER(v_name) || '~' || id;
		v_password := SUBSTR(v_name, 3) || '@' || SUBSTR(v_surname, 4);

		-- insert user into table 
		INSERT INTO users VALUES (id, v_type, v_organization_name, v_name, v_surname, v_username, v_password, v_email, v_address, v_country);
	END LOOP;	
	COMMIT;
	
	DBMS_OUTPUT.PUT_LINE('Added users, done!');
	
	DBMS_OUTPUT.PUT_LINE('Adding 50 categories...');
	FOR c_id IN 1..50 LOOP
		c_name := list_category_name(TRUNC(DBMS_RANDOM.VALUE(0, list_category_name.count))+1);
		c_season := list_category_season(TRUNC(DBMS_RANDOM.VALUE(0, list_category_season.count))+1);
		INSERT INTO categories VALUES (c_id, c_name, c_season);	
	END LOOP;
	COMMIT;
	
	DBMS_OUTPUT.PUT_LINE('Added categories, done!');

	DBMS_OUTPUT.PUT_LINE('Adding 1000000 products...');
	p_id := 0;
	FOR p_id_category IN 1..50 LOOP
		SELECT name INTO category_name FROM categories WHERE id = p_id_category; 
		FOR nrProducts IN 1..1000000/50 LOOP
			p_id := p_id + 1;
			p_price := TRUNC(DBMS_RANDOM.VALUE(1, 100));
			p_rating := TRUNC(DBMS_RANDOM.VALUE(1, 5));
			p_color := list_colors(TRUNC(DBMS_RANDOM.VALUE(0, list_colors.count))+1);
			p_size := list_size(TRUNC(DBMS_RANDOM.VALUE(0, list_size.count))+1);
			p_material := list_material(TRUNC(DBMS_RANDOM.VALUE(0, list_material.count))+1);
			p_stock := TRUNC(DBMS_RANDOM.VALUE(1, 200));
			p_image := 'images/products/' || p_id;
			p_id_producer := TRUNC(DBMS_RANDOM.VALUE(0, 1000000))+1;
			
			p_name := p_color || ' ' || category_name;
			IF (category_name = 'skirt') THEN 
				p_gender := 'female';
			ELSIF (TRUNC(DBMS_RANDOM.VALUE(0, 10)) < 5) THEN 
				p_gender := 'female';
			ELSE
				p_gender :='male';
			END IF;
			INSERT INTO products VALUES (p_id, p_id_category, p_name, p_price, p_id_producer, p_rating, p_image, p_color, p_size, p_material, p_stock, p_gender);
		END LOOP;
	END LOOP;
	COMMIT;

	DBMS_OUTPUT.PUT_LINE('Added products, done!');

	DBMS_OUTPUT.PUT_LINE('Adding 50 promotions...');
	FOR pr_id IN 1..50 LOOP
		pr_limited := TRUNC(DBMS_RANDOM.VALUE(1, 20));
		IF(TRUNC(DBMS_RANDOM.VALUE(0, 1))+1 = 1) THEN
			pr_id_category := TRUNC(DBMS_RANDOM.VALUE(0, 50)) + 1;
			pr_id_product := NULL;
			ELSE 
				pr_id_product := TRUNC(DBMS_RANDOM.VALUE(0, 1000000)) + 1;
				pr_id_category := NULL;
		END IF;
		pr_percent := TRUNC(DBMS_RANDOM.VALUE(5, 80));
		INSERT INTO promotions VALUES (pr_id, pr_id_category, pr_id_product, pr_limited, pr_percent);
	END LOOP;
	COMMIT;

	DBMS_OUTPUT.PUT_LINE('Added promotions, done!');

	DBMS_OUTPUT.PUT_LINE('Adding 500 orders...');
	FOR o_id IN 1..500 LOOP
		o_product := TRUNC(DBMS_RANDOM.VALUE(0, 1000000)) + 1;
		o_user := TRUNC(DBMS_RANDOM.VALUE(0, 1000000)) + 1;
		o_data := TO_DATE('01-01-2000','MM-DD-YYYY')+TRUNC(DBMS_RANDOM.VALUE(0, 365));
		o_quantity := TRUNC(DBMS_RANDOM.VALUE(0, 50)) + 1;
		o_status := list_status(TRUNC(DBMS_RANDOM.VALUE(0, list_status.count))+1);
		INSERT INTO orders VALUES (o_id, o_product, o_user, o_data, o_quantity, o_status);
	END LOOP;
	COMMIT;

	DBMS_OUTPUT.PUT_LINE('Added orders, done!');

END;
/
	CREATE INDEX index_category ON categories (name,season);
	CREATE INDEX index_promotions_product ON promotions (id_product);
	CREATE INDEX index_promotions_category ON promotions (id_category);
	
	CREATE INDEX index_price ON products (price);
	CREATE INDEX index_rating ON products (rating);
	CREATE INDEX index_size ON products (sizeProduct);
	CREATE INDEX index_color ON products (color);
	CREATE INDEX index_material ON products (materialType);

	
	CREATE INDEX index_users ON users (email, username, password);
	
/

SELECT COUNT(*) FROM users;