--TASK1. 10개의 속성을 구성되는 테이블 2개를 작성하세요. 단 FOREIGN KEY를 적용하여 한쪽 테이블의 데이터를 삭제시 다른 테이블의 관련되는
--데이터도 모두 삭제되도록 하세요. (모든 제약 조건을 사용)
--단, 각 테이블에 5개의 데이터를 입력하고 두번째 테이블에 첫번째 데이터를 참고하고 있는 속성을 선택하여 데이터를 삭제.
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

INSERT INTO customers VALUES(1,'철수','역삼동','010-1234-1234');
INSERT INTO customers VALUES(2,'영희','영통동','010-9021-4324'); 
INSERT INTO customers VALUES(3,'가나','망포동','010-8204-5324'); 
INSERT INTO customers VALUES(4,'다라','원동','010-5664-6844');;

INSERT INTO orders VALUES(1,SYSDATE,1,10000,8000,'크리스피 치킨');
INSERT INTO orders VALUES(2,SYSDATE,1,12000,9000,'양념 치킨');
INSERT INTO orders VALUES(3,SYSDATE,1,11000,8500,'간장 치킨');
INSERT INTO orders VALUES(4,SYSDATE,1,13000,1100,'반반 치킨');

SELECT * FROM customers;
SELECT * FROM orders;

DELETE customers;
DELETE orders;

DROP TABLE customers;
DROP TABLE orders;
DROP TABLE customer;

--Task2_0520. Customer 테이블에서 박세리 고객의 주소를 김연아 고객의 주소로 변경하시오.
CREATE TABLE Customer(
custid NUMBER,
custname VARCHAR(20),
address VARCHAR(30));

INSERT INTO Customer VALUES(1, '박세리','서울시');
INSERT INTO Customer VALUES(2, '김연아','수원시');

SELECT * FROM customer;
UPDATE customer SET address='서울시' WHERE address='수원시';

DROP TABLE Customer;

--Task3_0520.도서 제목에 ‘야구’가 포함된 도서를 ‘농구’로 변경한 후 도서 목록, 가격을 보이시오.
DROP TABLE BOOK;

CREATE TABLE BOOK(
bookid NUMBER(2) PRIMARY KEY,
bookname VARCHAR(20),
price NUMBER);

INSERT INTO Book VALUES(1, '축구의 역사', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 13000);


UPDATE AAA
SET MN_ID = REPLACE(MN_ID,'M00','M11')
WHERE MN_ID LIKE '%M00%' 

UPDATE BOOK SET bookname = REPLACE(BOOKNAME,'축구','농구')
WHERE BOOKNAME LIKE '%축구%';

SELECT * FROM BOOk;

DROP TABLE BOOK;

--Task4_0520. 마당서점의 고객 중에서 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
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

SELECT gender as 성별, COUNT(*) AS 인원수
FROM MADANG_BOOK_STORE
WHERE gender = 'male'
GROUP BY gender;

drop table MADANG_BOOK_STORE;

--Task5_0520. 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오.
drop table madang_book;

CREATE TABLE MADANG_Book(
bookid NUMBER(2) PRIMARY KEY,
bookname VARCHAR2(40),
publisher VARCHAR2(40),
price NUMBER(8),
orderdate DATE);

select * from madang_book;

INSERT INTO madang_Book VALUES(1, '축구의 역사', '굿스포츠', 7000, TO_DATE('2024-05-10', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(2, '축구아는 여자', '나무수', 13000, TO_DATE('2024-05-11', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(3, '축구의 이해', '대한미디어', 22000, TO_DATE('2024-05-12', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(4, '골프 바이블', '대한미디어', 35000, TO_DATE('2024-05-13', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(5, '피겨 교본', '굿스포츠', 8000, TO_DATE('2024-05-20', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000,TO_DATE('2024-05-13', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(7, '야구의 추억', '이상미디어', 20000,TO_DATE('2024-05-14', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(8, '야구를 부탁해', '이상미디어', 13000,TO_DATE('2024-05-19', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(9, '올림픽 이야기', '삼성당', 7500,TO_DATE('2024-05-18', 'YYYY-MM-DD'));
INSERT INTO madang_Book VALUES(10, 'Olympic Champions', 'Pearson', 13000,TO_DATE('2024-05-20', 'YYYY-MM-DD'));

SELECT orderdate 주문일, ADD_day(orderdate, 2) from MADANG_Book;

select orderdate 주문일, TO_CHAR(orderdate + 10, 'YY/MM/DD') 확정일자 from madang_Book;