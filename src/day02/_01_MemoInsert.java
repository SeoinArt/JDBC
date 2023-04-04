package day02;

import java.util.*;
import java.sql.*;

public class _01_MemoInsert {
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		Scanner sc = new Scanner(System.in);
		
		System.out.println("작성자: ");
		String name = sc.nextLine();
		
		System.out.println("메모 내용: ");
		String msg = sc.nextLine();
		
		System.out.println(name +"/"+msg);
		
		// 1. 드라이버 로딩
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("드라이버 로딩 완료"); 
		
		// 2. DB 연결
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
		String user = "scott";
		String pwd = "tiger";
		
		Connection con = DriverManager.getConnection(url, user, pwd);
		System.out.println("connected!!");
		
		// 3. SQL 작성
		String sql ="insert into memo(no,name,msg) values( MEMO_SEQ.NEXTVAL, '"+name+"','" +msg+"')" ;
		System.out.println(sql);
		
		// 4. Statement 얻기
		Statement stat = con.createStatement();
		
		// 5. execute() 호출
//		stat.execute(sql);
		int b = stat.executeUpdate(sql);
		// execute : 모든 sql문을 실행시킨다.
		// public int executeUpdate(String sql) 
		// : insert, delete, update문을 실행시키고자 할 때 사용 (sql문에 의해 영향받은 레코드 개수를 반환한다.)
		System.out.println(b+"개의 레코드를 등록했어요!!");
		System.out.println((b>0)? "글쓰기 성공":"글쓰기 실패");
		
		
		
		System.out.println("데이터 삽입 성공!!");
		
		// 6. DB 자원 반납
		if(stat !=null) stat.close();
		if(con != null ) con.close();
	}
}
