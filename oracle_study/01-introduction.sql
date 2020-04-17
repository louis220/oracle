-- APEX port
-- APEX와 HTTPPORT 확인

SELECT DBMS_XDB.gethttpport() FROM DUAL;

-- APEX 포트 변경(Apache Tomcat 때문)
exec dbms_xdb.sethttpport(8090);

-- hr 계정 사용 가능하게 (unlock)
select username, account_status from dba_users where username='HR';

-- hr  계쩡 잠금 해제
alter user hr identified by hr account unlock; 