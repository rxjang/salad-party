package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.salpa.bookery.model.entity.BookVo;

@Repository
public class BookDaoImpl implements BookDao {

	@Autowired
	DataSource dataSource;
	@Autowired
	SqlSessionFactory sqlSessionFactory;
	
	@Override
	public List<BookVo> selectAll() throws SQLException {
		// TODO Auto-generated method stub
		List<BookVo> list =new ArrayList<BookVo>();
		
		try(SqlSession session = sqlSessionFactory.openSession()){
			list = session.selectList("book.selectAll");
		}//try
		return list;
	}//selectAll

	@Override
	public BookVo selectOne(int key) throws SQLException {
		// TODO Auto-generated method stub
		BookVo bean = null;
		try(SqlSession session = sqlSessionFactory.openSession()){
			bean = session.selectOne("book.selectOne", key);
		}//try
		return bean;
	}//selectOne

	@Override
	public void insertOne(BookVo bean) throws SQLException {
		// TODO Auto-generated method stub
		try(SqlSession session = sqlSessionFactory.openSession()){
			session.insert("book.insertOne", bean);
		}//try
	}//insertOne

}//classEnd
