/* DDL */
-- 테이블 생성(CREATE)
CREATE TABLE EMP_DDL(	
	EMPNO 		NUMBER(4),
	ENAME		VARCHAR2(10),
	JOB			VARCHAR2(9),
	HIREDATE	DATE,
	SAL			NUMBER(7, 2),
	COMM 		NUMBER(7, 2),
	DEPTNO		NUMBER(2)
);

CREATE TABLE EMP_DDL1
    AS SELECT *
         FROM EMP e
        WHERE DEPTNO = 30;
     
SELECT *
  FROM EMP_DDL1;
  
CREATE TABLE EMP_DDL2
    AS SELECT *
         FROM EMP e 
        WHERE 1 <> 1;
        
SELECT *
  FROM EMP_DDL2;
  
-- 테이블 수정(ALTER)
ALTER TABLE EMP_DDL1
  ADD HP VARCHAR2(20);		-- 컬럼(열) 추가
  
SELECT *
  FROM EMP_DDL1;
  
 ALTER TABLE EMP_DDL1
RENAME COLUMN HP TO TEL;	-- 컬럼명 변경

COMMIT;

 ALTER TABLE EMP_DDL1		
MODIFY EMPNO NUMBER(10);	-- 자료형 변경

ALTER TABLE EMP_DDL1 
 DROP COLUMN TEL;			-- 컬럼 삭제
 
TRUNCATE TABLE EMP_DDL1;	-- 전체 데이터 삭제

DROP TABLE EMP_DDL1;
DROP TABLE EMP_DDL2;
DROP TABLE EMP_DDL;

----------------------------------------------------

/* 제약조건 */
-- NOT NULL: NULL 불가
-- UNIQU: 중복 불가
CREATE TABLE TBL_EX(
	LOGIN_ID		VARCHAR2(20) NOT NULL,
	LOGIN_PW		VARCHAR2(20) NOT NULL,
	TEL 			VARCHAR2(20)
);

SELECT *
  FROM TBL_EX;
 
INSERT INTO TBL_EX te (LOGIN_ID, LOGIN_PW, TEL)
VALUES ('AAAA', '1234', NULL);

INSERT INTO TBL_EX te (LOGIN_ID, LOGIN_PW, TEL)
VALUES ('BBBB', 'NULL', NULL);

-- ALTER TABLE TBL_EX
--MODIFY TEL NOT NULL;		-- 이미 제약조건에 반하는 데이터 들어가있을 경우 변경 불가(이미 TEL에 NULL값 들어있음)

UPDATE TBL_EX
   SET TEL = '010-****-****'
 WHERE LOGIN_ID = 'AAAA';
 
-- UNIQUE
CREATE TABLE TBL_UNIQ (
	LOGIN_ID		VARCHAR2(20) UNIQUE,		-- NULL값은 중복 가능
	LOGIN_PW		VARCHAR2(20) NOT NULL,
	TEL				VARCHAR2(20)
);

SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
  FROM USER_CONSTRAINTS;			-- USER: 데이터 사전
 
-- PRIMARY KEY(후보키): 유일하게 하나만 존재하는 키, UNIQUE, NOT NULL 제약조건이 동시에 이루어져야 함
CREATE TABLE TBL_UNIQ2 (
	LOGIN_ID		VARCHAR2(20) PRIMARY KEY,		-- 중복과 NULL 비허용
	LOGIN_PW		VARCHAR2(20) NOT NULL,
	TEL				VARCHAR2(20)
);

-- FOREIGN KEY(외래키)
CREATE TABLE TBL_UNIQ3 (
	LOGIN_ID		VARCHAR2(20) FOREIGN KEY,		-- 중복과 NULL 비허용
	LOGIN_PW		VARCHAR2(20) NOT NULL,
	TEL				VARCHAR2(20)
);

SELECT OWNER, CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, R_OWNER, R_CONSTRAINT_NAME
  FROM USER_CONSTRAINTS
 WHERE TABLE_NAME 
    IN ('EMP', 'DEPT');
    
/* CHECK */
CREATE TABLE TBL_CHK(
	LOGIN_ID		VARCHAR2(20) CONSTRAINT TBLCK_LOGING_PK PRIMARY KEY,
	LOGIN_PW		VARCHAR2(20) CONSTRAINT TBLCK_LOGING_CK CHECK (LENGTH(LOGIN_PW) > 3),
	TEL				VARCHAR2(20)
);

/* 정규식
010 - 1234 -5678
010 - [0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]
010 - \d\d\d\d - \d\d\d\d
^010 - \d{4} - \d{4}$ 
*/

/* 문제풀이 */
SELECT *
  FROM EMP;
 
SELECT *
  FROM DEPT;

-- 1. EMP 테이블에서 사원번호가 7521인 사원의 직업과 같고, 사원번호 7934인 사원의 급여보다 많은 사원의 사번, 이름, 
-- 직업, 급여 출력
SELECT EMPNO AS "사번", 
	   ENAME AS "이름", 
	   JOB AS "직무", 
	   SAL AS "급여"
  FROM EMP e
 WHERE JOB = (SELECT JOB
  			    FROM EMP e1
  			   WHERE EMPNO = 7521) AND
  	   SAL > (SELECT SAL
  	   			FROM EMP e2
  	   		   WHERE EMPNO = 7934);
  	   
-- 2. 직업별로 최소 급여를 받는 사원의 정보를 사원번호, 이름, 업무, 부서명으로 출력(직업별 내림차순)
SELECT e.EMPNO AS "사원번호", 
	   e.ENAME AS "이름", 
	   e.JOB AS "직무", 
	   d.DNAME AS "부서명"
  FROM EMP e LEFT OUTER JOIN DEPT d ON (e.DEPTNO = d.DEPTNO)
 WHERE (JOB, SAL) IN (SELECT JOB, MIN(e1.SAL)
			    	    FROM EMP e1
			   		   GROUP BY e1.JOB)	
 ORDER BY JOB DESC;

SELECT e.EMPNO AS "사원번호", 
	   e.ENAME AS "이름", 
	   e.JOB AS "직무", 
	   d.DNAME AS "부서명"
  FROM EMP e, DEPT d
 WHERE e.DEPTNO = d.DEPTNO 
	   AND (e.JOB, e.SAL) IN (SELECT JOB, MIN(e1.SAL)
	   					    	FROM EMP e1
	   					   	   GROUP BY e1.JOB)
 ORDER BY JOB DESC;
	   				
 
-- 3. 각 사원별 커미션이 0 또는 NULL이고, 부서 위치가 'GO'로 끝나는 사원의 사원번호, 사원이름, 커미션, 부서 번호,
-- 부서명, 부서 위치 출력(보너스가 NULL이면 0으로 출력)
SELECT e.EMPNO AS "사원번호", 
	   e.ENAME AS "사원명", 
	   NVL(e.COMM, 0) AS "보너스", 
	   e.DEPTNO AS "부서번호", 
	   d.DNAME AS "부서명", 
	   d.LOC AS "부서 위치"
  FROM EMP e LEFT OUTER JOIN DEPT d ON (e.DEPTNO = d.DEPTNO)
 WHERE d.LOC LIKE '%GO' 
       AND (COMM = 0 OR COMM IS NULL)

COMMIT;
