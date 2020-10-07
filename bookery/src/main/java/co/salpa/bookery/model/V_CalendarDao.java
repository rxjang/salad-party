package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.V_CalendarVo;

public interface V_CalendarDao {
	List<V_CalendarVo> selectAllByUserId(int user_id) throws DataAccessException;

	List<V_CalendarVo> selectAllByStudyId(int study_id) throws DataAccessException;

	List<V_CalendarVo> selectFinData(int study_id) throws DataAccessException;
}
