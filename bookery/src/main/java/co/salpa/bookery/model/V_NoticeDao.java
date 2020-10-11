package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.V_NoticeVo;

public interface V_NoticeDao {
	List<V_NoticeVo> selectQnA() throws DataAccessException;
	
	List<V_NoticeVo> selectQnAByUserId(int user_id) throws DataAccessException;
}
