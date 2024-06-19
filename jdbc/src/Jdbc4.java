import java.sql.*;

public class Jdbc4 {
    // 자원정리 (try-with-resource 구문)
    public static void main(String[] args) {
        String url = "jdbc:mysql://127.0.0.1:3306/scott";
        String user = "root";
        String password = "1234";

        try (
                Connection conn = DriverManager.getConnection(url, user, password);
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM emp");
        ) {
            while (rs.next()) {
                // 컬럼 라벨(이름)을 기준으로 데이터 가져오기
                String ename = rs.getString("ename");
                int empno = rs.getInt("empno");

                // 컬럼 순서(인덱스)를 기준으로 데이터 가져오기
                int empnoIndex = rs.getInt(1);
                System.out.printf("%d %s %d %n", empno, ename, empnoIndex);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } // close 사용하지 않아도 try 문 종료와 함께 자원이 정리

    }
}