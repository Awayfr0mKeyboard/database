public class Jdbc1 {
    // JDBC(Java DataBase Connectivity)
    // 자바앱에서 DB에 접근하고 조작할 수 있게 해주는 인터페이스
    
    // 각 Driver 는 제조사에 따라 다름, 인터페이스는 독립적

    // JDBC 드라이버 로딩 확인
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("드라이버를 성공적으로 불러왔습니다.");

        } catch (ClassNotFoundException e) {
            System.out.println("드라이버 클래스를 찾을 수 없습니다.");
            throw new RuntimeException(e);
        }
    }

}
