package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;

import co.salpa.bookery.model.entity.CheckPageVo;

public interface CheckPageDao {
	
	List<CheckPageDao> selectAll() throws SQLException;
	int updateOne(CheckPageVo page) throws SQLException;

}
