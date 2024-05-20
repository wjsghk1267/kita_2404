SELECT * FROM BOOK;
SELECT BOOKID FROM BOOK;

SELECT * FROM orders;
SELECT * FROM customer;
SELECT * FROM imported_book;

--DISTINCT : �ߺ� ����
select DISTINCT publisher from book;

--Q. ������ 10,000�� �̻��� ������ �˻�, ������ WHERE
select * from book
WHERE price > 10000;

-- Q. ������ ���� �̻� 2���� ������ ���� �˻�. (2����)
SELECT * FROM BOOK
WHERE PRICE >= 10000 AND PRICE <= 20000; -- ù��° ���

--WHERE PRICE BETWEEN 10000 AND 20000; -- �ι�° ���

--LIKE�� ��Ȯ�� '�౸�� ����'�� ��ġ�ϴ� �ุ ����
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '�౸�� ����';

-- % : 0�� �̻��� ������ ����
-- %�̸�% �� '�౸'�� ���Ե� å�̸�,���ǻ� ���
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '%�౸%';

-- _ : ��Ȯ�� 1���� ������ ����
--���� �̸��� ���� �ι�° ��ġ�� '��'��� ���ڿ��� ���� ����
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '_��%';



--ORDER BY : �������� ����(default)
SELECT * FROM BOOK
ORDER BY PRICE;

--��������
SELECT * FROM BOOK
ORDER BY PRICE DESC;

--Q. ������ ���ݼ����� �˻��ϰ�, ������ ������ �̸������� �˻��Ͻÿ�.
SELECT * FROM BOOK
ORDER BY price, bookname;


SELECT * FROM ORDERS;
SELECT SUM(SALEPRICE) AS  "�� �Ǹž�"
FROM ORDERS
WHERE CUSTID = 2;

--GROUP BY : �����͸� Ư�� ���ؿ� ���� �׷�ȭ�ϴµ� ���. �̸� ���� �����Լ� (SUM, AVG, MAX, MIN, COUNT) �̿�.
SELECT SUM(saleprice) AS total,
AVG(saleprice) AS average,
MIN(saleprice) AS mininum,
MAX(saleprice) AS maximum,
FROM orders;

-- ���Ǹž��� custid �������� �׷�ȭ
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
GROUP BY custid;

--bookid�� 5���� ū ����
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE BOOKID > 5
GROUP BY custid;

-- ���������� 2���� ū ����
SELECT custid, COUNT(*) AS ��������, SUM(saleprice) AS "�� �Ǹž�"
FROM orders
WHERE BOOKID > 5 --WHERE ���� �࿡ ���� ���� ����
GROUP BY custid
HAVING COUNT(*) > 2; -- HAVING �׷쿡 ���� ���� ����

commit; 
--COMMIT ������ ���� ���� ���� �ݿ�
--COMMIT ��ɾ �����ϸ� Ʈ����� ������ ����� ��� ������ ���� ����(INSERT, UPDATE, DELETE)�� �����ͺ��̽��� ���������� �ݿ��˴ϴ�.
--�̸� ���� �������� �ϰ����� ���Ἲ�� ������ �� �ֽ��ϴ�.

--COMMIT�� Ʈ������� ó�� ������ �����Ű�� ������ �մϴ�.
--Ʈ����� ������ ����� ��� �۾��� ���������� �Ϸ�Ǿ����� �����ͺ��̽��� �˸��� ���Դϴ�.

--COMMIT ������ ROLLBACK ��ɾ �����ϸ� Ʈ����� ���� ��� ���� ������ ����� �� �ֽ��ϴ�.
--�̸� ���� ������ ���� �������� �߻��� �� �ִ� ������ �ذ��� �� �ֽ��ϴ�.

--Ʈ����� ������ ����� �۾����� COMMIT ��ɾ ���� �����ͺ��̽��� �ݿ��˴ϴ�.
--�̸� ���� �������� ���Ἲ�� �ϰ����� ������ �� �ֽ��ϴ�.

--COMMIT ��ɾ ���� Ʈ������� �����ϸ� �ٸ� ����ڰ� �ش� �����Ϳ� ������ �� �ְ� �˴ϴ�.
--�̸� ���� �����ͺ��̽��� ���ü� ��� ���������ϴ�.
--���� COMMIT�� ������ ���� ������ ���������� �ݿ��ϰ�, Ʈ����� ó�� ������ �����ϸ�, ������ ������ �ϰ��� ����, ���ü� ���� ���� �������� ���˴ϴ�. 
--�̸� ���� �����ͺ��̽��� �������� �ŷڼ��� ���� �� �ֽ��ϴ�.