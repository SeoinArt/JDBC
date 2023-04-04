package day03;

import java.sql.*;
import java.util.*;
import common.util.*;

public class _03_EmpInsert {
	public static void main(String[] args) throws Exception {
		// emp 테이블에 사번, 이름, 업무 , 부서번호, 급여를 입력받아서 insert문을 실행시키세요
		// PreparedStatement 사용!!

		Scanner sc = new Scanner(System.in);
		Connection con = DBUtil.getCon();

		System.out.println("사번 : ");
		int empno = sc.nextInt();
		sc.nextLine();
		System.out.println("이름 : ");
		String ename = sc.nextLine();

		System.out.println("업무 : ");
		String job = sc.nextLine();

		System.out.println("부서번호 : ");
		int deptno = sc.nextInt();

		System.out.println("급여 : ");
		int sal = sc.nextInt();

		System.out.println(empno + ename + job + deptno + sal);

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
		
		String sql = "insert into emp(empno, ename, job, hiredate, deptno, sal) values (?,?,?,sysdate,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, empno);
		ps.setString(2, ename);
		ps.setString(3, job);
		ps.setInt(4, deptno);
		ps.setInt(5, sal);

		int n = ps.executeUpdate();
		System.out.println(n + "개의 레코드를 수정하였습니다.");

		if (ps != null)
			ps.close();
		if (con != null)
			con.close();
		if (sc != null)
			sc.close();

	}
}
