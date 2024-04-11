CREATE TABLE MEMBERS(
	ID		VARCHAR2(30) PRIMARY KEY,
	PW		VARCHAR2(30) NOT NULL
);

CREATE TABLE GAME_CHARACTER(
	 ID			VARCHAR2(30) NOT NULL,
	 NICKNAME 	VARCHAR2(30) NOT NULL,
	 TRIBE		VARCHAR2(30) NOT NULL,
	 JOB 		VARCHAR2(30) NOT NULL,
	 CONSTRAINT FK_ID FOREIGN KEY(ID) REFERENCES MEMBERS(ID) ON DELETE CASCADE
);

COMMIT;
	 