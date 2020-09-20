package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.BookVo;

public interface MylibDao {
	
	List<BookVo> selectNoGoalBook(int id) throws DataAccessException; //미독 책 리스트 반환
	List<BookVo> selectStudyingBook(int id) throws DataAccessException; //미완독 책 리스트 반환
	List<BookVo> selectFinishedBook(int id) throws DataAccessException; //완독 책 리스트 반환
	int countNoGoalBook(int id) throws DataAccessException; //미독 책 개수 반환
	int countStudyingBook(int id) throws DataAccessException; //미완독 책 개수 반환
	int countFinishedBook(int id) throws DataAccessException; //완독 책 개수 반환
}
