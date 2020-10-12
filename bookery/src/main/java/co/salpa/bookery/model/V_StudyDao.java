package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.V_StudyVo;

public interface V_StudyDao {
	
	List<V_StudyVo> selectAll() throws DataAccessException;
	V_StudyVo selectOne(Map<String, Integer> map) throws DataAccessException;
	V_StudyVo selectOneByStudyId(int study_id) throws DataAccessException;
	List<V_StudyVo> selectAllByUserId(int key) throws DataAccessException;//사용안함
	List<V_StudyVo> selectActiveByUserId(int key) throws DataAccessException;//미완독 스터디 리스트 반환
	List<Integer> selectActiveStudyIDByUserId(int user_id);//미완독 study_id 목록 반환
	List<V_StudyVo> selectNoGoalBook(int id) throws DataAccessException; //미독 책 리스트 반환
	List<V_StudyVo> selectStudyingBook(int id) throws DataAccessException; //미완독 책 리스트 반환
	List<V_StudyVo> selectFinishedBook(int id) throws DataAccessException; //완독 책 리스트 반환
	List<V_StudyVo> bestAchieveUser() throws DataAccessException; //책 완독 횟수 많은 유저
	int countNoGoalBook(int id) throws DataAccessException; //미독 책 개수 반환
	int countStudyingBook(int id) throws DataAccessException; //미완독 책 개수 반환
	int countFinishedBook(int id) throws DataAccessException; //완독 책 개수 반환
	int countPeopleByBook(int bid) throws DataAccessException;//같은 책 읽는 사람 수 
}