package co.salpa.bookery.model;

import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.salpa.bookery.model.entity.BookVo;

@Repository
public class MylibDaoImpl implements MylibDao{
	@Autowired
	DataSource dataSource;
	@Autowired
	SqlSessionFactory sqlSessionFactory;

	@Override
	public BookVo selectNoGoalBook(int id) throws SQLException {
		BookVo bean = null;
		try(SqlSession session = sqlSessionFactory.openSession()){
			bean = session.selectOne("book.selectOne", id);
		}//try
		return bean;
	}//selectNoGoalBook

}//MylibDaoImpl
