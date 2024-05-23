
--Q. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.

SELECT NAME, BOOKNAME
FROM CUSTOMER C, BOOK B, ORDERS O
WHERE B.BOOKID = O.BOOKID AND C.CUSTID = O.CUSTID
ORDER BY C.NAME; --WHERE 조건행 입력된 항목 그룹화되어 결과 출력. 고객명(CUSTID.NAME)-도서명(BOOKID.NAME)

SELECT CUSTOMER.NAME, BOOK.BOOKNAME
FROM ORDERS
INNER JOIN CUSTOMER ON ORDERS.CUSTID = CUSTOMER.CUSTID
INNER JOIN BOOK ON ORDERS.BOOKID = BOOK.BOOKID;

-- Q. 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.

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
-- JOIN은 두 개 이상의 테이블을 연결하여 관련된 데이터를 결합할 때 사용.
-- 내부조인 (INNER JOIN) - 교집합출력
SELECT customer.name, orders.saleprice
FROM customer
INNER JOIN orders ON customer.custid = orders.custid;

--왼쪽 외부 조인 (Left Outer Join) : . 두 번째 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
SELECT customer.name, orders.saleprice
FROM customer
LEFT OUTER JOIN orders ON customer.custid = orders.custid;

--오른쪽 외부 조인 (Right Outer Join) : 첫 번째 테이블에 일치하는 데이터가 없는 경우 NULL 값이 사용
SELECT customer.name, orders.saleprice
FROM customer
RIGHT OUTER JOIN orders ON customer.custid = orders.custid;

--FULL OUTER JOIN : 일치하는 데이터가 없는 경우 해당 테이블에서는 NULL 값이 사용
SELECT customer.name, orders.saleprice
FROM customer
FULL OUTER JOIN orders ON customer.custid = orders.custid;

--CROSS JOIN : 두 테이블 간의 모든 가능한 조합을 생성 - 합집합
SELECT customer.name, orders.saleprice
FROM customer
CROSS JOIN orders;

-- Q. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오. (2가지 방법, WHERE, JOIN)
SELECT NAME, SALEPRICE
FROM ORDERS O, CUSTOMER C
WHERE C.CUSTID = O.CUSTID(+); -- CUSTID 카운트가 서로 다를 경우, 부족한 쪽에 카운트를 더해줌. (+)

SELECT C.NAME, SALEPRICE
FROM CUSTOMER C
FULL OUTER JOIN ORDERS ON C.CUSTID = ORDERS.CUSTID;

--부속 질의 Q. 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT NAME FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);


--Q. ‘대한미디어’에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT B.PUBLISHER, O.BOOKID,C.NAME
FROM BOOK B, ORDERS O, CUSTOMER C
WHERE B.BOOKID = O.BOOKID AND C.CUSTID = O.CUSTID AND PUBLISHER = '대한미디어';

SELECT NAME FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS
WHERE BOOKID IN (SELECT BOOKID FROM BOOK
WHERE PUBLISHER = '대한미디어'));


--Q. 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
SELECT B1. BOOKNAME
FROM BOOK B1
WHERE B1.PRICE > (SELECT AVG(B2.PRICE)
FROM BOOK B2
WHERE B2.PUBLISHER = B1.PUBLISHER);

--Q. 도서를 주문하지 않은 고객의 이름을 보이시오.
SELECT NAME FROM CUSTOMER
WHERE CUSTID NOT IN (SELECT CUSTID FROM ORDERS);

--Q. 주문이 있는 고객의 이름과 주소를 보이시오.
SELECT NAME 고객이름, ADDRESS 주소 FROM CUSTOMER
WHERE CUSTID IN (SELECT CUSTID FROM ORDERS);
