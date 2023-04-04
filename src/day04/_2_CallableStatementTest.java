package day04;
/* Statement
 * 		+---PreparedStatement
 * 				+---CallableStatement
 * PL/SQL 을 호출하려면 CallableStatement를 사용함
 * 
 * -------------------------------------------
 * CREATE OR REPLACE PROCEDURE MEMO_ADD
 * (PNAME IN VARCHAR2, PMSG IN VARCHAR2)
 * IS
 * BEGIN
 * INSERT INTO MEMO(NO,NAME,MSG)
 * VALUES(MEMO_SEQ.NEXTVAL, PNAME, PMSG);
 * COMMIT;
 * END;
 * /
 * -------------------------------------------
 * 
 * */

import java.sql.*;
import common.util.*;
import javax.swing.*;

public class _2_CallableStatementTest {

	public static void main(String[] args) throws Exception {
		String name = JOptionPane.showInputDialog("작성자명을 입력하세요! : ");
		String msg = JOptionPane.showInputDialog("메모 내용을 입력하세요 : ");
		
		if(name == null || msg == null) 
			return;
		
		Connection con = DBUtil.getCon();
		
		String sql = "{call memo_add(?,?)}";
		CallableStatement cs = con.prepareCall(sql);
		// in parameter 값 setting
		
		cs.setString(1,name);
		cs.setString(2, msg);
		
		// 실행
//		int n = cs.executeUpdate();
		cs.execute();
		System.out.println("메모 글 등록 성공");
		
		cs.close();
		con.close();	
		
	}

}
