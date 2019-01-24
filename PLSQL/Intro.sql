set  SERVEROUTPUT on;
DECLARE
BEGIN
SYS.dbms_output.put_line('merhaba');
END;
-------------
-- int tanımlama
DECLARE
x number(2):=5;
BEGIN
SYS.dbms_output.put_line(x);
END;
---------------------
-- tabloda tek bir değer almak
DECLARE
p_isim varchar(30);
BEGIN
select first_name into p_isim
from employees
where employee_id=103;
SYS.dbms_output.put_line('merhaba '|| p_isim );
END;
---------------
-- kayıt almak (obje gibi)
DECLARE
per employees % ROWTYPE;
BEGIN
select * into per
from employees
where employee_id=103;
SYS.dbms_output.put_line('merhaba '|| per.first_name );
END;
------------------
--struct tanımlama(type )
DECLARE
type full_name is RECORD (
	adi varchar(30),
	soyadi varchar(30)
);
-- full_name tipinden değişken tanımlama
per_full_name full_name;
BEGIN
select first_name,last_name into per_full_name
from employees
where employee_id=103;
SYS.dbms_output.put_line('merhaba '||
 per_full_name.adi|| per_full_name.soyadi );
END;
-----------------------
-- cursor tanımlama
DECLARE
cursor c_emp is (select * from employees);
p_kayit c_emp % ROWTYPE;
BEGIN
open c_emp;
fetch c_emp into p_kayit;
sys.dbms_output.put_line(p_kayit.first_name);
close c_emp;
end;
--------------------------------
-- cursorden okunan değeri full name tipinden bir değişkene atamak
DECLARE 
cursor c_emp is (select first_name,last_name from employees);
type full_name is RECORD(
isim varchar2(30),
soyad varchar2(30)
);
per_full_name full_name;
begin
open c_emp;
fetch c_emp into  per_full_name;
 dbms_output.put_line(per_full_name.isim||' '||
 	per_full_name.soyad);

close c_emp;

    
end;
----------------------------
--aynı örnek loop içinde butun personellerin full name
DECLARE 
cursor c_emp is (select first_name,last_name from employees);
type full_name is RECORD(
isim varchar2(30),
soyad varchar2(30)
);
per_full_name full_name;
begin
open c_emp;
loop
fetch c_emp into  per_full_name;
 dbms_output.put_line(per_full_name.isim||' '||
 	per_full_name.soyad);
 exit
  when c_emp%notfound;
end loop;
close c_emp;

    
end;
--------------------------------
-- begin ve end bir scop tanımlıyor {}
-- butun çalışanların isimlerini yazdırmak
DECLARE
cursor c_emp is (select * from employees);
p_kayit c_emp % ROWTYPE;
BEGIN
open c_emp;
LOOP
	fetch c_emp into p_kayit;
	sys.dbms_output.put_line(p_kayit.first_name);
	EXIT 
	    when c_emp%notfound;
end loop;
close c_emp;
end;

-------------------
-- çalışanların sayısı
DECLARE
cursor c_emp is (select 'a' from employees);-- kayıt önemli deği sadece satır sayısı
p_kayit c_emp% ROWTYPE;
counter number(4):=0;
begin
open c_emp;
LOOP
	fetch c_emp into p_kayit;
	counter:=counter+1;
	EXIT
	  when c_emp%notfound;   
end loop;
sys.dbms_output.put_line(counter);
close c_emp;
end;
-------------------------
-- personellerin full isimler,
DECLARE
cursor c_emp is (select * from employees);
p_kayit c_emp% ROWTYPE;
begin
open c_emp;
LOOP
	fetch c_emp into p_kayit;
	sys.dbms_output.put_line(p_kayit.first_name|| ' '|| p_kayit.salary);
	EXIT
	  when c_emp%notfound;   
end loop;

close c_emp;
end;
------------
-- table = array
-- employee tutan bir dizi 
DECLARE
-- type oluşturma : arraylist<employees> gibi
type personel_table_type  is table of employees%ROWTYPE;
cursor c_emp is (select * from employees);
-- oluşturduğumuz typeden bir instance (obje) oluşturma
 personel_table personel_table_type;
begin
open c_emp;
	fetch c_emp BULK COLLECT into personel_table;
close c_emp;
-- index 1 den başlıyor
sys.dbms_output.put_line(personel_table(1).first_name);
end;
---------------------------
-- full name tipinden bir arraay oluşturma
DECLARE
type full_name is RECORD(
	isim varchar2(30),
	soyad varchar2(30)
);
cursor c is (select first_name,last_name from employees);
type per_full_name_table_type is table of full_name;
per_full_name_table per_full_name_table_type;

begin
open c;
fetch c BULK COLLECT into per_full_name_table;
close c;
dbms_output.put_line(per_full_name_table(1).isim);
end;
---------------------
-- tür oluşturmamıza gerek yok direk cursor tipinde bir array 
--oluştururuz
DECLARE
cursor c is (select first_name,last_name from employees);
type per_full_name_table_type is table of c%ROWTYPE;
per_full_name_table per_full_name_table_type;

begin
open c;
fetch c BULK COLLECT into per_full_name_table;
close c;
dbms_output.put_line(per_full_name_table(1).first_name);
end;

-- PLsqldeki fonksyonlar sql deki fonsyonlardan daha hızlı çalışır(max ,count gibi)
-- sadece first_name ve salary tutan bir dizi
DECLARE
cursor c_emp is (select first_name,salary from employees);
type personel_table_type  is table of c_emp%ROWTYPE;
 personel_table personel_table_type;
begin
open c_emp;
	fetch c_emp BULK COLLECT into personel_table;
close c_emp;
sys.dbms_output.put_line(personel_table(1).first_name|| ' '|| personel_table(1).salary);

end;
--
-- personel sayısı
DECLARE
cursor c_emp is (select first_name,salary from employees);
type personel_table_type  is table of c_emp%ROWTYPE;
 personel_table personel_table_type;
begin
open c_emp;
	fetch c_emp BULK COLLECT into personel_table;
	sys.dbms_output.put_line(c_emp%rowcount);
close c_emp;


end;
--
-- select into dönen kayıt sayısı tekse kullanılır
-- select while içinde kullanabiliriz
DECLARE
sal employees.salary%Type:=700;
mgr_id employees.manager_id%Type :=110;
lname employees.last_name%Type;
-- bu kod parçası ne yapıyor
begin
WHILE sal <= 15000 LOOP
	SELECT salary, manager_id, last_name   INTO 
	         sal ,    mgr_id , lname
	FROM employees
	WHERE employee_id = mgr_id;
	sys.dbms_output.put_line(mgr_id|| ' '||lname||'  '||sal);
END LOOP;
end;
-- output
--108 Chen  8200
--101 Greenberg  12008
--100 Kochhar  17000
--aynı kod sql ile çalışma aşamları
select * from employees
WHERE employee_id = 110; -> mgr=108
-- output
--108 Chen  8200
-- bu kişi tarafından yöetilen employee bul
select * from employees
WHERE employee_id = 108;  mgr=>101
-- output
--101 Greenberg  12008
select * from employees
WHERE employee_id = 101;  sal=>1700 
-- output
--100 Kochhar  17000
---------------------------
-- son satırdan kurtulmak için

DECLARE
sal employees.salary%Type:=700;
mgr_id employees.manager_id%Type :=110;
lname employees.last_name%Type;
begin
 LOOP
	SELECT salary, manager_id, last_name   INTO 
	         sal ,    mgr_id , lname
	FROM employees
	WHERE employee_id = mgr_id;
   
	exit 
	when sal > 15000;
     sys.dbms_output.put_line(mgr_id|| ' '||lname||'  '||sal);
	
END LOOP;
end;
-------------------------------
-- slayttan
DECLARE
v_jobid employees.job_id%TYPE; -- variable for job_id
v_lastname employees.last_name%TYPE; -- variable for last_name
CURSOR c1 IS SELECT last_name, job_id FROM employees;
BEGIN
OPEN c1; -- open the cursor before fetching
LOOP
-- Fetches 2 columns into variables
FETCH c1 INTO v_lastname, v_jobid;
-- exit yeri çok öneml yazdıramadan önce olmalı
EXIT WHEN c1%NOTFOUND;
--RPAD boşluk  atıyor
sys.DBMS_OUTPUT.PUT_LINE( RPAD(v_lastname, 25, ' ') || v_jobid );
END LOOP;
CLOSE c1;
sys.DBMS_OUTPUT.PUT_LINE( '-------------------------------------' );
END;
---------------------
-- birden ona kadar sayıları yazdırmak
DECLARE
begin
  for i in 1 ..10 loop
      DBMS_OUTPUT.put_line(i);
   end loop;
end;
--------------
DECLARE
begin
  for i in 1 ..1 loop
      DBMS_OUTPUT.put_line(i);
   end loop;
end;
--bir kere döner
--------------------------
DECLARE
begin
  for i in reverse 1 ..10 loop
      DBMS_OUTPUT.put_line(i);
   end loop;
end;
--10 9 8 7 6 5 4 3 2 1
--------------cursor örnekleri------------------
-- butun personellere ulaşmak için uyguladığımız yöntemler
-- örnekler tekrar
--personellerin full isimler,
DECLARE
cursor c_emp is (select * from employees);
p_kayit c_emp% ROWTYPE;
begin
open c_emp;
LOOP
	fetch c_emp into p_kayit;
	sys.dbms_output.put_line(p_kayit.first_name|| ' '|| p_kayit.salary);
	EXIT
	  when c_emp%notfound;   
end loop;

close c_emp;
end;
-----------
-- sonra BULK COLLECT kullanarak toplu atama yaptık
DECLARE
cursor c_emp is (select first_name,salary from employees);
type personel_table_type  is table of c_emp%ROWTYPE;
 personel_table personel_table_type;
begin
open c_emp;
	fetch c_emp BULK COLLECT into personel_table;
close c_emp;
sys.dbms_output.put_line(personel_table(1).first_name|| ' '|| personel_table(1).salary);

end;
--------
--  daha kolay yöntemler
-- for kullanarak çalışanların isimler yazdırmak
DECLARE
cursor c_emp is select * from employees;
r_personel c_emp%ROWTYPE;

begin
 for r_personel in c_emp loop
   dbms_output.put_line(r_personel.first_name||'  '||r_personel.last_name);
end loop;
end;
-- usee r_personel oluşturmadan for içinde kullanmak
DECLARE
cursor c_emp is select * from employees;
begin
 for r_personel in c_emp loop
   dbms_output.put_line(r_personel.first_name||'  '||r_personel.last_name);
end loop;
end;
--- cursor tanımlamadan yapılabilir
DECLARE
begin
 for r_personel in (select * from employees) loop
   dbms_output.put_line(r_personel.first_name||'  '||r_personel.last_name);
end loop;
end;
---------------------------------------------------
--cursor function gibi parametre alabilir
DECLARE
cursor c_emp(p_salary in pls_integer) is
select * from employees
where salary>p_salary;
begin
for r_personel in c_emp(5000) loop
    dbms_output.put_line(r_personel.first_name||'  '||r_personel.last_name||'  '||r_personel.salary);
 end loop;
end;
---------------
/*PROCEDURE geriye değer döndürmeyan bir işlem yapan kod parçası
void gibi
yani iş yapacaksan PROCEDURE (in out değişkenler kullanılır)
bir hesap yapacaksan ve geriye sonucu dödüruceksen function
*/
----benim-- dep_id == null ise sorun nvl eklenmeli
create or replace function get_department_name(p_department_id in pls_integer)
return varchar2 is
d_name varchar2(30);
begin
   select department_name into d_name 
   from departments
   where department_id=p_department_id;
   return(d_name);
end;
------ 2.yol 
create or replace function get_department_name(p_department_id in pls_integer)
return varchar2 is
cursor c_dep is
select department_name
from departments
where department_id=p_department_id;
r_dep varchar2(30);
begin
   open c_dep;
   fetch c_dep into r_dep;
   close c_dep;
   return(r_dep);
end;
--
DECLARE
begin
 for r_personel in (select * from employees) loop
   dbms_output.put_line(r_personel.first_name||'  '||get_department_name(r_personel.department_id));
end loop;
end;
-- sql içerisinde normal oracle fonkyonları gibi kullanılıabilir
    create or replace PROCEDURE fazla_maas_alan_sil
    (maas in pls_integer ) is
	begin
	   delete from personel
	   	where salary>maas;
	end;
    
  -------------------test1  
 DECLARE
begin
fazla_maas_alan_sil(6000);
end;
-----------------------
select * from personel where salary>6000
------------------------test 2
EXEC fazla_maas_alan_sil(15000)
---------------------- out paramtre kullanmak
create or replace PROCEDURE fazla_maas_alan_sil
	(maas in pls_integer ,silinen_kayit_sayisi out pls_integer ) is
	begin
	   delete from personel
	   	where salary>maas;
	   silinen_kayit_sayisi:=sql % rowcount;
	end;
	-------------------------- test
	 DECLARE
 s_kayit_sayisi Number(5);
begin
	fazla_maas_alan_sil(6000,s_kayit_sayisi);
	dbms_output.put_line(s_kayit_sayisi);

end;
-------------------------------------------
-- in out 
create or replace PROCEDURE artir( no in out number)is
	begin
	no:=no+1;
	end;
	DECLARE
	x Number(2):=2;
	begin
	artir(x);
	dbms_output.put_line(x);
	end;

	
--------------------- package c de header dosyası gibi
CREATE OR REPLACE 
PACKAGE PERSONEL_PAC AS 

PROCEDURE fazla_maas_alan_sil(maas in pls_integer ,silinen_kayit_sayisi out pls_integer );
function get_department_name(p_department_id in pls_integer)return varchar2;

END PERSONEL_PAC;
---packagin bi tane bodysi var butub fonksyonların implementation (bire bir)
CREATE OR REPLACE
PACKAGE BODY PERSONEL_PAC AS

  PROCEDURE fazla_maas_alan_sil(maas in pls_integer ,silinen_kayit_sayisi out pls_integer ) AS
  BEGIN
       delete from personel
	   	where salary>maas;
	   silinen_kayit_sayisi:=sql % rowcount;
  END fazla_maas_alan_sil;

  function get_department_name(p_department_id in pls_integer)return varchar2 AS
    d_name varchar2(30);
    begin
       select department_name into d_name 
       from departments
       where department_id=p_department_id;
     return(d_name);
     END get_department_name;

END PERSONEL_PAC;

------------------------------------------
-----------package
create or replace package
p_ppackage as
PROCEDURE artir(no in out number);
end ;
---------body
create or replace package BODY p_ppackage as
	 PROCEDURE artir( no in out number)is
		begin
		no:=no+1;
		end;
end;
------------test
  DECLARE
    x Number(2):=2;
  begin
    p_ppackage.artir(x);
    dbms_output.put_line(x);
  end;


