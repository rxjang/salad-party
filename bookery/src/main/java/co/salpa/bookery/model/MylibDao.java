package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.BookVo;

public interface MylibDao {
	
	List<BookVo> selectNoGoalBook(int id) throws DataAccessException;
	List<BookVo> selectStudyingBook(int id) throws DataAccessException;
	List<BookVo> selectFinishedBook(int id) throws DataAccessException;
}
