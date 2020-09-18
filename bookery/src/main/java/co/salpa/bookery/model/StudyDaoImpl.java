package co.salpa.bookery.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.salpa.bookery.model.entity.StudyVo;

//@Repository
public class StudyDaoImpl {

//	@Autowired
//	DataSource dataSource;
//	@Autowired
//	SqlSessionFactory sqlSessionFactory;
//
//	@Override
//	public List<StudyVo> selectAll() throws SQLException { // 모든 스터디정보 조회
//		// TODO Auto-generated method stub
//		List<StudyVo> list = new ArrayList<StudyVo>();
//		try (SqlSession session = sqlSessionFactory.openSession()) {
//			list = session.selectList("study.selectAll");
//		} // try
//		return list;
//	}// selectAll
//
//	@Override
//	public StudyVo selectOne(int key) throws SQLException { // 특정 스터디 조회
//		// TODO Auto-generated method stub
//		StudyVo bean = null;
//		try (SqlSession session = sqlSessionFactory.openSession()) {
//			bean = session.selectOne("study.selectOne", key);
//		} // try
//		return bean;
//	}// selectOne
//
//	@Override
//	public void insertOne(StudyVo bean) throws SQLException { // 스터디 추가
//		// TODO Auto-generated method stub
//		try (SqlSession session = sqlSessionFactory.openSession()) {
//			session.insert("study.insertOne", bean);
//		} // try
//	}// insertOne

}// classEnd