package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.salpa.bookery.model.entity.UserVo;

@Repository
public class UserDaoImpl implements UserDao {
	@Autowired
	DataSource dataSource;
	@Autowired
	SqlSessionFactory sqlSessionFactory;

	@Override
	public List<UserVo> selectAll() throws SQLException {
		List<UserVo> list = null;
		try(SqlSession session = sqlSessionFactory.openSession()){
			list = session.selectList("selectAll");
		}
		return list;
	}

	@Override
	public UserVo selectOne(int id) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
	
		return session.selectOne("countNoGoalBook", id);
	}

	@Override
	public void insertOne(UserVo bean) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		session.insert("insertOne", bean);
	}

	@Override
	public int updateOne(UserVo bean) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		int result = session.update("updateOne", bean);
		
		return result;
	}

	@Override
	public int deleteOne(int id) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		int result = session.delete("deleteOne", id);
		
		return result;
	}

	@Override
	public int chkEmail(String email) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.selectOne("chkEmail", email);
		
		return cnt;
	}

	@Override
	public int chkNickName(String nickName) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.selectOne("chkNickName", nickName);
		
		return cnt;
	}

	@Override
	public int chkTel(String tel) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.selectOne("chkTel", tel);
		
		return cnt;
	}

	@Override
	public UserVo login(Map<String, String> map) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		UserVo userBean = session.selectOne("login", map); 
		
		return userBean;
	}

	@Override
	public String findEmail(Map<String, String> map) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		String email = session.selectOne("findEmail", map);
	
		return email;
	}

	@Override
	public int findPw(Map<String, String> map) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.selectOne("findPw", map);
		
		return cnt;
	}

	@Override
	public int newPw(Map<String, String> map) throws SQLException {
		SqlSession session = sqlSessionFactory.openSession();
		int result = session.update("newPw", map);
		
		return result;
	}

}
