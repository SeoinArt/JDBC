package common.util;
import java.sql.*;
public class DBUtil {
	static String url = "jdbc:oracle:thin:@localhost:1521:XE";
	static String user = "scott";
	static String pwd = "tiger";
	
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Driver Loading Success!!");
		}catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	
	public static Connection getCon() throws SQLException {
		Connection con = DriverManager.getConnection(url,user,pwd);
		System.out.println("Connected!!");
		return con;
	}
	
	
	
	
}
