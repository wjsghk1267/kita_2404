-- 절대값, 테이블 안만들고 임의의 테이블을 쓸 경우 FROM dual
SELECT ABS(-78), ABS(+78)
FROM DUAL;

-- 반올림, 동일.
SELECT ROUND(4.875, 1)
FROM DUAL;

--Q. 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오.
SELECT * FROM ORDERS;

SELECT custid 고객번호, ROUND(AVG(saleprice), -2) 평균주문금액
FROM orders
GROUP BY custid;

--Q. '굿스포츠'에서 출판한 도서의 제목과 제목의 글자 수, 바이트 수를 보이시오.
SELECT bookname 제목, publisher, length(bookname) 글자수, lengthb(bookname) 바이트수
FROM book WHERE publisher = '굿스포츠';

--Q. DBMS 서버에 설정도니 현재 날짜와 시간, 요일을 확인하시오.
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-mm-dd HH:MI:SS day') SYSDATE1
FROM DUAL;

--Q. 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시.
--NVL 함수는 값이 NULL인 경우, 지정값을 출력해줌. NVL("값","지정값")
SELECT NAME 이름, NVL(phone, '연락처없음') 전화번호
FROM customer;

--Q. 고객목록에서 고객번호,이름,전화번호를 앞의 두명만 보이싱.
--ROWNUM : 오라클에서 자동으로 제공하는 가상 열로 쿼리가 진행되는 동안 각 행에 일련번호를 자동할당.
SELECT rownum 순번, custid 고객번호, name 이름, phone 전화번호
FROM customer
WHERE rownum < 3;


