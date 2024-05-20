--������ Ÿ��
--������ (Numeric Types)
--NUMBER: ���� �������� ���� ������ Ÿ��. ����, �Ǽ�, ���� �Ҽ���, �ε� �Ҽ��� ���� ����
--NUMBER�� NUMBER(38,0)�� ���� �ǹ̷� �ؼ�, Precision 38�� �ڸ���, Scale 0�� �Ҽ��� ���� �ڸ���
--NUMBER(8,2) - 8�ڸ��� �Ҽ��� 2�ڸ� ���Ե�. ��, 00000000.00 �ڸ��� ��.
--������ (Character Types)
--VARCHAR2(size): ���� ���� ���ڿ��� ����. size�� �ִ� ���� ���̸� ����Ʈ, Ȥ�� ���ڼ��� ����
--NVARCHAR2(size)�� ����� ������ ���� ����Ʈ ���� ��� �׻� ���� ������ ũ�Ⱑ ����
--CHAR(size): ���� ���� ���ڿ��� ����. ������ ���̺��� ª�� ���ڿ��� �ԷµǸ� �������� �������� ä����
--��¥ �� �ð��� (Date and Time Types)
--DATE: ��¥�� �ð��� ����. ������ Ÿ���� ��, ��, ��, ��, ��, �ʸ� ����
--DATE Ÿ���� ��¥�� �ð��� YYYY-MM-DD HH24:MI:SS �������� �����մϴ�.
--���� ���, 2024�� 5�� 20�� ���� 3�� 45�� 30�ʴ� 2024-05-20 15:45:30���� ����

--TIMESTAMP: ��¥�� �ð��� �� ���� ������ �������� ����
--���� �������� (Binary Data Types)
--BLOB: �뷮�� ���� �����͸� ����. �̹���, ����� ���� ���� �����ϴ� �� ����
--��Ը� ��ü�� (Large Object Types)
--CLOB: �뷮�� ���� �����͸� ����
--NCLOB: �뷮�� ������ ���� ���� �����͸� ����

--���� ���ڵ��� �ǹ�
--��ǻ�ʹ� ���ڷ� �̷���� �����͸� ó��. ���ڵ��� ���� ����(��: 'A', '��', '?')�� 
--����(�ڵ� ����Ʈ)�� ��ȯ�Ͽ� ��ǻ�Ͱ� �����ϰ� ������ �� �ְ� �Ѵ�.
--���� ���, ASCII ���ڵ������� �빮�� 'A'�� 65��, �ҹ��� 'a'�� 97�� ���ڵ�. 
--�����ڵ� ���ڵ������� 'A'�� U+0041, �ѱ� '��'�� U+AC00, �̸�Ƽ�� '?'�� U+1F60A�� ���ڵ�
--�ƽ�Ű�� 7��Ʈ�� ����Ͽ� �� 128���� ���ڸ� ǥ���ϴ� �ݸ� �����ڵ�� �ִ� 1,114,112���� ���ڸ� ǥ��

--ASCII ���ڵ�:
--���� 'A' -> 65 (10����) -> 01000001 (2����)
--���� 'B' -> 66 (10����) -> 01000010 (2����)

--�����ڵ�(UTF-8) ���ڵ�: 
--���� 'A' -> U+0041 -> 41 (16����) -> 01000001 (2����, ASCII�� ����)
--���� '��' -> U+AC00 -> EC 95 80 (16����) -> 11101100 10010101 10000000 (2����)

--CLOB: CLOB�� �Ϲ������� �����ͺ��̽��� �⺻ ���� ����(��: ASCII, LATIN1 ��)�� ����Ͽ� �ؽ�Ʈ �����͸� ����. 
--�� ������ �ַ� ����� ���� ���� ����Ʈ ���ڷ� �̷���� �ؽ�Ʈ�� �����ϴ� �� ���.
--NCLOB: NCLOB�� �����ڵ�(UTF-16)�� ����Ͽ� �ؽ�Ʈ �����͸� ����. ���� �ٱ��� ������ �ʿ��� ��, \
--�� �پ��� ���� ������ �ؽ�Ʈ �����͸� ������ �� ����. �ٱ��� ���ڰ� ���Ե� �����͸� ȿ�������� ó���� �� �ִ�.



--VARCHAR2 �� �� ���� ������� ���̸� ���� : ����Ʈ�� ����
--���� Ȯ�� ���
SELECT * FROM v$nls_parameters
WHERE PARAMETER = 'NLS_LENGTH_SEMANTICS';

--������������ : 
--PRIMARY KEY : �� ���� �����ϰ� �ĺ��ϴ� ��(�Ǵ� ������ ����). �ߺ��ǰų� NULL ���� ������� �ʴ´�.
--FOREIGN KEY : �ٸ� ���̺��� �⺻ Ű�� �����ϴ� ��. ���� ���Ἲ�� ����
--UNIQUE : ���� �ߺ��� ���� ����� ���� ����. NULL���� ���
--NOT NULL : ���� NULL ���� ������� �ʴ´�. 
--CHECK : �� ���� Ư�� ������ �����ؾ� ���� ���� (��: age > 18)
--DEFAULT : ���� ������� ���� �������� ���� ��� ���� �⺻���� ����

--AUTHOR ���̺� ����
CREATE TABLE AUTHORS (
ID NUMBER PRIMARY KEY,
FIRST_NAME VARCHAR(20) NOT NULL,
LAST_NAME VARCHAR(50) NOT NULL,
NATIONALITY VARCHAR(50) NOT NULL
);
DROP TABLE AUTHORS;
DROP TABLE NEWBOOK;

-- Q. NEWBOOK �̶�� ���̺��� �����ϼ���.
CREATE TABLE NEWBOOK(
    BOOKID NUMBER,
    ISBN NUMBER(13),
BOOKNAME VARCHAR(50) NOT NULL,
AUTHOR VARCHAR(50) NOT NULL,
PUBLISHER VARCHAR2(30) NOT NULL,
PRICE NUMBER DEFAULT 10000 CHECK(PRICE > 1000),
PUBLISHER_DATE DATE,
PRIMARY KEY (BOOKID)
);

INSERT INTO NEWBOOK VALUES (1, 9781234567890, 'SQL Guide', 'John Doe', 'TechBooks', 15000, TO_DATE('2024-05-20', 'YYYY-MM-DD'));

ALTER TABLE newbook MODIFY(isbn VARCHAR(50)); -- �� �ڵ�� NEWBOOK ���̺��� ISBN �÷� ������ Ÿ���� NUMBER(13)���� VARCHAR(50)���� ����
DELETE FROM newbook; -- newbook ���̺��� ��� �����͸� ����

INSERT INTO newbook VALUES(2,9781234567890, 'SQL Guide', 'John Doe', 'TechBooks', 15000,
TO_DATE('2024-05-20 15-45-30', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO newbook VALUES(3,978123456789000023, 'SQL Guide', 'John Doe', 'TechBooks', 15000,
TO_DATE('2024-05-20 15-45-30', 'YYYY-MM-DD HH24:MI:SS'));

SELECT * FROM NEWBOOK;

DESC NEWBOOK; -- ���̺� ���� Ȯ��
--���̺� �������� ����, �߰�, �Ӽ� �߰�, ����, ����
ALTER TABLE newbook MODIFY (isbn VARCHAR2(10));
ALTER TABLE newbook ADD author_id NUMBER;
ALTER TABLE newbook DROP COLUMN author_id;

--ON DELETE CASCADE �ɼ��� �����Ǿ� �־�, newcustomer ���̺��� � ���� ���ڵ尡 �����Ǹ�, �ش� ���� ��� �ֹ���
--neworders ���̺����� �ڵ����� ����. ��ID ����� ���µ� �ֹ������ ���������� ���Ἲ�� ����ǹǷ�, ��Ʈ�� ���� �����ǵ��� ����.
-- *FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE);
CREATE TABLE newcustomer(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30));

CREATE TABLE neworders(
orderid NUMBER,
custid NUMBER NOT NULL,
bookid NUMBER NOT NULL,
saleprice NUMBER NOT NULL,
orderdate DATE,
PRIMARY KEY(orderid),
FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE);
DESC NEWORDERS;

INSERT INTO newcustomer VALUES(1,'KEVIN','���ﵿ','010-1234-1234');
INSERT INTO neworders VALUES(10,1,100,1000,SYSDATE);

SELECT * FROM newcustomer;
SELECT * FROM neworders;
--�⺻Ű�� ������ (newcustomer)���� ������ neworders�� ���� �����ǳ�, ����Ű ��(neworders)�� �����ص� �⺻Ű ���� �����ȵ�.
DELETE newcustomer;
DELETE neworders;

DROP TABLE neworders;
DROP TABLE newcustomer;


drop table ORDERS;
drop table customer1;
DESC customer1;
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
