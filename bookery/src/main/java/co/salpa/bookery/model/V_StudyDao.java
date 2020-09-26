package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.V_StudyVo;

public interface V_StudyDao {

	List<V_StudyVo> selectAll() throws SQLException;

	V_StudyVo selectOne(Map<String, Integer> map) throws SQLException; //userid와 bid로 스터디 찾기

	V_StudyVo selectOneByStudyId(int study_id) throws DataAccessException;

	List<V_StudyVo> selectAllByUserId(int key) throws SQLException;

	List<V_StudyVo> selectActiveByUserId(int key) throws SQLException;

	List<V_StudyVo> selectNoGoalBook(int id) throws DataAccessException; // 미독 책 리스트 반환

	List<V_StudyVo> selectStudyingBook(int id) throws DataAccessException; // 미완독 책 리스트 반환

	List<V_StudyVo> selectFinishedBook(int id) throws DataAccessException; // 완독 책 리스트 반환

	int countNoGoalBook(int id) throws DataAccessException; // 미독 책 개수 반환

	int countStudyingBook(int id) throws DataAccessException; // 미완독 책 개수 반환

	int countFinishedBook(int id) throws DataAccessException; // 완독 책 개수 반환
}