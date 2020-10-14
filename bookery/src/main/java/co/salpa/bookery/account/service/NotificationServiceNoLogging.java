package co.salpa.bookery.account.service;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import co.salpa.bookery.model.AwardDao;
import co.salpa.bookery.model.ClubDao;
import co.salpa.bookery.model.V_AwardsDao;
import co.salpa.bookery.model.V_NoticeDao;
import co.salpa.bookery.model.entity.AwardVo;
import co.salpa.bookery.model.entity.UserVo;

@Service
@Transactional
public class NotificationServiceNoLogging implements NotificationService {

	@Autowired
	SqlSession sqlSession;

	/*
	 * 내 알림들 목록 댓글, 1대1문의, 어워즈
	 */
	@Override
	public Model listReplyMyPostService(Model model, HttpSession session) {
		UserVo user = (UserVo) session.getAttribute("user");
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		V_NoticeDao v_noticeDao=sqlSession.getMapper(V_NoticeDao.class);
		V_AwardsDao v_awardsDao=sqlSession.getMapper(V_AwardsDao.class);
		model.addAttribute("replyMyPost", clubDao.selectReplyALLByUserId(user.getId()));
		model.addAttribute("QnANotice", v_noticeDao.selectQnAByUserId(user.getId()));
		model.addAttribute("awardNotice", v_awardsDao.selectAchieveMedalNotice(user.getId()));
		return null;
	}

	/*
	 * 내 글에 달린 알림 목록 사이즈 반환
	 */
	@Override
	public int getReplyMyPostListSize(HttpSession session) {
		UserVo user = (UserVo) session.getAttribute("user");
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		V_NoticeDao v_noticeDao=sqlSession.getMapper(V_NoticeDao.class);
		V_AwardsDao v_awardsDao=sqlSession.getMapper(V_AwardsDao.class);
		int size = 0;
		try {
			checkMedal1(session);
		} catch (DataAccessException | NullPointerException e) {}
		try {
			size = clubDao.selectReplyALLByUserId(user.getId()).size()
					+v_noticeDao.selectQnAByUserId(user.getId()).size()
					+v_awardsDao.selectAchieveMedalNotice(user.getId()).size();
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

	/*
	 * 알림 페이지에서 읽은 어워즈 마킹
	 */
	@Override
	public void checkedAwardService(int award_id) throws DataAccessException {
		AwardDao awardDao=sqlSession.getMapper(AwardDao.class);
		awardDao.updateAwardChecked(award_id);
	}
	
	//medal1은 여러개가 생기기때문에 최초의 메달1달성시 나머지 메달도 체크하게 함
	public void checkMedal1(HttpSession session){
		UserVo user = (UserVo) session.getAttribute("user");
		AwardDao awardDao=sqlSession.getMapper(AwardDao.class);
		AwardVo bean=awardDao.selectAward01(user.getId());
		if(bean.getChecked()==1) {
			awardDao.updateMedal1Checked(user.getId());
			System.out.println("메달 1 업데이트");
		}
	}

}
