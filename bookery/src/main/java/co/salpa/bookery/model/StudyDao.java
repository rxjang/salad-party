package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.StudyVo;

public interface StudyDao {
	
	List<StudyVo> selectAll() throws DataAccessException;

	StudyVo selectOne(int key) throws DataAccessException;

	void insertOne(StudyVo bean) throws DataAccessException;
	
	void assertPlan(StudyVo bean) throws DataAccessException;

	StudyVo updateTypeChap(int study_id);

	StudyVo updateTypePage(int study_id);
}
