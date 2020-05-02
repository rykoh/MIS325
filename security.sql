-- Security, DCL, and Views Assignment
-- Ryan Kohanski, RLK984


-- 1.	Complete the Access Control Matrix for the 4 roles by assigning Select, Insert, Update, and Delete privileges for the Members, 
-- Member_Phone, Loans, Transaction_History, and Employees entities.
-- Deliverable: A access control matrix in a table with roles in rows and entities in columns that show privilege assignments per role/entity.   

-- 2.	Write the SQL code to create roles of the Member, Admin, Loan_Analyst, Customer_Service_Rep
-- Deliverable: Text or SQL file that contain the SQL statements 
CREATE ROLE Member;
CREATE ROLE Admin;
CREATE ROLE Loan_Analyst;
CREATE ROLE Customer_Service_Rep;
 
-- 3.	Write the SQL code to Grant the appropriate (object) privileges to the Member, Admin, Loan_Analyst, Customer_Service_Rep 
-- Deliverable: Text or SQL file that contain the SQL statements

--FOR THE MEMBERS TABLE
GRANT SELECT, INSERT, UPDATE ON Members TO Member;
GRANT SELECT, INSERT, UPDATE ON Members TO Admin;
GRANT SELECT, UPDATE ON Members TO Customer_Service_Rep;

--FOR THE MEMBER_PHONE TABLE
GRANT SELECT, INSERT, UPDATE ON Member_Phone TO Member;
GRANT SELECT, INSERT, UPDATE ON Member_Phone TO Admin;
GRANT SELECT, UPDATE ON Member_Phone TO Customer_Service_Rep;


--FOR THE LOANS TABLE
GRANT SELECT ON Loans TO Member;
GRANT SELECT, INSERT, UPDATE ON Loans TO Admin;
GRANT SELECT ON Loans TO Loan_Analyst;
GRANT SELECT ON Loans TO Customer_Service_Rep;

--FOR THE TRANSACTION_HISTORY TABLE
GRANT SELECT ON Transaction_History TO Member;
GRANT SELECT, INSERT, UPDATE ON Transaction_History TO Admin;
GRANT SELECT ON Transaction_History TO Loan_Analyst;
GRANT SELECT ON Transaction_History TO Customer_Service_Rep;

--FOR THE EMPLOYEES TABLE
GRANT SELECT, INSERT, UPDATE ON Employees TO Admin;

 
-- 4.	Write the SQL code to Revoke all the privileges from the Member, Admin, Loan_Analyst, Customer_Service_Rep 
-- Deliverable: Text or SQL file that contain the SQL statements
--FOR THE MEMBER ROLE
REVOKE ALL ON Members FROM Member;
REVOKE ALL ON Member_Phone FROM Member;
REVOKE ALL ON Loans FROM Member;
REVOKE ALL ON Transaction_History FROM Member;

--FOR THE ADMIN ROLE
REVOKE ALL ON Members FROM Admin;
REVOKE ALL ON Member_Phone FROM Admin;
REVOKE ALL ON Loans FROM Admin;
REVOKE ALL ON Transaction_History FROM Admin;
REVOKE ALL ON Employees FROM Admin;

--FOR THE LOAN_ANALYST ROLE
REVOKE ALL ON Loans FROM Loan_Analyst;
REVOKE ALL ON Transaction_History FROM Loan_Analyst;

--FOR THE CUSTOMER_SERVICE_REP ROLE
REVOKE ALL ON Members FROM Customer_Service_Rep;
REVOKE ALL ON Member_Phone FROM Customer_Service_Rep;
REVOKE ALL ON Loans FROM Customer_Service_Rep;
REVOKE ALL ON Transaction_History FROM Customer_Service_Rep;

 
-- 5.	Create 4 users (one assigned to each role).  Also provide drop statements for users.
-- Deliverable: Text or SQL file that contain the SQL statements
CREATE USER Ryan;
CREATE USER Emily;
CREATE USER Cayden; 
CREATE USER Kasey;

GRANT Loan_Analyst TO Ryan;
GRANT Customer_Service_Rep TO Kasey;
GRANT Member TO Cayden;
GRANT Admin TO Emily;


-- 6.	Customer Service Reps should only be able to see the type of loan a member has and the assigned employee_id for the loan.  
-- To enable this, create a view call loans_csr_view that pulls only the Loan_Number, Member_ID, Type, and EmployeeID from the Loans table.  
-- Then write the SQL DCL statement that will grant only SELECT privileges to this view for the Customer_Service_Rep role.  
-- Deliverable: Text or SQL file that contain the SQL statements

CREATE OR REPLACE VIEW loans_csr_view AS
   SELECT Loan_Number, Member_ID, Type, Employee_ID
   FROM Loans;

GRANT SELECT ON loans_csr_view TO Customer_Service_Rep;

