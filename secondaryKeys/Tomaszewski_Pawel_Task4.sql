-- Display information about estate agent whos age is 30, property sold by him is 146012 and works in office named JohnCompany
CREATE index age_index on person(age);
DROP index age_index on person;
CREATE index price_index on sale(price);
DROP index price_index on sale;
CREATE index date_of_sale_index on sale(date);
DROP index date_of_sale_index on sale;
CREATE index office_name_index on estate_agent(office_name);
DROP index office_name_index on estate_agent;

explain 
SELECT p.first_name, p.surname, p.age, e.office_name
FROM person p
JOIN estate_agent e
ON p.idPerson = e.idEstateAgent
JOIN sale s
ON e.idEstateAgent = s.Estate_agent_id
WHERE p.age = 30
AND s.price = 146012
AND e.office_name = 'JohnCompany';

SHOW index FROM sale;
-- disply countries with number of properties (enought to connect house_number table, cause one house number -> one property ) and number of street in the country
CREATE index house_number_index on house_number(house_number);
DROP index house_number_index on house_number;
CREATE index street_index on street(street);
DROP index house_number_index on house_number;

explain
SELECT cou.country, COUNT(h.id), COUNT(DISTINCT s.id)
FROM country cou
LEFT JOIN city cit
ON cou.id = cit.country_id
LEFT JOIN zip_code z
ON  cit.id = z.City_id
LEFT JOIN  street s
ON  z.id = s.zip_code_id
LEFT JOIN house_number h
ON  s.id = h.street_id
GROUP BY cou.id;

show indexes FROM house_number;
-- Show names, surnames and phone numbers from thoes property owners who have at least one property 130 squere meters
-- surrounded by 2 lakes and 4 parks

CREATE index number_of_parks_index on surrounding_area(number_of_parks);
DROP index number_of_parks_index on surrounding_area;

CREATE index number_of_lakes_index on surrounding_area(number_of_lakes);
DROP index number_of_lakes_index on surrounding_area;

CREATE index number_of_squere_meters_index on property(number_of_squere_meters);
DROP index number_of_squere_meters_index on property;

explain
select per.first_name, per.surname,  p_o.phone_number
from property_owner p_o
JOIN person per
ON per.idPerson = p_o.personFkProperty_owner
WHERE
p_o.id IN( 
SELECT p.Property_owner_id
from property p
JOIN surrounding_area s
ON s.id = p.Surrounding_area_id
WHERE p.number_of_squere_meters = 130
AND s.number_of_parks = 4
AND s.number_of_lakes = 2);

-- show esatet agent named "name1" with property sold for the most from properties having at least 100 squere meters ONE INDEX(NAME)
CREATE index number_of_squere_meters_index on property(number_of_squere_meters);
DROP index number_of_squere_meters_index on property;
CREATE index price_index on sale(price);
DROP index price_index on sale;
CREATE index office_name_index on sale(price);
CREATE index name_index on person(first_name);
DROP index name_index on person;

explain
SELECT p.first_name, p.surname, p.age, e.office_name
FROM person p
JOIN estate_agent e
ON p.idPerson = e.idEstateAgent
JOIN sale s
ON s.Estate_agent_id = idEstateAgent
WHERE p.first_name ="name1"
AND s.price >= ALL (SELECT s.price FROM sale s JOIN property prop
ON s.Property_id = prop.id WHERE prop.number_of_squere_meters >= 100);
