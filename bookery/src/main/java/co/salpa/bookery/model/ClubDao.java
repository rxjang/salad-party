package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.ClubVo;

public interface ClubDao {
	List<ClubVo> selectNotice() throws DataAccessException;
	
	List<ClubVo> selectOneToOne() throws DataAccessException;

	ClubVo selectOneNotice(int id) throws DataAccessException;
	
	List<ClubVo> selectBookClubAll() throws DataAccessException;
	
	List<ClubVo> selectAboutBook(int book_bid) throws DataAccessException;
	
	void insertBookClub(BookVo book) throws DataAccessException;
	
	void insertNotice(ClubVo club) throws DataAccessException;
	
	void updateNotice(ClubVo club) throws DataAccessException;

	void updateRef(int id) throws DataAccessException;
	
	void deleteClubData(int id) throws DataAccessException;

	ClubVo selectOneClub(int id) throws DataAccessException;//북클럽 특정책 리스트에서 글 보기 
	
	void insertOneClub(ClubVo club) throws DataAccessException;//북클럽 특정 책에 글쓰기
}
