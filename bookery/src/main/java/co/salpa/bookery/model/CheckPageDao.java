package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import co.salpa.bookery.model.entity.CheckPageVo;

public interface CheckPageDao {

	List<CheckPageDao> selectAll() throws SQLException;

	CheckPageVo selectRecentChecked() throws SQLException;

	CheckPageVo selectOneByStudyId(Map<String, Integer> map) throws SQLException;

	CheckPageVo selectOneByDate(Map<String, String> map) throws SQLException;

	int updateOne(CheckPageVo page) throws SQLException;

}