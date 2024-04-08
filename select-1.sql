SELECT * FROM EMP;		-- EMP 테이블 전체 조회

SELECT EMPNO, ENAME, SAL FROM EMP;	-- 사원번호, 사원 이름, 월급 조회

SELECT ENAME AS "이름", SAL AS "월급" FROM EMP;		-- 사원 이름, 월급 조회 / 별칭 지정 시 AS 키워드 생략 가능 / 식별자: 큰따옴표

-- 사원 번호, 사원 이름, 월급, 연봉을 구하고 컬럼명은 사원번호, 사원이름, 월급, 연봉으로 지정
SELECT EMPNO AS "사원번호", ENAME AS "사원이름", SAL AS "월급", SAL*12 AS "연봉" FROM EMP;

SELECT DISTINCT JOB FROM EMP;	-- DISTINCT: JOB에서 중복데이터 제거하여 조회
SELECT DISTINCT JOB, DEPTNO FROM EMP;
SELECT ALL JOB, DEPTNO FROM EMP;

SELECT 'ABC' FROM DUAL;		-- 더미테이블
SELECT 2 + 3 FROM DUAL;
SELECT 'ABC', 2+3 FROM DUAL;
SELECT 2 + 3 AS RESULT FROM DUAL;
SELECT 1 + '5' FROM DUAL;	-- 오라클에서 기본: 숫자, 문자+숫자 시 자동으로 숫자로 형변환됨
SELECT '1' + '5' FROM DUAL;
SELECT '1' || '5' FROM DUAL;	-- ||: 문자 연결

-- 사원명과 업무를 연결, (SMITH, CLERK) 형태로 표시, 컬럼명은 EMPLOYEE AND JOB으로 표시
SELECT '(' || ENAME || ', ' || JOB || ')' AS "EMPLOYEE AND JOB" FROM EMP;

-- 사원별 연간 총수입 조회, 별칭: 연간 총수입
SELECT SAL * 12 + NVL(COMM, 0)  AS "연간 총수입" FROM EMP;

SELECT * FROM EMP;
SELECT * FROM EMP ORDER BY SAL;	-- SAL 기준으로 오름차순 정렬
SELECT * FROM EMP ORDER BY EMPNO;	-- EMPNO 기준으로 오름차순 정렬
SELECT * FROM EMP ORDER BY SAL DESC;	-- SAL 기준으로 내림차순 정렬
-- 정렬에 시간, 자원 많이 소모됨, 가급적 정렬은 피해야 함

------------------------------------------------------------------------

-- 조건을 추가하는 WHERE절
SELECT * FROM EMP e;
SELECT * FROM EMP WHERE EMPNO=7839;

-- 사원번호가 7698인 사원 이름과 업무, 급여 출력
SELECT ENAME, JOB, SAL FROM EMP WHERE EMPNO = 7698;

-- SMITH의 사원 이름, 부서, 월급
SELECT ENAME, DEPTNO, SAL  FROM EMP e WHERE ENAME='SMITH';

-- !, ^, <>, NOT: 논리 부정
SELECT * FROM EMP e WHERE SAL = 3000;		-- 월급이 3000인 사람만 출력
SELECT * FROM EMP e WHERE SAL != 3000;		-- 월급이 3000이 아닌 사람만 출력
SELECT * FROM EMP e WHERE SAL ^= 4000;		-- 월급이 4000이 아닌 사람만 출력
SELECT * FROM EMP e WHERE SAL <> 5000;		-- 월급이 5000이 아닌 사람만 출력 / ANSII 표준식
SELECT * FROM EMP e WHERE NOT SAL = 6000;	-- 월급이 5000이 아닌 사람만 출력
SELECT * FROM EMP e WHERE ENAME >= 'M';		-- 첫 문자가 M과 같거나 보다 큰 문자열 출력 / 사전순

-- 월급이 2500 이상 3000 미만인 사원과 입사일, 월급 출력
SELECT ENAME, HIREDATE, SAL FROM EMP e WHERE 2500<=SAL AND SAL<3000;	-- 2500 이상 3000 미만

SELECT ENAME, HIREDATE, SAL FROM EMP e WHERE 2500<=SAL AND SAL<=3000;	-- 2500 이상 3000 이하
SELECT ENAME, HIREDATE, SAL FROM EMP e WHERE SAL BETWEEN 2500 AND 3000;	-- 2500 이상 3000 이하

-- 월급이 2000 이상 3000 이하에 포함되지 않는 사원명과 월급, 입사일 조회
SELECT ENAME, SAL, HIREDATE FROM EMP e WHERE 2000>SAL OR 3000<SAL;
SELECT ENAME, SAL, HIREDATE FROM EMP e WHERE NOT (2000<=SAL AND 3000>=SAL);

-- 81년 5월 1일 ~ 동년 12월 3일 사이 입사한 사원의 사원명, 급여, 입사일 조회, 날짜 포맷 사용
SELECT ENAME, SAL, HIREDATE FROM EMP e WHERE HIREDATE 
	BETWEEN TO_DATE('1-5-1981', 'DD-MM-YYYY') AND TO_DATE('3-12-1981', 'DD-MM-YYYY');

-- 1987년도 입사한 사원의 사원명, 월급, 입사일 출력
SELECT ENAME, SAL, HIREDATE FROM EMP e WHERE HIREDATE
	BETWEEN TO_DATE('19870101', 'YYYYMMDD') AND TO_DATE('19871231', 'YYYYMMDD');
	
-- 직업이 MANAGER, CLERK, SALESMAN인 사원
SELECT * FROM EMP e WHERE JOB = 'MANAGER' OR JOB = 'CLERK' OR JOB = 'SALESMAN';
SELECT * FROM EMP e WHERE JOB IN ('MANAGER', 'CLERK', 'SALESMAN');	-- 열이 같을 때만 사용 가능

-- 사원번호 7566, 7782, 7934인 사원을 제외한 사원의 사번, 이름, 월급 출력
SELECT EMPNO, ENAME, SAL FROM EMP e WHERE EMPNO NOT IN (7566, 7782, 7934);

-- 부서번호 30에서 근무, 월 2000달러 이하 받는 81년 5월 1일 이전에 입사한 사원의 이름, 급여, 부서번호, 입사일 조회
SELECT ENAME, SAL, DEPTNO, HIREDATE FROM EMP e 
	WHERE DEPTNO = 30 AND SAL <= 2000 AND HIREDATE < '1981-05-01';

-- 부서가 10 또는 30인 부서, 월급이 2000~5000달러인 사원명, 급여, 부서번호
SELECT ENAME, SAL, DEPTNO FROM EMP e WHERE DEPTNO IN (10, 30) AND SAL BETWEEN 2000 AND 5000;

-- JOB이 MANAGER 또는 SALESMAN이고, 급여가 1600달러, 2975달러, 2850달러가 아닌 사원명, 입사일, 급여, 부서번호 출력
SELECT ENAME, HIREDATE, SAL, DEPTNO FROM EMP e 
	WHERE JOB IN ('MANAGER', 'SALESMAN') AND SAL NOT IN (1600, 2975, 2850);

------------------------------------------------------------------------------

SELECT * FROM DEPT;

SELECT * FROM EMP e WHERE ENAME LIKE 'S%';	-- 이름이 'S'로 시작하는 사원 출력 / %: wildcard
SELECT * FROM EMP e WHERE ENAME LIKE '_L%';	-- 이름의 두번째 글자가 'L'인 사원 출력

-- 1. 사원명 중 'S'가 포함되지 않는 부서번호 20인 사원의 이름, 부서번호 조회
SELECT ENAME, DEPTNO FROM EMP e WHERE DEPTNO = 20 AND ENAME NOT LIKE '%S%';

-- 2. 1981.6.1 ~ 1981.12.31 입사자 중 부서명이 30인 사원의 부서번호, 사원명, 직업, 입사일 출력(입사일 오름차순 정렬)
SELECT DEPTNO, ENAME, JOB, HIREDATE 
FROM EMP e 
WHERE HIREDATE BETWEEN TO_DATE('19810601', 'YYYYMMDD') AND TO_DATE('19811231', 'YYYYMMDD') 
	AND DEPTNO = 30
ORDER BY HIREDATE;

-- 사원 이름 중에 A와 E가 있는 사원 조회
SELECT * FROM EMP e WHERE ENAME LIKE '%A%' AND ENAME LIKE '%E%';
	
SELECT * FROM EMP WHERE COMM = NULL;	-- NULL은 비교연산자 사용 불가
SELECT ENAME, SAL, SAL * 12 + COMM, COMM FROM EMP;	-- NULL 연산 시 NULL 출력됨

SELECT * FROM EMP WHERE COMM IS NULL;	-- NULL 비교 시 IS 키워드 사용해야 함 / COMM이 NULL인 열 출력
SELECT * FROM EMP WHERE COMM IS NOT NULL;	-- COMM이 NULL이 아닌 열 출력

-- 사수가 있는 사원 출력
SELECT * FROM EMP WHERE MGR IS NOT NULL;

-- 특별수당이 0인 사원을 제외한 사원 조회: 0이 아니거나 NULL인 경우
SELECT * FROM EMP WHERE COMM != 0 OR COMM IS NULL;
SELECT * FROM EMP WHERE NOT (COMM = 0 AND COMM IS NOT NULL);
