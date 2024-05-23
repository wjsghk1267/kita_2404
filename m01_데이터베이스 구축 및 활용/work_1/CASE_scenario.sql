--[실습 - 2인 1조]
--학교 관리를 위하여 테이블 2개 이상으로 db를 구축하고 3개 이상 활용할 수 있는 case를 만드세요.
--성적/출결 - 학생기록부  -- case 성적조회.(2023년도 1/2학기). 졸업날짜출력, 낙제과목분류'F'
SELECT * FROM GRADE_1;
SELECT * FROM GRADE_2;
SELECT * FROM STUDENTS;


-- NO1. 1학기 특정과목 낙제자 조회
SELECT std_id 학번, name 이름, math
FROM GRADE_1
WHERE math = 0.0;


-- NO2. 1학기 낙제 과목명 확인
SELECT std_id 학번, name 이름, 
    CASE 
        WHEN math = 0.0 THEN '수학'
        WHEN english = 0.0 THEN '영어'
        WHEN science = 0.0 THEN '과학'
        WHEN music = 0.0 THEN '음악'
        WHEN social = 0.0 THEN '사회'
    END 낙제과목
FROM GRADE_1
WHERE math = 0.0 OR english = 0.0 OR science = 0.0 OR music = 0.0 OR social = 0.0;


-- NO3. 전과목 낙제 포함 조회
SELECT std_id 학번, name 이름, math 수학, english 영어, science 국어, music 과학, social 역사 
FROM GRADE_1
WHERE math = 0.0 or english = 0.0 or science = 0.0 or music = 0.0 or social = 0.0;


-- NO4. 개인 성적 조회
SELECT std_id 학번, name 이름, G1.math 수학, G1.science 과학, G1.english 영어, G1.music 음악, G1.social 사회, 
    (SELECT AVG(G1.math + G1.science + G1.English + G1.music + G1.social)/5 FROM GRADE_1 G2) 평균
FROM GRADE_1 G1
WHERE std_id = 2303001;


-- NO5. 전체 성적 조회
SELECT std_id 학번, name 이름, G1.math 수학, G1.science 과학, G1.english 영어, G1.music 음악, G1.social 사회, 
    (math + english + science + music + social)/5 평균학점 
FROM GRADE_1 G1;


-- NO6. 학기별 장학금 대상자 선별 (상위 2명)
SELECT * FROM(
    SELECT std_id 학번, name 이름, (math + english + science + music + social)/5 평균학점 
    FROM GRADE_1 G1
    WHERE G1.math + english + music + science + social >= (SELECT AVG(G2.math + G2.english + G2.music + G2.science + G2.social) FROM GRADE_1 G2)
    order by 평균학점 DESC)
WHERE rownum < 3;


-- NO7. 학기별 학사경고 여부 조회 (기준 : 전과목 낙제)
SELECT std_id 학번, name 이름, (math + english + music + science + social)/5 취득학점,
    CASE 
        WHEN (math + english + music + science + social) = 0.0 THEN '전과목'
    END 낙제과목
FROM GRADE_1 G1
WHERE math = 0.0 AND english = 0.0 AND music = 0.0 AND science = 0.0 AND social = 0.0;


-- NO8. 1,2학기 연속 낙제 과목 조회
SELECT S.NAME, G1.math as "1학기", G2.math as "2학기"
FROM STUDENTS S
JOIN GRADE_1 G1 ON S.std_id = G1.std_id
JOIN GRADE_2 G2 ON S.std_id = G2.std_id
WHERE G1.math = 0.0 AND G2.math = 0.0;


-- NO9. 입학년도에 따른 졸업연도 확인
SELECT std_id "학번", name "이름", enrollment "입학날짜", TO_CHAR(ADD_MONTHS(enrollment, 3 * 12 + 11), 'YYYY-mm') "졸업연도"
FROM STUDENTS;


-- NO10. 군대 현역 예정자 확인
--BMI 계산기
SELECT std_id "학번", name "이름", height "키", weight "몸무게"
FROM STUDENTS
WHERE sex='남자' and std_id in (
    SELECT std_id 
    from students
    where weight / power(height/100, 2) between 15 and 40);
