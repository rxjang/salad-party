package co.salpa.bookery.model;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.CheckPageVo;

public interface CheckPageDao {
	
	List<CheckPageDao> selectAll() throws DataAccessException;

	CheckPageVo selectRecentChecked() throws DataAccessException;

	CheckPageVo selectOneByStudyId(Map<String, Integer> map) throws DataAccessException;

	CheckPageVo selectOneByDate(Map<String, String> map) throws DataAccessException;

	void insertOne(CheckPageVo bean) throws DataAccessException;
	
	int updateOne(CheckPageVo page) throws DataAccessException;
	
}
