package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import co.salpa.bookery.model.entity.V_StudyVo;

public interface V_StudyDao {
	
	List<V_StudyVo> selectAll() throws SQLException;
	V_StudyVo selectOne(Map<String, Integer> map) throws SQLException;
	V_StudyVo selectOneByStudyId(int study_id) throws SQLException;
	List<V_StudyVo> selectAllByUserId(int key) throws SQLException;
	List<V_StudyVo> selectActiveByUserId(int key) throws SQLException;
}