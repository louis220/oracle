--view
--생성
desc myemp;
SELECT * FROM myemp;
--기반 테이블 생성
DROP TABLE myemp;
CREATE TABLE myemp
AS SELECT * FROM hr.employees;
SELECT * FROM myemp;

--view 생성
--view 생성을 위해서는 create view 권한이 있어야 한다
--system, sys 계정으로
-- grant create view TO bituser를 해야함
--department_id =1인 직원들의 목록
CREATE OR REPLACE VIEW myemp_10
AS SELECT employee_id, first_name, last_name, hire_date, salary
    FROM myemp
    Where department_id=10;
--단일 테이블의 단순 컬럼의 목록으로 작성된 view : simpleview
--simpleview는 제약조건에 걸리지 않으면 insert, update, delete 가능
--view는 일반 table처럼 select 할 수 있다
SELECT * FROM myemp_10;

UPDATE myemp_10 SET salary = salary *2;
-- 가능하면 view는 read only(조회 전용)로 사용하도록 합시다

CREATE OR REPLACE VIEW myemp_10
AS SELECT employee_id, first_name, last_name, salary
    FROM myemp
    WHERE department_id=10
WITH READ ONLY; --읽기 전용의 view 생성

UPDATE myemp_10 SET salary = salary *2; --read only view는 insert, update, delete 불가

--complex view
-- 두 개 이상의 테이블 혹은 view를 기반으로 생성
-- 표현식, 함수를 포함하기도 한다
-- book 테이블과 author 테이블을 join해서 book_detail view 생성
CREATE OR REPLACE VIEW book_detail
    (book_id, title, author_name, pub_date)
    AS SELECT book_id, title, author_name, pub_date
    FROM book b, author a
    WHERE b.author_id = a.author_id;
DESC book_detail;

SELECT * FROM book_detail;
SELECT * FROM book;

INSERT INTO book 
VALUES(1, '토지', sysdate, 1);
INSERT INTO book
VALUES(2, '살인자의 기억법', sysdate, 2);
COMMIT;

SELECT * FROM book_detail;
-- complex view는 기본적으로는 insert, update, delete를 허용하지 않는다

-- view를 위한 dictionary
--user views
SELECT * FROM user_views;

--user objects를 이용한 view 확인
SELECT object_name, status, object_type FROM user_objects
WHERE object_type='VIEW';

--view 지우기
DROP VIEW myemp_10;
SELECT * FROM user_views;

--index : 쿼리 성능 상승을 위해 사용
SELECT * FROM myemp;
--myemp 테이블의 employess_id 컬럼에 unique 인덱스를 만들어 봅시다
CREATE UNIQUE INDEX myemp_id_unique
ON myemp(employee_id);
CREATE INDEX myemp_dept_id
ON myemp(department_id);

 -- 사용자가 가지고 있는 index 확인
 SELECT * FROM user_indexes;
 -- 어느 컬럼에 인덱스가 있는지 확인
 SELECT * FROM user_ind_columns;
 
 --어느 인덱스가 어느 컬럼에 걸려 있는지 join해서 확인
 SELECT t.index_name, c.column_name, c.column_position
FROM user_indexes t, user_ind_columns c
WHERE t.index_name = c.index_name
    AND t.table_name = 'MYEMP';
    
--index 제거
DROP INDEX myemp_dept_id;
DROP INDEX myemp_id_unique;

SELECT * FROM user_indexes;

--sequence : 유일한 정수값을 발생시키는 객체
SELECT * FROM author;

-- 새로운 author 레코드를 추가한다고 가정
-- pk 중복 방지를 위해서 author_id의 가장 큰 값을 확인
SELECT max(author_id)+1 max_id FROM author;

--새로운 author를 추가해 봅시다
INSERT INTO author (author_id, author_name)
VALUES((SELECT max(author_id)+1 FROM author), '스티븐 킹');
SELECT * FROM author;
COMMIT;
-- 이 방식은 안전하지 않을 수 있습니다.
--sequence를 만들어서 primary key를 생성할 때 활용

-- 새 시퀀스 만들어서 연습
CREATE SEQUENCE test_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10;
    
    --시퀀스에서 값을 받아와 봅시다
SELECT test_seq.NEXTVAL FROM dual;  --새 값 생성
SELECT test_seq.CURRVAL FROM dual;
SELECT test_seq.NEXTVAL FROM dual;

--시퀀스를 변경해 봅시다
ALTER SEQUENCE test_seq
    INCREMENT BY 3 --증가값 3
    MAXVALUE 10000000;

SELECT test_seq.NEXTVAL FROM dual;

-- 사용자 시퀀스 확인
SELECT * FROM user_sequences;
SELECT * FROM user_objects
WHERE object_type='SEQUENCE';

--author의 pk를 위한 seq 작성
SELECT max(author_id) FROM author;
CREATE SEQUENCE seq_author_pk
    START WITH 4
    INCREMENT BY 1;

-- SEQUENCE를 활용한 레코드의 추가
INSERT INTO author(author_id, author_name)
VALUES(seq_author_pk.NEXTVAL, '유시민');
SELECT * FROM author;
COMMIT;

--book 테이블의 pk를 위한 sequence 생성
SELECT max(book_id) FROM book;
CREATE SEQUENCE seq_book_pk
    START WITH 3
    INCREMENT BY 1;
    SELECT * FROM user_sequences;

--시퀀스 삭제
DROP SEQUENCE test_seq;



































