import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Jdbc6 {
    // INSERT
    public static void main(String[] args) {
        String url = "jdbc:mysql://127.0.0.1:3306/jdbc";
        String user = "root";
        String password = "1234";

        String sql = """
                INSERT INTO boards (title, content, writer, filename, filedata)
                VALUES (?, ?, ?, ?, ?)
                """;

        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            // 컬럼 타입에 맞게 값을 지정
            pstmt.setString(1, "눈 오는 날"); // 제목
            pstmt.setString(2, "함박 눈이 내리네요"); // 내용
            pstmt.setString(3, "한겨울"); // 저자
            pstmt.setString(4, "snow.jpg"); // 파일명
            FileInputStream fis = new FileInputStream("src/snow.jpg");
            pstmt.setBlob(5, fis);  // 파일데이터

            // executeUpdate() : ResultSet을 반환하지 않음
            // SQL문 실행 => 반환값 (영향을 받은 행의 수 : int)
            int rows = pstmt.executeUpdate();

            // 1 행이 삽입되었음을 나타냄
            System.out.println("반영된 행의 수 : " + rows);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
