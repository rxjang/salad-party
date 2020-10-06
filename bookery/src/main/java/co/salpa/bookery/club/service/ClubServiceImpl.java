package co.salpa.bookery.club.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.salpa.bookery.model.ClubDao;
import co.salpa.bookery.model.V_Readers_cntDao;
import co.salpa.bookery.model.entity.ClubVo;
import co.salpa.bookery.model.entity.RecommendVo;
import co.salpa.bookery.model.entity.UserVo;

@Service
@Transactional
public class ClubServiceImpl implements ClubService {

	@Autowired
	SqlSession sqlSession;
	ObjectMapper objectMapper = new ObjectMapper();

	/*
	 * 북클럽 메인에서 책 목록 불러오기.
	 */
	@Override
	public Model listBookClubService(Model model) throws DataAccessException {
		List<ClubVo> list = new ArrayList<ClubVo>();
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);

		return model.addAttribute("list", clubDao.selectBookClubAll());
	}// listBookClub

	/*
	 * 책제목, 커버, 함꼐읽는 사람수. 리스트로 반환.
	 */
	@Override
	public Model listReadersService(Model model) throws DataAccessException {
		V_Readers_cntDao v_Readers_cntDao = sqlSession.getMapper(V_Readers_cntDao.class);

		return model.addAttribute("cntReaders", v_Readers_cntDao.selectAll());
	}// listReadersService

	@Override
	public Model getReaderService(int book_bid, Model model) throws DataAccessException {
		V_Readers_cntDao v_Readers_cntDao = sqlSession.getMapper(V_Readers_cntDao.class);

		return model.addAttribute("cntReaders", v_Readers_cntDao.selectOne(book_bid));
	}

	/*
	 * 하나의 책과 관련된 게시글들을 불러온다. 리스트
	 */
	@Override
	public Model OneBooListService(int book_bid, Model model, String search) throws DataAccessException {
		// TODO Auto-generated method stub
		if (search == null) {
			search = "%%";
		} else {
			search = "%" + search + "%";
		}
		ClubVo club = new ClubVo();
		club.setSearch(search);
		club.setBook_bid(book_bid);

		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
//		Map<String, String> map = new HashMap<>();
//		
//		map.put("book_bid", book_bid+"");
//		map.put("search", search);

		model.addAttribute("listSize", clubDao.countOfPosts(book_bid));
		return model.addAttribute("list", clubDao.selectAboutBook(club));
	}

	/*
	 * 게시글 내용 보기. 디테일
	 */
	@Override
	public Model getOneService(int id, Model model) throws DataAccessException {
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		return model.addAttribute("club", clubDao.selectOneClub(id));
	}

	@Override
	public ClubVo getOneService(int id) throws DataAccessException {
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		return clubDao.selectOneClub(id);
	}

	/*
	 * 게시글 쓰기
	 */
	@Override
	public void addPostService(ClubVo club, HttpSession session, Model model) throws DataAccessException {
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		UserVo user = (UserVo) session.getAttribute("user");
		club.setUser_id(user.getId());

		String newLine = club.getContent().replaceAll("\n", "<br/>");
		club.setContent(newLine);

		clubDao.insertOneClub(club);
	}

	@Override
	public String listMoreService(ClubVo club) throws DataAccessException {
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		String search = club.getSearch();
		if (search == null) {
			search = "%%";
		} else {
			search = "%" + search + "%";
		}
		club.setSearch(search);
//		Map<String, String> map = new HashMap<String, String>();
//		map.put("book_bid", book_bid+"");
//		map.put("start", start+"");
//		map.put("search", search);
		List<ClubVo> list = clubDao.selectMore(club);

		String json = "{\"key\":[";

		int cnt = 0;
		for (ClubVo vo : list) {
			if (cnt == 0) {
				json += vo.toString();
			} else {
				json += ", " + vo.toString();
			} // if
			cnt++;
		} // for
		json += "]}";
		return json;
	}

	/*
	 * 게시글 댓글달기
	 */
	@Override
	public String addReplyService(ClubVo club, HttpSession session) throws DataAccessException {
		// TODO Auto-generated method stub
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		UserVo user = (UserVo) session.getAttribute("user");
		club.setUser_id(user.getId());

		String newLine = club.getContent().replaceAll("\n", "<br/>");
		club.setContent(newLine);

		clubDao.insertReplyClub(club);

		return null;
	}

	/*
	 * 댓글 목록 보기
	 */
	@Override
	public Model listReplyService(int id, Model model) throws DataAccessException {

		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		return model.addAttribute("replylist", clubDao.selectReplyById(id));
	}

	/*
	 * 게시글 수정하기
	 */
	@Override
	public void updatePostSerivce(ClubVo club) throws DataAccessException {
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		/*
		 * "id":0, "ref":0, "depth":0, "num":0, "user_id":0, "book_bid":16687560,
		 * "title":"수정테스트", "content":"수정수정 수정
		 * 
		 * 완 료", "createtime":"null", "updatetime":"null", "start":0,"nickname":"null"
		 * 
		 * 
		 * 
		 * update salpa.club set title=수정테스트, content=수정수정 ,updatetime = now() where id
		 * = #{id}
		 */
		String newLine = club.getContent().replaceAll("\n", "<br/>");
		club.setContent(newLine);
		clubDao.updateClubPost(club);

	}

	/*
	 * 게시글 or 댓글 삭제
	 */
	@Override
	public void deletePostService(int id) throws DataAccessException {
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		clubDao.deleteClubData(id);
	}

	/*
	 * 댓글 수정
	 */
	@Override
	public void updateReplyService(ClubVo club) throws DataAccessException {
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);

		String newLine = club.getContent().replaceAll("\n", "<br/>");
		club.setContent(newLine);
		clubDao.updateReply(club);
	}

	/*
	 * 댓글 추천+1
	 */
	@Override
	public void recommendUpService(int id) throws DataAccessException {
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		clubDao.updateRecommendUp(id);
	}

	/*
	 * 한 댓글에 추천은 유저id당 1번.
	 */
	@Override
	public void recommendUpChkService(HttpSession session, int id) throws DataAccessException {
		UserVo user = (UserVo) session.getAttribute("user");
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);

		RecommendVo recommendVo = new RecommendVo();
		recommendVo.setUser_id(user.getId());
		recommendVo.setClub_id(id);

		clubDao.insertRecommendChk(recommendVo);
	}

	/*
	 * 댓글에 추천했는지 검사용 리스트 로그인중인 유저의 모든 추천기록 리스트를 이용해서 현재 댓글의 글번호가 있는지 확인한다.
	 */

	@Override
	public void listRecommendByUserService(Model model, HttpSession session) throws DataAccessException {
		UserVo user = (UserVo) session.getAttribute("user");
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		
		String json = "";
		
		try {
			json = objectMapper.writeValueAsString(clubDao.selectAllRecommend(user.getId()));
			System.out.println(json);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("recommendChk", json);
	}
	
	/*
	 * 추천 취소. -1
	 */
	@Override
	public void recommendDownService(int id) throws DataAccessException {
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		clubDao.updateRecommendDown(id);
		
	}

	/*
	 * 댓글추천기록에 추천한 기록을 삭제. 추천취소
	 */
	@Override
	public void recommendDownChkService(HttpSession session, int id) throws DataAccessException {
		UserVo user = (UserVo) session.getAttribute("user");
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);

		RecommendVo recommendVo = new RecommendVo();
		recommendVo.setUser_id(user.getId());
		recommendVo.setClub_id(id);

		clubDao.deleteRecommendChk(recommendVo);
		
	}

}
