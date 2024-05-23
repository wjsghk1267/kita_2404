--TASK1. 10���� �Ӽ��� �����Ǵ� ���̺� 2���� �ۼ��ϼ���. �� FOREIGN KEY�� �����Ͽ� ���� ���̺��� �����͸� ������ �ٸ� ���̺��� ���õǴ�
--�����͵� ��� �����ǵ��� �ϼ���. (��� ���� ������ ���)
--��, �� ���̺� 5���� �����͸� �Է��ϰ� �ι�° ���̺� ù��° �����͸� �����ϰ� �ִ� �Ӽ��� �����Ͽ� �����͸� ����.
CREATE TABLE customers(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30));
FOREIGN KEY(custid) REFERENCES customers(custid) ON DELETE CASCADE);

CREATE TABLE orders(
orderid NUMBER UNIQUE,
orderdate DATE PRIMARY KEY,
custid NUMBER,
price NUMBER DEFAULT 6000 CHECK(price > 3000),
saleprice NUMBER,
menu VARCHAR(20),
FOREIGN KEY(custid) REFERENCES customers(custid) ON DELETE CASCADE);

INSERT INTO customers VALUES(1,'ö��','���ﵿ','010-1234-1234');
INSERT INTO customers VALUES(2,'����','���뵿','010-9021-4324'); 
INSERT INTO customers VALUES(3,'����','������','010-8204-5324'); 
INSERT INTO customers VALUES(4,'�ٶ�','����','010-5664-6844');;

INSERT INTO orders VALUES(1,SYSDATE,1,10000,8000,'ũ������ ġŲ');
INSERT INTO orders VALUES(2,SYSDATE,1,12000,9000,'��� ġŲ');
INSERT INTO orders VALUES(3,SYSDATE,1,11000,8500,'���� ġŲ');
INSERT INTO orders VALUES(4,SYSDATE,1,13000,1100,'�ݹ� ġŲ');

SELECT * FROM customers;
SELECT * FROM orders;

DELETE customers;
DELETE orders;

DROP TABLE customers;
DROP TABLE orders;
DROP TABLE customer;

--teach
DROP table mart;
DROP table department;
create table mart(
    custid number primary key
    , name varchar2(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , frequency number -- �湮 ��
    , amount_num number
    , amount_price number
    , parking varchar2(20) -- ��������
    , family number -- ���� ������ ��
);

alter table mart drop column amount_num;
alter table mart modify (name varchar2(30));
alter table mart modify (phone varchar2(20));

DESC mart;
insert into mart values(1, '��浿', 32, '��', '010-1234-1234', '���� ����', 5, 1500000, 'N', 3);
insert into mart values(2, '�����', 31, '��', '010-7777-1234', '���� ��õ', 5, 200000000, 'Y', 4);
insert into mart values(3, '�̼���', 57, '��', '010-1592-1234', '�泲 �뿵', 5, 270000, 'N', 1);
insert into mart values(4, '������', 30, '��', '010-0516-1234', '���� ����', 5, 750000000, 'Y', 4);
insert into mart values(5, '�ӿ���', 30, '��', '010-0517-1235', '���� ����', 5, 75000000, 'Y', 2);

select * from mart;

create table department(
    custid number primary key
    , name varchar(20)
    , age number
    , sx varchar2(20)
    , phone number not null
    , address varchar2(100)
    , use_store varchar2(100) -- ���� ã�� ����
    , amount_num number
    , amount_price number
    , valet varchar2(20) -- �߷���ŷ ���� ��뿩��
    , rounge varchar2(20) -- vip ����� ��뿩��
    , foreign key (custid) references mart(custid) on delete cascade
);

alter table department modify (amount_price check (amount_price > 100000000));
alter table department modify (rounge default 'Y');
alter table department modify (valet default 'Y');
alter table department modify (phone varchar2(100));
alter table department drop column amount_num;
--alter table department add (custid number);
select * from department;

insert into department values(1, '�����', 31, '��', '010-7777-1234', '���� ��õ', 'LV', 900000000,'','');
insert into department values(2, '������', 30, '��', '010-0516-1234', '���� ����', 'GUCCI', 1500000000,'','');
insert into department values(3, '������', 31, '��', '010-7775-1235', '���� ��õ', 'LV', 900000000,'','');
insert into department values(4, '�ڼ���', 30, '��', '010-0516-1234', '���� ����', 'GUCCI', 1500000000,'','');
insert into department values(5, '�ӿ���', 30, '��', '010-0517-1235', '���� ����', 'ROLEX', 150000000,'','');

DELETE mart
WHERE custid = 1;

--DML ����
--Task2_0520. Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
CREATE TABLE Customer(
custid NUMBER,
custname VARCHAR(20),
address VARCHAR(30));

INSERT INTO Customer VALUES(1, '�ڼ���','�����');
INSERT INTO Customer VALUES(2, '�迬��','������');

SELECT * FROM customer;
UPDATE customer 
SET address='�����' 
WHERE address='�λ��';

DROP TABLE Customer;
-- TEACH
UPDATE CUSTOMER
SET ADDRESS = (
    SELECT ADDRESS
    FROM CUSTOMER
    WHERE CUSTNAME = '�迬��'
)
WHERE CUSTNAME = '�ڼ���';
-- �λ����� ����
UPDATE CUSTOMER
SET ADDRESS = '�λ��'
WHERE CUSTNAME = '�ڼ���';

--Task3_0520.���� ���� ���߱����� ���Ե� ������ ���󱸡��� ������ �� ���� ���, ������ ���̽ÿ�.
DROP TABLE BOOK;

CREATE TABLE BOOK(
bookid NUMBER(2) PRIMARY KEY,
bookname VARCHAR(20),
price NUMBER);

INSERT INTO Book VALUES(1, '�౸�� ����', 7000);
INSERT INTO Book VALUES(2, '�౸�ƴ� ����', 13000);
INSERT INTO Book VALUES(3, '�౸�� ����', 22000);
INSERT INTO Book VALUES(4, '���� ���̺�', 35000);
INSERT INTO Book VALUES(5, '�ǰ� ����', 8000);
INSERT INTO Book VALUES(6, '���� �ܰ躰���', 6000);
INSERT INTO Book VALUES(7, '�߱��� �߾�', 20000);
INSERT INTO Book VALUES(8, '�߱��� ��Ź��', 13000);
INSERT INTO Book VALUES(9, '�ø��� �̾߱�', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 13000);


UPDATE BOOK SET bookname = REPLACE(BOOKNAME,'��','�߱�')
WHERE BOOKNAME LIKE '%�౸%';

SELECT * FROM BOOk;
DROP TABLE BOOK;

-- teach. ��ȸ���ϴ°�. �����Ϸ��� UPDATE SET ���� �� Ŀ�Ա����ؾ� ��.
SELECT bookid, REPLACE(bookname, '�߱�','��') bookname, publisher, price
FROM Book;


--Task4_0520. ���缭���� �� �߿��� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
CREATE TABLE MADANG_BOOK_STORE(
custid NUMBER(10) PRIMARY KEY,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(50) NOT NULL,
age NUMBER,
gender VARCHAR(10));

INSERT INTO MADANG_BOOK_STORE VALUES(1,'KIM','HongJun', 35, 'male');
INSERT INTO MADANG_BOOK_STORE VALUES(2,'KIM','HyeonDong', 70, 'male');
INSERT INTO MADANG_BOOK_STORE VALUES(3,'Gwon','YeongSuk', 62, 'female');
INSERT INTO MADANG_BOOK_STORE VALUES(4,'Gwon','YeongMi', 60, 'female');
INSERT INTO MADANG_BOOK_STORE VALUES(5,'KIM','SuMeong', 36, 'female');
select * from MADANG_BOOK_STORE;

SELECT gender as ����, COUNT(*) AS �ο���
FROM MADANG_BOOK_STORE
WHERE gender = 'male'
GROUP BY gender;

drop table MADANG_BOOK_STORE;

-- TEACH. GROUP BY ������ ��Ī(��) ���Ұ�. ǥ����(substr(name,1,1))�� ����ؾ� ��.
SELECT * FROM customer;
SELECT substr(name,1,1) ��, count(*) �ο� FROM customer
GROUP BY substr(name,1,1);


--Task5_0520. ���缭���� �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���Ͻÿ�.
drop table madang_book;

CREATE TABLE MADANG_Book(
bookid NUMBER(2) PRIMARY KEY,
bookname VARCHAR2(40),
publisher VARCHAR2(40),
price NUMBER(8),
orderdate DATE);

select * from madang_book;

INSERT INTO madang_Book VALUES(1, '�౸�� ����', '�½�����', 7000, TO_DATE('2024-05-10', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(2, '�౸�ƴ� ����', '������', 13000, TO_DATE('2024-05-11', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(3, '�౸�� ����', '���ѹ̵��', 22000, TO_DATE('2024-05-12', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(4, '���� ���̺�', '���ѹ̵��', 35000, TO_DATE('2024-05-13', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(5, '�ǰ� ����', '�½�����', 8000, TO_DATE('2024-05-20', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(6, '���� �ܰ躰���', '�½�����', 6000,TO_DATE('2024-05-13', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(7, '�߱��� �߾�', '�̻�̵��', 20000,TO_DATE('2024-05-14', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(8, '�߱��� ��Ź��', '�̻�̵��', 13000,TO_DATE('2024-05-19', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(9, '�ø��� �̾߱�', '�Ｚ��', 7500,TO_DATE('2024-05-18', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(10, 'Olympic Champions', 'Pearson', 13000,TO_DATE('2024-05-20', 'YYYY-MM-DD'));

SELECT orderdate �ֹ���, ADD_months(orderdate, 2) from orders;

select orderdate �ֹ���, TO_CHAR(orderdate + 10, 'YY/MM/DD') Ȯ������ from madang_Book;


--teach
SELECT * FROM orders;
SELECT orderid, orderdate �ֹ���, orderdate + 10 Ȯ����, ADD_months(orderdate, 2) ��ǰ��  FROM orders;


--Task6_0520.���缭���� 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ�� ��� ���̽ÿ�. 
--�� �ֹ����� ��yyyy-mm-dd ���ϡ� ���·� ǥ���Ѵ�.
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate, 'YYYY-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ FROM orders
WHERE orderdate = '2020-07-07';

--Task7_0520. ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ��� ���̽ÿ�.
SELECT orderid �ֹ���ȣ, saleprice �ݾ�, (SELECT AVG(O2.saleprice) FROM orders O2) ��հ� FROM orders O1
WHERE O1.saleprice <= (SELECT AVG(O2.saleprice) FROM orders O2);

--teach - JOIN ���, ����Ŀ���� O2��� ��Ī���� ����,  ��հ��� avg_saleprice�� ���.
SELECT orderid, saleprice FROM orders O1
JOIN (SELECT AVG(saleprice) AS avg_saleprice FROM orders) O2
ON O1.saleprice < O2.avg_saleprice;


--Task8_0520. ���ѹα����� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���Ͻÿ�.
SELECT sum(saleprice) ���Ǹž� FROM orders
WHERE custid IN (SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');


--[�ǽ� - 2�� 1��]
--�б� ������ ���Ͽ� ���̺� 2�� �̻����� db�� �����ϰ� 3�� �̻� Ȱ���� �� �ִ� case�� ���弼��.





