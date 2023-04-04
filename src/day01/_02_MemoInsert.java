package day01;

import java.sql.*;
import java.util.Scanner;

public class _02_MemoInsert {
	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		Scanner sc =new Scanner(System.in);
		// 1, Driver 로딩
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("driver 연결 ");
		
		// 2. DB 연결
		String url ="jdbc:oracle:thin:@127.0.0.1:1521:XE";
		String id = "scott";
		String pwd = "tiger";
		
		Connection con = DriverManager.getConnection(url,id,pwd);
		System.out.println("connected");
		
		/* CREATE SEQUENCE MEMO_SEQ
		   START WITH 1
		   INCREMENT BY 1;
		*/
		
		// 3. SQL문 작성
		String str = "insert into memo values ( MEMO_SEQ.NEXTVAL, ";
		str+= "'"+sc.next()+"', ";
		sc.nextLine();
		str+= "'"+sc.nextLine()+"', ";
		str+= "sysdate ) ";
		
		System.out.println(str);
		
		// 4. Statement 얻어오기
		Statement stmt = con.createStatement();
		
		// 5. execute() 호출
		stmt.execute(str);
		System.out.println("데이터 삽입 성공");
		
		// DB 연결 자원 반납
		if(stmt!=null) stmt.close();
		if(con!=null) con.close();
		
	}
}
