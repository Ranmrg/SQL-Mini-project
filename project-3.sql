create database bank;
use bank;
create table Branch
(Branch_no int primary key,
Name varchar(15) not null);

insert into Branch values
(1,"Delhi"),
(2,'Mumbai');

create table Customer
( custid int primary key,
fname varchar(15) not null,
mname varchar(15),
lname varchar(15),
occupation varchar(15),
dob date);

insert into customer values
( 1,'Ramesh','Chandra','Sharma','Service','1976-12-06'),
(2,'Avinash','Sunder','Minha','Business','1974-10-16');
desc customer;

create table Account
(acnumber int primary key,
custid int,
bid int,
curbal int,
opnDT date not null,
atype varchar(15) not null,
astatus varchar(15) not null,
foreign key (custid) references customer(custid)
);

insert into account values
( 1,1,1,10000,'2012-12-15','Saving','Active'),
(2,2,2,5000,'2012-06-12','Saving','Active');

create table Employee
(
emp_no int primary key,
Branch_no int ,
fname varchar(15) not null,
Mname varchar(15) not null,
Lname varchar(15) not null,
Dept varchar(15) not null,
Desig varchar(15) not null,
managr_no int not null,
foreign key (Branch_no) references Branch (Branch_no)
);

insert into employee values
(1,1,'Mark','steve','Lara','Account','Accountant',2),
(2,2,'Bella','James','Ronald','Loan','Manager',1);

select * from account
select * from branch
select * from customer
select * from employee

#3.	Select unique occupation from customer table
select distinct occupation from customer;

#4.	Sort accounts according to current balance 
select * from account
order by curbal;

#5.	Find the Date of Birth of customer name ‘Ramesh’
select dob  `date of birth` from customer
where fname like '%Ramesh%';

#6.	Add column city to branch table 
alter table branch add column city varchar(15);

#7.	Update the mname and lname of employee ‘Bella’ and set to ‘Karan’, ‘Singh’ 
update  employee set mname= 'Karan'
where fname='bella';
update  employee set lname= 'Singh'
where fname='bella';
select * from employee;

#8.	Select accounts opened between '2012-07-01' AND '2013-01-01'
select * from account
where opndt between '2012-07-01' and '2013-01-01';

#9.	List the names of customers having ‘a’ as the second letter in their names 
select concat(fname,' ' ,mname,' ' ,lname) name from customer
where fname like '_a%';

#10.	Find the lowest balance from customer and account table
select custid,concat(fname,' ' ,mname,' ' ,lname) name,curbal balance from account join customer
using (custid)
where curbal =(select min(curbal) from account);

#11.	Give the count of customer for each occupation
select count(occupation) from customer
group by custid;

#12.	Write a query to find the name (first_name, last_name) 
#of the employees who are managers

select concat(fname,' ' ,lname) name from employee
where emp_no in (select managr_no from employee);

#13.List name of all employees whose name ends with a.
select concat(fname,' ' ,mname,' ' ,lname) name from employee
where lname like '%a';

#14.	Select the details of the employee 
#who work either for department ‘loan’ or ‘credit’
select * from employee
where dept like '%loan%' or dept like '%Credit%';

#15.Write a query to display the customer number, 
#customer firstname, account number for the customer whose occupation in bussiness
select custid,fname,acnumber from customer
join account using (custid)
where occupation like '%business%';

#16.	Write a query to display the customer’s number, customer’s firstname,
 #branch id and balance amount for all people using JOIN.
 select custid customer_number ,fname first_name,bid branch_id,curbal balance_ammount
 from customer join account using (custid);
 
 #17.	Create a virtual table to store the customers 
 #who are having the accounts in the same city as they live
 alter table customer add column city varchar(15);
 update  customer set city='Delhi'
 where fname='Ramesh';                       #uploading dummy values since no data mentioned
 update  customer set city='Mumbai'
 where fname='Avinash';
create view customers as
select custid,fname,mname,lname,occupation,dob,customer.city  from account join customer using(custid) join branch on  
account.bid=branch.branch_no
where customer.city=branch.name;

-- 18.	A. Create a transaction table with following details 
-- TID – transaction ID – Primary key with autoincrement 
-- Custid – customer id (reference from customer table
-- account no – acoount number (references account table)
-- bid – Branch id – references branch table
-- amount – amount in numbers
-- type – type of transaction (Withdraw or deposit)
-- DOT -  date of transaction

create table transaction
( TID int  auto_increment,
custid int not null,
account_no int,
bid int,
amount int,
type  varchar(15),
DOT date,
foreign key(custid) references customer (custid),
foreign key(account_no) references account(acnumber),
foreign key(bid) references branch (branch_no),
check(type in ('Withdraw','deposit'))
);
-- a. Write trigger to update balance in account table on Deposit or Withdraw in transaction table
-- b. Insert values in transaction table to show trigger success
select * from transaction;
delimiter //
CREATE TRIGGER transac
AFTER INSERT ON transaction
for each row 
begin
update account a set a.curbal= a.curbal+if(new.type='withdraw',-new.amount,+new.amount)
WHERE a.custid = new.custid;
end;

select * from account; #before transaction
insert into transaction values
(123467,1,1,1,1000,'withdraw',current_date())
select * from account; # after transaction
#19.	Write a query to display the details of customer with second highest balance 
select t.custid,concat(fname,' ',mname,' ',lname ) name,occupation,dob,city,curbal balance from
(select *,dense_rank() over(order by curbal desc) rnk from account)  t join
customer on t.custid=customer.custid
where rnk=2
#20.Take backup of the databse created in this case study
#-server-data-export-export-to-self-contained-file-choose-file-export
