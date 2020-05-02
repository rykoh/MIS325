--1 Date formatting 
--starting statement
select sysdate as unformatted,
        sysdate as formatted1,
        sysdate as formatted2,
        sysdate as formatted3,
        sysdate as formatted4
from dual;

--final statement
select  sysdate as unformatted,
        to_char(sysdate,'MON-YYYY') as formatted1,
        to_char(sysdate,'Month DD, YYYY') as formatted2,
        to_char(sysdate,'MM/DD/YY HH:MM:SS') as formatted3,
        to_char(sysdate,'Dy, MM-DD-YYYY') as formatted4
from dual;

-- 1 side note: How do we get rid of those spaces around the long spelled out month?
select  sysdate as unformatted,
        TRIM(to_char(sysdate,'Month')) || ' ' || to_char(sysdate,'DD, YYYY') as formatted2
from dual;

---------------------------------------------------------------------------
 
--2 convert NUMBER to CHAR and format
select   invoice_total as unformatted
        ,invoice_total as formatted1
from invoices;

select   invoice_total as unformatted
        ,to_char(invoice_total ,'$999') as formatted1
        ,to_char(invoice_total ,'$999,999.99') as formatted2
        ,to_char(invoice_total ,'$999,999') as formatted3
from invoices;


--Example of how to do CAST function using TO Function
SELECT  invoice_id,
        invoice_date, 
        invoice_total,
        to_char(invoice_date) AS varchar_date,
        to_number(invoice_total) AS integer_total
FROM    invoices;
 
SELECT  invoice_id,
        invoice_date, 
        invoice_total,
        CAST(invoice_date AS VARCHAR2(9))AS varchar_date,
        CAST(invoice_total AS NUMBER(9)) AS integer_total
FROM    invoices; 



-------------------------- String functions

--starter statement
select  vendor_name,
        vendor_state as state,
        to_char(invoice_date,'Month DD, YYYY') as invoice_date,
        invoice_total as Invoice_Total
from    vendors v inner join invoices i
         on v.vendor_id = i.vendor_id
order by v.vendor_name; 


--final answer
select  UPPER(vendor_name),
        LOWER(vendor_state) as state,
        TRIM(to_char(invoice_date,'Month')) || ' ' || TRIM(to_char(invoice_date,'DD, YYYY'))as invoice_date,
        LPAD(invoice_total,15,'.') as invoice_total
from    vendors v inner join invoices i
         on v.vendor_id = i.vendor_id
order by v.vendor_name;


 
---start statement
select  vendor_phone as unformatted_phone,
        replace( replace(vendor_phone,'(',''),') ','-') as phone_replace,
        vendor_phone as phone_substr,
        vendor_phone as phone_length
from vendors ;

select  vendor_phone as unformatted_phone,
        replace(replace(replace(vendor_phone,'(',''),')',''),' ','-') as phone_replace,
        substr(vendor_phone,2,3) ||'-'|| substr(vendor_phone,7,3)  ||'-'|| substr(vendor_phone,11,4) as phone_substr,
        length(vendor_phone) as phone_length
from vendors;


-- using INSTR and SUBSTR to parse dynamic text
select  product_name,
        instr(product_name,' '),
        substr(product_name,1,instr(product_name,' ')-1) as Brand,
        substr(product_name,instr(product_name,' ')+1) as Instrument_name
from    products;


----------------Numeric Functions
--start SQL 
SELECT  12.4999 as Round_Whole,
        12.4999 as Round_Decimal,
        12.4999 as Format_TRUNC
FROM DUAL;

--Answer
SELECT  Round(12.4999) as Round_Whole,
        Round(12.4999,1) as Round_Decimal,
        TRUNC(12.4999,2) as Format_TRUNC
FROM DUAL;
 


----------------Date Functions
-- starter statement
Select  SYSDATE - TO_DATE('01-JAN-19') as Days_since_New_Year,
        SYSDATE - TO_DATE('01-JAN-19') as Days_Rounded
from    DUAL;

-- answer
Select  SYSDATE - TO_DATE('01-JAN-19') as Days_since_New_Year,
        ROUND(SYSDATE - TO_DATE('01-JAN-19')) as Days_Rounded,
        MONTHS_BETWEEN(SYSDATE,TO_DATE('01-JAN-19')),
        SYSDATE + 30,
        ADD_MONTHS(SYSDATE,1)
from    DUAL;



--Parsing Date values
select  SYSDATE as current_hour,
        SYSDATE as hours_left 
from dual;

select  to_char(SYSDATE, 'HH24') as current_hour,
        24 - to_char(SYSDATE, 'HH24') as hours_left 
from dual;



--Search with dates
select * 
from date_sample
where start_date = '28-FEB-06';


--CASE SIMPLE
select  product_name, 
        list_price, 
        CASE  category_id
            WHEN 1  THEN 'Guitars'
            WHEN 2  THEN 'Bass'
            WHEN 3  THEN 'Drums'
            WHEN 4  THEN 'Keyboard'
        END as category_name
from products
order by category_name, list_price;


--CASE SEARCH
select  product_name, 
        list_price, 
        CASE 
            WHEN list_price >= 1000 THEN 'Professional'
            WHEN (list_price between 500 and 1000) THEN 'Intermediate'
            ELSE 'Beginner'
        END as product_grade
from products
order by list_price;


---NVL
select vendor_id, vendor_name, vendor_phone,
        nvl(vendor_phone,'Update contact') as contact_check
from vendors;

--NVL2
select  vendor_id, vendor_name, 
        nvl2(vendor_phone,'Okay','Update contact') as contact_check
from vendors
order by contact_check desc;
 
 
--RANK or RANK_DENSE
select  product_name, 
        list_price, 
        dense_rank() OVER (order by list_price desc) as Rank
from products;



--Row number
SELECT ROW_NUMBER() OVER(ORDER BY vendor_name) 
       AS row_number, vendor_name
FROM vendors;

Select * 
FROM (SELECT ROW_NUMBER() OVER(ORDER BY vendor_name) AS row_number, vendor_name
      FROM vendors);
      
--Now you can use row_numer in the WHERE clause.  This isn't possible with ROWNUM pseudo column
Select * 
FROM (SELECT ROW_NUMBER() OVER(ORDER BY vendor_name) AS row_number, vendor_name
      FROM vendors)
WHERE Row_Number BETWEEN 5 and 10;

 


 


 

 