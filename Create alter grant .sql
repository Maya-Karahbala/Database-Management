-- create
create table calisan3
(adi varchar2(30), soyadi varchar2(30), calisan_id Number)
--
 select * from calisan3
  select * from employees
  select * from ogretmen
 -- drop
 drop table calisan2
 -- create table with primart key  constraint kural demek
 create table ogretmen
 (adi varchar2(30), soyadi varchar2(30), ogretmen_id Number
 , constraint ogretmen_pk primary key (ogretmen_id))
 -- OGRETMEN_PK buyuk harflerle yazılmalı yoksa çalışmaz 
 -- aynı durumda foregin key boyle saklanır kendisi bir nesne 
 select * from all_constraints
 where constraint_name ='OGRETMEN_PK'
 -- give info in output about the table
 desc ogretmen
 -- var olan bir tabloya colum ekleme
 alter table ogretmen
 add (adres varchar2(40))
 -- add constraint
  alter table ogretmen
 add (adres varchar2(40))
 --
  alter table ogretmen
 add (department_id Number)
 -- var olan bir colum  foregin key yapmak
ALTER TABLE ogretmen
ADD CONSTRAINT fk_ogretmen
  FOREIGN KEY (department_id)
  REFERENCES Departments(department_id);
  --
  insert into ogretmen
  (adi,ogretmen_id)
  values
  ('Ahmet',9)
  -- var olmayan bir department_id yazsak eroor verir   parent key not found
   insert into ogretmen
  (adi,ogretmen_id,department_id)
  values
  ('Ahmet',11,9990)
 --
  update ogretmen 
  set department_id=900
  -- error verir
  delete from departments
  where department_id=90
  --ORA-02292: integrity constraint (HR.EMP_DEPT_FK) violated - child record found
  -- bunlar static controller
  -- burda foregin key seçenekleri var 
  -- ya default ata , yada kontrol etmeden sil
  -- foreginkey ile ilgili kayıtlar luck koyar
 SELECT table_name FROM user_tables
 SELECT table_name FROM all_tables
 -- butun kullanıcılarımlar kayit_Giren_Kullanici columu eklemek istiyorum
 alter table calisan
 add (kayit_Giren_Kullanici varchar2(30) )
 --
 
 select 'alter table '|| table_name||' add (kayit_Giren_Kullanici varchar2(30) );' from user_tables
 -- output sonucu script olarak çalıştırılabilir
alter table REGIONS add (kayit_Giren_Kullanici varchar2(30) );
alter table LOCATIONS add (kayit_Giren_Kullanici varchar2(30) );
alter table DEPARTMENTS add (kayit_Giren_Kullanici varchar2(30) );
alter table JOBS add (kayit_Giren_Kullanici varchar2(30) );
alter table EMPLOYEES add (kayit_Giren_Kullanici varchar2(30) );
alter table JOB_HISTORY add (kayit_Giren_Kullanici varchar2(30) );
alter table PERSONEL add (kayit_Giren_Kullanici varchar2(30) );
alter table BIRIM add (kayit_Giren_Kullanici varchar2(30) );
alter table PERSONEL2 add (kayit_Giren_Kullanici varchar2(30) );
alter table CALISAN add (kayit_Giren_Kullanici varchar2(30) );
alter table OGRENCI add (kayit_Giren_Kullanici varchar2(30) );
alter table OGRETMENLER add (kayit_Giren_Kullanici varchar2(30) );
alter table CALISAN3 add (kayit_Giren_Kullanici varchar2(30) );
alter table OGRETMEN add (kayit_Giren_Kullanici varchar2(30) );
alter table COUNTRIES add (kayit_Giren_Kullanici varchar2(30) );
 -- drop constrait
 alter table ogretmen
 drop constraint fk_ogretmen
 --
  -- veri tabanında bütün kuralları siliıyor hiç bir kayıt silmez sadece kuralları autocommit roleback işe yaramiyor truncate de autocimmit
-- CASCADE CONSTAINTS
-- foregn key eklemeye çalıştığımızda onceki kayıtları kontrol etme diye bilirim 
--deferrable initially immaidate  novalidate 
 
  -- eskiden eklemediğim kayıt ekleye bilirim
  -- sonra bi daha foregin key eklemeye çalışsam kabule etmez onceki kayıtlar uymuyor onu çözmek için
  --deferrable initially immaidate  novalidate  ekleriz
  
  
  -- veri tabanında objeler userler ve haklar var
  -- roller hak gurubu toplu haklar vermek için kullanılır
  -- haklar iki düzeye bölünür 
  --  1- nesne özerinde(ekleme , silme,) -> belli satırlar üzerinde yada belli sütünler
  --, 2- system üzerinde create table delete
  -- ssteme g,r,ş yaparken yeni user oluşturma
  -- yetki sırası  sys -> system ->hr
  CREATE USER maya1 IDENTIFIED BY maya1;
  -- bağlanma hakkı verme
  grant create session to maya
    -- tablolar 3 düzeyde
   --   1- user  2- all -db
   -- public synunim tum kullanıcıların göre bileceği tablolar her zaman user.tablo ismi yazmamak için
   -- system kodları
   CREATE USER mayaa IDENTIFIED BY mayaa;
grant create session to mayaa;
SELECT table_name FROM dba_tables
grant create table to mayaa
GRANT UNLIMITED TABLESPACE TO mayaa
 select * from hr.employees
 grant select on  hr.employees to mayaa
 grant all on  hr.employees to mayaa
  select * from ders
  -- 3aşamalı bir id
  create role adminRol
  grant UNLIMITED TABLESPACE to adminRol
   grant all on hr.departments to adminRol
   grant adminRol to mayaa
    revoke adminRol from mayaa
    revoke all on hr.employees from mayaa
    -- sütün bazlı tyetkiler maaş columu gibi
     grant update (job_id) on hr.jobs to mayaa
      -- aynı zamanda satır bazlı yetkiler verilebilir  primary key kullanarak fonksyon yazılır true dönerse kullanıcı işlem yapabikir
   
  select table_name from all_tables
 SELECT table_name FROM user_tables
 SELECT table_name FROM all_tables
  SELECT table_name FROM dba_tables
 create table ders 
 (name varchar2(30),puan Number)
 select * from ders
 -- oluşturduğu tablolar üzerinde değiştirme hakkı var
 alter table ders
 add(notSystemi varchar2(30))
 -- hr tabloları görme hakkı yok
 select * from hr.employees
  select * from hr.departments
  -- viyo konusu slaydlarda var
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
