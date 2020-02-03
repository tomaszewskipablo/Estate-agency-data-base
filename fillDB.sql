Drop database	mydb;
-- -----------------------------------------------------
-- Table PERSON fill
-- -----------------------------------------------------
delimiter //
CREATE PROCEDURE fill_person(IN counter INT)
BEGIN
DECLARE first_name VARCHAR(45);
DECLARE surname VARCHAR(45);
DECLARE age INT;
DECLARE gender enum('M','W');
DECLARE date_of_birth date;

WHILE counter > 0 DO
    SET first_name = CONCAT('name',counter);
    SET surname = CONCAT('surname',counter);
    SET age = FLOOR(18+RAND()* (70));
    SET date_of_birth  = NOW();
    
   SET gender = 'M';
    
    INSERT INTO PERSON (IDPERSON, FIRST_NAME, SURNAME, AGE, GENDER, DATE_OF_BIRTH)
    VALUES (counter, first_name, surname, age, gender, date_of_birth);
    SET counter = counter - 1;
END WHILE;
END //
delimiter ; 

call fill_person(100);

select * from person;

-- -----------------------------------------------------
-- Table CUSTOMER fill
-- -----------------------------------------------------
delimiter //
CREATE PROCEDURE fill_customer(
IN num INT)
BEGIN
declare salary INT;
declare profession varchar(45);
declare id_Person INT;
DECLARE RememberNum INT;
DECLARE Random INT;

DECLARE done INT;
DECLARE PersonCursor CURSOR FOR SELECT idPerson FROM person;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SET done = false;
OPEN PersonCursor;

SET RememberNum = num;

Person_Loop: LOOP

    IF done THEN
      LEAVE Person_Loop;
    END IF;
    SET num = RememberNum;
    WHILE num > 0 DO
    
        FETCH PersonCursor INTO id_Person;
    
    SET salary = FLOOR(2000 + (RAND() * 3000));
	
    SET Random = FLOOR(1 + (RAND() * 5));
    IF Random = 1 THEN SET profession = 'teacher'; END IF;
   IF Random = 2 THEN SET profession = 'softewere developer'; END IF;
    IF Random = 3 THEN SET profession = 'project manager'; END IF;
    IF Random = 4 THEN SET profession = 'doctor'; END IF;
   IF Random = 5 THEN SET profession = 'nurse'; END IF;
    
    
    INSERT INTO Customer(salary, profession, personFKCustomer)
    VALUES (salary, profession, id_Person);
    SET num = num - 1;
    
	END WHILE;
END LOOP;

CLOSE PersonCursor;

END //
delimiter ;

call fill_customer(100);

select * from customer;

-- -----------------------------------------------------
-- Table ESTATE_AGENT fill
-- -----------------------------------------------------
delimiter //
CREATE PROCEDURE fill_estate_agent(
IN num INT)
BEGIN
declare office_name varchar(45);
declare id_Person INT;
DECLARE RememberNum INT;
DECLARE Random INT;

DECLARE done INT;
DECLARE PersonCursor CURSOR FOR SELECT idPerson FROM person;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SET done = false;
OPEN PersonCursor;

SET RememberNum = num;

Person_Loop: LOOP

    IF done THEN
      LEAVE Person_Loop;
    END IF;
    SET num = RememberNum;
    WHILE num > 0 DO
    
        FETCH PersonCursor INTO id_Person;
   
    SET Random = FLOOR(1 + (RAND() * 5));
    IF Random = 1 THEN SET office_name= 'JohnCompany'; END IF;
    IF Random = 2 THEN SET office_name= 'BestEstate';END IF;
    IF Random = 3 THEN SET office_name= 'YourHome'; END IF;
    IF Random = 4 THEN SET office_name=  'RobertsonHouses';END IF;
    IF Random = 5 THEN SET office_name=  'life';END IF;
    
    INSERT INTO estate_agent(office_name, personFKEstate_agent)
    VALUES (office_name, id_Person);
    SET num = num - 1;
    
	END WHILE;
END LOOP;

CLOSE PersonCursor;

END //
delimiter ;

call fill_estate_agent(100);

select * from estate_agent;
-- -----------------------------------------------------
-- Table PROPERTY_OWNER fill
-- -----------------------------------------------------
delimiter //
CREATE PROCEDURE fill_property_owner(
IN num INT)
BEGIN
declare phone_number INT;

declare id_Person INT;
DECLARE RememberNum INT;


DECLARE done INT;
DECLARE PersonCursor CURSOR FOR SELECT idPerson FROM person;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SET done = false;
OPEN PersonCursor;

SET RememberNum = num;

Person_Loop: LOOP

    IF done THEN
      LEAVE Person_Loop;
    END IF;
    SET num = RememberNum;
    WHILE num > 0 DO
    
        FETCH PersonCursor INTO id_Person;
   
  SET phone_number = FLOOR(100000000 + (RAND() * 899999999));
  
    INSERT INTO property_owner(phone_number,personFkProperty_owner )
    VALUES (phone_number, id_Person);
    SET num = num - 1;
    
	END WHILE;
END LOOP;

CLOSE PersonCursor;

END //
delimiter ;

call fill_property_owner(100);

select * from property_owner;

-- *****************************************************
-- 						ADRESS
-- *****************************************************

-- -----------------------------------------------------
-- Table COUNTRY fill
-- -----------------------------------------------------
delimiter //
CREATE PROCEDURE fill_country(IN counter INT)
BEGIN
DECLARE country VARCHAR(45);
declare Random INT; 

WHILE counter > 0 DO
  
	SET Random = FLOOR(1 + (RAND() * 7));
    IF Random= 1 THEN SET country= 'Slovenia'; END IF;
    IF Random = 2 THEN SET country= 'Poland';END IF;
    IF Random = 3 THEN SET country= 'Germany'; END IF;
    IF Random = 4 THEN SET country=  'Austria';END IF;
    IF Random = 5 THEN SET country=  'Spain';END IF;
    IF Random = 6 THEN SET country= 'France'; END IF;
    IF Random = 7 THEN SET country=  'Italy';END IF;
    IF Random = 8 THEN SET country=  'Croatia';END IF;
    

    INSERT INTO country(country)
    VALUES (country);
    SET counter = counter - 1;
END WHILE;
END //
delimiter ; 

call fill_country(10);

select * from country;

-- -----------------------------------------------------
-- Table City fill
-- -----------------------------------------------------

delimiter //
CREATE PROCEDURE fill_city(
IN num INT)
BEGIN
declare city varchar(45);
declare id_Country INT;
DECLARE RememberNum INT;


DECLARE done INT;
DECLARE CountryCursor CURSOR FOR SELECT id FROM country;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SET done = false;
OPEN CountryCursor;

SET RememberNum = num;

Country_Loop: LOOP

FETCH CountryCursor INTO id_Country; 
    IF done THEN
      LEAVE Country_Loop;
    END IF;
    SET num = RememberNum;
    WHILE num > 0 DO
    
       
   
	SET city = CONCAT('city',num);
    
    INSERT INTO city(city, country_id)
    VALUES (city, id_Country);
    SET num = num - 1;
    
	END WHILE;
END LOOP;


CLOSE CountryCursor;

END //
delimiter ;

call fill_city(10);

select * from city;

-- -----------------------------------------------------
-- Table ZIP_CODE fill
-- -----------------------------------------------------

delimiter //
CREATE PROCEDURE fill_zip_code(
IN num INT)
BEGIN
declare zip_code varchar(45);
declare id_City INT;
DECLARE RememberNum INT;


DECLARE done INT;
DECLARE CityCursor CURSOR FOR SELECT id FROM city;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SET done = false;
OPEN CityCursor;

SET RememberNum = num;

City_Loop: LOOP

FETCH CityCursor INTO id_City;
    IF done THEN
      LEAVE City_Loop;
    END IF;
    SET num = RememberNum;
     
     
    WHILE num > 0 DO
    
   
	SET zip_code =  FLOOR(10000 + (RAND() * 8999));
    
    INSERT INTO zip_code(zip_code, city_id)
    VALUES (zip_code, id_City);
    SET num = num - 1;
    
	END WHILE;
END LOOP;

CLOSE CityCursor;

END //
delimiter ;

call fill_Zip_code(10);

select * from zip_code;

-- -----------------------------------------------------
-- Table STREET fill
-- -----------------------------------------------------

delimiter //
CREATE PROCEDURE fill_street(
IN num INT)
BEGIN
declare street varchar(45);
declare id_zip_code INT;
DECLARE RememberNum INT;


DECLARE done INT;
DECLARE Zip_codeCURSOR CURSOR FOR SELECT id FROM Zip_code;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SET done = false;
OPEN Zip_codeCursor;

SET RememberNum = num;

Zip_code_Loop: LOOP

FETCH Zip_codeCursor INTO id_Zip_code;
    IF done THEN
      LEAVE Zip_code_Loop;
    END IF;
    SET num = RememberNum;
     
     
    WHILE num > 0 DO
    
    
	SET street = CONCAT('street',num);
    
    INSERT INTO street(street, Zip_code_id)
    VALUES (street, id_Zip_code);
    SET num = num - 1;
    
	END WHILE;
END LOOP;

CLOSE Zip_codeCursor;

END //
delimiter ;

call fill_street(10);

select * from street;

- -----------------------------------------------------
-- Table HOUSE_NUMBER fill
-- -----------------------------------------------------

delimiter //
CREATE PROCEDURE fill_house_number(
IN num INT)
BEGIN
declare house_number varchar(45);
declare street_id INT;
DECLARE RememberNum INT;


DECLARE done INT;
DECLARE streetCURSOR CURSOR FOR SELECT id FROM Street;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SET done = false;
OPEN streetCursor;

SET RememberNum = num;

Street_Loop: LOOP

FETCH StreetCursor INTO Street_id;
    IF done THEN
      LEAVE Street_Loop;
    END IF;
    SET num = RememberNum;
     
     
    WHILE num > 0 DO
    
    
	SET house_number =  FLOOR(1 + (RAND() * 70));
    
    INSERT INTO House_number(house_number, street_id)
    VALUES (house_number, street_id);
    SET num = num - 1;
    
	END WHILE;
END LOOP;

CLOSE streetCursor;

END //
delimiter ;

call fill_house_number(10);

select * from house_number;
-- -----------------------------------------------------
-- Table surrounding_area fill
-- -----------------------------------------------------
drop procedure fill_surrounding_area
delimiter //
CREATE PROCEDURE fill_surrounding_area(IN counter INT)
BEGIN
DECLARE number_of_parks INT;
DECLARE number_of_lakes INT;
DECLARE calm TINYINT;
DECLARE high_buildings_nearby TINYINT;
DECLARE metro TINYINT;
DECLARE description longtext;

WHILE counter > 0 DO
  

    SET number_of_parks = FLOOR((RAND() * 7));
    SET number_of_lakes = FLOOR( (RAND() * 7));
    SET calm = FLOOR( (RAND() * 2));
    SET high_buildings_nearby = FLOOR( (RAND() * 2));
    SET metro = FLOOR( (RAND() * 2));
    set description = "Lorem ipsul";

    INSERT INTO Surrounding_area(number_of_parks,number_of_lakes,calm,high_buildings_nearby,metro,description)
    VALUES (number_of_parks,number_of_lakes,calm,high_buildings_nearby,metro,description);
    SET counter = counter - 1;
END WHILE;
END //
delimiter ; 

call fill_surrounding_area(10);

select * from surrounding_area;


-- -----------------------------------------------------
-- Table PROPERTY fill
-- -----------------------------------------------------

delimiter //
CREATE PROCEDURE fill_property(
IN num INT)
BEGIN
DECLARE Surrounding_area_id INT;
DECLARE Property_owner_id INT;
DECLARE house_number_id INT;
DECLARE value INT;
DECLARE number_of_squere_meters INT;
DECLARE number_of_rooms INT;
DECLARE number_of_bathrooms INT;
DECLARE number_of_bedrooms INT;
DECLARE is_balcony TINYINT;
DECLARE number_of_storeies INT;
DECLARE description LONGTEXT;
DECLARE build_in DATE;
DECLARE renovated_in DATE;
DECLARE expected_price INT;

DECLARE rememberNum INT;

DECLARE done INT;
DECLARE Surrounding_areaCursor CURSOR FOR SELECT id FROM Surrounding_area;
DECLARE Property_ownerCURSOR CURSOR FOR SELECT id FROM property_owner;
DECLARE house_numberCURSOR CURSOR FOR SELECT id FROM house_number;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SET done = false;
OPEN Surrounding_areaCursor;
OPEN Property_ownerCURSOR;
OPEN house_numberCURSOR;
SET rememberNum=num;
SET @MIN = '1930-01-01';
SET @MAX = '1990-12-30';
SET @MIN2 = '1990-01-01';
SET @MAX2 = '2019-12-30';

    property_Loop: LOOP
    FETCH Surrounding_areaCursor INTO Surrounding_area_id;
    IF done THEN
      LEAVE property_Loop;
    END IF;
	SET num=rememberNum;
    WHILE num > 0 DO
	FETCH Property_ownerCURSOR INTO property_owner_id;
    FETCH house_numberCURSOR INTO house_number_id;
    
 
    
SET value = Floor(60000 + (RAND() * 100000));
SET number_of_squere_meters = Floor(20 + (RAND() * 300));
SET number_of_rooms = Floor(2 + (RAND() * 8));
SET number_of_bathrooms = Floor(1 + (RAND() * 2));
SET number_of_bedrooms = Floor(1 + (RAND() * 3));
SET is_balcony = Floor((RAND() * 2));
SET number_of_storeies = Floor(1 + (RAND() * 2));
SET description = "LOREN impsuM";
SET build_in = TIMESTAMPADD(SECOND, FLOOR(RAND() * TIMESTAMPDIFF(SECOND, @MIN, @MAX)), @MIN);
SET renovated_in = TIMESTAMPADD(SECOND, FLOOR(RAND() * TIMESTAMPDIFF(SECOND, @MIN2, @MAX2)), @MIN);
SET expected_price = number_of_squere_meters * 2800;
    
    
    
    INSERT INTO property(value, number_of_squere_meters, number_of_rooms, number_of_bathrooms, number_of_bedrooms, is_balcony, number_of_storeies, description, build_in, renovated_in,expected_price, Surrounding_area_id, Property_owner_id,house_number_id)
    VALUES (value, number_of_squere_meters, number_of_rooms, number_of_bathrooms, number_of_bedrooms, is_balcony, number_of_storeies, description, build_in, renovated_in,expected_price, Surrounding_area_id, Property_owner_id,house_number_id);
    SET num = num - 1;
    
	END WHILE;
END LOOP;

CLOSE Surrounding_areaCursor;
CLOSE Property_ownerCursor;
CLOSE house_numberCursor;

END //
delimiter ;

call fill_property(10);

select * from property;

-- -----------------------------------------------------
-- Table SALE fill
-- -----------------------------------------------------

DROP procedure fill_sale;
delimiter //
CREATE PROCEDURE fill_sale(
IN num INT)
BEGIN
DECLARE Customer_id INT;
DECLARE Estate_agent_id INT;
DECLARE Property_id INT;
DECLARE date DATE;
DECLARE price INT;

DECLARE rememberNum INT;

DECLARE done INT;
DECLARE CustomerCursor CURSOR FOR SELECT idCustomer FROM Customer;
DECLARE Estate_agentCURSOR CURSOR FOR SELECT idEstateAgent FROM Estate_agent;
DECLARE PropertyCURSOR CURSOR FOR SELECT id FROM Property;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SET done = false;
OPEN CustomerCursor;
OPEN Estate_agentCURSOR;
OPEN PropertyCURSOR;
SET rememberNum=num;


    sale_Loop: LOOP
    FETCH Estate_agentCursor INTO Estate_agent_id;
    IF done THEN
      LEAVE sale_Loop;
    END IF;
	SET num=rememberNum;
    WHILE num > 0 DO
	FETCH propertyCURSOR INTO property_id;
    FETCH CustomerCURSOR INTO Customer_id;
    
 
    
SET price = Floor(60000 + (RAND() * 100000));
SET date = NOW();

    
    
    INSERT INTO sale(date, price, Customer_id,Estate_agent_id,Property_id)
    VALUES (date, price, Customer_id,Estate_agent_id,Property_id);
    SET num = num - 1;
    
	END WHILE;
END LOOP;

CLOSE CustomerCursor;
CLOSE Estate_agentCursor;
CLOSE PropertyCursor;

END //
delimiter ;

call fill_sale(10);

select * from sale;

-- -----------------------------------------------------
-- Table VISIT fill
-- -----------------------------------------------------
drop procedure fill_Visit;
delimiter //
CREATE PROCEDURE fill_Visit(
IN num INT)
BEGIN
DECLARE idVisit INT;
DECLARE date date;
DECLARE duration TIME;
DECLARE value INT;
DECLARE Estate_agentFK INT;
DECLARE CustumerFK INT;
DECLARE Property_id INT;

DECLARE rememberNum INT;

DECLARE done INT;
DECLARE Estate_agentCursor CURSOR FOR SELECT idEstateAgent FROM estate_agent;
DECLARE CustomerCURSOR CURSOR FOR SELECT idCustomer FROM customer;
DECLARE PropertyCURSOR CURSOR FOR SELECT id FROM property;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
SET done = false;
OPEN Estate_agentCursor;
OPEN CustomerCURSOR;
OPEN PropertyCURSOR;
SET rememberNum=num;

    visit_Loop: LOOP
    FETCH Estate_agentCursor INTO Estate_agentFK;
    IF done THEN
      LEAVE visit_Loop;
    END IF;
	SET num=rememberNum;
    WHILE num > 0 DO
	FETCH CustomerCURSOR INTO CustumerFK;
    FETCH PropertyCURSOR INTO Property_id;
    
 
    
SET date = NOW();
SET duration = "01:22:00";
    
    
    INSERT INTO visit(date, duration, Estate_agentFK, CustomerFK, Property_id)
    VALUES (date, duration, Estate_agentFK, CustomerFK, Property_id);
    SET num = num - 1;
    
	END WHILE;
END LOOP;

CLOSE Estate_agentCursor;
CLOSE PropertyCURSOR;
CLOSE CustomerCURSOR;

END //
delimiter ;

call fill_visit(10);

select * from visit;
