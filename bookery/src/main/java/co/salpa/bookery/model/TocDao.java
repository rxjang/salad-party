package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;

import co.salpa.bookery.model.entity.TocVo;

public interface TocDao {

	List<TocVo> selectAll() throws SQLException;

	List<TocVo> selectOne(int key) throws SQLException;

	void insertOne(TocVo bean) throws SQLException;

	int updateOne(TocVo bean) throws SQLException;

	int deleteOne(int key) throws SQLException;
}
