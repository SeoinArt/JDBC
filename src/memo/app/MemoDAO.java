package memo.app;

import java.sql.*;
import common.util.*;
import java.util.*;

/**
 * @author a 영속성 계층 (Persistence Layer)에 속함 DAO ( Data Access Object) : 데이터에
 *         접근해서 CRUD의 로직을 수행하는 객체 => Model
 */

public class MemoDAO {
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;

	/**
	 * 한줄 메모장에 insert문을 수행하는 메서드 (C)
	 */

	public int insertMemo(MemoVo memo) throws SQLException {
		try {
			con = DBUtil.getCon();
			// String : 불변성 (immutable) => 원본은 불변함
			// StringBuffer , StringBuilder : 문자열 편집 작업이 가능한 클래스 => 문자열을 메모리 버퍼에 넣고 수정, 삽입, 삭제 등을 수행함
			StringBuilder buf = new StringBuilder("insert into memo(no,name,msg,wdate)")
					.append(" values(memo_seq.nextval, ?, ?,sysdate)");
			String sql = buf.toString();
			
			ps =con.prepareStatement(sql);
			ps.setString(1, memo.getName());
			ps.setString(2, memo.getMsg());
			
			int n = ps.executeUpdate();
			return n;
			

		} finally {
			// db 연결 자원 반납
			close();

		}
	}// ---------------------------------------	
	
	/** 전체 메글을 가져오는 메서드
	 * 
	 */
	
	public  List<MemoVo>listMemo() throws SQLException{
		try {
			con = DBUtil.getCon();
			StringBuilder buf = new StringBuilder("SELECT rpad(no,10,' ') no, rpad(name,10,' ') name,");
			buf.append( "rpad(msg,120,' ') msg, wdate FROM memo ORDER BY no DESC ");
			String sql = buf.toString();
			
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			List<MemoVo> arr = new ArrayList<>();
			while(rs.next()) {
				int no = rs.getInt("no");
				String name = rs.getString("name");
				String msg = rs.getString("msg");
				java.sql.Date date = rs.getDate("wdate");
				
				MemoVo memo = new MemoVo(no,name,msg,date);
				arr.add(memo);
			}
			
			return arr;
			
		}finally {
			close();
		}
		
	}
	
	
	
	
	/**
	 * DB관련한 자원들을 반납하는 메서드
	 */
	public void close() {
		try {
			if (rs != null) rs.close();
			if (ps != null) ps.close();
			if (con != null) con.close();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// ---------------------------------------
}
