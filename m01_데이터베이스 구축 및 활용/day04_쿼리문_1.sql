--NVL() NULL을 0 또는 다른 값으로 변환하는 함수
SELECT last_name, manager_id,
nvl(to_char(manager_id), 'CEO') revised_id from employees;

--decode()    if문이나 case문과 같이 여러 경우를 선택할 수 있도록 하는 함수
--DECODE 함수는 단순한 조건에 기반하여 값을 반환합니다. 구문은 DECODE(expression, search1, result1, ..., searchN, resultN, default) 
--여기서 expression은 검사할 값을 나타내고, search와 result는 각각 조건과 해당 조건이 참일 때 반환할 값
--default는 모든 search 조건이 거짓일 때 반환할 기본 값 출력

SELECT last_name, department_id,
decode(department_id,
    90, '경영지원실',
    60, '프로그래머',
    100, '인사부','기타') 부서
FROM employees;

--Q. employees 테이블에서 commission_pct가 null이 아닌 경우, 'A' null 인 경우 'N'을 표시하는 쿼리를 작성
SELECT commission_pct as commission
    , decode(commission_pct, null, 'N', 'A') AS 변환
FROM employees
order by 변환 desc;

--case()
--decode() 함수와 유사하나 decode() 함수는 조건이 동일한 경우만 가능하지만
--case() 함수는 다양한 비교연산자로 조건을 제시할 수 있다.
--CASE 문은 조건에 따라 다른 값을 반환하는 데 사용되며, DECODE보다 복잡한 조건을 표현할 수 있다. 
--구문은 CASE WHEN condition THEN result ... ELSE default END이다. 

SELECT last_name, department_id,
CASE WHEN department_id = 90 then '경영지원실'
     WHEN department_id = 60 then '프로그래머'
     WHEN department_id = 100 then '인사부'
else '기타'
end as 소속
FROM employees;

--Q. employees 테이블에서 salary가 20000 이상이면 'a', 10000~20000 이면 'B', 그 이하면 'C'로 표시하는 쿼리 작성.(case)
SELECT last_name, salary,
CASE WHEN salary >= 20000 then 'A'
     WHEN salary < 20000 and salary > 10000 then 'B'
     ELSE 'C'
END AS 등급
FROM employees;

--INSERT
--테이블에 데이터를 입력하는 방법은 두 가지 유형이 있으며 한 번에 한 건만 입력된다.
--a. INSERT INTO 테이블명 (COLUMN_LIST) VALUES (COLUMN_LIST에 넣을 VALUE_LIST);
--b. INSERT INTO 테이블명 VALUES (전체 COLUMN에 넣을 VALUE_LIST);

-- Concatenation : 콤마 대신에 사용하면 문자열이 연결되어 출력된다.
SELECT last_name, 'is a', job_id FROM employees;
SELECT last_name || 'is a' || job_id FROM employees;


--UNION(합집합) INTERSECT(교집합) MINUS(차집합) UNION ALL(겹치는 것까지 포함)
--두 개의 쿼리문을 사용해야 한다. 데이터 타입을 일치 시켜야 한다.
SELECT first_name 이름, salary 급여 FROM employees
WHERE salary < 5000
union
SELECT first_name 이름, salary 급여 FROM employees
where hire_date < '99/01/01';

SELECT first_name 이름, salary 급여, hire_date from employees
where salary < 5000
union all
SELECT first_name 이름, salary 급여, hire_date FROM employees
where hire_date < '05/01/01';

SELECT first_name 이름, salary 급여, hire_date from employees
where salary < 5000
minus
SELECT first_name 이름, salary 급여, hire_date FROM employees
where hire_date < '05/01/01';

SELECT first_name 이름, salary 급여, hire_date from employees
where salary < 5000
intersect
SELECT first_name 이름, salary 급여, hire_date FROM employees
where hire_date < '05/01/01';


--CREATE VIEW 명령어는 오라클 SQL에서 테이블의 특정 부분이나 조인된 결과를 논리적인 뷰(view)로 만들 때 사용
--뷰는 데이터를 요약하거나 복잡한 조인을 단순화하며, 사용자에게 필요한 데이터만을 보여주는 데 유용
--뷰는 실제 테이블 데이터를 복사하지 않고, 대신 쿼리 결과를 저장
--뷰의 주요 특징
--쿼리 단순화: 복잡한 쿼리를 뷰로 저장함으로써 사용자는 복잡한 쿼리문을 반복해서 작성할 필요 없이 간단하게 뷰를 참조할 수 있다.
--데이터 추상화: 뷰는 기본 테이블의 구조를 숨기고 사용자에게 필요한 데이터만을 보여줄 수 있어, 데이터 추상화를 제공.
--보안 강화: 뷰를 사용하면 특정 데이터에 대한 접근을 제한할 수 있으며, 사용자가 볼 수 있는 데이터의 범위를 제어할 수 있다.
--데이터 무결성 유지: 뷰를 사용하여 데이터를 수정하더라도, 이 변경사항이 기본 테이블의 데이터 무결성 규칙을 위반하지 않도록 관리할 수 있다.



--TCL (Transaction Control Language)
--COMMIT: 현재 트랜잭션 내에서 수행된 모든 변경(INSERT, UPDATE, DELETE 등)을 데이터베이스에 영구적으로 저장.
--COMMIT 명령을 실행하면, 트랜잭션은 완료되며, 그 이후에는 변경 사항을 되돌릴 수 없다.
--ROLLBACK: 현재 트랜잭션 내에서 수행된 변경들을 취소하고, 데이터베이스를 트랜잭션이 시작하기 전의 상태로 되돌린다. 
--오류가 발생했거나 다른 이유로 트랜잭션을 취소해야 할 경우에 사용된다.
--SAVEPOINT: 트랜잭션 내에서 중간 체크포인트를 생성합니다. 오류가 발생할 경우, ROLLBACK을 사용하여 최근의 SAVEPOINT까지 되돌릴 수 있다.
--트랜잭션을 콘트롤하는 TCL(TRANSACTION CONTROL LANGUAGE)

INSERT INTO members (member_id, name, email, join_date, status) VALUES (1, 'John Doe', 'john@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (2, 'Jane Doe', 'jane@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (3, 'Mike Smith', 'mike@example.com', SYSDATE, 'Inactive');
savepoint sp1
INSERT INTO members (member_id, name, email, join_date, status) VALUES (4, 'Alice Johnson', 'alice@example.com', SYSDATE, 'Active');
INSERT INTO members (member_id, name, email, join_date, status) VALUES (5, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');
rollback to savepoint sp1
INSERT INTO members (member_id, name, email, join_date, status) VALUES (6, 'Bob Brown', 'bob@example.com', SYSDATE, 'Inactive');

