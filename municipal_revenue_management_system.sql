SET LINESIZE 150
SET PAGESIZE 200

DROP TABLE admin;
DROP TABLE invoice;
DROP TABLE revenue;
DROP TABLE account;
DROP TABLE population;

create table admin(
admin_id number(05),
name varchar(50),
primary key(admin_id)
);

create table population(
population_id number(10),
first_name varchar(20),
last_name varchar(20),
Address varchar(25),
Occupation varchar(25),
primary key(population_id)
);

create table account(
Account_id number(05),
population_id number(10),
Account_no number(10),
Name varchar(20),
primary key(Account_id),
foreign key(population_id) references population
);

create table revenue(
bill_number number(10),
account_id number(05),
monthly_bill float(10),
no_of_months number(2),
amount float(10),
primary key(bill_number),
foreign key(account_id) references account
);

create table invoice(
invoice_id number(05),
bill_number number(10),
paying_date  date,
primary key(invoice_id),
foreign key(bill_number) references revenue
);

-- Insert data into admin table
INSERT INTO admin VALUES (1, 'Admin1');
INSERT INTO admin VALUES (2, 'Admin2');

-- Insert data into the population table
INSERT INTO population VALUES (1, 'John', 'Doe', '123 Main St', 'Engineer');
INSERT INTO population VALUES (2, 'Jane', 'Smith', '456 Oak St', 'Teacher');
INSERT INTO population VALUES (3, 'Alice', 'Johnson', '789 Elm St', 'Doctor');
INSERT INTO population VALUES (4, 'Bob', 'Williams', '321 Pine St', 'Lawyer');
INSERT INTO population VALUES (5, 'Eva', 'Brown', '555 Maple St', 'Artist');
INSERT INTO population VALUES (6, 'David', 'Jones', '777 Cedar St', 'Accountant');

-- Insert data into the account table using first names from the population table
INSERT INTO account VALUES (1001, 1, 10001, (SELECT first_name FROM population WHERE population_id = 1) || ' Account');
INSERT INTO account VALUES (1002, 2, 10002, (SELECT first_name FROM population WHERE population_id = 2) || ' Account');
INSERT INTO account VALUES (1003, 3, 10003, (SELECT first_name FROM population WHERE population_id = 3) || ' Account');
INSERT INTO account VALUES (1004, 4, 10004, (SELECT first_name FROM population WHERE population_id = 4) || ' Account');
INSERT INTO account VALUES (1005, 5, 10005, (SELECT first_name FROM population WHERE population_id = 5) || ' Account');
INSERT INTO account VALUES (1006, 6, 10006, (SELECT first_name FROM population WHERE population_id = 6) || ' Account');

-- Insert data into revenue table
INSERT INTO revenue VALUES (12345, 1001, 50.0, 3, 150.0);
INSERT INTO revenue VALUES (23451, 1002, 75.0, 2, 150.0);
INSERT INTO revenue VALUES (34521, 1003, 60.0, 4, 240.0);
INSERT INTO revenue VALUES (45213, 1004, 40.0, 5, 200.0);
INSERT INTO revenue VALUES (52134, 1005, 55.0, 3, 165.0);
INSERT INTO revenue VALUES (21345, 1006, 80.0, 2, 160.0);

-- Insert data into the invoice table using bill numbers from the revenue table
INSERT INTO invoice VALUES (1,12345, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
INSERT INTO invoice VALUES (2,23451, TO_DATE('2023-01-20', 'YYYY-MM-DD'));
INSERT INTO invoice VALUES (3,34521, TO_DATE('2023-02-10', 'YYYY-MM-DD'));
INSERT INTO invoice VALUES (4,45213, TO_DATE('2023-02-25', 'YYYY-MM-DD'));
INSERT INTO invoice VALUES (5,52134, TO_DATE('2023-03-05', 'YYYY-MM-DD'));
INSERT INTO invoice VALUES (6,21345, TO_DATE('2023-03-15', 'YYYY-MM-DD'));

select * from admin;
select * from population;
select * from account;
select * from revenue;
select * from invoice;


-- Create trigger
CREATE OR REPLACE TRIGGER before_amount
BEFORE INSERT OR UPDATE ON revenue
FOR EACH ROW
BEGIN
:NEW.Amount := :NEW.monthly_bill * :NEW.no_of_months;
END before_amount;
 /

--Check if the trigger works
INSERT INTO revenue (bill_number, account_id,monthly_bill,no_of_months,amount)VALUES (67855,1003,30, 3, null);
select * from revenue;
