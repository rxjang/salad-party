package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.UserVo;

public interface UserDao {
	
	List<UserVo> selectAll() throws DataAccessException;

	UserVo selectOne(int id) throws DataAccessException;
	
	// 네이버 계정 등록 여부 확인
	int chkNaver(Map<String, String> map) throws DataAccessException;
	
	// 회원가입
	void insertOne(UserVo bean) throws DataAccessException;

	// 정보수정
	int updateOne(UserVo bean) throws DataAccessException;

	// 삭제 (update deleted=1)
	int deleteOne(int id) throws DataAccessException;
	
	// 로그인 확인
	UserVo login(Map<String, String> map) throws DataAccessException;
	
	// email 중복확인 
	int chkEmail(String email) throws DataAccessException;
	
	// 닉네임 중복확인 
	int chkNickName(String nickName) throws DataAccessException;
	
	// 연락처 중복확인
	int chkTel(String tel) throws DataAccessException;
	
	// 정보 수정 닉네임 중복확인
	int chkUpdateNickName(Map<String, String> map) throws DataAccessException;
	
	// 정보 수정 연락처 중복확인
	int chkUpdateTel(Map<String, String> map) throws DataAccessException;
	
	// 아이디(이메일) 찾기
	String findEmail(Map<String, String> map) throws DataAccessException;
	
	// 비밀번호 찾기 (계정 존재 여부 확인)
	int findPw(Map<String, String> map) throws DataAccessException;
	
	// 비밀번호 변경처리
	int newPw(Map<String, String> map) throws DataAccessException;

	// sns를 통한 가입(lvl값이 "naver" or "kakao")
	String chkBySns(String email);

	// 가장 최근에 가입한 사용자의 id값 구하기
	int maxId();
	
}
