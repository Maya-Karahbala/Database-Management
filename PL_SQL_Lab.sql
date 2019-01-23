--Personel adedini count fonksiyonu
--kullanmadan PL’SQL ile bulunuz.
DECLARE
counter number(7):=0;
begin
for r in (select * from employees)loop
  counter:=counter+1;
end loop;
dbms_output.put_line('number of employees = '||counter);
end;
-------------- 2. yol
DECLARE
cursor c_emp is (select 'a' from employees);
counter number(7):=0;
begin
for r in c_emp loop
  counter:=counter+1;
end loop;
dbms_output.put_line('number of employees = '||counter);
end;
--Personel adedini bulma işlemini bir fonksiyona
--taşıyınız.
create or replace function get_personel_number
	return number is
    counter number(4):=0;
	begin	
	for r in (select * from employees)loop
         counter:=counter+1;
    end loop;
    return (counter);	
	end;
	-- test1
	    select get_personel_number from dual
	-- test 2 pl sql
	DECLARE
	begin
	dbms_output.put_line(get_personel_number);
	end;
-- birimlerdeki personel adedini bulan bir fonksyon yazınız
create or replace function get_personel_dep_number
	(dep_id number)
	return number is
	counter number(4):=0;
	cursor c_emp is (select * from employees 
		where department_id= dep_id );

	begin
     for r in c_emp loop
         counter:= counter+1;
     end loop;
     return counter;
	end;
-- test 
select department_name,get_personel_dep_number(department_id)
from departments
-- test2
DECLARE
begin
  for r in (select * from departments) loop
  dbms_output.put_line( r.department_name||' '||get_personel_dep_number(r.department_id));
  end loop;
end;
----------------------------------
-- birimin maaşlarını artırmak
select * from personel where department_id=100


create or replace PROCEDURE dep_maas_artir(dep_id Number)is
begin
update personel
set salary=salary+(salary*0.1)
where department_id=dep_id;
end;


declare
begin 
dep_maas_artir(100);
end;
--
create or replace  package calisan_pack as
	type birim_adet_record is record(
		dep_name varchar2(30),
		adet number(5));
	type birim_adet_table is table of birim_adet_record;
end calisan_pack;
-- o turleri kullanaarak get_birim_adet_table fonksyonu yazınız

create or replace function get_birim_adet_table
	return calisan_pack.birim_adet_table is
	dep_per_table1 calisan_pack.birim_adet_table;
	cursor c is (select department_name,get_personel_dep_number(department_id) from departments);
	begin
	open c;
	fetch c bulk collect into dep_per_table1;
	close c;
    return (dep_per_table1);
	end;


---------------- test
DECLARE
  v_Return HR.CALISAN_PACK.BIRIM_ADET_TABLE;
BEGIN

  v_Return := GET_BIRIM_ADET_TABLE();

sys.DBMS_OUTPUT.PUT_LINE( v_Return(1).adet||' ' || v_Return(1).dep_name);

END;
--- personel tablosuna dep_name columu ekleyiniz ve pl sql kullanarak update ediniz
select * from personel2
--
alter table personel2 
add(dep_name varchar2(30))
--
declare
begin
 update personel2
 set dep_name =get_department_name(department_id);
end;

-- birimlerin ortalama maaşı
select department_id, avg(salary)
from employees
group by department_id
-- bu sorgu sorunlu iki kere aynı sorguyu çalıştırır pl sql bu sorun çözer
update personel2 p
set salary=(select avg(salary) from personel2 where department_id= p.department_id)
where salary>(select avg(salary) from personel2 where department_id= p.department_id)
--
create or replace PROCEDURE update_salary is 
	cursor c is 
		(select department_id, avg(salary) ortalama
	     from employees
	     group by department_id);
	begin 
	  for r in c loop 
	     update personel2 p
	     set salary=r.ortalama
	     where salary>r.ortalama
	     and r.department_id=p.department_id;
	  end loop;
	end;

-- test
    declare
	begin 
	  update_salary;
	end;
	
	----------------
create or replace package personell_package as
		
		type birim_rec_type is record(
			adi varchar2(30),
            personel_number Number(4)
			);
        type birim_rec_table_type is table of birim_rec_type; 

		end;


create or replace function get_birim_record_table 
    return personell_package.birim_rec_table_type 
	is
	table_p personell_package.birim_rec_table_type;
     cursor c is (select department_name,get_personel_dep_number(department_id) from departments);
	begin
    open c;
    fetch c bulk collect into table_p;
    close c;
    return table_p;
	end ;
 

 declare
 begin
 end;