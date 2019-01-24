create table calisan as (select * from employees)--kopyalama 
select * from calisan
-- kayıt ekleme
insert into calisan 
(employee_id,first_name,last_name,email,hire_date,job_id)
values
(888,'Ahmet','Ak','aa@gmail.com',sysdate,'SA_REP')
-- dep id =90 olan personellere 200 dp eklemek 
--burda values yok
insert into calisan 
(employee_id,first_name,last_name,email,hire_date,job_id,department_id)
(select employee_id+1000,first_name,last_name,email,hire_date,job_id,100 from calisan 
where department_id=90)
-- update
-- employee_id 1000 büyük çalışanların maaşı 10000 yapın
update calisan
set salary=10000
where employee_id>1000
-- update
-- aynı zamanda iki alanı değiştirmek
update calisan
set salary=salary *1.1,commission _pct=0.5
where employee_id>1000
-- update
-- 
update calisan
set salary=(select avg(salary) from calisan)
where employee_id>1000
-- önce kısıtlama
update (select * from calisan 
where employee_id>1000)
set salary=(select avg(salary) from calisan)
-- maaşı ortalama maaştan büyük personellerin maaşı ortalamaya eşit yapın
update calisan
set salary=(select avg(salary) from calisan)
where salary>(select avg(salary) from calisan)
