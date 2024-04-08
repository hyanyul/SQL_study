SELECT ENAME, UPPER(ENAME), LOWER(ENAME) FROM EMP e;	-- UPPER(): 대문자로 변환, LOWER(): 소문자로 변환
SELECT ENAME, INITCAP(ENAME) FROM EMP;	-- INITCAP(): 첫글자를 대문자, 나머지는 소문자로 바꿈

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP e WHERE DEPTNO = 10
UNION	-- 집합연산자, 합쳐서 출력
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP e WHERE DEPTNO = 20;

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP e WHERE DEPTNO = 10
UNION
SELECT EMPNO, ENAME, SAL FROM EMP e WHERE DEPTNO = 20;	-- 열의 개수가 달라서 오류남

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP e WHERE DEPTNO = 10
UNION
SELECT SAL, JOB , DEPTNO, SAL FROM EMP e WHERE DEPTNO = 20;		-- 열의 개수와 데이터 유형이 같으면 출력됨(컬럼명은 첫번째 쿼리 기준)

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP e
MINUS	-- 차집합
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP e2 WHERE DEPTNO = 10;

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP e
EXCEPT	-- 차집합
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP e2 WHERE DEPTNO = 10;

SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP e
INTERSECT	-- 교집합
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP e2 WHERE DEPTNO = 10;

SELECT ENAME, LENGTH(ENAME) FROM EMP;

-- 이름 글자가 5글자 이상인 사원 출력
SELECT * FROM EMP e WHERE LENGTH(ENAME) >= 5;

SELECT LENGTH('오라클'), LENGTHB('오라클')  FROM DUAL;		-- LENGTH(): 문자 길이, LENGTHB(): 바이트 크기

-----------------------------------------------------------------------------------

/* 문자열 일부 추출 */
-- SUBSTR(문자, 숫자1, 숫자2(생략 가능)): 문자에서 숫자1번째의 문자에서부터 숫자2개의 문자 추출
SELECT JOB, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3, 2), SUBSTR(JOB, 5) FROM EMP e;	

-- SUBSTR() 함수를 사용해서 모든 사원의 이름을 3번째부터 출력
SELECT ENAME, SUBSTR(ENAME, 3) FROM EMP e;

/* 특정문자 위치 찾기 */
-- INSTR(문자, 찾을 문자, 시작 위치, 문자 순번)
-- 못찾으면 0 반환
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR1, 		-- 전체에서 L 찾아서 위치 출력
	INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR2,		-- 5번째 문자부터 L 찾아서 위치 출력
	INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR3	-- 2번째 문자부터 L 찾아서 2번째로 나오는 L 위치 출력
FROM DUAL;

-- 사원 이름에서 S자가 있는 열 출력
SELECT *
FROM EMP e
WHERE ENAME 
	LIKE '%S%';

SELECT *
FROM EMP e
WHERE INSTR(ENAME, 'S') > 0;

/* 문자 변환 */
-- REPLACE(문자열, 변환할 문자, 변환 결과(생략 시 ''로 바뀜))
SELECT '010-1234-5678' AS REPLACA1,
	REPLACE('010-1234-5678', '-', ' ') AS REPLACE2,
	REPLACE('010-1234-5678', '-') AS REPLACE3
FROM DUAL;

/* 빈 공간 메우기 */
-- LPAD(), RPAD()
-- (문자열, 전체 자리 수, 빈자리 채울 문자(LPAD의 경우 왼쪽, RPAD의 경우 오른쪽이 채워짐 / 생략 시 띄어쓰기로 채워짐))
SELECT 'Oracle',
	LPAD('Oracle', 10, '#') AS LPAD1,
	RPAD('Oracle', 10, '*') AS RPAD1,
	LPAD('Oracle', 10) AS LPAD2,
	RPAD('Oracle', 10) AS RPAD2
FROM DUAL;

-- 주민등록번호, 전화번호의 각각 끝 7자리, 4자리 '*'로 처리
SELECT RPAD('010822-', 14, '*') AS "주민등록번호",
	RPAD('010-3568-', 13, '*') AS "전화번호"
FROM DUAL;

/* 특정 문자 지우기 */
-- TRIM(), RTRIM(), LTRIM()
SELECT '[' || TRIM(' __Oracle__ ') || ']' AS TRIM,	-- 앞뒤 공백 삭제
	'[' || TRIM(LEADING FROM ' __Oracle__ ') || ']' AS TRIM_LEADING,	-- 왼쪽 공백 삭제
	'[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS TRIM_TRAILING,	-- 오른쪽 공백 삭제
	'[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS TRIM_BOTH	-- 앞뒤 공백 삭제
FROM DUAL;	

/* 반올림 */
-- ROUND(숫자, 반올림할 자릿수)
SELECT ROUND(1234.5678),
	ROUND(1234.5678, 0),
	ROUND(1234.5678, 1),
	ROUND(1234.5678, -1),	-- 자연수 첫째자리 반올림
	ROUND(1234.5678, -2)
FROM DUAL;

/* 버림 */
-- TRUNC(숫자, 버릴 자릿수)
SELECT TRUNC(1234.5678),
	TRUNC(1234.5678, 0),
	TRUNC(1234.5678, 1),
	TRUNC(1234.5678, -1)
FROM DUAL;

/* 나머지 구하기 */
-- MOD()
SELECT MOD(15, 2),
	MOD(10, 2),
	MOD(11, 2)
FROM DUAL;


-- 각 사원별 시급을 계산하여 부서번호, 사원 이름, 시급 출력
/* 조건
 1. 한달 근무일수 20일, 하루 근무 시간 8시간
 2. 부서별로 오름차순 정렬
 3. 시급은 소수점 둘째자리까지
 4. 시급 높은 순으로 출력  */
SELECT DEPTNO AS "부서번호", 
	ENAME AS "사원명", 
	ROUND((SAL / (20 * 8)), 1) AS "시급"
FROM EMP e
ORDER BY DEPTNO, "시급" DESC; 

/* 날짜 */
-- SYSDATE: 운영체제가 가지고 있는 날짜 및 시간 출력
SELECT SYSDATE AS NOW,			-- 현재 날짜 및 시간
	SYSDATE -1 AS YESTERDAY,	-- 1일 전 날짜 및 시간
	SYSDATE +1 AS TOMORROW		-- 1일 후 날짜 및 시간
FROM DUAL;

-- ADD_MONTH(날짜, 더할 개월 수)
SELECT SYSDATE,
	ADD_MONTHS(SYSDATE, 3)	-- 3개월 더해짐
FROM DUAL;

-- 입사 10주년이 되는 사원 출력(사원번호, 사원이름, 입사일, 10주년 날짜)
SELECT EMPNO AS 사원번호, 
	ENAME AS 사원이름, 
	HIREDATE AS 입사일, 
	ADD_MONTHS(HIREDATE, 120) AS "10주년 날짜" 
FROM EMP e;

-- 두 날짜간의 개월차
SELECT EMPNO,
	ENAME,
	HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTHS1,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS3,
	TRUNC(MONTHS_BETWEEN(HIREDATE, SYSDATE)) AS MONTHS4
FROM EMP;

-- 요일, 마지막 날짜
SELECT SYSDATE,
	NEXT_DAY(SYSDATE, '월요일'),	-- 다음에 돌아오는 월요일 날짜 출력
	LAST_DAY(SYSDATE)			-- 입력한 날짜가 속한 달의 마지막 날짜 출력
FROM DUAL;

SELECT SYSDATE,
	ROUND(SYSDATE, 'CC') AS FORMAT_CC,		-- 세기 기준 반올림
	ROUND(SYSDATE, 'YYYY') AS FORMAT_YYYY	-- 1년 기준 반올림
FROM DUAL;

/* 형 변환 */
SELECT EMPNO, 
	ENAME, 
	EMPNO + '500'		-- '500' 숫자형태로 자동변환
FROM EMP e 
WHERE ENAME = 'SCOTT';

SELECT 'ABCD' + EMPNO, 	-- 'ABCD' 형변환 안일어남
	EMPNO
FROM EMP e
WHERE ENAME = 'SCOTT';

/* 암묵적 형변환(컴파일러가 자동 변환) <-> 명시적 형변환(사용자가 변환)
TO_CHAR: 숫자 (또는 날짜 데이터)를 문자 데이터로 변환
TO_NUMBER: 문자 (또는 날짜 데이터)를 숫자 데이터로 변환
TO_DATE: 문자 (또는 숫자 데이터)를 날짜 데이터로 변환
*/

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS "현재 날짜 시간"
FROM DUAL;

-- CC: 세기, YYYY: 연, YY: 연(2), MM: 월, MON: 월(약어), MONTH: 월(전체), 
-- DD: 일, DDD: 365일, DY: 요일(약어), DAY: 요일(풀이), W:주
-- HH24: 24시간 기준 시간, HH/HH12: 12시간, M1: 분, SS: 초, AM/PM/A.M/P.M: 오전, 오후

SELECT SYSDATE,
	TO_CHAR(SYSDATE, 'MM') AS MM,
	TO_CHAR(SYSDATE, 'MON') AS MON,
	TO_CHAR(SYSDATE, 'MONTH') AS MONTH,
	TO_CHAR(SYSDATE, 'DD') AS DD,
	TO_CHAR(SYSDATE, 'DY') AS DY,
	TO_CHAR(SYSDATE, 'DAY') AS DAY
FROM DUAL;

-- NLS_DATE_LANGUADE = 언어이름 : 다국적 언어로 변환 가능
SELECT SYSDATE,
	TO_CHAR(SYSDATE, 'MM') AS MM,
	TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_K,
	TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH_J,
	TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') AS DD_E,
	TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN') AS DY_K,
	TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH') AS DAY_E
FROM DUAL;

SELECT SYSDATE,
	TO_CHAR(SYSDATE, 'HH24:MI:SS') AS HH24MISS,
	TO_CHAR(SYSDATE, 'HH12:MI:SS AM') AS HHMISS_AM,
	TO_CHAR(SYSDATE, 'HH:MI,SS P.M.') AS HHMISS_PM
FROM DUAL;

SELECT TO_DATE('2019-04-04', 'YYYY-MM-DD') AS TODATE,
	TO_DATE('20100301', 'YYYY-MM-DD') AS TODATE2
FROM DUAL;

-- 1981년 12월 1일 이후 입사한 사원정보 출력
SELECT *
FROM EMP e
WHERE HIREDATE > TO_DATE('19811201', 'YYYYMMDD');
