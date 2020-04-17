--insert
--author 테이블 구조 확인
DESC author;

-- insert : 새 레코드 추가
-- 모든 컬럼 데이터를 일괄 입력하려면 테이블의 컬럼 구조에 맞게 데이터 입력
INSERT INTO author
VALUES(1, '박경리', '토지 작가');
-- 특정 컬럼을 지정해서 데이터를 입력할 경우에는 컬럼의 목록을 제시
INSERT INTO author (author_id, author_name)
VALUES (2, '김영하');
--insert update delete는 트렉젝션의 대상
-- 완료되기 이전까지는 타 사용자는 변경 내용을 볼 수 없다 
COMMIT;

DESC book;
INSERT INTO book
VALUES(1, '토지', sysdate, 1);

INSERT INTO book(book_id, title, author_id)
VALUES(2, '살인자의 기억법', 2);

SELECT * FROM book;
ROLLBACK; -- 변경사항 원래대로 복구
SELECT * FROM book;

--update
-- 김영하 작가의 작가 소개를 변경해 봅시다
UPDATE author 
SET author_desc='알뜰신잡 출연';

SELECT * FROM author;
ROLLBACK;

--update delete 등의 dml은 where 절이 없으면 전체 레코드 변경
--항상 주의하자
UPDATE author
SET author_desc= '알뜰신잡 출연'
WHERE author_id=2;

SELECT * FROM author;
COMMIT;

--HR.EMPLOYEES 테이블로부터 mpemp라는 테이블을 만들어 봅시다
CREATE table myemp AS 
    (SELECT * FROM hr.employees);

DESC myemp;
SELECT * FROM myemp;

--delete : where을 지정하지 않으면 전체 레코드가 삭제되므로 주의하자
DELETE FROM myemp
WHERE employee_id=100;

SELECT * FROM myemp;
ROLLBACK;

--delect와 truncate : 전체 레코드 삭제
DELETE FROM myemp; --delete는 개별레코드를 삭제하고 삭제 기록을 log로 보관
                    --> rollback 가능
SELECT * FROM myemp;
ROLLBACK;
TRUNCATE TABLE myemp; --rollback 불가
ROLLBACK;






























