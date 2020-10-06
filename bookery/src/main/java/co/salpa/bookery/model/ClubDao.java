package co.salpa.bookery.model;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.ClubVo;

public interface ClubDao {
	List<ClubVo> selectNotice() throws DataAccessException;
	
	List<ClubVo> selectOneToOne() throws DataAccessException;

	ClubVo selectOneNotice(int id) throws DataAccessException;
	
	List<ClubVo> selectBookClubAll() throws DataAccessException;
	
	List<ClubVo> selectAboutBook(ClubVo club) throws DataAccessException; //북클럽 특정책 리스트불러오기
	
	void insertBookClub(BookVo book) throws DataAccessException;
	
	void insertNotice(ClubVo club) throws DataAccessException;
	
	void updateNotice(ClubVo club) throws DataAccessException;

	void updateRef(int id) throws DataAccessException;
	
	void deleteClubData(int id) throws DataAccessException;

	ClubVo selectOneClub(int id) throws DataAccessException;//북클럽 특정책 리스트에서 글 보기 
	
	List<ClubVo> selectMore(ClubVo club) throws DataAccessException;//북클럽 특정책 리스트 더 불러오기(더보기버튼누름)

	void insertOneClub(ClubVo club) throws DataAccessException;//북클럽 특정 책에 글쓰기
	
	int countOfPosts(int book_bid) throws DataAccessException; //특정책의 게시글 수
	
	void insertReplyClub(ClubVo club) throws DataAccessException; //게시글 댓글 작성

	List<ClubVo> selectReplyById(int id) throws DataAccessException; //게시글 댓글 목록
	
	void updateClubPost(ClubVo club) throws DataAccessException; //게시글 수정하기

}
