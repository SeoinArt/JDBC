package memo.app;

import java.awt.event.*;
import java.sql.SQLException;
import java.util.*;

/**
 * @author a Controller View 쪽에서 이벤트가 발생하면 이벤트를 처리한다. ==> DB 관련 작업이 존재하면 DAO 객체를
 *         통해 작업을 수행한다. Model과 View 사이에서 제어하는 역할을 수행한다.
 */

public class MemoHandler implements ActionListener {
	MemoAppView app; // View
	MemoDAO dao = new MemoDAO();
	MemoVo vo;

	public MemoHandler(MemoAppView mav) {
		this.app = mav;
	}
	@Override
	public void actionPerformed(ActionEvent e) {
//		System.out.println("event 처리 중...");
// 		MemoAppView타이틀에 "event 처리 중 ..." 출력

//		app.setTitle("event 처리 중 ...");
		Object obj = e.getSource();
		if (obj == app.btAdd) {
			addMemo();
			app.clearInput();
		}else if (obj == app.btList) {
			listMemo();
		}
		
		
		
//		MemoAppView app = new MemoAppView();
//		app.setTitle("event 처리 중 ...");
//		app.setSize(400,300);
//		app.setVisible(true);
	}

	public void listMemo() {
		try {
			List<MemoVo> arr = dao.listMemo();
			app.setTitle("전체 글 갯수 : "+arr.size()+"개 입니다.");
			// 모델 (dao)를 통해서 받아온 데이터를 화면단(app)에게 넘겨준다.
			app.showTextArea(arr);
		}catch(SQLException e) {
			app.showMessage(e.getMessage());
		}
	}//-------------------------------
	
	
	
	public void addMemo() {
		// [1] app 의 tfName, tfMsg에 입력한 값 얻어오기
		String name = app.tfName.getText();
		String msg = app.tfMsg.getText();

		// [2] 유효성 체크(null, 빈 문자열 체크
		if (name == null || msg == null || name.trim().isEmpty() || msg.trim().isEmpty()) {
			app.showMessage("작성자와 메모 내용을 입력해야 해요");
			app.tfName.requestFocus();
			return;
		}

		// [3] [1] 번에서 받은 값을 MemoVo객체에 담아준다
		MemoVo memo = new MemoVo(0, name, msg, null);
		try {
			// [4] Dao의 insertMemo()호출한다
			int result = dao.insertMemo(memo);
			// [5] 그 결과값에 따라 메시지 처리
			if (result>0) app.setTitle("글 등록 성공");
			else app.showMessage("글 등록을 실패");
		} catch (SQLException e) {
			app.showMessage(e.getMessage());
		}

	}

}
