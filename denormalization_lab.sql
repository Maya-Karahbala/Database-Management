-- soru 1 Kişilerin çalışma sürelerini isimleriyle sorgulayınız.
alter table personel
add (calismaSuresi Number(5))

update personel
set calismaSuresi=hire_date-sysdate
-- Birimlerdeki personel adetlerini birim isimleriyle birlikte bulunuz
 alter table birim
 add (personel_adet Number(4))

update birim b
set personel_adet=(select count('a') from personel p
where b.department_id=p.department_id )
--Kişiler isimlerini, unvan isimleri ile birlikte sorgulayınız.
alter table personel
add (dep_name varchar2(30))

update personel p
set dep_name=(
 select department_name from birim b where p.department_id=b.department_id)
--Belirli bir şehirde çalışan kişi sayısını bulunuz.
alter table countries
add(per_adet Number(30))

select * from countries

update countries c
set per_adet=(
select count('a')
from employees e,birim b, locations l
where e.department_id=b.department_id
and b.location_id=l.location_id
and l.country_id=c.country_id
)

--Kendi birimi ortalamasından yüksek maaş alan kişileri «YÜKSEK MAŞ» düşük alanları «DÜŞÜK
--MAAŞ» kategorisi niteleyiniz.

alter table personel
add (maasdurum varchar2(20) ) 

update personel ust
set maasdurum= 
case
  when salary>(select avg(salary) from personel alt where  ust.department_id=alt.department_id)    then 'yuksek maas'
  else  'dusuk maas'
end

-----------------------------
ek sorular
-- personel tablosuna durum kolumu ekle maas ortalamadan tuksekse 
--yuksek azsa az yapın
 select salary,
	case when salary>(select avg(salary) from personel) then 'high'
	else  'low'
	end case
 from personel
