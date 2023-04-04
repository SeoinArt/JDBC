package day04;

import java.sql.*;
import java.util.*;
import common.util.*;

// PreparedStatement 사용
public class _01_EmpFind {

	public static void main(String[] args) throws Exception {
		// 검색할 사원의 이름 키워드를 입력받아서 해당 사원정보를 출력하세요
		// 사번, 사원명, 부서명, 담당업무, 입사일, 근무지 가져와 출력하기

		Scanner sc = new Scanner(System.in);
		System.out.println("검색할 사원의 이름 키워드를 입력하세요");
		String name = sc.nextLine();

		String sql = "select e.empno, e.ename, lpad(d.dname,10,' '), rpad(e.job,10,' '), rpad(hiredate,15,' ') , d.loc ";
		sql += "from emp e join dept d on e.deptno = d.deptno ";
		sql += "where ename like ?";
		
		
		System.out.println(sql);
		
		Connection con = DBUtil.getCon();
		
		
		PreparedStatement ps = con.prepareStatement(sql);
		
		ps.setString(1,"%"+name+"%");
		
		ResultSet rs = ps.executeQuery();
		
		int cnt=0;
		while(rs.next()) {
			cnt++;
			int empno = rs.getInt(1);
			String ename = rs.getString(2);
			String dname = rs.getString(3);
			String job = rs.getString(4);
			String hdate = rs.getString(5);
			String loc = rs.getString(6);
			System.out.println(empno+"\t"+ename+"\t"+dname+"\t"+job+"\t"+hdate+"\t"+loc);
		}
		if(cnt ==0) System.out.println("검색한 사원의 정보는 없습니다");
		if(rs!= null) rs.close();
		if (ps != null)
			ps.close();
		if (con != null)
			con.close();
	}
}
