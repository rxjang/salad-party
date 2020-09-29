package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.MedalVo;

public interface MedalDao {
	List<MedalVo> selectAll() throws DataAccessException;
}
