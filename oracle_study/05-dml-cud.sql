--insert
--author ���̺� ���� Ȯ��
DESC author;

-- insert : �� ���ڵ� �߰�
-- ��� �÷� �����͸� �ϰ� �Է��Ϸ��� ���̺��� �÷� ������ �°� ������ �Է�
INSERT INTO author
VALUES(1, '�ڰ渮', '���� �۰�');
-- Ư�� �÷��� �����ؼ� �����͸� �Է��� ��쿡�� �÷��� ����� ����
INSERT INTO author (author_id, author_name)
VALUES (2, '�迵��');
--insert update delete�� Ʈ�������� ���
-- �Ϸ�Ǳ� ���������� Ÿ ����ڴ� ���� ������ �� �� ���� 
COMMIT;

DESC book;
INSERT INTO book
VALUES(1, '����', sysdate, 1);

INSERT INTO book(book_id, title, author_id)
VALUES(2, '�������� ����', 2);

SELECT * FROM book;
ROLLBACK; -- ������� ������� ����
SELECT * FROM book;

--update
-- �迵�� �۰��� �۰� �Ұ��� ������ ���ô�
UPDATE author 
SET author_desc='�˶���� �⿬';

SELECT * FROM author;
ROLLBACK;

--update delete ���� dml�� where ���� ������ ��ü ���ڵ� ����
--�׻� ��������
UPDATE author
SET author_desc= '�˶���� �⿬'
WHERE author_id=2;

SELECT * FROM author;
COMMIT;

--HR.EMPLOYEES ���̺�κ��� mpemp��� ���̺��� ����� ���ô�
CREATE table myemp AS 
    (SELECT * FROM hr.employees);

DESC myemp;
SELECT * FROM myemp;

--delete : where�� �������� ������ ��ü ���ڵ尡 �����ǹǷ� ��������
DELETE FROM myemp
WHERE employee_id=100;

SELECT * FROM myemp;
ROLLBACK;

--delect�� truncate : ��ü ���ڵ� ����
DELETE FROM myemp; --delete�� �������ڵ带 �����ϰ� ���� ����� log�� ����
                    --> rollback ����
SELECT * FROM myemp;
ROLLBACK;
TRUNCATE TABLE myemp; --rollback �Ұ�
ROLLBACK;






























