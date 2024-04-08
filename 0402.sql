/*
 * DDL(데이터 정의어): CREATE/ALTER/DROP
 * DML(데이터 조작어): SELECT/UPDATA/INSERT/DELETE
 * DCL(데이터 제어어): REVOKE/GRANT
*/

SELECT * FROM dual;	-- 더미테이블 만듦

SELECT LENGTH('ab') FROM dual;	

-- 테이블 사용하기 전에 선언 필요, 타입 있음
-- 행: row/record
-- 열: column - 하나의 속성, 중복되면 안됨
-- data: value, 값 자체
-- information: 데이터를 가공해서 만든 것 


-- 오라클은 테이블명이나 컬럼명의 대소문자 구별안함, data는 구별
CREATE TABLE ex2_2(
	-- VARCHAR2(문자), NUMBER(숫자), DATE(날짜) 많이 사용
	COLUMN1		CHAR(10),	-- 문자/고정길이(처리속도 빠름)
	COLUMN2 	VARCHAR2(10), 	-- 문자/가변길이(메모리 효율적)
	COLUMN3 	NVARCHAR2(10),	-- 문자/가변길이 유니코드(다국어 입력 가능)
	COLUMN4 	NUMBER,	-- 정수일 때 사용
	COLUMN5		DATE
);	-- 세미콜론 안적어도 됨

DROP TABLE ex2_1;

INSERT INTO ex2_2(column1, column2) VALUES ('abc', 'abc');

SELECT  column1, LENGTH(column1) AS len1,
		column2, LENGTH(column2) AS len2
		FROM ex2_2;
		
DROP TABLE ex2_2;

CREATE TABLE ex2_2(
	column1		varchar2(3),	-- 디폴트값인 byte 적용
	column2	 	varchar2(3 byte),	-- 최대 3byte 데이터 넣을 수 있음
	column3		varchar2(3 char)	-- 최대 3글자 넣을 수 있음
);

INSERT INTO ex2_2 values('abc', 'abc', 'abc');

SELECT * FROM ex2_2;

SELECT column1, LENGTH(column1) AS len1,	-- AS len1 없으면 컬럼명 LENGTH(column1)로 나옴(별칭으로 바꾸는 명령어)
	   column2, LENGTH(column2) AS len2,
	   column3, LENGTH(column3) AS len3
	   FROM ex2_2;

-- 식별자/컬럼명 "", 문자열 ''
INSERT INTO ex2_2 values('홍길동', '홍길동', '홍길동');
/* SQL Error [12899] [72000]: ORA-12899: "ADAM"."EX2_2"."COLUMN1" 
열에 대한 값이 너무 큼(실제: 9, 최대값: 3) */
-- 한글 바이트 크기- utf-8: 3 byte, utf-16: 2 byte

INSERT INTO ex2_2 (column3) VALUES ('홍길동');

SELECT column3, LENGTH(column3) AS len3, lengthb(column3) AS bytelen FROM ex2_2;


CREATE TABLE ex2_3(
	col_int		integer,
	col_dec		decimal,
	col_num 	NUMBER
);

-- 새로고침 또는 commit이 없으면 가상공간에 저장됨(실질적으로 데이터베이스는 저장 안된 상태)

SELECT column_id, column_name, data_type, data_length
	FROM USER_TAB_COLS 
	WHERE table_name = 'EX2_3'	-- ''로 묶을 경우 대소문자 구분함
	ORDER BY column_id;


CREATE table ex2_5(
	col_date	    DATE,
	col_timestamp 	timestamp
);

INSERT INTO ex2_5 VALUES (sysdate, systimestamp);

SELECT * FROM ex2_5;


CREATE TABLE ex2_6(
	col_null		varchar2(10),
	col_not_null	varchar2(10) NOT NULL
);

INSERT INTO ex2_6 VALUES ('AA', '');	-- NOT null로 선언한 컬럼에 빈값 넣을 수 없음

INSERT INTO ex2_6 VALUES ('AA', 'BB');


CREATE TABLE ex2_7(
	col_unique_null		varchar2(10) UNIQUE,	-- NULL 허용, 중복 불가
	col_unique_nnull	varchar2(10) UNIQUE NOT NULL,	-- NULL 불가, 중복 불가
	col_unique			varchar2(10),	-- 제약조건 없음
	CONSTRAINTS unique_nml UNIQUE (col_unique)
);

SELECT constraint_name, constraint_type, table_name, search_condition
	FROM user_constraints
	WHERE table_name = 'EX2_7';	-- WHERE: 선택
	
INSERT INTO ex2_7 VALUES ('AA', 'AA', 'AA');

INSERT INTO ex2_7 VALUES ('AA', 'AA', 'AA');	-- UNIQUE 제약조건에 의해 같은 값 못 넣음

INSERT INTO ex2_7 VALUES ('', 'BB', 'BB');

INSERT INTO ex2_7 VALUES ('', 'CC', 'CC');	-- null은 값이 없으므로 UNIQUE 비교 대상에서 제외

SELECT * FROM ex2_7;