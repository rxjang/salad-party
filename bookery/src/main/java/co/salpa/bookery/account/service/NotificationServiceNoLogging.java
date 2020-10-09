package co.salpa.bookery.account.service;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import co.salpa.bookery.model.ClubDao;
import co.salpa.bookery.model.entity.UserVo;

@Service
@Transactional
public class NotificationServiceNoLogging implements NotificationService {

	@Autowired
	SqlSession sqlSession;

	/*
	 * 내 글에 달린 댓글들 목록
	 */
	@Override
	public Model listReplyMyPostService(Model model, HttpSession session) {
		UserVo user = (UserVo) session.getAttribute("user");
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		return model.addAttribute("replyMyPost", clubDao.selectReplyALLByUserId(user.getId()));
	}

	/*
	 * 내 글에 달린 댓글들 목록 사이즈 반환
	 */
	@Override
	public int getReplyMyPostListSize(HttpSession session) {
		UserVo user = (UserVo) session.getAttribute("user");
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		int size = 0;
		try {
			size = clubDao.selectReplyALLByUserId(user.getId()).size();
		} catch (DataAccessException | NullPointerException e) {
		}

		return size;
	}

	/*
	 * 알림 페이지에서 읽은 댓글 마킹
	 */
	@Override
	public void checkedNotiService(int club_id) throws DataAccessException {
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		clubDao.updateReplyTitleForMark(club_id);

	}

}
