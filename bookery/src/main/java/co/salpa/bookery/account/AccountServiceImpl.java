package co.salpa.bookery.account;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.salpa.bookery.model.UserDao;
import co.salpa.bookery.model.entity.UserVo;

@Service
public class AccountServiceImpl implements AccountService{

	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int register(String email, String password, String name, String nickname, String tel) throws SQLException {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		UserVo bean = new UserVo(email, password, name, nickname, tel);
		userDao.insertOne(bean);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		map.put("name", name);
		
		int cnt = userDao.findPw(map);
		
		return cnt;
	}

	@Override
	public int chkEmail(String email) throws SQLException {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int cnt = userDao.chkEmail(email);
		return 0;
	}

	@Override
	public int updateInfo(UserVo bean) throws SQLException {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int result = userDao.updateOne(bean);
		return result;
	}

	@Override
	public String findId(String name, String tel) throws SQLException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("name", name);
		map.put("tel", tel);
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		String email = userDao.findEmail(map);
		return email;
	}

	@Override
	public int findPw(String email, String name, String tel) throws SQLException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		map.put("name", name);
		map.put("tel", tel);
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int cnt = userDao.findPw(map);
		return cnt;
	}

	@Override
	public UserVo login(String email, String password) throws SQLException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		map.put("password", password);
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		UserVo userBean = userDao.login(map);
		return userBean;
	}

}
