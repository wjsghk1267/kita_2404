SELECT * FROM BOOK;
SELECT BOOKID FROM BOOK;

SELECT * FROM orders;
SELECT * FROM customer;
SELECT * FROM imported_book;

--DISTINCT : 중복 제거
select DISTINCT publisher from book;

--Q. 가격이 10,000원 이상인 도서를 검색, 조건은 WHERE
select * from book
WHERE price > 10000;

-- Q. 가격이 만원 이상 2만원 이하인 도서 검색. (2가지)
SELECT * FROM BOOK
WHERE PRICE >= 10000 AND PRICE <= 20000; -- 첫번째 방법

--WHERE PRICE BETWEEN 10000 AND 20000; -- 두번째 방법

--LIKE는 정확히 '축구의 역사'와 일치하는 행만 선택
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '축구의 역사';

-- % : 0개 이상의 임의의 문자
-- %이름% 은 '축구'가 포함된 책이름,출판사 출력
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '%축구%';

-- _ : 정확히 1개의 임의의 문자
--도서 이름의 왼쪽 두번째 위치에 '구'라는 문자열을 갖는 도서
SELECT BOOKNAME, PUBLISHER FROM BOOK
WHERE BOOKNAME LIKE '_구%';



--ORDER BY : 오름차순 정렬(default)
SELECT * FROM BOOK
ORDER BY PRICE;

--내림차순
SELECT * FROM BOOK
ORDER BY PRICE DESC;

--Q. 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT * FROM BOOK
ORDER BY price, bookname;


SELECT * FROM ORDERS;
SELECT SUM(SALEPRICE) AS  "총 판매액"
FROM ORDERS
WHERE CUSTID = 2;

--GROUP BY : 데이터를 특정 기준에 따라 그룹화하는데 사용. 이를 통해 집계함수 (SUM, AVG, MAX, MIN, COUNT) 이용.
SELECT SUM(saleprice) AS total,
AVG(saleprice) AS average,
MIN(saleprice) AS mininum,
MAX(saleprice) AS maximum,
FROM orders;

-- 총판매액을 custid 기준으로 그룹화
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
GROUP BY custid;

--bookid가 5보다 큰 조건
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
WHERE BOOKID > 5
GROUP BY custid;

-- 도서수량이 2보다 큰 조건
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS "총 판매액"
FROM orders
WHERE BOOKID > 5 --WHERE 개별 행에 대한 조건 지정
GROUP BY custid
HAVING COUNT(*) > 2; -- HAVING 그룹에 대해 조건 지정

commit; 
--COMMIT 데이터 변경 사항 영구 반영
--COMMIT 명령어를 실행하면 트랜잭션 내에서 수행된 모든 데이터 변경 사항(INSERT, UPDATE, DELETE)이 데이터베이스에 영구적으로 반영됩니다.
--이를 통해 데이터의 일관성과 무결성을 유지할 수 있습니다.

--COMMIT은 트랜잭션의 처리 과정을 종료시키는 역할을 합니다.
--트랜잭션 내에서 수행된 모든 작업이 성공적으로 완료되었음을 데이터베이스에 알리는 것입니다.

--COMMIT 이전에 ROLLBACK 명령어를 실행하면 트랜잭션 내의 모든 변경 사항을 취소할 수 있습니다.
--이를 통해 데이터 변경 과정에서 발생할 수 있는 문제를 해결할 수 있습니다.

--트랜잭션 내에서 수행된 작업들은 COMMIT 명령어를 통해 데이터베이스에 반영됩니다.
--이를 통해 데이터의 무결성과 일관성을 유지할 수 있습니다.

--COMMIT 명령어를 통해 트랜잭션을 종료하면 다른 사용자가 해당 데이터에 접근할 수 있게 됩니다.
--이를 통해 데이터베이스의 동시성 제어가 가능해집니다.
--따라서 COMMIT은 데이터 변경 사항을 영구적으로 반영하고, 트랜잭션 처리 과정을 종료하며, 데이터 복구와 일관성 유지, 동시성 제어 등의 목적으로 사용됩니다. 
--이를 통해 데이터베이스의 안정성과 신뢰성을 높일 수 있습니다.