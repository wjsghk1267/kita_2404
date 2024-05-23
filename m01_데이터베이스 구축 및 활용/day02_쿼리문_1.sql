
--Q. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.

SELECT NAME, BOOKNAME
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID AND C.CUSTID = O.CUSTID
ORDER BY C.NAME; --WHERE ������ �Էµ� �׸� �׷�ȭ�Ǿ� ��� ���. ����(CUSTID.NAME)-������(BOOKID.NAME)

SELECT CUSTOMER.NAME, BOOK.BOOKNAME
FROM ORDERS
INNER JOIN CUSTOMER ON ORDERS.CUSTID = CUSTOMER.CUSTID
INNER JOIN BOOK ON ORDERS.BOOKID = BOOK.BOOKID;

-- Q. ������ 20,000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.

SELECT NAME, BOOKNAME
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID AND C.CUSTID = O.CUSTID AND PRICE = 20000
ORDER BY C.NAME;

SELECT CUSTOMER.NAME, BOOK.BOOKNAME
FROM ORDERS
INNER JOIN CUSTOMER ON ORDERS.CUSTID = CUSTOMER.CUSTID
INNER JOIN BOOK ON ORDERS.BOOKID = BOOK.BOOKID
WHERE PRICE = 20000;

SELECT * FROM customer;
SELECT * FROM orders;
-- JOIN�� �� �� �̻��� ���̺��� �����Ͽ� ���õ� �����͸� ������ �� ���.
-- �������� (INNER JOIN) - ���������
SELECT customer.name, orders.saleprice
FROM customer
INNER JOIN orders ON customer.custid = orders.custid;

--���� �ܺ� ���� (Left Outer Join) : . �� ��° ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
SELECT customer.name, orders.saleprice
FROM customer
LEFT OUTER JOIN orders ON customer.custid = orders.custid;

--������ �ܺ� ���� (Right Outer Join) : ù ��° ���̺� ��ġ�ϴ� �����Ͱ� ���� ��� NULL ���� ���
SELECT customer.name, orders.saleprice
FROM customer
RIGHT OUTER JOIN orders ON customer.custid = orders.custid;

--FULL OUTER JOIN : ��ġ�ϴ� �����Ͱ� ���� ��� �ش� ���̺����� NULL ���� ���
SELECT customer.name, orders.saleprice
FROM customer
FULL OUTER JOIN orders ON customer.custid = orders.custid;

--CROSS JOIN : �� ���̺� ���� ��� ������ ������ ���� - ������
SELECT customer.name, orders.saleprice
FROM customer
CROSS JOIN orders;

-- Q. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�. (2���� ���, WHERE, JOIN)
SELECT NAME, SALEPRICE
FROM ORDERS O, CUSTOMER C
WHERE C.CUSTID = O.CUSTID(+); -- CUSTID ī��Ʈ�� ���� �ٸ� ���, ������ �ʿ� ī��Ʈ�� ������. (+)

SELECT C.NAME, SALEPRICE
FROM CUSTOMER C
FULL OUTER JOIN ORDERS ON C.CUSTID = ORDERS.CUSTID;

--�μ� ���� Q. ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�.
SELECT NAME FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);


--Q. �����ѹ̵����� ������ ������ ������ ���� �̸��� ���̽ÿ�.
SELECT B.PUBLISHER, O.BOOKID,C.NAME
FROM BOOK B, ORDERS O, CUSTOMER C
WHERE B.BOOKID = O.BOOKID AND C.CUSTID = O.CUSTID AND PUBLISHER = '���ѹ̵��';

SELECT NAME FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS
WHERE BOOKID IN (SELECT BOOKID FROM BOOK
WHERE PUBLISHER = '���ѹ̵��'));


--Q. ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
SELECT B1. BOOKNAME
FROM BOOK B1
WHERE B1.PRICE > (SELECT AVG(B2.PRICE)
FROM BOOK B2
WHERE B2.PUBLISHER = B1.PUBLISHER);

--Q. ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
SELECT NAME FROM CUSTOMER
WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS);

--Q. �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
SELECT NAME ���̸�, ADDRESS �ּ� FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);
