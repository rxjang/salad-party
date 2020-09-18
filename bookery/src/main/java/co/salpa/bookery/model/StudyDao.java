package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;

import co.salpa.bookery.model.entity.StudyVo;

public interface StudyDao {
	
	List<StudyVo> selectAll() throws SQLException;

	StudyVo selectOne(int key) throws SQLException;

	void insertOne(StudyVo bean) throws SQLException;
}
