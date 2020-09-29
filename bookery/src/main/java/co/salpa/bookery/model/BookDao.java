package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.BookVo;

public interface BookDao {
	List<BookVo> selectAll() throws DataAccessException;

	List<BookVo> selectMostBook() throws DataAccessException;//스터디 테이블에 가장 많이 등록된 책 순서대로

	BookVo selectOne(int key) throws DataAccessException;

	void insertOne(BookVo bean) throws DataAccessException;

	int updateOne(BookVo bean) throws DataAccessException;

	int deleteOne(int key) throws DataAccessException;
}
