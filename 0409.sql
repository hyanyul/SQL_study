-- 1. EMP 테이블에서 입사일 순으로 사원번호, 이름, 업무, 급여, 입사일자, 부서번호 조회
SELECT e.EMPNO AS "사원번호",
	   e.ENAME AS "이름",
	   e.JOB AS "업무",
	   e.SAL AS "급여",
	   e.HIREDATE AS "입사일자",
	   e.DEPTNO AS "부서번호"
  FROM EMP e
 ORDER BY HIREDATE;

-- 2. EMP 테이블에서 부서번호로 정렬한 후 급여가 많은 순으로 사원번호, 성명, 업무, 부서번호, 급여 조회
SELECT e.EMPNO AS "사원번호",
	   e.ENAME AS "성명",
	   e.JOB AS "업무",
	   e.DEPTNO AS "부서번호",
	   e.SAL AS "급여"
  FROM EMP e
 ORDER BY e.DEPTNO, e.SAL DESC 

-- 3. EMP 테이블에서 모든 SALESMAN의 급여 평균, 최고액, 최저액, 합계 조회
SELECT AVG(e.SAL) AS "급여 평균",
	   MAX(e.SAL) AS "최고액",
	   MIN(e.SAL) AS "최저액",
	   SUM(e.SAL) AS "합계"
  FROM EMP e
 WHERE JOB = 'SALESMAN';
	   
-- 4. EMP 테이블에서 각 부서별로 인원 수, 급여의 평균, 최저 급여, 최고 급여, 급여의 합을 구하여 많은 순으로 출력
SELECT DEPTNO AS "부서번호",
	   COUNT(*) AS "인원 수",
	   AVG(e.SAL) AS "급여 평균",
	   MIN(e.SAL) AS "최저 급여",
	   MAX(e.SAL) AS "최고 급여",
	   SUM(e.SAL) AS "급여의 합"
  FROM EMP e
 GROUP BY DEPTNO
 ORDER BY "급여의 합" DESC;
 
COMMIT;

SELECT *
  FROM EMP e;