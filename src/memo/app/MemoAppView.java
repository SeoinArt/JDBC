package memo.app;

import javax.swing.*;

import java.awt.*;
import java.awt.event.*;
import java.util.*;
import java.text.*;

/**
 * ---------------------------------
 * @author 박서인
 * 작성일 : 2023-04-05
 * 버 전 : 1.1
 * 한줄 메모장 애플리케이션의 화면을 담당하는 클래스
 * ---------------------------------
 * 
 * MFC(c++),JFC(java swing)
 * MVC 패턴===> 웹 mvc패턴 도입
 * 
 * 모델1 방식 : mvc패턴을 적용하지 않을 때
 * 모델2 방식 : mvc패턴 적용
 * 
 * Model  :  DB접근 로직(DB처리 로직을 갖는다. CRUD) [Persistence Layer-영속성 계층]
 * 			 VO(Value Object, DTO (Data Transfer Object),  DAO (Data Access Object) : DB에 접근해서 CRUD 로직을 수행함. 
 * View   :  화면단 (Presentatioin Layer) - Swing, HTML(JSP)
 * 
 * Controller: Model View사이에서 제어하는 역할을 담당하는 계층. Event Handler,  Servlet/SpringFramework Controller
 * 
 * MemoAppView:=> GUI /View 담당 [Presentatioin Layer]
 * XXXDAO: DB접근 로직(DB처리 로직을 갖는다. CRUD)
 * 		   Data Access Object  [Persistence Layer-영속성 계층]
 * XXXVO/XXXDTO [Domain Layer]
 *  Value Object/ Data Transfer Object : 사용자가 입력한 값을 담거나 DB에서 가져온 값을 갖고 있는 객체
 */



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
	
	MemoHandler handler; // controller

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
		String date = this.getSysDate();
		tfDate.setText(date);
		tfNo.setEditable(false);
		
		pS.add(btDel = new JButton("글 삭제"));
		pS.add(btEdit = new JButton("글 수정"));
		pS.add(btEditEnd = new JButton("글 수정 처리"));
		pS.add(btFind = new JButton("글 검색"));
		
		// 리스너 부착 -----------
		// MemoHandler와 MemoAppView가 연동하기 위해서는 생성자에서 this를 넘겨준다.
		handler = new MemoHandler(this);
		btAdd.addActionListener(handler);
		btList.addActionListener(handler);
		btDel.addActionListener(handler);
		btEdit.addActionListener(handler);
		btEditEnd.addActionListener(handler);
		btFind.addActionListener(handler);
		
		
		

		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	
	/** 메시지를 대화창에 보여주는 메서드
	 **/
	
	public void showMessage(String str) {
		JOptionPane.showMessageDialog(this, str);
	}// -----------------------------------------
	
	/* 입력 필드를 모두 빈 문자열로 초기화하는 메서드
	 * */
	public void clearInput() {
		tfNo.setText("");
		tfName.setText("");
		tfMsg.setText("");
		tfDate.setText("");
	}// --------------------------------------------
	
	
	
	// 생성자 ------
	// 현재 날짜를 yyyy-MM-dd 포맷의 문자열로 변환하여 반환하는 메서드
	
	public String getSysDate() {
		Date today = new Date(); // java.util.Date 
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(today);
		return str;
		/*  java  => yy : 년도 MM: 월 dd : 일  hh : 시간 mm : 분 ss : 초
		 * Oracle => yy : 년도 mm: 월 dd : 일  hh : 시간 mi : 분 ss : 초
		 */
	}

	public static void main(String[] args) {
		MemoAppView my = new MemoAppView();
		my.setSize(800, 500);
		my.setVisible(true);
	}

}
