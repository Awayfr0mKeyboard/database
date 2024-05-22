-- 사용자 생성 및 권한 부여

-- 1. 사용자 생성
-- [Adiministration] -> [Users and privileges]
-- [Add Account] 를 클릭하여 추가 가능


CREATE USER 'username'@'%' IDENTIFIED BY 'password';
-- username : 생성할 사용자 이름
-- '%' : 사용자가 접속할 호스트
	-- '%' : 모든 호스트에서 접속 가능
    -- 'localhost' : 로컬에서만 접속 가능
    -- 'xxx.xxx.xxx.xxx' : 특정 IP에서만 접속 가능
-- password : 사용할 비밀번호

SELECT host, user FROM mysql.user;			-- 모든 사용자와 호스트 확인

-- 사용자 삭제하기
DROP USER 'username'@'%';

-- 권한 부여하기
CREATE USER 'user1'@'localhost' IDENTIFIED BY '12345';

-- GRANT
-- GRANT 권한 ON DB객체.TABLE객체 TO 사용자
	-- 권한 : ALL PRIVILEGES(모든 권한), SELECT 등...
    -- 객체 : *.*(모든 DB).(모든 테이블)
    -- 사용자 : '유저이름'@'호스트'
GRANT ALL PRIVILEGES ON *.* TO 'user1'@'localhost';
	
    -- WITH GRANT OPTION : 사용자가 부여받은 권한을 다른 사용자에게도 부여할 수 있게 허용
CREATE USER 'user2'@'localhost' IDENTIFIED BY '12345';
GRANT ALL PRIVILEGES ON *.* TO 'user2'@'localhost' WITH GRANT OPTION;

-- 모든 데이터베이스에 SELECT 권한을 부여
CREATE USER 'user3'@'localhost' IDENTIFIED BY '12345';
GRANT SELECT ON *.* TO 'user3'@'localhost';

-- employees 데이터베이스에 SELECT 권한을 부여
CREATE USER 'user4'@'localhost' IDENTIFIED BY '12345';
GRANT SELECT ON employees.* TO 'user4'@'localhost';

-- shopdb 데이터베이스에 INSERT, UPDATE, DELETE, SELECT 권한 부여
GRANT INSERT, UPDATE, DELETE, SELECT ON shopdb.* TO 'user4'@'localhost';

-- 특정 테이블(sakila.actor)에 대한 SELECT 권한을 부여
GRANT SELECT ON skaila.actor TO 'user4'@'localhost';

-- 권한 회수 REVOKE
-- REVOKE 권한 ON DB객체.TABLE객체 FROM 사용자

-- user4번의 employees 테이블 조회(SELECT) 권한 회수
REVOKE SELECT ON employees.* FROM 'user4'@'localhost';

-- user4번의 shopdb의 테이블 조회(INSERT, DELETE)권한 회수
REVOKE INSERT, DELETE ON shopdb.* FROM 'user4'@'localhost';

-- user1번의 모든 권한을 회수
REVOKE ALL PRIVILEGES ON *.* FROM 'user1'@'localhost';

-- 사용자 삭제
DROP USER 'user1'@'localhost';
DROP USER 'user2'@'localhost';
DROP USER 'user3'@'localhost';
DROP USER 'user4'@'localhost';