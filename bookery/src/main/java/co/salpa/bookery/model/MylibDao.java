package co.salpa.bookery.model;

import java.sql.SQLException;

import co.salpa.bookery.model.entity.BookVo;

public interface MylibDao {
	
	BookVo selectNoGoalBook(int id) throws SQLException;
}
