package ex;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ex1 {

    public static void main(String[] args) {
        // jdbc 데이터베이스 users 테이블에 INSERT 문으로 user 정보를 삽입하는 코드를 작성하세요.
        String url = "jdbc:mysql://127.0.0.1:3306/jdbc";
        String user = "root";
        String password = "1234";

        String sql = """
                INSERT INTO users (userId, username, password, age, email)
                VALUES (?, ?, ?, ?, ?)
                """;

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setString(1, "ss"); // 아이디
            pstmt.setString(2, "ㄴㄴ"); // 이름
            pstmt.setString(3, "123"); // 패스워드
            pstmt.setInt(4, 20); // 나이
            pstmt.setString(5, "ss@naver.com"); // 이메일

            // executeUpdate() : ResultSet 을 반환하지 않음
            // SQL 문 실행 => 반환값 (영향을 받은 행의 수 : int)
            int rows = pstmt.executeUpdate();

            System.out.println("반영된 행의 수 : " + rows);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
