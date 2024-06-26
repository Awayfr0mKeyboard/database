import java.sql.*;

public class Jdbc5 {
    // PrepareStatement
    public static void main(String[] args) {
        String url = "jdbc:mysql://127.0.0.1:3306/scott";
        String user = "root";
        String password = "1234";

        // 동적 쿼리
        String sql = "SELECT * FROM emp WHERE deptno = ?";

        try (
                Connection conn = DriverManager.getConnection(url, user, password);
                // 1. Prepare 문 준비
                PreparedStatement pstmt = conn.prepareStatement(sql);
        ) {
            // 2. 변수 설정
            // setXXX(?의 순서(인덱스, 설정할 값)
            pstmt.setInt(1, 20);
            // 3. 쿼리문 실행
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                // 결과 셋에서 데이터 가져와 출력
                String ename = rs.getString("ename");
                int deptno = rs.getInt("deptno");
                System.out.printf("%s  %d\n", ename, deptno);
            }
            rs.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } // 4. 메모리 해제 (close 또는 try-with-resource)

    }
}