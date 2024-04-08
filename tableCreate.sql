SELECT * FROM employees e;

CREATE TABLE emp(
	empno		NUMBER(4) NOT NULL,		-- 사원 번호
	ename		varchar2(2),			-- 사원 이름
	job			varchar2(9),			-- 업무
	mgr			NUMBER(4),				-- 사수 번호
	hiredate	DATE,					-- 입사일
	sal			NUMBER(7, 2),			-- 월급
	comm		NUMBER(7, 2),			-- 커미션(추가수당)
	deptno		NUMBER(2)				-- 부서 번호
);

SELECT * FROM emp;	-- 테이블 조회, 열 8개 확인

ALTER TABLE emp MODIFY ename varchar2(10);	-- 컬럼 변경

INSERT INTO emp VALUES (7369, 'SMITH', 'CLERK', 7902, to_date('17-12-1980', 'dd-mm-yyyy'), 800, NULL, 20);
INSERT INTO emp VALUES (7499, 'ALLEN', 'SALESMAN', 7698, to_date('20-2-1981', 'dd-mm-yyyy'), 1600, 300, 30);
INSERT INTO emp VALUES (7521, 'WARD', 'SALESMAN', 7698, to_date('22-2-1981', 'dd-mm-yyyy'), 1250, 500, 30);
INSERT INTO emp VALUES (7566, 'JONES', 'MANAGER', 7839, to_date('2-4-1981', 'dd-mm-yyyy'), 2975, NULL, 20);
INSERT INTO emp VALUES (7654, 'MARTIN', 'SALESMAN', 7698, to_date('28-9-1981', 'dd-mm-yyyy'), 1250, 140, 30);
INSERT INTO emp VALUES (7698, 'BLACK', 'MANAGER', 7839, to_date('1-5-1981', 'dd-mm-yyyy'), 2850, NULL, 30);
INSERT INTO emp VALUES (7782, 'CLARK', 'MANAGER', 7839, to_date('9-6-1981', 'dd-mm-yyyy'), 2450, NULL, 10);
INSERT INTO emp VALUES (7788, 'SCOTT', 'ANALYST', 7566, to_date('13-7-1987', 'dd-mm-yyyy'), 3000, NULL, 20);
INSERT INTO emp VALUES (7839, 'KING', 'PRESIDENT', NULL, to_date('17-11-1981', 'dd-mm-yyyy'), 5000, NULL, 10);
INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN', 7698, to_date('8-9-1981', 'dd-mm-yyyy'), 1500, 0, 30);
INSERT INTO emp VALUES (7876, 'ADAMS', 'CLERK', 7788, to_date('13-7-1987', 'dd-mm-yyyy'), 1100, NULL, 20);
INSERT INTO emp VALUES (7900, 'JAMES', 'CLERK', 7698, to_date('3-12-1981', 'dd-mm-yyyy'), 950, NULL, 30);
INSERT INTO emp VALUES (7902, 'FORD', 'ANALYST', 7566, to_date('3-12-1981', 'dd-mm-yyyy'), 3000, NULL, 20);
INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK', 7782, to_date('23-1-1982', 'dd-mm-yyyy'), 1300, NULL, 10);

COMMIT;

SELECT * FROM emp;

CREATE TABLE dept(
	deptno		NUMBER(2),		-- 부서 번호
	dname		varchar2(4),	-- 부서명
	loc			varchar2(13)	-- 지역
);

SELECT * FROM DEPT;

ALTER TABLE DEPT MODIFY DNAME VARCHAR2(14);

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE BONUS(
   ENAME VARCHAR2(10),
   JOB VARCHAR2(9),
   SAL NUMBER,
   COMM NUMBER
);

CREATE TABLE SALGRADE(		-- 급여 정보
	GRADE	NUMBER,
	LOSAL	NUMBER,
	HISAL	NUMBER
);

INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);

SELECT * FROM SALGRADE;