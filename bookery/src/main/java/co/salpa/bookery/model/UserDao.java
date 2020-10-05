package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import co.salpa.bookery.model.entity.UserVo;

public interface UserDao {
	
	List<UserVo> selectAll() throws SQLException;

	UserVo selectOne(int id) throws SQLException;
	
	// 네이버 계정 등록 여부 확인
	int chkNaver(String password) throws SQLException;
	
	// 회원가입
	void insertOne(UserVo bean) throws SQLException;

	// 정보수정
	int updateOne(UserVo bean) throws SQLException;

	// 삭제 (update deleted=1)
	int deleteOne(int id) throws SQLException;
	
	// 로그인 확인
	UserVo login(Map<String, String> map) throws SQLException;
	
	// email 중복확인 
	int chkEmail(String email) throws SQLException;
	
	// 닉네임 중복확인 
	int chkNickName(String nickName) throws SQLException;
	
	// 연락처 중복확인
	int chkTel(String tel) throws SQLException;
	
	// 정보 수정 닉네임 중복확인
	int chkUpdateNickName(Map<String, String> map) throws SQLException;
	
	// 정보 수정 연락처 중복확인
	int chkUpdateTel(Map<String, String> map) throws SQLException;
	
	// 아이디(이메일) 찾기
	String findEmail(Map<String, String> map) throws SQLException;
	
	// 비밀번호 찾기 (계정 존재 여부 확인)
	int findPw(Map<String, String> map) throws SQLException;
	
	// 비밀번호 변경처리
	int newPw(Map<String, String> map) throws SQLException;
	
}
