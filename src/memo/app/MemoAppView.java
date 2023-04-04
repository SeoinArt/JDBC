package memo.app;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class MemoAppView extends JFrame {

	Container cp;
	JPanel pN = new JPanel(new GridLayout(2, 1)); // 2행 1열
	JPanel pS = new JPanel(); // FlowLayout 남쪽
	JTextArea ta; // 중앙

	
	JPanel pN_sub = new JPanel(new GridLayout(2,1));
	JPanel pN_sub_1 = new JPanel();
	JPanel pN_sub_2 = new JPanel();
	
	JLabel lbTitle, lbName, lbDate, lbNo, lbMsg;
	JButton btAdd, btList, btDel, btEdit, btEditEnd, btFind;

	JTextField tfName, tfDate, tfNo, tfMsg;

	public MemoAppView() {
		super("::MemoAppView::");
		cp = this.getContentPane();

		ta = new JTextArea("::한줄 메모장::");
		JScrollPane sp = new JScrollPane(ta);
		cp.add(sp, "Center");

		cp.add(pN, "North");
		cp.add(pS, "South");

		ta.setEditable(false); // 편집 불가 (읽기 전용)

		lbTitle = new JLabel("♥♥ 한줄 메모장 ♥♥ ", JLabel.CENTER);
		lbTitle.setFont(new Font("Serif", Font.BOLD, 28));
		pN.add(lbTitle);
		
		pN.add(pN_sub);
		pN_sub.add(pN_sub_1);
		pN_sub.add(pN_sub_2);
		
		
		pN_sub_1.setLayout(new FlowLayout(FlowLayout.LEFT));
		pN_sub_1.add(lbName = new JLabel("작성자: "));
		pN_sub_1.add(tfName = new JTextField(15));
		
		pN_sub_1.add(lbDate = new JLabel("작성일: "));
		pN_sub_1.add(tfDate = new JTextField(10));
		
		
		pN_sub_1.add(lbNo = new JLabel("글 번호: "));
		pN_sub_1.add(tfNo = new JTextField(10));
		
		
		pN_sub_2.setLayout(new FlowLayout(FlowLayout.LEFT));
		pN_sub_2.add(lbMsg = new JLabel("메모 내용: "));
		pN_sub_2.add(tfMsg = new JTextField(40));
		pN_sub_2.add(btAdd = new JButton("글 등록"));
		pN_sub_2.add(btList = new JButton("글 목록"));
		
		
		
		
		
		
		
		
		
		
		
		
		tfDate.setEditable(false);
		tfDate.setForeground(Color.blue);
		tfDate.setFont(new Font("Serif",Font.BOLD,14));
		tfDate.setHorizontalAlignment(JTextField.CENTER);
		tfDate.setText("2023-03-31");
		tfNo.setEditable(false);
		
		
		
		
		
		

		pS.add(btDel = new JButton("글 삭제"));
		pS.add(btEdit = new JButton("글 수정"));
		pS.add(btEditEnd = new JButton("글 수정 처리"));
		pS.add(btFind = new JButton("글 검색"));
		

		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}

	public static void main(String[] args) {
		MemoAppView my = new MemoAppView();
		my.setSize(800, 500);
		my.setVisible(true);
	}

}
