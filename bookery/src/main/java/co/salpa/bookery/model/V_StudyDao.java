package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;

import co.salpa.bookery.model.entity.V_StudyVo;

public interface V_StudyDao {
	
	List<V_StudyVo> selectAll() throws SQLException;
	V_StudyVo selectOne(int key) throws SQLException;
	V_StudyVo selectOneByUserId(int key) throws SQLException;

}
