
--Drops all Credit Union tables--
DROP TABLE Transaction_History;
DROP TABLE Loans;
DROP TABLE Employees;
DROP TABLE Branch;
DROP TABLE Member_Tax_ID;
DROP TABLE Member_Phone;
DROP TABLE member_address_link;
DROP TABLE member_address;
DROP TABLE members;

--Drop all sequences--
DROP SEQUENCE memberID_seq;
DROP SEQUENCE transactionID_seq;
DROP SEQUENCE employeeID_seq;
DROP SEQUENCE addressID_seq;
DROP SEQUENCE phoneID_seq;
DROP SEQUENCE BranchNumber_seq;

--Create Sequence Section--
CREATE SEQUENCE memberID_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE transactionID_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE employeeID_seq
    START WITH 90000
    INCREMENT BY 1;

CREATE SEQUENCE addressID_seq
    START WITH 1
    INCREMENT BY 1;

CREATE SEQUENCE phoneID_seq
    START WITH 1
    INCREMENT BY 1;
    
CREATE SEQUENCE BranchNumber_seq
    START WITH 1
    INCREMENT BY 1;
    
    
-----Create Table Section-----
CREATE TABLE Members
(
        memberID    NUMBER(20)      DEFAULT memberID_seq.NEXTVAL PRIMARY KEY,
        firstName   VARCHAR(20)     NOT NULL,
        middleName  VARCHAR(20),
        lastName    VARCHAR(30)     NOT NULL,
        email       VARCHAR(40)     UNIQUE          NOT NULL,
        CONSTRAINT email_length_check CHECK(LENGTH(email) >=7)
);

--Creates address table and attributes--
CREATE TABLE Member_Address
(
        addressID       NUMBER(20)      DEFAULT addressID_seq.NEXTVAL PRIMARY KEY,
        addressLineOne  VARCHAR(50)     NOT NULL,
        addressLineTwo  VARCHAR(50),
        city            VARCHAR(40)     NOT NULL,
        addressState    CHAR(2)         NOT NULL,
        zipCode         CHAR(5)         NOT NULL
);

--Creates linking table between members and address with a composite primary key--
CREATE TABLE Member_Address_Link
(
        memberID        NUMBER(20),
        addressID       NUMBER(20),
        addressStatus   CHAR(1)         NOT NULL,
        CONSTRAINT memberID_addressID_pk PRIMARY KEY (memberID, addressID),
        CONSTRAINT memberID_link_fk FOREIGN KEY (memberID) REFERENCES members(memberID),
        CONSTRAINT addressID_link_fk FOREIGN KEY (addressID) REFERENCES member_address(addressID)
);

--Creates phone table and attributes--
CREATE TABLE Member_Phone
(
        phoneID         NUMBER(20)      DEFAULT phoneID_seq.NEXTVAL PRIMARY KEY,
        memberID        NUMBER(20)      NOT NULL,
        phoneNumber     CHAR(12)        NOT NULL,
        phoneType       VARCHAR(10)     NOT NULL,
        CONSTRAINT memberID_phone_fk FOREIGN KEY (memberID) REFERENCES members(memberID)
);

--Creates taxID table and attributes, one-to-one relationship with members table--
CREATE TABLE Member_Tax_ID
(
        memberID        NUMBER(20)      PRIMARY KEY,
        taxID           CHAR(9)         UNIQUE          NOT NULL,
        CONSTRAINT memberID_taxID_fk FOREIGN KEY (memberID) REFERENCES members(memberID)
);

--Creates Branch table and attributes--
CREATE TABLE Branch
(
        BranchNumber    NUMBER(20)      DEFAULT BranchNumber_seq.NEXTVAL PRIMARY KEY,
        BranchName      VARCHAR(30)     UNIQUE          NOT NULL,
        address         VARCHAR(50)     NOT NULL,
        city            VARCHAR(40)     NOT NULL,
        addressState    CHAR(2)         NOT NULL,
        zipCode         CHAR(5)         NOT NULL
);

--Creates Employees table and attributes--
CREATE TABLE Employees
(
        employeeID      NUMBER(20)      DEFAULT employeeID_seq.NEXTVAL PRIMARY KEY,
        BranchNumber    NUMBER(20)      NOT NULL,
        firstName       VARCHAR(20)     NOT NULL,
        lastName        VARCHAR(30)     NOT NULL,
        address         VARCHAR(50)     NOT NULL,
        city            VARCHAR(40)     NOT NULL,
        addressState    CHAR(2)         NOT NULL,
        zipCode         CHAR(5)         NOT NULL,
        phone           CHAR(12)        NOT NULL,
        dateOfBirth     DATE            NOT NULL,
        taxID           CHAR(9)         UNIQUE      NOT NULL,
        employeeLevel   NUMBER(1)      NOT NULL     CHECK (employeeLevel = 1 or employeeLevel = 2 or employeeLevel = 3 or employeeLevel = 4 or employeeLevel = 5),
        CONSTRAINT BranchNumber_Employees_fk FOREIGN KEY (BranchNumber) REFERENCES Branch(BranchNumber)  
);

--Creates Loans table and attributes--
CREATE TABLE Loans
(
        loanID              CHAR(12)        PRIMARY KEY,
        memberID            NUMBER(20)      NOT NULL,
        employeeID          NUMBER(20)      NOT NULL,
        originalAmount      NUMBER(20, 2)   NOT NULL,
        originationDate     DATE            NOT NULL,
        numberOfPayments    NUMBER(10)      NOT NULL,
        interestRate        NUMBER(5, 3)    NOT NULL    CHECK (interestRate BETWEEN 0 AND 99.999),
        paymentAmount       NUMBER(20, 2)      NOT NULL,
        maturityDate        DATE            NOT NULL,
        notes               VARCHAR(250),
        loanStatus          VARCHAR(2)      NOT NULL    CHECK (loanStatus = 'A' or loanStatus = 'R' or loanStatus = 'P' or loanStatus = 'D' or loanStatus = 'C'),
        loanType            CHAR(2)         NOT NULL,
        CONSTRAINT memberID_Loans_fk FOREIGN KEY (memberID) REFERENCES members(memberID),
        CONSTRAINT employeeID_Loans_fk FOREIGN KEY (employeeID) REFERENCES Employees (employeeID),
        CONSTRAINT date_check CHECK (originationDate < maturityDate)
);

--Creates transaction history table and attributes--
CREATE TABLE Transaction_History
(
        transactionID           NUMBER(20)      DEFAULT transactionID_seq.NEXTVAL PRIMARY KEY,
        loanID                  CHAR(12)        NOT NULL,
        dateOfTransaction       DATE            DEFAULT SYSDATE     NOT NULL,
        amount                  NUMBER(20, 2)   NOT NULL,
        transactionDescription  VARCHAR(100)    NOT NULL,
        balance                 NUMBER(20, 2)   NOT NULL    CHECK (balance > 0),
        CONSTRAINT loanID_transaction_fk FOREIGN KEY (loanID) REFERENCES Loans(loanID) 
);

--Insert Data Section--
--Inserts 2 members--
INSERT INTO members (firstName, middleName, lastName, email)
VALUES ('Clint', NULL, 'Tuttle', 'ct@memail.io');

INSERT INTO members (firstName, middleName, lastName, email)
VALUES ('Julie', NULL, 'Jones', 'jj@mydomain.com');

--Inserts addresses--
INSERT INTO member_address (addressLineOne, addressLineTwo, city, addressState, zipCode)
VALUES ('12345 Maple Lane', NULL, 'Houston', 'TX', '77002');

INSERT INTO member_address (addressLineOne, addressLineTwo, city, addressState, zipCode)
VALUES ('201 E 21st Street', NULL, 'Austin', 'TX', '78705');

INSERT INTO member_address (addressLineOne, addressLineTwo, city, addressState, zipCode)
VALUES ('54321 Green Tree Avenue', NULL, 'Dallas', 'TX', '75270');

INSERT INTO member_address (addressLineOne, addressLineTwo, city, addressState, zipCode)
VALUES ('1588 Yellowstone Street', NULL, 'Austin', 'TX', '78705');

COMMIT;

--Inserts member and address info to linking table--
INSERT INTO member_address_link
VALUES (1, 1, 'P');

INSERT INTO member_address_link
VALUES (1, 2, 'S');

INSERT INTO member_address_link
VALUES (2, 3, 'P');

INSERT INTO member_address_link
VALUES (2, 2, 'S');

INSERT INTO member_address_link
VALUES (2, 4, 'S');

--Inserts cell and home phones--
INSERT INTO member_phone (memberID, phoneNumber, phoneType)
VALUES (1, '192-221-5435', 'cell');

INSERT INTO member_phone (memberID, phoneNumber, phoneType)
VALUES (1, '232-901-2222', 'home');

INSERT INTO member_phone (memberID, phoneNumber, phoneType)
VALUES (2, '381-952-7799', 'cell');

INSERT INTO member_phone (memberID, phoneNumber, phoneType)
VALUES (2, '412-665-8061', 'home');

--Inserts 2 Branches--
INSERT INTO Branch (BranchName, address, city, addressState, zipCode)
VALUES ('Lionsgate', '1234 Lionsgate Lane', 'Round Rock', 'TX', '76555');

INSERT INTO Branch (BranchName, address, city, addressState, zipCode)
VALUES ('Firefall', '5678 Firefall Circle', 'Georgetown', 'TX', '75433');

COMMIT;

--Inserts 4 Employees--
INSERT INTO Employees (BranchNumber, firstName, lastName, address, city, addressState, zipCode, phone, dateOfBirth, taxID, employeeLevel)
VALUES (1, 'Frank', 'Smith', '1111 Lakeway Lane', 'Round Rock', 'TX', '76555', '111-111-1111', '01-JAN-81', 'FS1111111', 1);

INSERT INTO Employees (BranchNumber, firstName, lastName, address, city, addressState, zipCode, phone, dateOfBirth, taxID, employeeLevel)
VALUES (1, 'Lia', 'Grant', '2222 Baker Blvd', 'Round Rock', 'TX', '76555', '222-222-2222', '02-FEB-72', 'LG2222222', 2);

INSERT INTO Employees (BranchNumber, firstName, lastName, address, city, addressState, zipCode, phone, dateOfBirth, taxID, employeeLevel)
VALUES (2, 'Jimmy', 'Falcon', '3333 Margerita Ct', 'Georgetown', 'TX', '75433', '333-333-3333', '03-MAR-69', 'JF3333333', 3);

INSERT INTO Employees (BranchNumber, firstName, lastName, address, city, addressState, zipCode, phone, dateOfBirth, taxID, employeeLevel)
VALUES (2, 'McKenna', 'Scott', '4444 Leapfrog Lane', 'Georgetown', 'TX', '75433', '444-444-4444', '04-APR-75', 'MS4444444', 4);

--Inserts 4 Loans associated with the 2 members--
INSERT INTO Loans
VALUES ('SZB123456789', 1, 90000, 5000, '14-AUG-18', 5, 2, 1000, '14-AUG-23', 'Personal Loan', 'A', 'PL');

INSERT INTO Loans
VALUES ('SZB123456788', 1, 90001, 100000, '29-JUL-15', 10, 1, 2000, '29-JUL-20', 'Car Loan', 'C', 'CL');

INSERT INTO Loans
VALUES ('SMJ123456778', 2,  90002, 7500, '03-SEP-12', 5, 3, 1500, '03-SEP-17', 'Business Loan', 'D', 'BL');

INSERT INTO Loans
VALUES ('SMJ123456678', 2, 90003, 25000, '16-DEC-15', 25, 4, 1000, '16-DEC-30', 'Education Loan', 'R', 'EL');

--Inserts transaction history for the active loan--
INSERT INTO Transaction_History (loanID, dateOfTransaction, amount, transactionDescription, balance)
VALUES ('SZB123456789', '14-AUG-19', 1000, 'Payment One', 4000);

INSERT INTO Transaction_History (loanID, dateOfTransaction, amount, transactionDescription, balance)
VALUES ('SZB123456789', '14-AUG-20', 1000, 'Payment Two', 3000);

COMMIT;

--Create index section--
--Create indexes on foreign keys--
CREATE INDEX memberID_link_ix
	ON member_address_link (memberID);

CREATE INDEX addressID_link_ix
    ON member_address_link (addressID);

CREATE INDEX memberID_phone_ix
	ON member_phone (memberID);
    
CREATE INDEX BranchNumber_ix
	ON Employees (BranchNumber);

CREATE INDEX memberID_Loans_ix
	ON Loans (memberID);

CREATE INDEX employeeID_Loans_ix
	ON Loans (employeeID);

CREATE INDEX loanID_ix
	ON Transaction_History (loanID);

--Create indexes on attributes used commonly for querying--
CREATE INDEX phoneNumber_ix
    ON member_phone (phoneNumber);
    
CREATE INDEX addressLineOne_ix
    ON member_address(addressLineOne);

CREATE INDEX balance_ix
    ON Transaction_History(balance);

COMMIT;
