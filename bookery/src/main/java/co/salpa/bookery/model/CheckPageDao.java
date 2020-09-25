package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.CheckPageVo;

public interface CheckPageDao {
	
	List<CheckPageDao> selectAll() throws DataAccessException;

	void insertOne(CheckPageVo bean) throws DataAccessException;
	
	int updateOne(CheckPageVo page) throws DataAccessException;
	
}