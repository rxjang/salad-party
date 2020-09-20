package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import co.salpa.bookery.model.entity.BookVo;

@Repository
public class MylibDaoImpl implements MylibDao{
	@Autowired
	DataSource dataSource;
	@Autowired
	SqlSessionFactory sqlSessionFactory;

	@Override
	public List<BookVo> selectNoGoalBook(int id) throws DataAccessException{
		List<BookVo> list = null;
		try(SqlSession session = sqlSessionFactory.openSession()){
			list = session.selectList("selectNoGoalBook", id);
		}
		return list;
	}

	@Override
	public List<BookVo> selectStudyingBook(int id) throws DataAccessException {
		List<BookVo> list = null;
		try(SqlSession session = sqlSessionFactory.openSession()){
			list = session.selectList("selectStudyingBook", id);
		}
		return list;
	}

	@Override
	public List<BookVo> selectFinishedBook(int id) throws DataAccessException {
		List<BookVo> list = null;
		try(SqlSession session = sqlSessionFactory.openSession()){
			list = session.selectList("selectFinishedBook", id);
		}
		return list;
	}

	@Override
	public int countNoGoalBook(int id) throws DataAccessException {
		SqlSession session=sqlSessionFactory.openSession();
		return session.selectOne("countNoGoalBook", id);
	}

	@Override
	public int countStudyingBook(int id) throws DataAccessException {
		SqlSession session=sqlSessionFactory.openSession();
		return session.selectOne("countStydinglBook", id);
	}

	@Override
	public int countFinishedBook(int id) throws DataAccessException {
		SqlSession session=sqlSessionFactory.openSession();
		return session.selectOne("countFinishedBook", id);
	}

}//MylibDaoImpl
