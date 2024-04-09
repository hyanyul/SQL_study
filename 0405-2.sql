/* 다중함수(집계함수): SUM, MIN, MAX, COUNT, AVG */
SELECT *
  FROM EMP e;
  
SELECT COUNT(ENAME)		-- 개수 카운팅
  FROM EMP e;
  
SELECT COUNT(COMM)		-- COMM 개수 카운팅 / NULL값은 카운팅 안됨
  FROM EMP e;
  
-- 부서번호가 30인 부서의 직원 수
SELECT COUNT(*) AS "SALSE 부서 직원 수"
  FROM EMP e
 WHERE DEPTNO = 30;


/* 합 */
SELECT SUM(COMM)
  FROM EMP e;

SELECT SUM(SAL) 
  FROM EMP e;	
 
SELECT SUM(DISTINCT SAL)		-- 중복 제거한 합
  FROM EMP e;
  
SELECT SUM(DISTINCT SAL),		-- 중복 제거
	   SUM(ALL SAL)				-- 중복 포함 전체 / ALL 생략 가능
  FROM EMP e;
 
SELECT COUNT(SAL),
	   COUNT(ALL SAL),
	   COUNT(DISTINCT SAL)	
  FROM EMP e;
 
/* 최소 최대 */
SELECT MAX(SAL),
	   MIN(SAL)
  FROM EMP e
 WHERE DEPTNO = 10;
 
-- 20번 부서에서 신입과 최고참 입사일 조회
SELECT MAX(HIREDATE),
	   MIN(HIREDATE)
  FROM EMP e
 WHERE DEPTNO = 20;

-- 30번 부서의 월급 평균 조회
SELECT SUM(SAL) / COUNT(*) AS "30번 부서 월급 평균"
  FROM EMP e
 WHERE DEPTNO = 30;
 
/* GROUP BY */
SELECT 10 AS "DEPTNO",	
	   AVG(SAL)
  FROM EMP e
 WHERE DEPTNO = 10
UNION						-- 합집합
SELECT 20 AS "DEPTNO",
	   AVG(SAL)
  FROM EMP e
 WHERE DEPTNO = 20
UNION
SELECT 30 AS "DEPTNO",
       AVG(SAL)
  FROM EMP e
 WHERE DEPTNO = 30;
 
SELECT DEPTNO,
	   AVG(SAL)
  FROM EMP e
 GROUP BY DEPTNO
 ORDER BY DEPTNO;

-- 그룹화할 수 없는 일반열은 SELECT문에 올 수 없음
SELECT DEPTNO,
	   JOB,
	   AVG(SAL)
  FROM EMP e
 GROUP BY DEPTNO,
		  JOB
 ORDER BY DEPTNO, 
          JOB;
          
/* 
  코드 작성 순서: SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY(자원 가장 많이 사용)
  실행 순서: FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/
         
SELECT DEPTNO,
	   JOB,
	   AVG(SAL)
  FROM EMP e
 WHERE AVG(SAL) >= 2000		-- GROUP BY보다 먼저 실행됨 -> 그룹함수 사용 불가
 GROUP BY DEPTNO, JOB
 ORDER BY DEPTNO, JOB;
 
SELECT DEPTNO,
	   JOB,
	   AVG(SAL)
  FROM EMP e
 GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000		-- WHERE절 대신 HAVING절 사용
 ORDER BY DEPTNO, JOB;
 
SELECT DEPTNO,
	   JOB,
	   AVG(SAL)
  FROM EMP e
 WHERE SAL <= 3000			-- 집계함수 불가, 단독 사용 가능
 GROUP BY DEPTNO,
 		  JOB
HAVING AVG(SAL) >= 2000
 ORDER BY DEPTNO,
 		  JOB;


/* JOIN */
-- 두 개 이상의 테이블을 연결하여 하나의 테이블처럼 출력
-- INNER JOIN
-- OUTER JOIN(LEFT/RIGHT/FULL)

/* 오라클 조인 */
SELECT *
  FROM DEPT d;
 
SELECT *
  FROM EMP e;

-- FROM절에서 테이블로 조인
SELECT *
  FROM EMP e, DEPT d;

-- WHERE절에서 열 이름을 비교하는 조건식으로 조인
SELECT *
  FROM EMP e, DEPT d
 WHERE e.DEPTNO = d.DEPTNO
 ORDER BY EMPNO;
 
SELECT e.EMPNO,
	   e.ENAME,
	   d.DEPTNO,
	   d.DNAME
  FROM EMP e, DEPT d
 WHERE e.DEPTNO = d.DEPTNO
 ORDER BY d.DEPTNO;				-- 등가조인
 
SELECT e.EMPNO,
	   e.ENAME,
	   d.DEPTNO,
	   d.DNAME
  FROM EMP e, DEPT d
 WHERE e.DEPTNO = d.DEPTNO AND SAL >= 3000;		-- 조인에 조건식 추가
 
SELECT *
  FROM EMP e, SALGRADE s
 WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;		-- 비등가 조인
 
SELECT e.EMPNO,
	   e.ENAME,
	   e.MGR,
	   e2.EMPNO AS MGR_EMPNO,
	   e2.ENAME AS MGR_ENAME
  FROM EMP e, EMP e2
 WHERE e.MGR = e2.EMPNO (+)		-- RIGHT OUTER JOIN
 ORDER BY e.EMPNO;

SELECT e.EMPNO,
	   e.ENAME,
	   e.MGR,
	   e2.EMPNO AS MGR_EMPNO,
	   e2.ENAME AS MGR_ENAME
  FROM EMP e, EMP e2
 WHERE e.MGR (+) = e2.EMPNO 	-- LEFT OUTER JOIN
 ORDER BY e.EMPNO;

SELECT MGR
  FROM EMP e;
 
SELECT EMPNO
  FROM EMP e;
 
SELECT e.EMPNO,
	   e.ENAME,
	   e.JOB,
	   e.MGR,
	   e.HIREDATE,
	   e.SAL,
	   e.COMM,
	   DEPTNO,
	   d.DNAME,
	   d.LOC
  FROM EMP e NATURAL JOIN DEPT d		-- 자동으로 같은 컬럼을 찾아서 조인
 ORDER BY DEPTNO, e.EMPNO;		

/* JOIN ON */
-- INNER JOIN
SELECT e.EMPNO,
	   e.ENAME,
	   e.JOB,
	   e.MGR,
	   e.HIREDATE,
	   e.SAL,
	   e.COMM,
	   e.DEPTNO,
	   d.DNAME,
	   d.LOC
  FROM EMP e JOIN DEPT d ON (e.DEPTNO = d.DEPTNO)	-- 명시적으로 조인할 기준 컬럼 넣어서 조인
 WHERE SAL >= 3000
 ORDER BY e.DEPTNO, e.EMPNO;
 
-- OUTER JOIN
SELECT e.EMPNO,
	   e.ENAME,
	   e.MGR,
	   e2.EMPNO AS MGR_EMPNO,		-- LEFT OUTER JOIN, 기준: MGR
	   e2.ENAME AS MGR_ENAME
  FROM EMP e LEFT OUTER JOIN EMP e2 ON (e.MGR = e2.EMPNO);
 
SELECT e.EMPNO,
	   e.ENAME,
	   e.MGR,
	   e2.EMPNO AS MGR_EMPNO,		-- RIGHT OUTER JOIN, 기준: MGR
	   e2.ENAME AS MGR_ENAME
  FROM EMP e RIGHT OUTER JOIN EMP e2 ON (e.MGR = e2.EMPNO);
 
SELECT e.EMPNO,
	   e.ENAME,
	   e.MGR,
	   e2.EMPNO AS MGR_EMPNO,		-- FULL OUTER JOIN, 기준: MGR
	   e2.ENAME AS MGR_ENAME
  FROM EMP e FULL OUTER JOIN EMP e2 ON (e.MGR = e2.EMPNO);
  
SELECT *
  FROM EMP e LEFT OUTER JOIN DEPT d ON e.DEPTNO = d.DEPTNO;

/* 서브쿼리 */
SELECT ROWNUM,
	   e.*
  FROM EMP e;
 
SELECT *
  FROM (SELECT ROWNUM,
  			   e.* 
  	    FROM EMP e)
 WHERE ROWNUM BETWEEN 1 AND 5;
 
SELECT *
  FROM (SELECT ROWNUM AS N,
  			   e.* 
  	      FROM EMP e)
 WHERE N BETWEEN 6 AND 10;		-- 밖의 ROWNUM값에 해당
 
-- 급여를 내림차순 정렬, 상위 5명 정보 출력
SELECT *
  FROM (SELECT *
  		  FROM EMP e
  		 ORDER BY SAL DESC)
 WHERE ROWNUM < 6;

-- SCOTT보다 급여를 높게 받는 사람
SELECT *
  FROM EMP
 WHERE SAL > (SELECT SAL 
                FROM EMP e
               WHERE e.ENAME = 'SCOTT');
              
-- 'ALLEN'의 추가 수당보다 높은 추가수당을 받는 사람
SELECT *
  FROM EMP
 WHERE COMM IS NOT NULL 
       AND COMM > (SELECT COMM
                     FROM EMP e
                    WHERE e.ENAME = 'ALLEN')


/* 문제 풀기 */
-- 1. EMP 테이블에서 부서 인원이 4명보다 많은 부서의 부서 번호, 인원 수, 급여의 합 출력
SELECT e.DEPTNO AS 부서번호, 
	   COUNT(*) AS "인원 수", 	-- 전체 인원 출력 시 COUNT(*) 사용하면 됨
	   SUM(e.SAL) AS "급여의 합"		
  FROM EMP e
 GROUP BY DEPTNO				-- 집계함수를 사용하기 위해 GROUP BY 사용 필요
HAVING COUNT(EMPNO) > 4;

-- 2. EMP 테이블에서 가장 많은 사원이 속해있는 부서번호와 사원 수 출력
SELECT DEPTNO AS 부서번호, 
	   C AS "사원 수"
  FROM (SELECT DEPTNO, COUNT(EMPNO) AS C
  		  FROM EMP e
  		 GROUP BY DEPTNO
  	     ORDER BY COUNT(EMPNO) DESC)
 WHERE ROWNUM = 1;

SELECT DEPTNO AS "부서번호",
	   COUNT(*) AS "사원수"
  FROM EMP e 
 GROUP BY DEPTNO 
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) AS C
  		  			 FROM EMP e
  		 		    GROUP BY DEPTNO);

-- 3. EMP 테이블에서 가장 많은 사원을 갖는 MGR의 사원번호 출력
SELECT MGR AS "사원번호"
  FROM (SELECT MGR, COUNT(EMPNO)
          FROM EMP e
         GROUP BY MGR
         ORDER BY COUNT(EMPNO) DESC)
 WHERE ROWNUM = 1
 
SELECT MGR AS "사원번호"
  FROM EMP e
 GROUP BY MGR 
HAVING COUNT(MGR) = (SELECT MAX(COUNT(*))
					   FROM EMP e
					  GROUP BY MGR);
 
-- 4. EMP 테이블에서 부서번호가 10인 사원 수와 부서번호와 30인 사원 수를 각각 출력
SELECT DEPTNO AS "부서번호", 
	   COUNT(EMPNO) AS "사원 수"
  FROM EMP e
 WHERE DEPTNO = 10
 GROUP BY DEPTNO
UNION
SELECT DEPTNO, 
 	   COUNT(EMPNO)
  FROM EMP e
 WHERE DEPTNO = 30
 GROUP BY DEPTNO
 
SELECT DEPTNO AS "부서번호", 
	   COUNT(EMPNO) AS "사원 수"
  FROM EMP e
 GROUP BY DEPTNO
HAVING DEPTNO = 10 OR DEPTNO = 30
 ORDER BY DEPTNO;

-- DECODE(조회열, 조건, 결과, 조건, 결과, .. , 디폴트 결과)
-- COUTN() 안에 조건은 쓰지 못함. 함수는 사용 가능
SELECT COUNT(DECODE(DEPTNO, 10, 1)) AS "부서번호 10 사원 수",
	   COUNT(DECODE(DEPTNO, 30, 1)) AS "부서번호 30 사원 수"
  FROM EMP e;


COMMIT;
