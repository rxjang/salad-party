package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;

import org.springframework.stereotype.Component;

import co.salpa.bookery.model.entity.BookVo;

public interface BookDao {

	
	List<BookVo> selectAll() throws SQLException;
	BookVo selectOne(int key) throws SQLException;
	void insertOne(BookVo bean) throws SQLException;
}
