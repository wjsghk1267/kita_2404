-- TASK1_0517. 출판사가 '굿스포츠' 혹은 '대한미디어' 인 도서를 검색하시오. (3가지 방법)
SELECT * FROM BOOK
WHERE (PUBLISHER  = '굿스포츠') OR (PUBLISHER  = '대한미디어') -- 첫번째 방법

SELECT *
FROM BOOK
WHERE PUBLISHER IN ('굿스포츠','대한미디어');

SELECT *
FROM BOOK
WHERE PUBLISHER = '굿스포츠'
UNION --두 조건 결과에 대한 합
SELECT *
FROM BOOK
WHERE PUBLISHER = '대한미디어'

SELECT * FROM BOOK
WHERE PUBLISHER LIKE '굿스포츠' OR PUBLISHER LIKE '대한미디어' -- 세번째 방법

-- TASK2_0517. 출판사가 '굿스포츠' 혹은 '대한미디어' 가 아닌 도서를 검색.
SELECT * FROM BOOK
WHERE (PUBLISHER != '굿스포츠') AND (PUBLISHER != '대한미디어')

SELECT * FROM BOOK WHERE PUBLISHER NOT IN ('굿스포츠','대한미디어');

--TASK3_0517. 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT BOOKNAME, PRICE FROM BOOK
WHERE BOOKNAME LIKE '%축구%' AND PRICE >= 20000;

--Task4_0517. 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오. -- 쿼리문 사용. (집계함수-GROUP BY)
SELECT custid as 김연아, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액" -- SELECET custid << 그룹화할 열 명시, 집계함수 사용할 열 명시.
FROM orders
WHERE CUSTID = 2
GROUP BY custid;

SELECT CUSTOMER.NAME, ORDERS.CUSTID, SUM(ORDERS.SALEPRICE) AS "총 판매액"
FROM ORDERS, CUSTOMER
WHERE ORDERS.CUSTID = 2 AND ORDERS.CUSTID=CUSTOMER.CUSTID
GROUP BY CUSTOMER.NAME, ORDERS.CUSTID;

SELECT CUSTOMER.NAME, ORDERS.CUSTID, SUM(ORDERS.SALEPRICE) AS "총 판매액"
FROM ORDERS
INNER JOIN CUSTOMER ON ORDERS.CUSTID = CUSTOMER.CUSTID
WHERE ORDERS.CUSTID = 2
GROUP BY CUSTOMER.NAME, ORDERS.CUSTID;

--Task5_0517. 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 
--단, 두 권 이상 구매한 고객만 구하시오.
SELECT custid, COUNT(*) AS 도서수량
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING COUNT(*) >= 2
ORDER BY CUSTID;

--Task6_0517. 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT CUSTID AS 고객이름, BOOKID AS 책이름, SALEPRICE AS 판매가격 FROM ORDERS
WHERE CUSTID = 1; -- 고객 검색

SELECT NAME, SALEPRICE
FROM CUSTOMER, ORDERS
WHERE CUSTOMER.CUSTID = ORDERS.CUSTID;

--Task7_0517. 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT custid, SUM(saleprice) AS "총 판매액"
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
ORDER BY custid;

SELECT NAME, SUM (SALEPRICE) AS "총 판매액"
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY C.NAME
ORDER BY C.NAME;