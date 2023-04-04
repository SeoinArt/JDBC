package day04;

import javax.swing.*;
import java.sql.*;
import common.util.*;


public class _03_MemoUpdate {

	public static void main(String[] args) throws Exception {
		String no = JOptionPane.showInputDialog("수정할 글 번호를 입력하세요");
		String name = JOptionPane.showInputDialog("작성자명을 입력하세요!");
		String msg = JOptionPane.showInputDialog("메모 내용을 입력하세요");
		
		if(no.equals("") || name.equals("")|| msg.equals("")) {
			System.out.println(no);
			return;
		}
		Connection con = DBUtil.getCon();
		String sql = "{call memo_edit(?,?,?)}";
		
		CallableStatement cs = con.prepareCall(sql);
		cs.setInt(1, Integer.parseInt(no));
		cs.setString(2, name);
		cs.setString(3, msg);
		
		cs.executeUpdate();
		System.out.println(no+"번째 글이 수정되었습니다");
		
		cs.close();
		con.close();
	}
}
