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

--Task2_0520. Customer ���̺��� �ڼ��� ���� �ּҸ� �迬�� ���� �ּҷ� �����Ͻÿ�.
CREATE TABLE Customer(
custid NUMBER,
custname VARCHAR(20),
address VARCHAR(30));

INSERT INTO Customer VALUES(1, '�ڼ���','�����');
INSERT INTO Customer VALUES(2, '�迬��','������');

SELECT * FROM customer;
UPDATE customer SET address='�����' WHERE address='������';

DROP TABLE Customer;

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


UPDATE AAA
SET MN_ID = REPLACE(MN_ID,'M00','M11')
WHERE MN_ID LIKE '%M00%' 

UPDATE BOOK SET bookname = REPLACE(BOOKNAME,'�౸','��')
WHERE BOOKNAME LIKE '%�౸%';

SELECT * FROM BOOk;

DROP TABLE BOOK;

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

SELECT orderdate �ֹ���, ADD_day(orderdate, 2) from MADANG_Book;

select orderdate �ֹ���, TO_CHAR(orderdate + 10, 'YY/MM/DD') Ȯ������ from madang_Book;