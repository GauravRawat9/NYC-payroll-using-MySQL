create database nyc_payroll;
use nyc_payroll;

select * from nyc_pay;
alter table nyc_pay rename  column leave_status_as_of_july_31 to leave_status; 
alter table nyc_pay rename  column title_description to job_title; 

#leave status by job title
select job_title, leave_status, count(leave_status)
from nyc_pay
group by job_title, leave_status
order by leave_status asc;

#regular pay vs overtime pay
select job_title, sum(regular_gross_paid) as gross_paid, sum(total_ot_paid) as OT_paid
from nyc_pay group by job_title;

#employee tenure based on start date
select first_name, last_name, timestampdiff(year,start_date, curdate()) as tenure
from nyc_pay
order by tenure desc;

#count of emp by job title
select job_title, count(*) as number_of_emp from nyc_pay 
group by job_title 
order by number_of_emp desc;

#avg salary by job title
select job_title, avg(regular_gross_paid) as AVG_paid 
from nyc_pay group by job_title;

#Total emp by cities
select work_location_borough as location, count(*) as number_of_emp from nyc_pay 
group by location 
order by number_of_emp desc;

#Top 10 highest paid emp
select first_name, last_name, regular_gross_paid
from nyc_pay
order by regular_gross_paid desc
limit 10;

#total salary paid by agency
select agency_name, sum(regular_gross_paid) as total_salary
from nyc_pay
group by agency_name;

#avg Overtime pay by job title
select job_title, avg(total_ot_paid) as ot_pay
from nyc_pay
group by job_title
order by ot_pay desc;

#monthly salary payments
select months, sum(regular_gross_paid) as Salary, sum(total_ot_paid) as overtime_pay
from nyc_pay
group by months;

#active vs ceased employees
select leave_status, count(leave_status) as status
from nyc_pay
where leave_status in ("active","ceased")
group by leave_status;

#emp with longest tenure
select first_name, last_name , timestampdiff(year,start_date,curdate()) as Tenure
from nyc_pay
order by tenure desc
limit 1;

#total ot hours by job role
select job_title, sum(ot_hours) as Total_ot_hours
from nyc_pay
group by job_title;

#emp with most ot pay
select concat(first_name," ",last_name) as full_name, total_ot_paid
from nyc_pay
order by total_ot_paid desc
limit 1;

#avg salary and avg ot by job title
select job_title, avg(regular_gross_paid) as avg_sal, avg(total_ot_paid) as avg_sal
from nyc_pay
group by job_title;

