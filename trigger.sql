/* tetikliyici anlamında 
tablo üzerinde tanımlanan bir nesne
triggerler update , insert ve delete yaptığımızda tetikleniyor
olayın istediğmiz gibi tetkilenmesini sağlıyoruz
ddl  den önce  loglama yapılır
*/
-- constraint ile trigger arasındaki farklar
-- constraint where kısmında yazılabilen şartlar içeriyor
--- kayıt kuralı sağlıyorsa ekleniyor sağalmiyors eklenmiyor
-- sadece o tablunun değerlerine ulaşıyor

-- trigger pl sql yazılıyor
-- butun tablolara ulaşabiliyor
-- bir işlem yaptırabiliyoruz

select * from personel
 alter table personel
 add(kayit_giris_tarihi date)
-- personel tablosuna kayit_giris_tarihi otomatik atama
create or replace trigger trg_kayit_tarihi
	before insert on personel
	for each row
	begin
	-- new kayda referans ediyor 
	:NEW.kayit_giris_tarihi:=sysdate;
	end;
-----
maas dusurulemez kuralı
  insert into personel
		(employee_id,first_name,last_name,email,hire_date ,job_id)
        values
		(333,'ahmet','ak','a@gmail.com',sysdate,'SA_REP')
		-----------------------------------
	create or replace trigger trg_maas
	before update of salary on personel
	for each row
	begin
	-- new kayda referans ediyor 
	if :NEW.salary<:old.salary then
	   DBMS_OUTPUT.PUT_LINE('hata');
	   raise_application_error(-20001,'maasi dusuremezsiniz');
	end if;
	end;
    select * from personel
   
    update personel
    set salary=(salary-100)
    where employee_id=104
   /* output 
    Error report -
ORA-20001: maasi dusuremezsiniz
ORA-06512: at "HR.TRG_MAAS", line 5
ORA-04088: error during execution of trigger 'HR.TRG_MAAS'*/

	--statement level tablo için genel bir
	--kural varsa Or maas < 10000 olamaz

	-- log tablosu 
		create table Personel_log as (select * from personel)
    truncate table Personel_log
    
    select * from personel_log
    
    alter table Personel_log 
    add(tur varchar2(30))
     create or replace trigger trg_log_per
     	
         
