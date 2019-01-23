select rowid, calisan.* from calisan-- adreslenebilir kayıt sayısı
 
select * from calisan
update ( select job_id from calisan c 
          group by job_id
          having count(*)>1)
set job_id ="SA_REP"--hata verir
--> çözüm
 
 update (
         select * from calisan where job_id in (
                  select job_id from calisan c 
                  group by job_id
                  having count(*)=1)
                )
set job_id ='SA_REP'

-->
--
Delete from calisan
where salary>15000
-- her şey siliyor ama bir yerde sakliyor tamamen silmiyor silindi diye işaretliyor  çok hızlı çalışıyor
truncate table calisan-- tabloyu silmiyor sadece boşaltıyor
--
create table personel2 as (select * from employees)
drop table birim 
drop table personel2 
create table birim as (select * from departments)
select * from personel2
select * from birim
--1 tüm personellerin maaşlarını ort maaşile değiştiriniz
update personel2
set salary=(select avg(salary) from personel2)
--2 mınus ile çözulur hiç çalışanı olmaya birimleri siliniz
delete from birim 
where department_id in(
select department_id from birim  b where not  exists 
(select 'x' from personel2 p
where b.department_id=p.department_id)
)
-- tek aşamalı
delete from birim 
where department_id not in(select nvl(department_id,0) from personel2)
--3  tüm personellerin maaşlarını kendi biirimlerin ort maaşile değiştiriniz
update personel2 p
set salary=(
select avg(salary)
from personel2 p2
where p.department_id=p2.department_id
--group by department_id gerek yok
)
--4 birimlerin ort maaşlarından az alan personellerin maaşları ort maaş ile değiştiriniz 
update personel2 p
set salary=(
select avg(salary)
from personel2 p2
where p.department_id=p2.department_id)
where salary<(
select avg(salary)
from personel2 p2
where p.department_id=p2.department_id)
--5 çalışanı olmaya birimlerin yöneticilerini boş olarak update ediniz
update birim b 
set b.manager_id = Null
where not  exists 
(select 'x' from personel2 p
where b.department_id=p.department_id)

--6 --hatalı çözum
insert into personel2 
(employee_id,first_name,last_name,email,hire_date,department_id,job_id)
(select departme_id*1000+1,'x','x','x',sysdate,'x','x' from birim b
)
-->
insert into calisan 
(employee_id,first_name,last_name,email,hire_date,job_id,department_id)
(select department_id+1000,'x','x','x',sysdate,'x',department_id+100 from birim)

-->
--7 tüm personellerin maaşlarını kendi unvnların max maaşile değiştiriniz
update personel2 p
set salary=(select max_salary from jobs j where p.job_id=j.job_id )
-- insrt values directly
  insert into ogretmen
  (adi)
  values
  ('Ahmet')

--8 ismi tekrar eden personellerin maaşlarının ilgili isminn ortalama maaşı ile değiştiriniz
update personel2 p
set salary=(select avg(salary)
            from personel2 p2 
            where p.first_name=p2.first_name
            and  p.last_name=p2.last_name
            group by p.first_name)
            -- genel çözum var
--9 hem 1700 hem de 1800 mekanlarda ortak unvanlı çalışan varsa bu çalışanları siliniz
--çalışmadı
delete from perosnel2 where job_id in (
        (select job_id
        from personel2 p,birim b
        where p.department_id = b.department_id
        and b.location_id=1700
        ) 
        intersect
        (select job_id
        from personel2 p,birim b
        where p.department_id = b.department_id
        and b.location_id=1800
        -- and j.job_id=t.job_id intersect çözuyor
        ))
and department_id in (select department_id from birim where location_id (1700,1800))




