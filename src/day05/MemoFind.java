package day05;

import java.sql.*;
import common.util.*;
import javax.swing.*;

// 검색어를 입력하면 검색어를 갖는 메모글을 가져오는 프로시저를 작성하고 자바와 연동시키세요
/*
CREATE OR REPLACE PROCEDURE MEMO_SE(
	    CMSG IN MEMO.MSG%TYPE,
	    MOCR OUT SYS_REFCURSOR)
	IS 
	BEGIN
	    OPEN MOCR FOR
	    SELECT no,name,msg,wdate 
	    FROM MEMO 
	    WHERE MSG LIKE '%'||CMSG||'%';
	END;
	/
*/	
public class MemoFind {

	public static void main(String[] args) throws Exception {

		String smsg = JOptionPane.showInputDialog("검색어를 입력해주세요");

		Connection con = DBUtil.getCon();
		System.out.println(smsg);
		String sql = "{call memo_se(?,?)}";

		CallableStatement cb = con.prepareCall(sql);
		cb.setString(1, smsg);
		cb.registerOutParameter(2, oracle.jdbc.OracleTypes.CURSOR);

		cb.execute();

		ResultSet rs = (ResultSet) cb.getObject(2);

		while (rs.next()) {
			int no = rs.getInt(1);
			String name = rs.getString(2);
			String msg = rs.getString(3);
			java.util.Date date = rs.getDate(4);
			System.out.println(no + "\t" + name + "\t" + msg+"\t"+date);
		}
		rs.close();
		cb.close();
		con.close();		
	}
}
