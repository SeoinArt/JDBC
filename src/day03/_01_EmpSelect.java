package day03;

import java.sql.*;
import common.util.*;

public class _01_EmpSelect {

	public static void main(String[] args) throws Exception {
		Connection con = DBUtil.getCon();

//		String sql = "Select * from emp order by empno asc";
		String sql = "select empno, ename, rpad(job,12,' ') job,";
		sql += " rpad(mgr,10,' ') mgr,";
		sql += " hiredate, lpad(sal,10,' ') sal, lpad(comm,10,' ') comm, deptno";
		sql += " from emp order by 1";
		System.out.println(sql+"\n");
		Statement stmt = con.createStatement();

		// boolean execute(sql) : 모든 sql문 실행
		// int executeUpdate(sql) : DML 문장 실행
		// ResultSet executeQuery(sql) : DQL 문장 실행

		ResultSet rs = stmt.executeQuery(sql);

		/*
		EMPNO    NOT NULL NUMBER(4)    
		ENAME             VARCHAR2(10) 
		JOB               VARCHAR2(9)  
		MGR               NUMBER(4)    
		HIREDATE          DATE         
		SAL               NUMBER(7,2)  
		COMM              NUMBER(7,2)  
		DEPTNO            NUMBER(2)
		*/
		System.out.println("no" + "\t" + "name" + "\t" + "job" + "\t" + "\tmgr" + "\t" + "hireDate" + "\t" + "sal"
				+ "\t" + "comm" + "\t" + "deptno");

		while (rs.next()) {
			int no = rs.getInt(1);
			String name = rs.getString(2);
			String job = rs.getString(3);
			int mgr = rs.getInt(4);
			java.sql.Date hireDate = rs.getDate(5);
			int sal = rs.getInt(6);
			int comm = rs.getInt(7);
			int deptno = rs.getInt(8);

			System.out.printf("%d\t%s\t%s\t%d\t%s\t%d\t%d\t%d\n", 
					no, name, job, mgr, hireDate.toString(), sal, comm, deptno);

		}
		if (rs != null)
			rs.close();
		if (stmt != null)
			stmt.close();
		if (con != null)
			con.close();

	}

}
