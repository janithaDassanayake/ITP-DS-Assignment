CREATE TYPE Guardian_T AS OBJECT(
gname VARCHAR2(30),
gmobile VARCHAR2(30),
gincome number(8,2),
samurdhi char(1),
RELATIONSHIP VARCHAR2(30)
)
/

CREATE TYPE Guardian_T_TABLE AS TABLE OF Guardian_T
/

CREATE OR REPLACE TYPE schedule_T
/


CREATE OR REPLACE TYPE Doctor_t AS OBJECT(
doctorid int , 
docname varchar2(50), 
dspecialization varchar2(30),
visitChg float
)
/


CREATE OR REPLACE TYPE Adolescents_T AS OBJECT (
ano number(4), 
aname varchar2(15), 
dob date,
adoctor ref Doctor_t,
paymentfee number(8,2),
Guardian Guardian_T_TABLE
)
/


CREATE OR REPLACE TYPE schedule_T AS OBJECT(
schedule_no number(2),
schedule_name varchar2(12),
schedule_type varchar2(12),
scheduled_adolescent ref Adolescents_T
)
/

CREATE OR REPLACE TYPE Activity_t AS OBJECT (
activity_no number(4),
activity_name varchar2(15),
aschedule ref schedule_T,
arate number(2)
)
/


CREATE OR REPLACE TYPE medicalRecord_T AS OBJECT(
rAdolescent ref Adolescents_T , 
rdoctor ref Doctor_t,
rdate date
)
/




---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------


CREATE TABLE schedule OF schedule_T(
schedule_no PRIMARY KEY
)
/

CREATE TABLE Adolescents of Adolescents_T(
ano primary key)
nested table Guardian store as Guardian_tb
/

ALTER TABLE schedule 
MODIFY scheduled_adolescent REFERENCES Adolescents;
/

CREATE TABLE Activity OF Activity_t(
activity_no primary key,
aschedule references schedule
)
/


CREATE TABLE Doctor of Doctor_t(
doctorid primary key
)
/


CREATE TABLE medicalRecord of medicalRecord_T(
rAdolescent references Adolescents,
rdoctor references Doctor
)
/



---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

INSERT INTO Adolescents VALUES(1112,'JACK','21-JAN-97',NULL,10000.00,
Guardian_T_TABLE(Guardian_T('piyal','0717036280',20000.00 ,'Y' ,'FATHER' ),
Guardian_T('martha','0717936281',0.00,'N','MOTHER')))
/

INSERT INTO Adolescents VALUES(1113,'dureksha','07-FEB-20',NULL,20000.00,
Guardian_T_TABLE(Guardian_T('saman','0717045280',30000.00,'N','FATHER'),
Guardian_T('sunil','0727966281',25000.00,'N','UNCLE'),
Guardian_T('kanthi','0768836280' ,0.00 , 'N' ,'MOTHER')))
/

INSERT INTO Adolescents VALUES(1114,'thilini','21-AUG-97',NULL,30000.00,
Guardian_T_TABLE(Guardian_T('nimal' , '0777816280' , 50000.00 , 'N' , 'FATHER' ),
Guardian_T('nilani','0717936000',0.00,'N','MOTHER')))
/

INSERT INTO Adolescents VALUES(1115,'sonal','26-JAN-98',NULL,20000.00,
Guardian_T_TABLE(Guardian_T('asela' , '0722816280' , 40000.00 , 'Y' , 'UNCLE' )))
/

INSERT INTO Adolescents VALUES(1116,'Chamal','10-NOV-98',NULL,120000.00,
Guardian_T_TABLE(Guardian_T('sumana' , '0712216280' , 46000.00 , 'N' , 'AUNTY' )))
/






---------------------------------------------------------------------------------------------------

INSERT INTO Doctor VALUES(Doctor_t(10,'Dr.K.Alvis','Psychologist','1500.00'))
/
INSERT INTO Doctor VALUES(Doctor_t(11,'Dr.L.Dasun','Psychiatrist','2500.00'))
/
INSERT INTO Doctor VALUES(Doctor_t(12,'Dr.N.Saduni','therapist','1000.00'))
/
INSERT INTO Doctor VALUES(Doctor_t(13,'Dr.J.Sudath','Psychologist','1700.00'))
/
INSERT INTO Doctor VALUES(Doctor_t(14,'Dr.K.Avishka','counselor','1200.00'))
/




---------------------------------------------------------------------------------------------------


INSERT INTO schedule  VALUES(schedule_T(01,'schedule1','morning',(select ref(a) from Adolescents a where a.ano= 1112)))
/
INSERT INTO schedule  VALUES(schedule_T(02,'schedule2','evening',(select ref(a) from Adolescents a where a.ano= 1113)))
/
INSERT INTO schedule  VALUES(schedule_T(03,'schedule3','affternoon',(select ref(a) from Adolescents a where a.ano= 1113)))
/
INSERT INTO schedule  VALUES(schedule_T(04,'schedule5','night',(select ref(a) from Adolescents a where a.ano= 1112)))
/
INSERT INTO schedule  VALUES(schedule_T(05,'schedule3','affternoon',(select ref(a) from Adolescents a where a.ano= 1114)))
/
INSERT INTO schedule  VALUES(schedule_T(06,'schedule1','morning',(select ref(a) from Adolescents a where a.ano= 1115)))
/
INSERT INTO schedule  VALUES(schedule_T(07,'schedule1','morning',(select ref(a) from Adolescents a where a.ano= 1116)))
/
INSERT INTO schedule  VALUES(schedule_T(08,'schedule3','affternoon',(select ref(a) from Adolescents a where a.ano= 1112)))
/
INSERT INTO schedule  VALUES(schedule_T(09,'schedule1','morning',(select ref(a) from Adolescents a where a.ano= 1115)))
/
INSERT INTO schedule  VALUES(schedule_T(10,'schedule1','morning',(select ref(a) from Adolescents a where a.ano= 1116)))
/



---------------------------------------------------------------------------------------------------


INSERT INTO Activity VALUEs(Activity_t(0001,'speaking',(select ref (s) from schedule  s where s.schedule_no=01),07))
/
INSERT INTO Activity VALUEs(Activity_t(0002,'reading',(select ref (s) from schedule  s where s.schedule_no=02),05))
/
INSERT INTO Activity VALUEs(Activity_t(0003,'writing',(select ref (s) from schedule  s where s.schedule_no=04),05))
/
INSERT INTO Activity VALUEs(Activity_t(0004,'listeing',(select ref (s) from schedule  s where s.schedule_no=05),10))
/
INSERT INTO Activity VALUEs(Activity_t(0005,'speach',(select ref (s) from schedule  s where s.schedule_no=06),05))
/


---------------------------------------------------------------------------------------------------

INSERT INTO medicalRecord VALUEs(medicalRecord_T((select ref(a) from Adolescents a where a.ano= 1113),(select ref (d) from Doctor d where d.doctorid=11),'27-JAN-19'))
/
INSERT INTO medicalRecord VALUEs(medicalRecord_T((select ref(a) from Adolescents a where a.ano= 1114),(select ref (d) from Doctor d where d.doctorid=12),'01-FEB-20'))
/
INSERT INTO medicalRecord VALUEs(medicalRecord_T((select ref(a) from Adolescents a where a.ano= 1112),(select ref (d) from Doctor d where d.doctorid=10),'20-MAR-20'))
/
INSERT INTO medicalRecord VALUEs(medicalRecord_T((select ref(a) from Adolescents a where a.ano= 1115),(select ref (d) from Doctor d where d.doctorid=10),'21-NOV-19'))
/
INSERT INTO medicalRecord VALUEs(medicalRecord_T((select ref(a) from Adolescents a where a.ano= 1116),(select ref (d) from Doctor d where d.doctorid=14),'03-DCE-19'))
/
INSERT INTO medicalRecord VALUEs(medicalRecord_T((select ref(a) from Adolescents a where a.ano= 1112),(select ref (d) from Doctor d where d.doctorid=10),'03-DEC-19'))
/
INSERT INTO medicalRecord VALUEs(medicalRecord_T((select ref(a) from Adolescents a where a.ano= 1113),(select ref (d) from Doctor d where d.doctorid=11),'03-DEC-19'))
/
INSERT INTO medicalRecord VALUEs(medicalRecord_T((select ref(a) from Adolescents a where a.ano= 1114),(select ref (d) from Doctor d where d.doctorid=12),'16-FEB-20'))
/
INSERT INTO medicalRecord VALUEs(medicalRecord_T((select ref(a) from Adolescents a where a.ano= 1112),(select ref (d) from Doctor d where d.doctorid=10),'27-OCT-19'))
/
INSERT INTO medicalRecord VALUEs(medicalRecord_T((select ref(a) from Adolescents a where a.ano= 1115),(select ref (d) from Doctor d where d.doctorid=10),'06-NOV-19'))
/
INSERT INTO medicalRecord VALUEs(medicalRecord_T((select ref(a) from Adolescents a where a.ano= 1116),(select ref (d) from Doctor d where d.doctorid=14),'02-AUG-19'))
/
INSERT INTO medicalRecord VALUEs(medicalRecord_T((select ref(a) from Adolescents a where a.ano= 1112),(select ref (d) from Doctor d where d.doctorid=10),'25-JAN-20'))
/

--------------------------------------------------------------------------------------------

update Adolescents a
set a.adoctor = (select ref(d) from Doctor d where d.doctorid = 10)
where a.ano = 1112
/

update Adolescents a
set a.adoctor = (select ref(d) from Doctor d where d.doctorid = 11)
where a.ano = 1113
/

update Adolescents a
set a.adoctor = (select ref(d) from Doctor d where d.doctorid = 12)
where a.ano = 1114
/

update Adolescents a
set a.adoctor = (select ref(d) from Doctor d where d.doctorid = 10)
where a.ano = 1115
/

update Adolescents a
set a.adoctor = (select ref(d) from Doctor d where d.doctorid = 14)
where a.ano = 1116
/



---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------



ALTER TYPE Adolescents_T
ADD MEMBER FUNCTION
taxPayment(RATE FLOAT) RETURN FLOAT
CASCADE;
/


ALTER TYPE Adolescents_T
ADD MEMBER FUNCTION
calclDiscount RETURN FLOAT
CASCADE;
/



CREATE OR REPLACE TYPE BODY Adolescents_T AS
	MEMBER FUNCTION calclDiscount RETURN FLOAT IS
	discount FLOAT;
	BEGIN
			SELECT SUM(0.02 * SELF.paymentfee) INTO discount
			FROM TABLE(SELF.Guardian) d
			WHERE d.samurdhi = 'N';
			RETURN discount;
			
	
	END;
	
	MEMBER FUNCTION taxPayment(RATE FLOAT) RETURN FLOAT IS	
	BEGIN
		RETURN SELF.paymentfee * RATE;		
	
	END;
END;
/









ALTER TYPE Doctor_t
ADD MEMBER FUNCTION aditionalOTcharge(rate FLOAT,othours FLOAT)
RETURN FLOAT CASCADE;
/

ALTER TYPE Doctor_t
ADD MEMBER FUNCTION TotalCharge_WithOT(rate FLOAT,othours FLOAT)
RETURN FLOAT CASCADE;
/


CREATE OR REPLACE TYPE BODY Doctor_t AS 
MEMBER FUNCTION 
aditionalOTcharge(rate FLOAT, othours FLOAT) 
	RETURN FLOAT IS 
		BEGIN 
			return rate* othours * SELF.visitChg; 
             
		END aditionalOTcharge; 
        
MEMBER FUNCTION 
TotalCharge_WithOT(rate FLOAT,othours FLOAT)
	RETURN FLOAT IS 
    x float;
		BEGIN 
			x := rate * othours *SELF.visitChg; 
            RETURN x+SELF.visitChg; 
            
		END TotalCharge_WithOT;         
    
END; 
/

select d.docname,d.dspecialization,d.visitChg ,d.aditionalOTcharge(0.05,3),d.TotalCharge_WithOT(0.05,3)
from doctor d
WHERE d.docname='Dr.J.Sudath';


select d.docname,d.dspecialization,d.visitChg ,d.aditionalOTcharge(0.05,3),d.TotalCharge_WithOT(0.05,3)
from doctor d;












create type body Adolescents_T
as member function
age
return number is
x number;
begin
    
     x:=trunc(months_between(SYSDATE,self.dob)/12);

  return x;
end age;
end;

--------------------------------------------

select t.aname as NAME,t.age() as AGE
from Adolescents t







