package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.salpa.bookery.model.entity.TocVo;

@Repository
public class TocDaoImpl implements TocDao {

	@Autowired
	DataSource dataSource;
	@Autowired
	SqlSessionFactory sqlSessionFactory;

	@Override
	public List<TocVo> selectAll() throws SQLException {
		// TODO Auto-generated method stub

		List<TocVo> list = new ArrayList<TocVo>();

		try (SqlSession session = sqlSessionFactory.openSession()) {
			list = session.selectList("toc.selectAll");
		} // try
		return list;
	}// selectAll

	@Override
	public List<TocVo> selectOne(int key) throws SQLException {
		// TODO Auto-generated method stub
		List<TocVo> list = new ArrayList<TocVo>();

		try (SqlSession session = sqlSessionFactory.openSession()) {// 책 한권의 목차들을 리스트에 담아 반환
			list = session.selectList("toc.selectOne", key);
		} // try
		return list;
	}// selectOne

	@Override
	public void insertOne(TocVo bean) throws SQLException {
		// TODO Auto-generated method stub
		try (SqlSession session = sqlSessionFactory.openSession()) {// 목차 입력
			session.insert("toc.insertOne", bean);
		} // try
	}// insertOne

}//classEnd
