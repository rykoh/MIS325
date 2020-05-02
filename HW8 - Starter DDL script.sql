SET DEFINE OFF;
 
-- Begin an anonymous PL/SQL script that
-- drops all tables in the EX schema and
-- suppresses the error messages that are displayed if the tables don't exist
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE CUSTOMERS_EX';
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('');
END;
/
 
Commit;
  
 
CREATE TABLE CUSTOMERS_EX
(
  customer_id      	    NUMBER        	NOT NULL,
  customer_lastname     VARCHAR2(30),
  customer_firstname    VARCHAR2(30),
  customer_address 	    VARCHAR2(60),
  customer_city     	VARCHAR2(15),
  customer_state    	VARCHAR2(15),
  customer_zipcode     	VARCHAR2(10),
  customer_phonenum     VARCHAR2(24)
);
 
   
 
-- INSERT INTO CUSTOMERS_EX
INSERT INTO CUSTOMERS_EX VALUES (1, 'Anders', 'Maria', '345 Winchell Pl', 'Anderson', 'IN', '46014', '(765) 555-7878');
INSERT INTO CUSTOMERS_EX VALUES (2, 'Trujillo', 'Ana', '1298 E Smathers St', 'Benton', 'AR', '72018', '(501) 555-7733');
INSERT INTO CUSTOMERS_EX VALUES (3, 'Moreno', 'Antonio', '6925 N Parkland Ave', 'Puyallup', 'WA', '98373', '(253) 555-8332');
INSERT INTO CUSTOMERS_EX VALUES (4, 'Hardy', 'Thomas', '83 d''Urberville Ln', 'Casterbridge', 'GA', '31209', '(478) 555-1139');
INSERT INTO CUSTOMERS_EX VALUES (5, 'Berglund', 'Christina', '22717 E 73rd Ave', 'Dubuque', 'IA', '52004', '(319) 555-1139');
INSERT INTO CUSTOMERS_EX VALUES (6, 'Moos', 'Hanna', '1778 N Bovine Ave', 'Peoria', 'IL', '61638', '(309) 555-8755');
INSERT INTO CUSTOMERS_EX VALUES (7, 'Citeaux', 'Fred', '1234 Main St', 'Normal', 'IL', '61761', '(309) 555-1914');
INSERT INTO CUSTOMERS_EX VALUES (8, 'Summer', 'Martin', '1877 Ete Ct', 'Frogtown', 'LA', '70563', '(337) 555-9441');
INSERT INTO CUSTOMERS_EX VALUES (9, 'Lebihan', 'Laurence', '717 E Michigan Ave', 'Chicago', 'IL', '60611', '(312) 555-9441');
INSERT INTO CUSTOMERS_EX VALUES (10, 'Lincoln', 'Elizabeth', '4562 Rt 78 E', 'Vancouver', 'WA', '98684', '(360) 555-2680');
INSERT INTO CUSTOMERS_EX VALUES (11, 'Snyder', 'Howard', '2732 Baker Blvd.', 'Eugene', 'OR', '97403', '(503) 555-7555');
INSERT INTO CUSTOMERS_EX VALUES (12, 'Latimer', 'Yoshi', 'City Center Plaza 516 Main St.', 'Elgin', 'OR', '97827', '(503) 555-6874');
INSERT INTO CUSTOMERS_EX VALUES (13, 'Steel', 'John', '12 Orchestra Terrace', 'Walla Walla', 'WA', '99362', '(509) 555-7969');
INSERT INTO CUSTOMERS_EX VALUES (14, 'Yorres', 'Jaime', '87 Polk St. Suite 5', 'San Francisco', 'CA', '94117', '(415) 555-5938');
INSERT INTO CUSTOMERS_EX VALUES (15, 'Wilson', 'Fran', '89 Chiaroscuro Rd.', 'Portland', 'OR', '97219', '(503) 555-9573');
INSERT INTO CUSTOMERS_EX VALUES (16, 'Phillips', 'Rene', '2743 Bering St.', 'Anchorage', 'AK', '99508', '(907) 555-7584');
INSERT INTO CUSTOMERS_EX VALUES (17, 'Wilson', 'Paula', '2817 Milton Dr.', 'Albuquerque', 'NM', '87110', '(505) 555-5939');
INSERT INTO CUSTOMERS_EX VALUES (18, 'Pavarotti', 'Jose', '187 Suffolk Ln.', 'Boise', 'ID', '83720', '(208) 555-8097');
INSERT INTO CUSTOMERS_EX VALUES (19, 'Braunschweiger', 'Art', 'P.O. Box 555', 'Lander', 'WY', '82520', '(307) 555-4680');
INSERT INTO CUSTOMERS_EX VALUES (20, 'Nixon', 'Liz', '89 Jefferson Way Suite 2', 'Providence', 'RI', '02909', '(401) 555-3612');
INSERT INTO CUSTOMERS_EX VALUES (21, 'Wong', 'Liu', '55 Grizzly Peak Rd.', 'Butte', 'MT', '59801', '(406) 555-5834');
INSERT INTO CUSTOMERS_EX VALUES (22, 'Nagy', 'Helvetius', '722 DaVinci Blvd.', 'Concord', 'MA', '01742', '(351) 555-1219');
INSERT INTO CUSTOMERS_EX VALUES (23, 'Jablonski', 'Karl', '305 - 14th Ave. S. Suite 3B', 'Seattle', 'WA', '98128', '(206) 555-4112');
INSERT INTO CUSTOMERS_EX VALUES (24, 'Chelan', 'Donna', '2299 E Baylor Dr', 'Dallas', 'TX', '75224', '(469) 555-8828');
  
COMMIT;
 
--Create tables for om
SET DEFINE OFF;
 
-- Begin an anonymous PL/SQL script that
-- drops all tables in the EX schema and
-- suppresses the error messages that are displayed if the tables don't exist
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE CUSTOMERS_OM';
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('');
END;
/
 
CREATE TABLE CUSTOMERS_OM
(
  customer_id       	NUMBER      	NOT NULL,
  customer_first_name   VARCHAR2(50),
  customer_last_name    VARCHAR2(50)	NOT NULL,
  customer_address      VARCHAR2(255)   NOT NULL,
  customer_city     	VARCHAR2(50)	NOT NULL,
  customer_state    	CHAR(2)     	NOT NULL,
  customer_zip      	VARCHAR2(20)	NOT NULL,
  customer_phone        VARCHAR2(30)	NOT NULL,
  customer_fax      	VARCHAR2(30),
  CONSTRAINT CUSTOMERS_OM_pk
	PRIMARY KEY (customer_id)
);
  
-- INSERT INTO CUSTOMERS_OM
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (1,'Korah','Blanca','1555 W Lane Ave','Columbus','OH','43221','6145554435','6145553928');
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (2,'Yash','Randall','11 E Rancho Madera Rd','Madison','WI','53707','2095551205','2095552262');
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (3,'Johnathon','Millerton','60 Madison Ave','New York','NY','10010','2125554800',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (4,'Mikayla','Damion','2021 K Street Nw','Washington','DC','20006','2025555561',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (5,'Kendall','Mayte','4775 E Miami River Rd','Cleves','OH','45002','5135553043',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (6,'Kaitlin','Hostlery','3250 Spring Grove Ave','Cincinnati','OH','45225','8005551957','8005552826');
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (7,'Derek','Chaddick','9022 E Merchant Wy','Fairfield','IA','52556','5155556130',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (8,'Deborah','Damien','415 E Olive Ave','Fresno','CA','93728','5595558060',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (9,'Karina','Lacy','882 W Easton Wy','Los Angeles','CA','90084','8005557000',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (10,'Kurt','Nickalus','28210 N Avenue Stanford','Valencia','CA','91355','8055550584','8055556689');
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (11,'Kelsey','Eulalia','7833 N Ridge Rd','Sacramento','CA','95887','2095557500','2095551302');
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (12,'Anders','Rohansen','12345 E 67th Ave NW','Takoma Park','MD','24512','3385556772',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (13,'Thalia','Neftaly','2508 W Shaw Ave','Fresno','CA','93711','5595556245',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (14,'Gonzalo','Keeton','12 Daniel Road','Fairfield','NJ','07004','2015559742',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (15,'Ania','Irvin','1099 N Farcourt St','Orange','CA','92807','7145559000',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (16,'Dakota','Baylee','1033 N Sycamore Ave.','Los Angeles','CA','90038','2135554322',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (17,'Samuel','Jacobsen','3433 E Widget Ave','Palo Alto','CA','92711','4155553434',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (18,'Justin','Javen','828 S Broadway','Tarrytown','NY','10591','8005550037',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (19,'Kyle','Marissa','789 E Mercy Ave','Phoenix','AZ','85038','9475553900',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (20,'Erick','Kaleigh','Five Lakepointe Plaza, Ste 500','Charlotte','NC','28217','7045553500',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (21,'Marvin','Quintin','2677 Industrial Circle Dr','Columbus','OH','43260','6145558600','6145557580');
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (22,'Rashad','Holbrooke','3467 W Shaw Ave #103','Fresno','CA','93711','5595558625','5595558495');
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (23,'Trisha','Anum','627 Aviation Way','Manhatttan Beach','CA','90266','3105552732',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (24,'Julian','Carson','372 San Quentin','San Francisco','CA','94161','6175550700',NULL);
INSERT INTO CUSTOMERS_OM
(customer_id,customer_first_name,customer_last_name,customer_address,customer_city,customer_state,customer_zip,customer_phone,customer_fax)
VALUES (25,'Kirsten','Story','2401 Wisconsin Ave NW','Washington','DC','20559','2065559115',NULL);
  
COMMIT;
 
--Create tables for mgs
SET DEFINE OFF;
 
-- Use an anonymous PL/SQL script to
-- drop all tables and sequences in the current schema and
-- suppress any error messages that may displayed
-- if these objects don't exist
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE addresses';
  EXECUTE IMMEDIATE 'DROP TABLE customers_mgs';
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(''); 
END;
/
  
 
CREATE TABLE CUSTOMERS_mgs (
  customer_id       	NUMBER      	PRIMARY KEY,
  email_address     	VARCHAR2(255)   NOT NULL      UNIQUE,
  password          	VARCHAR2(60)	NOT NULL,
  first_name        	VARCHAR2(60)	NOT NULL,
  last_name         	VARCHAR2(60)	NOT NULL,
  shipping_address_id   NUMBER                    	DEFAULT NULL,
  billing_address_id	NUMBER                    	DEFAULT NULL
);
 
CREATE TABLE addresses (
  address_id     	NUMBER      	PRIMARY KEY,
  customer_id    	NUMBER      	REFERENCES CUSTOMERS_mgs (customer_id),
  line1          	VARCHAR2(60)    NOT NULL,
  line2          	VARCHAR2(60)                 	DEFAULT NULL,
  city           	VARCHAR2(40)	NOT NULL,
  state          	VARCHAR2(2) 	NOT NULL,
  zip_code       	VARCHAR2(10)	NOT NULL,
  phone          	VARCHAR2(12)	NOT NULL,
  disabled       	NUMBER(1)                    	DEFAULT 0
);
 
 
-- Disable substitution variable prompting
SET DEFINE OFF;
 
   
 
INSERT INTO CUSTOMERS_mgs (customer_id, email_address, password, first_name, last_name, shipping_address_id, billing_address_id) VALUES
(1, 'allan.sherwood@yahoo.com', '650215acec746f0e32bdfff387439eefc1358737', 'Allan', 'Sherwood', 1, 2);
INSERT INTO CUSTOMERS_mgs (customer_id, email_address, password, first_name, last_name, shipping_address_id, billing_address_id) VALUES
(2, 'barryz@gmail.com', '3f563468d42a448cb1e56924529f6e7bbe529cc7', 'Barry', 'Zimmer', 3, 3);
INSERT INTO CUSTOMERS_mgs (customer_id, email_address, password, first_name, last_name, shipping_address_id, billing_address_id) VALUES
(3, 'christineb@solarone.com', 'ed19f5c0833094026a2f1e9e6f08a35d26037066', 'Christine', 'Brown', 4, 4);
INSERT INTO CUSTOMERS_mgs (customer_id, email_address, password, first_name, last_name, shipping_address_id, billing_address_id) VALUES
(4, 'david.goldstein@hotmail.com', 'b444ac06613fc8d63795be9ad0beaf55011936ac', 'David', 'Goldstein', 5, 6);
INSERT INTO CUSTOMERS_mgs (customer_id, email_address, password, first_name, last_name, shipping_address_id, billing_address_id) VALUES
(5, 'erinv@gmail.com', '109f4b3c50d7b0df729d299bc6f8e9ef9066971f', 'Erin', 'Valentino', 7, 7);
INSERT INTO CUSTOMERS_mgs (customer_id, email_address, password, first_name, last_name, shipping_address_id, billing_address_id) VALUES
(6, 'frankwilson@sbcglobal.net', '3ebfa301dc59196f18593c45e519287a23297589', 'Frank Lee', 'Wilson', 8, 8);
INSERT INTO CUSTOMERS_mgs (customer_id, email_address, password, first_name, last_name, shipping_address_id, billing_address_id) VALUES
(7, 'gary_hernandez@yahoo.com', '1ff2b3704aede04eecb51e50ca698efd50a1379b', 'Gary', 'Hernandez', 9, 10);
INSERT INTO CUSTOMERS_mgs (customer_id, email_address, password, first_name, last_name, shipping_address_id, billing_address_id) VALUES
(8, 'heatheresway@mac.com', '911ddc3b8f9a13b5499b6bc4638a2b4f3f68bf23', 'Heather', 'Esway', 11, 12);
 
 
INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(1, 1, '100 East Ridgewood Ave.', '', 'Paramus', 'NJ', '07652', '201-653-4472', 0);
INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(2, 1, '21 Rosewood Rd.', '', 'Woodcliff Lake', 'NJ', '07677', '201-653-4472', 0);
INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(3, 2, '16285 Wendell St.', '', 'Omaha', 'NE', '68135', '402-896-2576', 0);
INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(4, 3, '19270 NW Cornell Rd.', '', 'Beaverton', 'OR', '97006', '503-654-1291', 0);
INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(5, 4, '186 Vermont St.', 'Apt. 2', 'San Francisco', 'CA', '94110', '415-292-6651', 0);
INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(6, 4, '1374 46th Ave.', '', 'San Francisco', 'CA', '94129', '415-292-6651', 0);
INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(7, 5, '6982 Palm Ave.', '', 'Fresno', 'CA', '93711', '559-431-2398', 0);
INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(8, 6, '23 Mountain View St.', '', 'Denver', 'CO', '80208', '303-912-3852', 0);
INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(9, 7, '7361 N. 41st St.', 'Apt. B', 'New York', 'NY', '10012', '212-335-2093', 0);
INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(10, 7, '3829 Broadway Ave.', 'Suite 2', 'New York', 'NY', '10012', '212-335-2093', 0);
INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(11, 8, '2381 Buena Vista St.', '', 'Los Angeles', 'CA', '90023', '213-772-5033', 0);
INSERT INTO addresses (address_id, customer_id, line1, line2, city, state, zip_code, phone, disabled) VALUES
(12, 8, '291 W. Hollywood Blvd.', '', 'Los Angeles', 'CA', '90024', '213-772-5033', 0);
 
  
COMMIT;
 




