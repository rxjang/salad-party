package co.salpa.bookery.account;

import java.sql.SQLException;

import co.salpa.bookery.model.entity.UserVo;

public interface AccountService {

	public int register(String email, String password, String name, String nickname, String tel) throws SQLException;

	public int chkEmail(String email) throws SQLException;

	public int updateInfo(UserVo bean) throws SQLException;

	public String findId(String name, String tel) throws SQLException;

	public int findPw(String email, String name, String tel) throws SQLException;

	public UserVo login(String email, String password) throws SQLException;

}
