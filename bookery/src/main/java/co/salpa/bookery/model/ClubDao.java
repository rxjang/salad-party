package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.ClubVo;

public interface ClubDao {
	List<ClubVo> selectNoticeAll() throws DataAccessException;

	ClubVo selectOneNotice(int id) throws DataAccessException;
	
	List<ClubVo> selectBookClubAll() throws DataAccessException;
	
	void insertBookClub(BookVo book) throws DataAccessException;
	
	void insertNotice(ClubVo club) throws DataAccessException;
	
	void updateNotice(ClubVo club) throws DataAccessException;
	
	void deleteClubData(int id) throws DataAccessException;
}
