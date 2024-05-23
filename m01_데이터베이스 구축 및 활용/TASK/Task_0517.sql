-- TASK1_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��' �� ������ �˻��Ͻÿ�. (3���� ���)
SELECT * FROM BOOK
WHERE (PUBLISHER  = '�½�����') OR (PUBLISHER  = '���ѹ̵��') -- ù��° ���

SELECT *
FROM BOOK
WHERE PUBLISHER IN ('�½�����','���ѹ̵��');

SELECT *
FROM BOOK
WHERE PUBLISHER = '�½�����'
UNION --�� ���� ����� ���� ��
SELECT *
FROM BOOK
WHERE PUBLISHER = '���ѹ̵��'

SELECT * FROM BOOK
WHERE PUBLISHER LIKE '�½�����' OR PUBLISHER LIKE '���ѹ̵��' -- ����° ���

-- TASK2_0517. ���ǻ簡 '�½�����' Ȥ�� '���ѹ̵��' �� �ƴ� ������ �˻�.
SELECT * FROM BOOK
WHERE (PUBLISHER != '�½�����') AND (PUBLISHER != '���ѹ̵��')

SELECT * FROM BOOK WHERE PUBLISHER NOT IN ('�½�����','���ѹ̵��');

--TASK3_0517. �౸�� ���� ���� �� ������ 20,000�� �̻��� ������ �˻��Ͻÿ�.
SELECT BOOKNAME, PRICE FROM BOOK
WHERE BOOKNAME LIKE '%�౸%' AND PRICE >= 20000;

--Task4_0517. 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�. -- ������ ���. (�����Լ�-GROUP BY)
SELECT custid as �迬��, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�" -- SELECET custid << �׷�ȭ�� �� ���, �����Լ� ����� �� ���.
FROM orders
WHERE CUSTID = 2
GROUP BY custid;

SELECT CUSTOMER.NAME, ORDERS.CUSTID, SUM(ORDERS.SALEPRICE) AS "�� �Ǹž�"
FROM ORDERS, CUSTOMER
WHERE ORDERS.CUSTID = 2 AND ORDERS.CUSTID=CUSTOMER.CUSTID
GROUP BY CUSTOMER.NAME, ORDERS.CUSTID;

SELECT CUSTOMER.NAME, ORDERS.CUSTID, SUM(ORDERS.SALEPRICE) AS "�� �Ǹž�"
FROM ORDERS
INNER JOIN CUSTOMER ON ORDERS.CUSTID = CUSTOMER.CUSTID
WHERE ORDERS.CUSTID = 2
GROUP BY CUSTOMER.NAME, ORDERS.CUSTID;

--Task5_0517. ������ 8,000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�. 
--��, �� �� �̻� ������ ���� ���Ͻÿ�.
SELECT custid, COUNT(*) AS ��������
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2
ORDER BY CUSTID;

--Task6_0517. ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
SELECT CUSTID AS ���̸�, BOOKID AS å�̸�, SALEPRICE AS �ǸŰ��� FROM ORDERS
WHERE CUSTID = 1; -- �� �˻�

SELECT NAME, SALEPRICE
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID;

--Task7_0517. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
SELECT custid, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
ORDER BY custid;

SELECT NAME, SUM (SALEPRICE) AS "�� �Ǹž�"
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
ORDER BY C.NAME;