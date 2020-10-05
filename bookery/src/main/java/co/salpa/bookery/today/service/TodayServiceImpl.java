package co.salpa.bookery.today.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import co.salpa.bookery.model.CheckChapDao;
import co.salpa.bookery.model.CheckPageDao;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.CheckChapVo;
import co.salpa.bookery.model.entity.CheckPageVo;
import co.salpa.bookery.model.entity.V_StudyVo;

@Service
public class TodayServiceImpl implements TodayService {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Model todayService(int user_id, Model model) throws SQLException{
		// study_id 별 총괄 map
		Map<Integer,Map> map_by_study_id=new HashMap<Integer,Map>();
		// study_id 별 정보 목록
		Map<String,Object> map_study=null;
			// key : "v_study", value:
			V_StudyVo v_study=new V_StudyVo();
			// key : "checkchap", value:
			List<CheckChapVo> checkChap=new ArrayList<CheckChapVo>();
			// key : "checkpage", value:
			List<CheckPageVo> checkPage=new ArrayList<CheckPageVo>();
		
		// user_id에 해당하는 진행중인 study_id 목록 구하기
		V_StudyDao studyDao=sqlSession.getMapper(V_StudyDao.class);
		List<Integer> study_id=studyDao.selectActiveStudyIDByUserId(user_id);
		
		// study_id에해당하는 세 가지 정보 모두 map_study에 담기
		for(Integer sid : study_id) {
			map_study=new HashMap<String,Object>();
			
			// key : "v_study", value: v_studyVo 담기
			V_StudyDao v_studyDao=sqlSession.getMapper(V_StudyDao.class);
			v_study=v_studyDao.selectOneByStudyId(sid);
			map_study.put("v_study", v_study);

			//key : "checkchap", value: checkchap 목록 담기
			CheckChapDao checkChapDao=sqlSession.getMapper(CheckChapDao.class);
			checkChap=checkChapDao.selectAllByStudyId(sid);
			map_study.put("checkchap", checkChap);

			//key : "checkpage", value: checkpage 목록 담기
			CheckPageDao checkPageDao=sqlSession.getMapper(CheckPageDao.class);
			checkPage=checkPageDao.selectAllByStudyId(sid);
			map_study.put("checkpage", checkPage);
			
			//map_by_study_id 에 key : study_id, value : map_study 담기
			map_by_study_id.put(sid, map_study);
			
		}
		System.out.println(map_by_study_id.size());
		System.out.println(map_by_study_id.toString());
		model.addAttribute("studymap", map_by_study_id);
		return model;
	}
}