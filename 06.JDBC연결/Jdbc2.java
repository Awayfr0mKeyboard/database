import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Jdbc2 {
    public static void main(String[] args) {
        // 데이터베이스 연결
        // 프로토콜:서브프로토콜://호스트이름:포트번호/DB이름
        String url = "jdbc:mysql://127.0.0.1:3306/scott";
        String user = "root";
        String password = "1234";

        Connection connection = null;

        try {
            // Driver 관리자가 자동으로 드라이버를 찾아서 로드
            // getConnection을 통해 연결 객체를 반환
            connection = DriverManager.getConnection(url, user, password);
            if (connection != null) {
                System.out.println("데이터베이스 성공적으로 연결");
            } else {
                System.out.println("데이터베이스 연결 객체 null");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                // DB 연결 종료 : 리소스 해제 메모리 반환
                connection.close();
                System.out.println("데이터베이스 연결 종료");
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
