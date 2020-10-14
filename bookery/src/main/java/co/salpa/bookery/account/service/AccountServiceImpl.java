package co.salpa.bookery.account.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import co.salpa.bookery.model.UserDao;
import co.salpa.bookery.model.entity.UserVo;

@Service
public class AccountServiceImpl implements AccountService{

	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void register(UserVo newUser) throws SQLException {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		UserVo bean = new UserVo(newUser.getEmail(), newUser.getPassword(), newUser.getName(), newUser.getNickname(), newUser.getTel(), newUser.getLvl());
		userDao.insertOne(bean);
	}
	
	@Override
	public int chkNaver(String password) throws SQLException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("password", password);
		map.put("lvl", "naver");
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int cnt = userDao.chkNaver(map);
		return cnt;
	}

	@Override
	public int chkEmail(String email) throws SQLException {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int cnt = userDao.chkEmail(email);
		return cnt;
	}

	@Override
	public int chkNickName(String nickname) throws SQLException {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int cnt = userDao.chkNickName(nickname);
		return cnt;
	}

	@Override
	public int chkTel(String tel) throws SQLException {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int cnt = userDao.chkTel(tel);
		return cnt;
	}
	
	@Override
	public Model getUserInfo(int id, Model model) throws SQLException {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		UserVo userBean = userDao.selectOne(id);
		return model.addAttribute("userBean", userBean);
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

	@Override
	public int newPw(String email, String newPassword) throws SQLException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		map.put("password", newPassword);
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int result = userDao.newPw(map);
		return result;
	}

	@Override
	public int chkUpdateNickName(String email, String nickname) throws SQLException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		map.put("nickname", nickname);
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int cnt = userDao.chkUpdateNickName(map);
		return cnt;
	}

	@Override
	public int chkUpdateTel(String email, String tel) throws SQLException {
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		map.put("tel", tel);
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int cnt = userDao.chkUpdateTel(map);
		return cnt;
	}

	@Override
	public int withdraw(int id) throws SQLException {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		int result = userDao.deleteOne(id);
		return result;
	}

	@Override
	public String chkBySns(String email) {
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		String lvl = userDao.chkBySns(email);
		return lvl;
	}

}