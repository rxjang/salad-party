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

import co.salpa.bookery.model.ClubDao;
import co.salpa.bookery.model.V_Readers_cntDao;
import co.salpa.bookery.model.entity.ClubVo;
import co.salpa.bookery.model.entity.UserVo;

@Service
@Transactional
public class ClubServiceImpl implements ClubService {

	@Autowired
	SqlSession sqlSession;

	
	/*
	 * 북클럽 메인에서 책 목록 불러오기. 
	 */
	@Override
	public Model listBookClubService(Model model) throws DataAccessException {
		List<ClubVo> list = new ArrayList<ClubVo>();
		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		
		return model.addAttribute("list", clubDao.selectBookClubAll());
	}//listBookClub

	
	/*
	 * 책제목, 커버, 함꼐읽는 사람수. 리스트로 반환. 
	 */
	@Override
	public Model listReadersService(Model model) throws DataAccessException {
		V_Readers_cntDao v_Readers_cntDao = sqlSession.getMapper(V_Readers_cntDao.class);

		return model.addAttribute("cntReaders", v_Readers_cntDao.selectAll());
	}//listReadersService


	@Override
	public Model getReaderService(int book_bid, Model model) throws DataAccessException {
		V_Readers_cntDao v_Readers_cntDao = sqlSession.getMapper(V_Readers_cntDao.class);
		
		return model.addAttribute("cntReaders", v_Readers_cntDao.selectOne(book_bid));
	}

	/*
	 * 하나의 책과 관련된 게시글들을 불러온다. 리스트
	 */
	@Override
	public Model listOfOneBookService(int book_bid,Model model,String search) throws DataAccessException {
		// TODO Auto-generated method stub
		if(search == null) {
			search = "%%";
		}else {
			search = "%"+search+"%";
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

	/*
	 * 게시글 쓰기
	 */
	@Override
	public void addPostService(ClubVo club, HttpSession session ,Model model) throws DataAccessException {
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
		if(search == null) {
			search = "%%";
		}else {
			search = "%"+search+"%";
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
				if(cnt == 0) {
					json += vo.toString();
				}else {
					json += ", "+vo.toString();
				}//if
				cnt++;
			}//for
		json+="]}";
		return json;
	}
	



}
