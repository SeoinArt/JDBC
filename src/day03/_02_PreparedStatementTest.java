package day03;
import java.sql.*;
import common.util.*;
import java.util.*;
/* Statement
	+ PreparedStatement
	: sql문을 미리 dbms 포맷에 맞게 컴파일 시켜서 준비시켜 놓는다.
	: Statement 보다 DB 연동하는 속도가 훨씬 빠르다.
*/ 

public class _02_PreparedStatementTest {

	public static void main(String[] args) throws Exception {
		Scanner sc = new Scanner(System.in);
		Connection con = DBUtil.getCon();
		
		// 메모글을 수정하는 문장을 삭정해봅시다.
		System.out.println();
		System.out.print("작성자 : ");
		String name =sc.nextLine();
		System.out.print("수정할 메모 내용 : ");
		String msg = sc.nextLine();
		
		
		String sql = "update memo set msg = ?, wdate = sysdate where name = ? ";
		// ? : IN PARAMETER : 변경될 값을 인 파라미터로 넣어준다.
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		// IN PARAMETER 값을 SETTING
		ps.setString(1, msg);
		ps.setString(2, name);
		
		int n = ps.executeUpdate();
		System.out.println(n+"개의 레코드를 수정하였습니다.");
		
		if(ps!= null)ps.close();
		if(con!= null)ps.close();
		if(sc!=null)sc.close();
	}
}
