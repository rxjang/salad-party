package co.salpa.bookery.model;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.CheckPageVo;

public interface CheckPageDao {
	
	List<CheckPageDao> selectAll() throws DataAccessException;

	CheckPageVo selectRecentChecked() throws SQLException;

	CheckPageVo selectOneByStudyId(Map<String, Integer> map) throws SQLException;

	CheckPageVo selectOneByDate(Map<String, String> map) throws SQLException;

	void insertOne(CheckPageVo bean) throws DataAccessException;
	
	int updateOne(CheckPageVo page) throws DataAccessException;
	
}