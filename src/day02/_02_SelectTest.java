package day02;

import java.sql.*;
import common.util.*;

public class _02_SelectTest {

	public static void main(String[] args) throws SQLException {
		Connection con = DBUtil.getCon();
//		System.out.println(con);

		String sql = "SELECT no, name, msg, wdate FROM memo ORDER BY no DESC";
		Statement st = con.createStatement();
		boolean b = st.execute(sql);
		System.out.println(b);

		if (b) { // select문일 경우 => 결과 테이블이 존재 (ResultSet)
			ResultSet rs = st.getResultSet();
			
			// boolean next()
			while(rs.next()) {
				int no = rs.getInt("no"); // 컬럼명 || 컬럼 인덱스(1부터 시작)
				String name = rs.getString("name");
				String msg = rs.getString("msg");
				java.sql.Date wdate = rs.getDate("wdate");
				System.out.println(no+"\t"+name+"\t"+msg+"\t"+wdate);
			}
			if(rs!=null) rs.close();
			
		} else {
			// select문이 아닐 경우
			int n = st.getUpdateCount();
			System.out.println(n+"개의 레코드가 변경되었습니다.");
		}

		if (st != null)
			st.close();
		if (con != null)
			con.close();

	}

}
