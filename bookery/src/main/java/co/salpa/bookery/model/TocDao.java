package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.TocVo;

public interface TocDao {

	List<TocVo> selectAll() throws DataAccessException;

	List<TocVo> selectOne(int key) throws DataAccessException;

	void insertOne(TocVo bean) throws DataAccessException;

	int updateOne(TocVo bean) throws DataAccessException;

	int deleteOne(int key) throws DataAccessException;
}
