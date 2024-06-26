-- 03_트리거
/*
 데이터베이스에서 특정 이벤트가 발생할 때 자동으로 실행되는 프로시저
  - BEFORE : 이벤트가 발생하기 전
  - AFTER : 이벤트가 발생한 후
  - INSERT | UPDATE | DELETE : 이벤트
*/
USE sqldb;

-- 사용자 기록을 남기는 기록 테이블
CREATE TABLE user_log (
	log_id INT AUTO_INCREMENT PRIMARY KEY,
    userId CHAR(8),			-- 사용자 ID
    action VARCHAR(10),		-- 발생한 액션
    action_time TIMESTAMP	-- 액션이 발생한 시간
);

-- 트리거 생성
DELIMITER $$
CREATE TRIGGER after_user_insert
	AFTER INSERT ON usertbl
    FOR EACH ROW
BEGIN
	-- usertbl의 각 행에 삽입 이벤트 발생 후 수행
	-- 이벤트 발생시 수행할 SQL문 (프로시저)
    INSERT INTO user_log (userId, action, action_time)
      VALUES (NEW.userID, 'INSERT', now());
END $$
DELIMITER ;

SELECT * FROM usertbl;
-- usertbl에 INSERT 이벤트가 발생하면
INSERT INTO usertbl
	VALUES ('TEST3', '테스트', 2000, '부산', '010', '12345678', '180', '2024-06-26');
-- 트리거가 동작 (로그 테이블에 자동 삽입 프로시저 수행됨)
SELECT * FROM user_log;

-- 삭제 이벤트 발생 시 동작하는 트리거
DELIMITER $$
CREATE TRIGGER after_user_delete
	AFTER DELETE ON usertbl
    FOR EACH ROW
BEGIN
	-- usertbl의 각 행에 삭제 이벤트 발생 후 수행
	-- 이벤트 발생시 수행할 SQL문 (프로시저)
    INSERT INTO user_log (userId, action, action_time)
      VALUES (OLD.userID, 'DELETE', now());
END $$
DELIMITER ;

-- 삭제 이벤트가 발생하면 트리거 동작
DELETE FROM usertbl WHERE userID = 'TEST';
-- user_log 테이블에 기록이 남음
SELECT * FROM user_log;

-- 트리거 목록 확인
SHOW TRIGGERS FROM sqldb;

-- 트리거 삭제하기
DROP TRIGGER after_user_delete;