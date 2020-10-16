package co.salpa.bookery.account.service;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.ui.Model;

import co.salpa.bookery.model.entity.UserVo;

public interface AccountService {

	public void register(UserVo bean) throws SQLException;

	public int chkNaver(String password) throws SQLException;
	
	public int chkEmail(String email) throws SQLException;
	
	public int chkNickName(String nickname) throws SQLException;
	
	public int chkTel(String tel) throws SQLException;
	
	public Model getUserInfo(int id, Model model) throws SQLException;
	
	public int chkUpdateNickName(String email, String nickname) throws SQLException;
	
	public int chkUpdateTel(String email, String tel) throws SQLException;

	public int updateInfo(UserVo bean) throws SQLException;

	public String findId(String name, String tel) throws SQLException;

	public int findPw(String email, String name, String tel) throws SQLException;

	public UserVo login(String email, String password) throws SQLException;
	
	public int newPw(String email, String newPassword) throws SQLException;
	
	public int withdraw(int id) throws SQLException;

	public String chkBySns(String email);

	public int maxId();

}