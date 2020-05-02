-- DDL Script Assignment (Homework Assignment 2)
-- Ryan Kohanski 
-- RLK984


-- DROP TABLES SECTION - Area of the script that drops all tables in the proper order
-- Ryan Kohanski - RLK984
DROP TABLE MemberAddress;
DROP TABLE MemberPhone;
DROP TABLE TransactionHistory;
DROP TABLE Loans;
DROP TABLE Employees;
DROP TABLE CreditUnionBranches;
DROP TABLE Address;
DROP TABLE MemberTaxID;
DROP TABLE Members;

-- Drop Sequences
DROP SEQUENCE member_id_seq;

DROP SEQUENCE transaction_id_seq;

DROP SEQUENCE employee_id_seq;


-- CREATE TABLES SECTION - Area of the script that creates tables and adds constraints either via CREATE or ALTER TABLE statements
-- Ryan Kohanski - RLK984
CREATE TABLE Members
    (
        MemberID            NUMBER          DEFAULT member_id_seq.NEXTVAL,
        FirstName           VARCHAR(20)     NOT NULL,
        MiddleName          VARCHAR(10),    --CAN BE NULL
        LastName            VARCHAR(20)     NOT NULL,
        PrimaryEmail        VARCHAR(30)     NOT NULL        UNIQUE      CONSTRAINT email_length_check CHECK (LENGTH(EMAIL) >= 7),
        
        CONSTRAINT MembersPK PRIMARY KEY (MemberID)
        -- FK Reference?
    );

CREATE TABLE MemberTaxID
    (
        MemberID            NUMBER          DEFAULT member_id_seq.NEXTVAL,
        TaxID               CHAR(9)         NOT NULL        UNIQUE,
        
        CONSTRAINT MemberTaxIDPK PRIMARY KEY (MemberID)
        -- FK Reference?
    );

CREATE TABLE Address
    (
        AddressID           NUMBER          NOT NULL,
        AddressLine1        VARCHAR(30)     NOT NULL,
        AddressLine2        VARCHAR(10),    --CAN BE NULL
        City                VARCHAR(20)     NOT NULL,
        State               CHAR(2)         NOT NULL,
        ZipCode             CHAR(5)         NOT NULL,
        
        CONSTRAINT AddressPK PRIMARY KEY (AddressID)
    );

CREATE TABLE MemberPhone
    (
        PhoneID             NUMBER          NOT NULL,
        PhoneType           VARCHAR(10)     NOT NULL,
        PhoneNumber         CHAR(12)        NOT NULL,
        MemberID            NUMBER          DEFAULT member_id_seq.NEXTVAL,
        
        CONSTRAINT MemberPhonePK PRIMARY KEY (PhoneID),
        CONSTRAINT MemberPhoneFK FOREIGN KEY (MemberID) REFERENCES Members (MemberID)
    );

-- Linking Table for Members and Address
CREATE TABLE MemberAddress
    (
        AddressID           NUMBER          NOT NULL,
        MemberID            NUMBER          DEFAULT member_id_seq.NEXTVAL,
        AddressStatus       CHAR(1)         NOT NULL,
        -- Address status should only be a single character so we can capture values like “P” for primary, “A” for active-non-primary, “I” inactive, or other to-be-determined values.
        
        -- Composite PK
        CONSTRAINT MembersAddressPK PRIMARY KEY (MemberID, AddressID),
        CONSTRAINT MemberAddressFK1 FOREIGN KEY (MemberID) REFERENCES Members (MemberID),
        CONSTRAINT MemberAddressFK2 FOREIGN KEY (AddressID) REFERENCES Address (AddressID)
    );

CREATE TABLE Employees
    (
        EmployeeID          NUMBER          DEFAULT employee_id_seq.NEXTVAL,
        FirstName           VARCHAR(20)     NOT NULL,
        LastName            VARCHAR(20)     NOT NULL,
        TaxID               CHAR(9)         NOT NULL        UNIQUE, 
        AddressLine1        VARCHAR(30)     NOT NULL,
        AddressLine2        VARCHAR(10), -- Can be null
        City                VARCHAR(20)     NOT NULL,
        State               CHAR(2)         NOT NULL,
        ZipCode             CHAR(5)         NOT NULL,
        Birthdate           DATE            NOT NULL,
        PhoneNumber         CHAR(12)        NOT NULL,
        EmployeeLevel       NUMBER(1)       NOT NULL        CHECK (Level IN (1, 2, 3, 4, 5)), 
        BranchID            NUMBER          NOT NULL,
        
        CONSTRAINT EmployeesPK PRIMARY KEY (EmployeeID),
        CONSTRAINT EmployeesFK FOREIGN KEY (BranchID) REFERENCES CreditUnionBranches (BranchID)
    );

CREATE TABLE CreditUnionBranches
    (
        BranchID            NUMBER          NOT NULL,
        BranchName          VARCHAR(20)     NOT NULL        UNIQUE,
        Address             VARCHAR(50)     NOT NULL, 
        City                VARCHAR(20)     NOT NULL,
        State               CHAR(2)         NOT NULL,
        ZipCode             CHAR(5)         NOT NULL,
        
        CONSTRAINT CreditUnionBranchesPK PRIMARY KEY (BranchID)
    );

CREATE TABLE Loans 
    (
        LoanID              CHAR(12)        NOT NULL, 
        OriginalAmount      NUMBER          NOT NULL,
        OriginationDate     DATE            NOT NULL,
        NumberOfPayments    NUMBER          NOT NULL,
        InterestRate        NUMBER(5, 3)    NOT NULL        CHECK (InterestRate >= 0 AND InterestRate <= 99.999), --0 TO 99.999
        PaymentAmount       NUMBER          NOT NULL,
        MaturityDate        DATE            NOT NULL,
        Notes               VARCHAR(250), --CAN BE NULL
        EmployeeID          NUMBER          DEFAULT employee_id_seq.NEXTVAL,
        LoanStatus          CHAR(1)         NOT NULL        CHECK (LoanStatus IN ("A", "R", "P", "D", "C")), 
        -- Status of a loan can be only one of the following codes: A for “application in process”, R for “rejected application”, P for “actively paying”, D for “delinquent”, and C for “Closed”
        MemberID            NUMBER          DEFAULT member_id_seq.NEXTVAL,
        LoanType            CHAR(2)         NOT NULL,
        
        CONSTRAINT LoansPK PRIMARY KEY (LoanID),
        CONSTRAINT LoansFK1 FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID),
        CONSTRAINT LoansFK2 FOREIGN KEY (MemberID) REFERENCES Members (MemberID),
        -- Make sure Maturity Date cannot come before the Origination Date
        CONSTRAINT compare_dates CHECK (MaturityDate > OriginationDate)

    );

CREATE TABLE TransactionHistory
    (
        TransactionID       NUMBER          DEFAULT transaction_id_seq.NEXTVAL,
        TransactionDate     DATE            DEFAULT SYSDATE, -- have not null?
        Amount              NUMBER          NOT NULL,
        TransactrionDescription VARCHAR(100)    NOT NULL,
        UpdatedBalance      NUMBER          NOT NULL        CHECK (UpdatedBalance >= 0),
        LoanID              CHAR(12)        NOT NULL,
        
        CONSTRAINT TransactionHistoryPK PRIMARY KEY (TransactionID),
        CONSTRAINT TransactionHistoryFK FOREIGN KEY (LoanID) REFERENCES Loans (LoanID)
    );


-- CREATE INDEXES:
-- Foreign Keys
CREATE INDEX MemberPhone_MemberID_ix
ON MemberPhone (MemberID);

--Index on composite key
CREATE INDEX MemberAddress_MemberID_AddressID_ix
ON MemberAddress (MemberID, AddressID);

CREATE INDEX CreditUnionBranches_BranchID_ix
ON Employees (BranchID);

CREATE INDEX Loans_EmployeeID_ix
ON Loans (EmployeeID);

CREATE INDEX Loans_MemberID_ix
ON Loans (MemberID);

CREATE INDEX TransactionHistory_LoanID_ix
ON TransactionHistory (LoanID);

-- Three Others
CREATE INDEX Members_PrimaryEmail_ix
ON Members (PrimaryEmail);

CREATE INDEX CreditUnionBranches_BranchName_ix
ON CreditUnionBranches (BranchName);

CREATE INDEX MemberTaxID_TaxID_ix
ON MemberTaxID (TaxID);


-- CREATE SEQUENCES:
CREATE SEQUENCE member_id_seq
START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE transaction_id_seq
START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE employee_id_seq -- for employees?
START WITH 90000 INCREMENT BY 1;


-- INSERT DATA SECTION - Area of the script that inserts data into the tables using “INSERT INTO”
-- Ryan Kohanski - RLK984

--Members:
INSERT INTO Members (FirstName, MiddleName, LastName, PrimaryEmail, MemberID) 
VALUES ('Ryan', 'Lee', 'Kohanski', 'rlk984@utexas.edu', 1); 

INSERT INTO Members (FirstName, MiddleName, LastName, PrimaryEmail, MemberID)
VALUES ('Cayden', 'Wesley', 'Capello', 'cwc2443@utexas.edu', 2); 

-- Member Tax IDs
INSERT INTO MemberTaxID (MemberID, TaxID)
VALUES (1, '123456789');

INSERT INTO MemberTaxID (MemberID, TaxID)
VALUES (2, '987654321');

COMMIT;

-- Address:
-- Member 1
INSERT INTO Address (AddressLine1, AddressLine2, City, State, ZipCode, AddressID)
VALUES ('1227 Whisper Trace Lane', NULL, 'Sugar Land', 'TX', '77479', 1); 

INSERT INTO MemberAddress (AddressID, MemberID, Status)
VALUES (1, 1, 'P');

INSERT INTO Address (AddressLine1, AddressLine2, City, State, ZipCode, AddressID)
VALUES ('1009 W 26th Street', 'Apt 408', 'Austin', 'TX', '78705', 2);

INSERT INTO MemberAddress (AddressID, MemberID, Status)
VALUES (2, 1, 'I');

COMMIT;

-- Member 2
INSERT INTO Address (AddressLine1, AddressLine2, City, State, ZipCode, AddressID)
VALUES ('1234 Longhorn Street', NULL, 'Houston', 'TX', '77479', 3); 

INSERT INTO MemberAddress (AddressID, MemberID, Status)
VALUES (3, 2, 'P');

INSERT INTO Address (AddressLine1, AddressLine2, City, State, ZipCode, AddressID)
VALUES ('1009 W 26th Street', 'Apt 408', 'Austin', 'TX', '78705', 4);

INSERT INTO MemberAddress (AddressID, MemberID, Status)
VALUES (4, 2, 'I');

COMMIT;

-- Phone Numbers:
-- Member 1
INSERT INTO MemberPhone (PhoneType, PhoneNumber, MemberID, PhoneID) 
VALUES ('Home', '1234567890', 1, 1);

INSERT INTO MemberPhone (PhoneType, PhoneNumber, MemberID, PhoneID)
VALUES ('Cell', '0987654321', 1, 2);

COMMIT;

-- Member 2
INSERT INTO MemberPhone (PhoneType, PhoneNumber, MemberID, PhoneID) 
VALUES ('Home', '2345678901', 2, 3);

INSERT INTO MemberPhone (PhoneType, PhoneNumber, MemberID, PhoneID)
VALUES ('Cell', '1098765432', 2, 4);

COMMIT;

-- Loans:
-- Member 1 
INSERT INTO Loans (OriginalAmount, OriginationDate, NumberOfPayments, InterestRate, PaymentAmount, MaturityDate, Notes, LoanStatus, LoanType, EmployeeID, MemberID, LoanID) 
VALUES (1000, '21-SEP-14', 5, 30.000, 600, '21-SEP-21', NULL, 'A', 'RK', 1, 1, 1);
-- Payments (2)
INSERT INTO TransactionHistory (TransactionDate, Amount, TransactionDescription, UpdatedBalance, LoanID, TransactionID)
VALUES('22-SEP-14', 200, 'Cash', 400, 1, 1);
INSERT INTO TransactionHistory (TransactionDate, Amount, TransactionDescription, UpdatedBalance, LoanID, TransactionID) 
VALUES('23-SEP-14', 200, 'Cash', 200, 1, 2);

INSERT INTO Loans (OriginalAmount, OriginationDate, NumberOfPayments, InterestRate, PaymentAmount, MaturityDate, Notes, LoanStatus, LoanType, EmployeeID, MemberID, LoanID)
VALUES (1000, '21-SEP-14', 5, 30.000, 600, '21-SEP-21', NULL, 'C', 'RK', 2, 1, 2);

-- Member 2
INSERT INTO Loans (OriginalAmount, OriginationDate, NumberOfPayments, InterestRate, PaymentAmount, MaturityDate, Notes, LoanStatus, LoanType, EmployeeID, MemberID, LoanID)
VALUES (1000, '21-SEP-14', 5, 30.000, 600, '21-SEP-21', NULL, 'D', 'CC', 3, 2, 3);

INSERT INTO Loans (OriginalAmount, OriginationDate, NumberOfPayments, InterestRate, PaymentAmount, MaturityDate, Notes, LoanStatus, LoanType, EmployeeID, MemberID, LoanID)
VALUES (1000, '21-SEP-14', 5, 30.000, 600, '21-SEP-21', NULL, 'R', 'CC', 4, 2, 4);

COMMIT;

-- Employees (4):
-- Create 4 employees and assign their each one of the members’ loans.
INSERT INTO Employees (FirstName, LastName, TaxID, AddressLine1, AddressLine2, City, State, ZipCode, Birthdate, PhoneNumber, EmployeeLevel, EmployeeID, BranchID) 
VALUES ('James', 'Harden', 'asdlek765', '1111 Rockets Drive', NULL, 'Houston', 'TX', '12345', '21-MAY-01', '1234567890', 5, 1, 1);

INSERT INTO Employees (FirstName, LastName, TaxID, AddressLine1, AddressLine2, City, State, ZipCode, Birthdate, PhoneNumber, EmployeeLevel, EmployeeID, BranchID)
VALUES ('Bruce', 'Wayne', 'aslker563', '1111 Bat Cave Lane', NULL, 'Gotham City', 'TX', '09876', '06-MAR-02', '0987654321', 3, 2, 1);

INSERT INTO Employees (FirstName, LastName, TaxID, AddressLine1, AddressLine2, City, State, ZipCode, Birthdate, PhoneNumber, EmployeeLevel, EmployeeID, BranchID)
VALUES ('Travis', 'Scott', 'aslwet109', '1111 Houston Street', NULL, 'Houston', 'TX', '13579', '13-APR-03', '2345678901', 4, 3, 2);

INSERT INTO Employees (FirstName, LastName, TaxID, AddressLine1, AddressLine2, City, State, ZipCode, Birthdate, PhoneNumber, EmployeeLevel, EmployeeID, BranchID)
VALUES ('Bevo', 'Longhorn', 'buqtvx128', '1111 Longhorns Blvd', NULL, 'Austin', 'TX', '78705', '12-DEC-05', '1098765432', 4, 4, 2);

COMMIT;

-- Branches (2):
INSERT INTO CreditUnionBranches (BranchName, Address, City, State, ZipCode, BranchID) 
VALUES ('Houston Branch', '1234 Houston Street', 'Houston', 'TX', '77479', 1);

INSERT INTO CreditUnionBranches (BranchName, Address, City, State, ZipCode, BranchID)
VALUES ('Austin Branch', '1234 Austin Street', 'Austin', 'TX', '78705', 2);

COMMIT;


-- Drop Indexes
-- Foreign Keys
DROP INDEX MemberPhone_MemberID_ix;
--Index on composite key
DROP INDEX MemberAddress_MemberID_AddressID_ix;

DROP INDEX CreditUnionBranches_BranchID_ix;

DROP INDEX Loans_EmployeeID_ix;

DROP INDEX Loans_MemberID_ix;

DROP INDEX TransactionHistory_LoanID_ix;

-- Three Others
DROP INDEX Members_PrimaryEmail_ix;

DROP INDEX CreditUnionBranches_BranchName_ix;

DROP INDEX MemberTaxID_TaxID_ix;
























