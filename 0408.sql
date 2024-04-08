/* UPDATE */
CREATE TABLE DEPT_TMP AS SELECT * FROM DEPT d;

SELECT * 
  FROM DEPT_TMP;

-- UPDATE ~ SET
UPDATE DEPT_TMP 
   SET LOC = 'SEOUL';		-- 해당열 전체 수정
   
UPDATE DEPT_TMP
   SET DNAME = 'DATABASE'
 WHERE DEPTNO = 40;

UPDATE DEPT_TMP
   SET LOC = 'BUSAN'
 WHERE DEPTNO = 40;
 
-- 서브쿼리를 사용한 데이터 수정
UPDATE DEPT_TMP
   SET (DNAME, LOC) = (SELECT DNAME, LOC
   		  				 FROM DEPT
   		 				WHERE DEPTNO = 40)
 WHERE DEPTNO = 40;

/* DELETE */
CREATE TABLE EMP_TMP AS SELECT * FROM EMP;

SELECT *
  FROM EMP_TMP;
  
DELETE FROM EMP_TMP
 WHERE JOB = 'SALESMAN';
 
DELETE FROM EMP_TMP;	-- 데이터만 삭제되고 테이블은 삭제되지 않음

SELECT * 
  FROM EMP_TMP;

DROP TABLE EMP_TMP;		-- 테이블 삭제(DROP TABLE [테이블 이름])


/* 트랜젝션 */
-- 트랜젝션: 하나의 명령을 실행하는 단위
-- 테이블 수정 중에 다른 사람 접근 불가
-- 어떤 하나의 행위가 반영될 때까지를 하나의 트랜젝션이라 함
CREATE TABLE DEPT_TMP;

SELECT * 
  FROM TAB;		-- 전체 테이블 조회

SELECT * 
  FROM DEPT_TMP;
  
CREATE TABLE DEPT_TCL
	AS SELECT * FROM DEPT d;

SELECT *
  FROM DEPT_TCL;
  
INSERT INTO DEPT_TCL 
VALUES (50, 'DATABASE', 'BUSAN');

UPDATE DEPT_TCL
   SET LOC = 'BUSAN'
 WHERE DEPTNO = 40;
 
DELETE FROM DEPT_TCL
 WHERE DNAME = 'RESEARCH'
 
ROLLBACK;		-- 트랜젝션 취소
COMMIT;			-- 트랜젝션 반영


/* 섹션 */
-- 로그인한 사용자가 로그아웃할 때까지

/* VIEW */
-- 하나 이상의 SELECT문을 가지고 있는 하나의 객체
-- 서브쿼리로 대체 가능
-- 보안성, 편리성
CREATE VIEW VM_EMP
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO
          FROM EMP e
         WHERE DEPTNO = 20);
    
SELECT * 
  FROM VM_EMP;
  
SELECT *
  FROM USER_VIEWS;
  
DROP VIEW VM_EMP;