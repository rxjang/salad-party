package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.ClubVo;

public interface ClubDao {
	List<ClubVo> selectNoticeAll() throws DataAccessException;
}