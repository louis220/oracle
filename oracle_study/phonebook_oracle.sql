--PhonebookOracle 과제를 위한 SQL
CREATE TABLE PHONE_BOOK(
    id NUMBER(10) PRIMARY KEY,
    name VARCHAR2(10),
    hp VARCHAR2(20),
    tel VARCHAR2(20)
    );
    
CREATE SEQUENCE seq_phone_book;

SELECT * FROM phone_book;

SELECT * FROM user_sequences;

INSERT INTO phone_Book
VALUES(1, '둘리', '010-9999-8888', '02-9666-9999');

INSERT INTO phone_book
VALUES(2, '또치', '010-5656-5455', '02-9655-8888');
DROP TABLE phone_book;
DROP SEQUENCE seq_phone_book;
COMMIT;