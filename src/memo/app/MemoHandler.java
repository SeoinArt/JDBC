package memo.app;

import java.awt.event.*;
import java.sql.SQLException;
import java.util.*;

import javax.swing.JOptionPane;

/**
 * @author Controller View 쪽에서 이벤트가 발생하면 이벤트를 처리한다. ==> DB 관련 작업이 존재하면 DAO 객체를
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
			listMemo();// 전체 목록 출력
		} else if (obj == app.btList) {
			listMemo();
		} else if (obj == app.btDel) {
			deleteMemo();
			listMemo();
		} else if (obj == app.btEdit) {
			// 글 수정
			editMemo();
		} else if (obj == app.btEditEnd) {
			// 글 수정 처리
			editMemoEnd();
			app.clearInput();
			listMemo();
		} else if (obj == app.btFind) {
			// 글 내용 검색 - 키워드 검색
			findMemo();
		}

	}

	public void findMemo() {
		String keyword = app.showInputDialog("검색할 키워드를 입력하세요");
		if (keyword == null)
			return;
		if (keyword.trim().isEmpty()) {
			findMemo(); // 재귀호출
			return;
		}
		try {
			List<MemoVo> arr = dao.findMemo(keyword);
			if (arr == null || arr.size() == 0) {
				app.showMessage(keyword + "로 검색한 결과 해당 글은 없어요");
				return;
			}
			app.showTextArea(arr);
		} catch (SQLException e) {
			e.printStackTrace();
			app.showMessage(e.getMessage());
		}

	}

	public void editMemo() {
		// 글 번호로 해당 글 가져오기 => select문 where 절 =>결과는 단일행 레코드
		String noStr = app.showInputDialog("수정할 글 번호를 입력하세요");
		if (noStr == null)
			return;
		try {
			MemoVo vo = dao.selectMemo(Integer.parseInt(noStr.trim()));
			if (vo == null) {
				app.showMessage(noStr + "번 글은 존재하지 않아요");
				return;
			}
			app.setText(vo);

		} catch (SQLException e) {
			app.showMessage(e.getMessage());
		}
	}

	public void editMemoEnd() {
		// 1. 사용자가 입력한 값 받아오기 (no, name, msg)
		String noStr = app.tfNo.getText();
		String nameStr = app.tfName.getText();
		String msgStr = app.tfMsg.getText();
		// 2. 유효성 체크
		if (noStr == null || nameStr == null || msgStr == null || noStr.trim().isEmpty() || nameStr.trim().isEmpty()
				|| msgStr.trim().isEmpty()) {
			app.showMessage("작성자와 글 번호는 반드시 입력해야해요");
			return;
		}
		// 3. 1번에서 얻은 값을 MemoVo객체에 담아주기
		MemoVo mo = new MemoVo(Integer.parseInt(noStr.trim()), nameStr, msgStr);

		// 4. dao의 updateMemo 호출하기
		try {
			int res = dao.updateMemo(mo);

			// 5. 그 결과 메시지 처리
			String str = (res > 0) ? "글 수정 성공" : "글 수정 실패";
			app.showMessage(str);
		} catch (SQLException e) {
			app.showMessage(e.getMessage());
		}

	}

	public void deleteMemo() {
		String noStr = app.showInputDialog("삭제할 글 번호를 입력하세요");
		if (noStr == null)
			return;
		try {
			int n = dao.deleteMemo(Integer.parseInt(noStr.trim()));
			String res = (n > 0) ? "글 삭제 성공" : "글 삭제 실패";
			app.showMessage(res);
		} catch (SQLException e) {
			app.showMessage(e.getMessage());
		}
		;
	}

	public void listMemo() {
		try {
			List<MemoVo> arr = dao.listMemo();
			app.setTitle("전체 글 갯수 : " + arr.size() + "개 입니다.");
			// 모델 (dao)를 통해서 받아온 데이터를 화면단(app)에게 넘겨준다.
			app.showTextArea(arr);
		} catch (SQLException e) {
			app.showMessage(e.getMessage());
		}
	}// -------------------------------

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
			if (result > 0) {
				app.setTitle("글 등록 성공");

			} else
				app.showMessage("글 등록을 실패");
		} catch (SQLException e) {
			app.showMessage(e.getMessage());
		}

	}

}
