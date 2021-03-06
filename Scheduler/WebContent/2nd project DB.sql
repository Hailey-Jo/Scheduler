/* USERDTO 테이블 생성 */
DROP TABLE USERDTO
CASCADE CONSTRAINT;

DROP SEQUENCE USER_SEQ;

CREATE TABLE USERDTO(
	USER_SEQ NUMBER(8),
	ID	VARCHAR2(50) PRIMARY KEY,
	PASSWORD VARCHAR2(50) NOT NULL,
	NAME	VARCHAR2(50) NOT NULL,
	BIRTH	VARCHAR2(50)	NOT NULL,
	EMAIL	VARCHAR2(50)	NOT NULL,
	PIC	VARCHAR2(1000),
	DEL	NUMBER(1)	NOT NULL	
)

INSERT INTO USERDTO(USER_SEQ, ID, PASSWORD, NAME, BIRTH, EMAIL, PIC, DEL)
VALUES (USER_SEQ.NEXTVAL, 'creepin', 'creepin', '라라라', '20111111', 'creepin@naver.com', '.\pic\creepin.jpg', 0);

SELECT * FROM USERDTO

CREATE SEQUENCE USER_SEQ
START WITH 1
INCREMENT BY 1;

/* 일정관리 테이블 생성 */

DROP TABLE SCHEDULE
CASCADE CONSTRAINT;

DROP SEQUENCE SHECDELE_SEQ;

CREATE TABLE SCHEDULE(
	SHECDELE_SEQ	NUMBER(8),
	ID	VARCHAR2(50),
	TITLE	VARCHAR2(50) NOT NULL,
	STARTDATE	DATE	NOT NULL,
	ENDDATE	DATE	NOT NULL,
	CATEGORY	VARCHAR2(50),
	CONTENT	VARCHAR2(2000)	NOT NULL,
	IMPORTANT	NUMBER(1)	NOT NULL,
	DEL	NUMBER(1)	NOT NULL
)

select * from schedule where id='mlmlml';

CREATE SEQUENCE SHECDELE_SEQ
START WITH 1
INCREMENT BY 1;

ALTER TABLE SCHEDULE
	ADD CONSTRAINT FK_SCHEDULE_ID FOREIGN KEY(ID)
	REFERENCES USERDTO(ID);

/* 가계부 테이블 만들기 */

DROP TABLE MONEYBOOK
CASCADE CONSTRAINT;

DROP SEQUENCE MONEYBOOK_SEQ

CREATE TABLE MONEYBOOK(
	MONEYBOOK_SEQ	NUMBER(8),
	ID	VARCHAR2(50),
	TITLE	VARCHAR2(50)	NOT NULL,
	MONEYDATE	DATE	NOT NULL,
	IOMONEY	NUMBER(1)	NOT NULL,
	CATEGORY	NUMBER(2),
	PRICE	NUMBER(8) NOT NULL,
	CONTENT	VARCHAR2(2000)	NOT NULL,
	DEL	NUMBER(1)	NOT NULL
)

CREATE SEQUENCE MONEYBOOK_SEQ
START WITH 1
INCREMENT BY 1;

ALTER TABLE MONEYBOOK
	ADD CONSTRAINT FK_MONEYBOOK_ID FOREIGN KEY(ID)
	REFERENCES USERDTO(ID);

INSERT INTO MONEYBOOK(MONEYBOOK_SEQ, ID, TITLE, MONEYDATE, IOMONEY, CATEGORY, PRICE, CONTENT, DEL)
VALUES (MONEYBOOK_SEQ.NEXTVAL, 'creepin', '교통/차량', '20180226', 1, 0, 1300, '출근', 0);

INSERT INTO MONEYBOOK(MONEYBOOK_SEQ, ID, TITLE, MONEYDATE, IOMONEY, CATEGORY, PRICE, CONTENT, DEL)
VALUES (MONEYBOOK_SEQ.NEXTVAL, 'creepin', '식비', '20180224', 1, 0, 1300, '점심식사', 0);

INSERT INTO MONEYBOOK(MONEYBOOK_SEQ, ID, TITLE, MONEYDATE, IOMONEY, CATEGORY, PRICE, CONTENT, DEL)
VALUES (MONEYBOOK_SEQ.NEXTVAL, 'creepin', '주수입', '20180228', 0, 0, 10000000, '월급', 0);

INSERT INTO MONEYBOOK(MONEYBOOK_SEQ, ID, TITLE, MONEYDATE, IOMONEY, CATEGORY, PRICE, CONTENT, DEL)
VALUES (MONEYBOOK_SEQ.NEXTVAL, 'creepin', '주수입', '20180128', 0, 0, 10000000, '월급', 0);

INSERT INTO MONEYBOOK(MONEYBOOK_SEQ, ID, TITLE, MONEYDATE, IOMONEY, CATEGORY, PRICE, CONTENT, DEL)
VALUES (MONEYBOOK_SEQ.NEXTVAL, 'creepin', '식비', '20180302', 1, 0, 6000, '아침', 0);


수입/지출
SELECT SUM(PRICE)
FROM MONEYBOOK 
WHERE ID='creepin' AND IOMONEY=0 AND TO_CHAR(MONEYDATE, 'YYYYMM') = '201803';

SELECT SUM(PRICE)  
FROM MONEYBOOK  
WHERE ID='creepin'  AND IOMONEY=0   TO_CHAR(MONEYDATE, 'YYYYMM') = '201803' 

SELECT MONEYBOOK_SEQ, ID, TITLE, MONEYDATE, IOMONEY, CATEGORY, PRICE, CONTENT, DEL
FROM MONEYBOOK
WHERE ID='creepin' 
ORDER BY MONEYDATE DESC;

DELETE FROM MONEYBOOK
WHERE MONEYBOOK_SEQ=?;

SELECT * FROM MONEYBOOK
WHERE DEL NOT IN(1) AND ID='mlmlml';

UPDATE MONEYBOOK
SET TITLE=?, MONEYDATE=?, CATEGORY=?, PRICE=?, CONTENT=?
WHERE MONEYBOOK_SEQ=?;

UPDATE MONEYBOOK
SET DEL=1
WHERE MONEYBOOK_SEQ=21;

DELETE MONEYBOOK
WHERE CONTENT='test';

/* 연락처 DB 만들기 */
DROP TABLE PHONEBOOK
CASCADE CONSTRAINT;

DROP SEQUENCE PHONEBOOK_SEQ;

CREATE TABLE PHONEBOOK(
	PHONEBOOK_SEQ	NUMBER(8),
	ID	VARCHAR2(50),
	NAME VARCHAR2(50) NOT NULL,
	BIRTH VARCHAR2(50) NOT NULL,
	PHONE VARCHAR2(50) NOT NULL,
	EMAIL VARCHAR2(50) NOT NULL
)

CREATE SEQUENCE PHONEBOOK_SEQ
START WITH 1
INCREMENT BY 1;

ALTER TABLE PHONEBOOK
	ADD CONSTRAINT FK_PHONEBOOK_ID FOREIGN KEY(ID)
	REFERENCES USERDTO(ID);

select * from phonebook

SELECT * FROM S_PDS

DROP TABLE S_PDS
CASCADE CONSTRAINT;

DROP SEQUENCE SEQ_S_PDS;

CREATE TABLE S_PDS(
	SEQ NUMBER(8) PRIMARY KEY,
	ID VARCHAR2(50) NOT NULL,
	TITLE VARCHAR2(200) NOT NULL,
	CONTENT VARCHAR2(4000) NOT NULL,
	FILENAME VARCHAR2(50) NOT NULL,
	READCOUNT NUMBER(8) NOT NULL,
	DOWNCOUNT NUMBER(8) NOT NULL,
	REGDATE DATE NOT NULL
);

CREATE SEQUENCE SEQ_S_PDS
START WITH 1 INCREMENT BY 1;

ALTER TABLE S_PDS
ADD CONSTRAINT FK_PDS_ID FOREIGN KEY(ID)
REFERENCES USERDTO(ID);

ALTER TABLE PDS
DROP CONSTRAINT FK_PDS_ID

SELECT * FROM S_PDS