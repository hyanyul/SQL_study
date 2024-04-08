-- SQL -> DBSM -> DB 형태로 접근(무결성 때문)
/* 명령문
 * DDL
 * DML(ISUD, CRUD)
 * DCL
 */

------------------------------------------------------------------

/* NULL 처리 내장함수 */
SELECT *
  FROM EMP e;

SELECT COMM * 1.1
  FROM EMP e;

-- NVL(해당 열, 해당 열의 값이 NULL일 경우 대체할 값)
SELECT NVL(COMM, 0)		-- COMM이 NULL일 경우 0으로 대체됨
  FROM EMP e;
  
SELECT NVL(COMM, 0) * 1.2
  FROM EMP e;
  
-- NVL2(해당 열, NULL이 아닌 경우 대체값, NULL일 경우 대채값)
SELECT NVL2(COMM, COMM*1.1, 0)
  FROM EMP e;
 
/* 쿼리 순서
FROM -> SELECT
*/

-- DECODE(해당 열, 조건1, 결과1, 조건2, 결과2, ... , 그외 조건에 대한 결과): 조건에 따라 값 선택
SELECT EMPNO,
	   ENAME,
	   JOB,
	   SAL,
	   DECODE(JOB, 							-- 해당 열
	   		  'MANAGER', SAL * 1.1,			-- MANAGER일 때 처리
	   		  'SALESMAN', SAL * 1.05,		-- SALESMAN일 때 처리
	   		  'ANALYST', SAL,				-- ANALYST일 때 처리
	   		  SAL * 1.03) AS UPSAL			-- 그 외일 때 처리
  FROM EMP e;	
 
SELECT EMPNO, 
       ENAME, 
       JOB, 
       SAL,
       CASE JOB
       		WHEN 'MANAGER' THEN SAL* 1.1
       		WHEN 'SALESMAN' THEN SAL * 1.5
       		WHEN 'ANALYST' THEN SAL
      		ELSE SAL * 1.03
       END AS UPSAL
  FROM EMP e;
 
SELECT ROWNUM,
       EMPNO,
	   ENAME,
	   JOB,
	   MGR,
	   HIREDATE,
	   SAL,
	   COMM, 
	   DEPTNO
  FROM EMP;

 
/* 행 제한 */
-- 5개씩 나눠서 출력  

-- 1~5
SELECT ROWNUM,
       EMPNO,
	   ENAME,
	   JOB,
	   MGR,
	   HIREDATE,
	   SAL,
	   COMM, 
	   DEPTNO
  FROM EMP e
 WHERE ROWNUM BETWEEN 1 AND 5;

-- 6~10
SELECT ROWNUM,
       EMPNO,
	   ENAME,
	   JOB,
	   MGR,
	   HIREDATE,
	   SAL,
	   COMM, 
	   DEPTNO
  FROM EMP e
 WHERE ROWNUM BETWEEN 1 AND 10
MINUS 
SELECT ROWNUM,
       EMPNO,
	   ENAME,
	   JOB,
	   MGR,
	   HIREDATE,
	   SAL,
	   COMM, 
	   DEPTNO
  FROM EMP e
 WHERE ROWNUM BETWEEN 1 AND 5;

-- 11~14
SELECT ROWNUM,
       EMPNO,
	   ENAME,
	   JOB,
	   MGR,
	   HIREDATE,
	   SAL,
	   COMM, 
	   DEPTNO 
  FROM EMP e
 WHERE ROWNUM BETWEEN 1 AND 14
MINUS
SELECT ROWNUM,
       EMPNO,
	   ENAME,
	   JOB,
	   MGR,
	   HIREDATE,
	   SAL,
	   COMM, 
	   DEPTNO
  FROM EMP e
 WHERE ROWNUM BETWEEN 1 AND 10
 ORDER BY EMPNO;