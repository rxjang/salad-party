package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.CheckChapVo;

public interface CheckChapDao {

	List<CheckChapVo> selectAllByStudyId(int study_id) throws DataAccessException;

}
