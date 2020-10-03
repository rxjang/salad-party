package co.salpa.bookery.model;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.StudyVo;

public interface StudyDao {
	
	List<StudyVo> selectAll() throws DataAccessException;

	StudyVo selectOne(int key) throws DataAccessException;
	
	List<Integer> selectIdByUserId(int user_id) throws DataAccessException;
	
	List<StudyVo> selectOneByIdAndBid(Map<String, String> map) throws DataAccessException;

	void insertOne(StudyVo bean) throws DataAccessException;
	
	void assertPlan(StudyVo bean) throws DataAccessException;

	StudyVo updateTypeChap(int study_id);

	StudyVo updateTypePage(int study_id);
}
