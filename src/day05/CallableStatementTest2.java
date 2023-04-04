package day05;

import java.sql.*;
import common.util.*;
import javax.swing.*;

/*
 CREATE OR REPLACE PROCEDURE EMP_FORJAVA (
	    PDNO IN EMP.DEPTNO%TYPE,
	    MYCR OUT SYS_REFCURSOR
	)
	IS
	BEGIN
	    OPEN MYCR FOR
	    select ename,job,dname,loc,hiredate from
	    (SELECT * FROM EMP WHERE DEPTNO = PDNO) A JOIN DEPT D
	     ON A.DEPTNO = D.DEPTNO;
	END;
*/


public class CallableStatementTest2 {

	public static void main(String[] args) throws Exception {
		String dnoStr = JOptionPane.showInputDialog("검색할 부서 번호를 입력하세요");
		if(dnoStr.equals("")) return;
		Connection con = DBUtil.getCon();
		String sql = "{call emp_forjava(?,?)}";
		
		CallableStatement cs = con.prepareCall(sql);
		
		// in parameter값 setting
		cs.setInt(1, Integer.parseInt(dnoStr));
		
		// out parameter값 setting : registerOutParameter()
		cs.registerOutParameter(2, oracle.jdbc.OracleTypes.CURSOR);
		
		cs.execute();
		
		// cursor는 ResultSet과 호환된다.
		ResultSet rs = (ResultSet)cs.getObject(2);
		System.out.println("----------"+dnoStr+"번 부서 사원 목록 ----------");
		
		
		while(rs.next()) {
			String name = rs.getString(1);
			String job = rs.getString(2);
			String dname = rs.getString(3);
			String loc = rs.getString(4);
			java.sql.Date hiredate = rs.getDate(5);
			
			System.out.println(name+"\t"+job+"\t"+dname+"\t"+loc+"\t"+hiredate.toString());
		}
		rs.close();
		cs.close();
		con.close();
		
	}

}
