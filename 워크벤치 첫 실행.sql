-- 쿼리창 (우측 상단)
-- 번개모양 클릭 : 쿼리창의 모든 쿼리를 실행
-- 범위를 지정하고 번개 모양 클릭 : 범위 쿼리 실행
-- 단축키 Ctrl + Shift + Enter

-- 번개 모양 커서 : 커서가 있는 한 줄만 쿼리 실행
-- 단축키 Ctrl + Enter

-- 스키마 제거
DROP SCHEMA IF EXISTS shopDB;
-- 스키마 생성
CREATE SCHEMA shopDB;
-- 하단 실행 결과 (Output 창)
-- 초록색 : 쿼리 실행 성공
-- 빨간색 : 쿼리 실행 실패(에러 메시지 확인)

-- 왼쪽 상단 SCHEMAS 창에서
-- 새로고침 버튼을 누르면 갱신

CREATE SCHEMA shopDB;