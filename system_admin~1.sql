--- PL/SQL Genel Yap�s�

DECLARE -- yaz�lmas� zorunlu de�ildir. Genellikle de�i�ken tan�mlan�r.

BEGIN -- yaz�lmas� zorunludur. Kod i�lemleri burda ger�ekle�ir.

    EXCEPTION WHEN NO_FOUND_DATA THEN -- yaz�lmas� zorunlu de�i�dir. Exceptionlar buraya yaz�l�r
END;


---- DATA TYPES
 
 
DECLARE
    wadi        CHAR(15); -- kullansada kullanmasada 15 karakterlik yer ay�rt�r.
    wsoyadi     VARCHAR2(15); -- kullan�lan de�er kadar kullan�r.
BEGIN
    wadi    := 'O�uzhan';
    wsoyadi := 'SE�GEL';
       
    dbms_output.put_line('*' ||wadi|| '*'); -- ��kt� �rne�i *O�uzhan               *
    dbms_output.put_line('*' ||wsoyadi|| '*'); -- ��kt� �rne�i *Se�gel*

END;


---***************** select * from customers 
DECLARE
    c_id    customers.�d%TYPE := 1;
    c_ad    customers.name%TYPE;
    c_soyad customers.surname%TYPE;
BEGIN
    SELECT
        �d,
        name,
        surname
    INTO
        c_id,
        c_ad,
        c_soyad
    FROM
        customers
    WHERE
        �d = c_id;

    dbms_output.put_line(c_id
                         || c_ad
                         || c_soyad);
END;

******---- SIMPLE LOOP - ko�ul olmad��� s�rece sonsuz d�ng�
--SYNTAX

DECLARE
    v_number number:=0;
BEGIN
    LOOP
    v_number := v_number + 1;
    dbms_output.put_line(v_number);
IF ( V_NUMBER = 100 )THEN EXIT ; END IF ;
    END LOOP;
END;



--******** For d�ng�s�
DECLARE
    v_number NUMBER := 10;
BEGIN FOR X IN 0 .. V_NUMBER LOOP 
    DBMS_OUTPUT.PUT_LINE ( X ) ;
    end loop;
    
END;


DECLARE
    v_number NUMBER := 10;
BEGIN FOR X IN 0 .. V_NUMBER LOOP 
    DBMS_OUTPUT.PUT_LINE ( X ) ;
    IF x=4 then
        
    exit;
    end if;
    end loop;
    
END;


 --******** CURSORS SELECT - UPDATE
 
DECLARE 
    rec_emp EMPLOYEES2%ROWTYPE; 
BEGIN
    SELECT * INTO rec_emp FROM employees2 WHERE employee_name='Oguzhan';
    
    
    IF SQL%FOUND THEN
        dbms_output.put_line('Kay�t var ' || sql%rowcount);
    ELSE
        dbms_output.put_line('Kay�t yok');
    END IF;
    
    IF SQL%NOTFOUND THEN
        dbms_output.put_line('Kay�t yok 1 ');
    ELSE
        dbms_output.put_line('Kay�t var 1 ');
    END IF;
    
    EXCEPTION WHEN NO_DATA_FOUND THEN 
        dbms_output.put_line('Kay�t yok 2');
end;
 
 
 
 
DECLARE 
    rec_emp EMPLOYEES2%ROWTYPE; 
BEGIN
    UPDATE EMPLOYEES2 SET EMPLOYEE_SALARY = EMPLOYEE_SALARY*1.20 WHERE DEPARTMENT_ID=5;
    
    
    IF SQL%FOUND THEN
        dbms_output.put_line(sql%rowcount || ' KAYIT UPDATE ED�LD�.');
    ELSE
        dbms_output.put_line('UPDATE ED�LECEK KAYIT BULUNAMADI');
    END IF;
    
end;
 
 
 -------- CURSORS EXPLICIT CURSORS SELECT employee_id, employee_name FROM EMPLOYEES2; birden fazla okuma hatas� i�in
 
 DECLARE 
 
    CURSOR c_emp IS SELECT employee_id, employee_name FROM EMPLOYEES2 order by employee_id DESC;
    
 
    wemployee_id    employees2.employee_id%type;
    wemployee_name  employees2.employee_name%type;
 BEGIN
 
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO wemployee_id,wemployee_name;
        EXIT WHEN c_emp%NOTFOUND;
        dbms_output.put_line('ID : '|| wemployee_id ||' ADI : ' || wemployee_name);
    END LOOP;
    CLOSE c_emp;
     
 END;
 
 ------------ CURSORS explicit
DECLARE

    CURSOR cursorname IS SELECT employee_id,employee_name,ROUND(employee_salary, 2) as employee_salary FROM EMPLOYEES2; -- cursor tan�mlanmas� rounda ise , den sonra al�nacak basamak say�s�

    wempid      employees2.employee_id%type;
    wempname    employees2.employee_name%type;
    wempsalary  EMPLOYEES2.employee_salary%type;
BEGIN
    OPEN cursorname; -- cursor a�ma i�lemi
    LOOP
        FETCH cursorname INTO wempid,wempname,wempsalary;
        EXIT WHEN cursorname%NOTFOUND; -- veri bulunmazsa d�ng�den ��kar
            dbms_output.put_line('Calisan Id : ' || wempid || ' Calisan Adi : ' || wempname ||' Calisan Maasi : '||wempsalary );
    END LOOP;
    
    CLOSE cursorname;
    
END;
--------
DECLARE
    CURSOR cursorname IS SELECT employee_name,ROUND(employee_salary, 2) as employee_salary FROM EMPLOYEES2 ORDER BY employee_salary DESC;
    wempname    employees2.employee_name%type;
    wempsalary  EMPLOYEES2.employee_salary%type;


BEGIN
    OPEN cursorname;
    LOOP
        FETCH cursorname INTO wempname,wempsalary;
        EXIT WHEN cursorname%NOTFOUND;
           dbms_output.put_line('CALISAN ADI  :' ||wempname ||' CALISAN MAASI : '|| wempsalary  );
    END LOOP;
    
    CLOSE cursorname;
END;


--------******************************* EXCEPTION
DECLARE 
v_id CUSTOMERS.ID%type:=1;
v_adi CUSTOMERS.NAME%type:='Ogu';
v_soyad CUSTOMERS.SURNAME%type;
BEGIN

SELECT SURNAME
INTO v_soyad
FROM customers
WHERE NAME=v_adi;


EXCEPTION
    -- Kullan�c� bulunamad�
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Adi ' || v_adi || ' olan kullanici bulunamadi.');

END;


--******************************** �F ELSE *************************
DECLARE

v_sayi1 integer:=3;
v_sayi2 integer:=5;


BEGIN

IF (v_sayi1 = 1) THEN
    dbms_output.put_line('Sayi 1 ' || v_sayi1 );
ELSIF(v_sayi1=2) THEN
    dbms_output.put_line('Sayi 1 ' || v_sayi1 );
ELSIF(v_sayi1=5) THEN
    dbms_output.put_line('Sayi 1 ' || v_sayi1 );
ELSE
    dbms_output.put_line('Sayi 1 ' || v_sayi1 );
END IF;
END;


 
 ----------------KOSULLU AKIS KONTROLLER �F
 
DECLARE
    dogumTarihi date    := to_date('29.04.2005','dd/mm/yyyy');
    yasi        number(3);

BEGIN
    yasi:=(sysdate-dogumTarihi)/365;
    
    if yasi<15 then
        dbms_output.put_line('Ben Cocugum Yasim : '|| yasi);
    elsif yasi<20 then
        dbms_output.put_line('Ben Gencim Yasim :'|| yasi);
        if yasi>18 then
            dbms_output.put_line('Ben 19 Yasindayim');
        end if;
    else
        dbms_output.put_line('Ben Cocuk Degilim Yasim :'|| yasi);
    end if;
END;
 
-------------------KOSULLU AKIS KONTROLLER SW�TCH CASE
DECLARE
    dogumTarihi date    := to_date('29.04.2015','dd/mm/yyyy');
    yasi        number(3);

BEGIN
    yasi:=(sysdate-dogumTarihi)/365;
    
    CASE
        when yasi<15 then dbms_output.put_line('Ben Cocugum Yasim : '|| yasi);
        when yasi<20 then dbms_output.put_line('Ben Gencim Yasim :'|| yasi);
    END CASE;
END;
 
---

-- i�inde bulundu�umuz g�n�n ad�n� yazd�ran program(unnamed block veritaban�nsda saklanmaz)

DECLARE

v_day varchar(25);
v_month varchar(25);
BEGIN
v_day:=To_CHAR(SYSDATE,'DAY');
v_month:= TO_CHAR(SYSDATE,'MONTH');
dbms_output.put_line('Bug�n : '|| v_day || ' Ay : ' || v_month);

END;

-- i�inde bulundu�umuz g�n�n ad�n� yazd�ran program(named block veri taban�nsda functionsda saklan�r)


CREATE OR REPLACE function GET_DAY_NAME(P_TARIH DATE) RETURN VARCHAR2
IS
BEGIN
    RETURN(TO_CHAR(P_TARIH, 'DAY'));
END;
/


SELECT GET_DAY_NAME(SYSDATE) FROM dual;

 CREATE OR REPLACE function BOLME(A IN NUMBER, B IN NUMBER) RETURN NUMBER
 IS
 C NUMBER;
 BEGIN
 C:=A/B;
 RETURN(C);
 END;
 
 BEGIN 
 dbms_output.put_line(BOLME(4,2));
 END;
 
 

 --- EXCEPTION BLOCK SQLERRM hata mesaj� i�i SQLERRM
 
 
DECLARE 
    D NUMBER;
BEGIN
    D:=BOLME(10,0);
    dbms_output.put_line(D);
    
    EXCEPTION WHEN ZERO_DIVIDE THEN
    dbms_output.put_line('SIFIRLA BOLME YAPILAMAZ...!! ' || SQLERRM);
END;
 
 
 
 ---
 SELECT * FROM CUSTOMERS
 
 
 ----------------------------------********************************************************************
CREATE OR REPLACE function GETNAME(IDNO IN NUMBER)RETURN VARCHAR2

IS
    VKADI VARCHAR2(35);
BEGIN

    SELECT NAME INTO VKADI FROM CUSTOMERS 
    WHERE ID= IDNO;

    RETURN(VKADI);
    EXCEPTION WHEN NO_DATA_FOUND THEN
        Return(IDNO||' nolu kullanici bulunamad�');
END;


DECLARE
VADI VARCHAR2(35);
BEGIN
VADI := GETNAME(12);
dbms_output.put_line(''||VADI);
    
END;



 -- BLOB UYGULAMASI file sistemden dbye resim aktaran PL/SQL uygulamas�

 create table RESIMLER(
                        dosyaAdi varchar2(100) primary key,
                        resim   blob);
 
 
 
 create directory IMAGE_DIR as 'c:\RESIMLER';
 
 
DECLARE
    foto            bfile;
    tempdata        blob;
    kaynakOffSet    PLS_INTEGER:=1;
    hedefOffSet     PLS_INTEGER:=1; 
    
BEGIN
    dbms_lob.CreateTemporary(tempdata,true);
    foto := BFileName('IMAGE_DIR','kedi.jpg');
    dbms_lob.FileOpen(foto,dbms_lob.FILE_READONLY);
    dbms_lob.LoadFromFile(tempdata,foto, dbms_lob.LOBMAXSIZE,hedefOffSet,kaynakOffSet);
    
    INSERT INTO RESIMLER (dosyaAdi,resim) values ('kedi.jpg',tempdata);
    commit;
    
    dbms_lob.FileClose(foto);

END;

 
 select * from RESIMLER;
 
 

 
-- FUNCTION AND PROCEDURE
 
-- Idsi girilien customer�n ad�n� getir
CREATE OR REPLACE function customer_name_by_id (customer_id IN CUSTOMERS.ID%TYPE)
RETURN CUSTOMERS.NAME%TYPE
IS
  v_name CUSTOMERS.NAME%TYPE;
BEGIN
  SELECT NAME
  INTO v_name
  FROM CUSTOMERS
  WHERE ID = customer_id;
  
  RETURN v_name;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 'Not Found'; 
END;
 
 
DECLARE
  v_name CUSTOMERS.NAME%TYPE;
BEGIN
  v_name := customer_name_by_id(6);
  dbms_output.put_line(v_name);
END;
 
 ---- IDS� girilen �lkenin ad�n� getir
 
 
 CREATE OR REPLACE function country_get_by_id(v_id IN COUNTRY.ID%TYPE) 
 RETURN COUNTRY.NAME%TYPE
 IS
    v_name COUNTRY.NAME%TYPE;
 BEGIN
    SELECT NAME
    INTO v_name
    FROM COUNTRY
    WHERE COUNTRY.ID = v_id;
    RETURN v_name;
 
 EXCEPTION 
     WHEN NO_DATA_FOUND THEN
        RETURN 'NO FOUND COUNTRY '||v_name;
 END;
 
 
 DECLARE
 v_cName COUNTRY.NAME%TYPE;
 BEGIN
 v_cName := country_get_by_id(14);
 dbms_output.put_line(v_cName);
 
 END;
 
 

 
 
 
 --- LOOP
 
 
 DECLARE
    rec_kurs KURSLAR%ROWTYPE; -- KURSLAR tablosunun sat�r t�r�n� kullanarak bir kay�t de�i�keni tan�mlan�yor.

BEGIN
    rec_kurs.egitmen := 'O�uzhan Se�gel'; -- Egitmen de�i�kenine de�er atama

    LOOP
        rec_kurs.kurs_id := NVL(rec_kurs.kurs_id, 0) + 1; -- kurs_id de�erini art�rma

        EXIT WHEN rec_kurs.kurs_id = 4; -- kurs_id 4 oldu�unda d�ng�y� sonland�rma

        -- Kurs ad�n� belirlemek i�in DECODE fonksiyonunu kullanma
        SELECT DECODE(rec_kurs.kurs_id,
                       1, 'Oracle SQL',
                       2, 'PL/SQL',
                       3, 'Oracle DBA')
        INTO rec_kurs.kurs_adi
        FROM DUAL;

        -- KURSLAR tablosuna yeni bir kay�t ekleme
        INSERT INTO KURSLAR (kurs_id, kurs_adi, egitmen)
        VALUES (rec_kurs.kurs_id, rec_kurs.kurs_adi, rec_kurs.egitmen);

    END LOOP;

    COMMIT; -- Veritaban�ndaki de�i�iklikleri kal�c� hale getirme
END;
 
 
 
 
 
 

 
 
 ----- CURSOR %ISOPEN %FOUND %NOTFOUND

 
 SELECT * FROM EMPLOYEES2
 
 
 BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO EMPLOYEES2 (employee_id, employee_name, employee_SURname, employee_salary, department_id)
        VALUES (
            i, -- employee_id: Her bir kay�t i�in benzersiz ID
            'Name' || i, -- first_name: �rne�in 'Name1', 'Name2', vb.
            'Surname' || i, -- last_name: �rne�in 'Surname1', 'Surname2', vb.
            DBMS_RANDOM.VALUE(40000, 60000), -- salary: 40,000 ile 60,000 aras�nda rastgele de�er
            TRUNC(DBMS_RANDOM.VALUE(1, 7)) -- department_id: 1 ile 6 aras�nda rastgele de�er
        );
    END LOOP;
    
    COMMIT;
END;
/
 
 












 
 ----remoteoracle kodlar�
 CREATE OR REPLACE function avg_price_product
RETURN NUMBER
IS
    v_avg_price NUMBER;
BEGIN
    -- Ortalama fiyat� hesapla
    SELECT AVG(PRICE) INTO v_avg_price
    FROM PRODUCTS;

    -- Hesaplanan ortalama fiyat� d�nd�r
    RETURN v_avg_price;
END;
/

DECLARE

v_price PRODUCTS.PRICE%TYPE;

BEGIN

v_price:= avg_price_product;
dbms_output.put_line(v_price);
END;

