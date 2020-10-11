package co.salpa.bookery.account.service;

import javax.servlet.http.HttpSession;

import org.springframework.dao.DataAccessException;
import org.springframework.ui.Model;

public interface NotificationService {

	Model listReplyMyPostService(Model model, HttpSession session) throws DataAccessException; // 내글에 달린 댓글

	int getReplyMyPostListSize(HttpSession session) throws DataAccessException; // 확인안한 댓글 알림 리스트

	void checkedNotiService(int club_id) throws DataAccessException; // 댓글알림 확인표시
	
	void checkedAwardService(int award_id) throws DataAccessException; // 댓글알림 확인표시

}
