package co.salpa.bookery.today.service;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import co.salpa.bookery.model.BookDao;
import co.salpa.bookery.model.CheckPageDao;
import co.salpa.bookery.model.StudyDao;
import co.salpa.bookery.model.TocDao;
import co.salpa.bookery.model.V_StudyDao;
import co.salpa.bookery.model.entity.CheckPageVo;
import co.salpa.bookery.model.entity.TocVo;
import co.salpa.bookery.model.entity.V_StudyVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = "classpath:/applicationContext.xml")
public class TodayServiceImplTest {

	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testListTodayStudiesService() {
	}

	@Test
	public void testListStudy_IDService() {
	}

	@Test
	public void testListCheckChapService() {
		//user id >> study id얻음.list
	
		
		V_StudyDao v_studyDao = sqlSession.getMapper(V_StudyDao.class);
		StudyDao studyDao = sqlSession.getMapper(StudyDao.class);
		
		Map<Integer, V_StudyVo> user_v_study = new HashMap<Integer, V_StudyVo>(); //study id 와 v_study 
		
		List<Integer> study_id = studyDao.selectIdByUserId(3); //userid로 study id 얻음
		
		for (Integer i : study_id) {
			V_StudyVo v_study = v_studyDao.selectOneByStudyId(i);
			user_v_study.put(i, v_study);
		}//for
		//user_v_study에 모든 study id의 v_study가 저장됨. 
		
		
		//책목차. study id로 bid를 구하고 bid로 목차를 구해서 list에 넣는다. 
		BookDao bookDao = sqlSession.getMapper(BookDao.class);
		TocDao tocDao = sqlSession.getMapper(TocDao.class);
		
		Map<Integer, List<TocVo>> user_study_toc = new HashMap<Integer, List<TocVo>>();
		for (Integer i : study_id) {
			
			V_StudyVo v_study = v_studyDao.selectOneByStudyId(i); //study id를 얻음. 위와중복되는코드. 
			//목차를 List로 반환
			user_study_toc.put(i, tocDao.selectOne(v_study.getBook_bid()));
			//user_study_toc맵에 study id 별로 책의 목차리스트를 value로 넣음
			
			//System.out.println(tocDao.selectOne(v_study.getBook_bid()).toString());
		}//for
		
		
		CheckPageDao checkPageDao = sqlSession.getMapper(CheckPageDao.class);
		Map<Integer, List<CheckPageVo>> user_chk_page = new HashMap<Integer, List<CheckPageVo>>();
		
		for (Integer i : study_id) {

			user_chk_page.put(i, checkPageDao.selectAll(i)); //study id별로 checkpageVO 리스트 담음
		}
		
		
		Map<Integer, List> user_today = new HashMap<Integer, List>();
		
		//이 맵에 최종적으로 key=userid value=sutdy_info List를 담아서 jsp로 보낸다. 
		//*****************************************************************************
		//user당 study가 여러개니까 Map<Integer, Map>으로 가야할듯..
		//Map<user id, map<studyid, study_info(List<Object>)>> user_today = new HashMap<>();
		//*****************************************************************************
		
		
		//user의 study id와 여러정보가 리스트로 담김.
		//add순서를 정해서 인덱스번호로 무슨정보인지 알 수 있다. 
		List<Object> study_info = new ArrayList<Object>();
		study_info.add(1);
		study_info.add(user_v_study);//스터디 아이디별로 V_studyVO
		study_info.add(user_chk_page);//스터디 아이디별로 chkpageVO담겨있음
		study_info.add(user_study_toc);//스터디 아이디별로 tocVO담겨있음
		
		
		
		user_today.put(3, study_info); //user id와 List
		//인덱스 0번 >> 스터디아이디, 
		/*
		 * 인덱스 0번 study id
		 * 인덱스 1번 v study
		 * 인덱스 2번 chkpage vo
		 * 인덱스 3번 toc
		 */
		Map<Integer, V_StudyVo> v1 =  (Map<Integer, V_StudyVo>) study_info.get(1);
		
		Map<Integer, List<CheckPageVo>> v2 = (Map<Integer, List<CheckPageVo>>) study_info.get(2);
		
		Map<Integer, List<TocVo>> v3 =  (Map<Integer, List<TocVo>>) study_info.get(3);
		
		Set set1 = v1.keySet();
		Iterator ite1 = set1.iterator();
		while(ite1.hasNext()) {
			
			//System.out.println(ite1.next());//key
			System.out.println(v1.get(ite1.next()).toString());//
		}
		
		
		Set set2 = v2.keySet();
		Iterator ite2 = set2.iterator();
		while(ite2.hasNext()) {
			System.out.println("chkpage");
			//System.out.println(ite1.next());//key
			for (CheckPageVo chkpage : v2.get(ite2.next())) {
				System.out.println(chkpage.toString());
			}
		}
		
		
		//System.out.println(v3.toString());
		Set set3 = v3.keySet();
		Iterator ite3 = set3.iterator();
		System.out.println("toc1");
		while(ite3.hasNext()) {
			System.out.println("toc");
		//	System.out.println(ite3.next());//key
			
			//System.out.println(v3.get(ite1.next()));//
			for (TocVo toc : v3.get(ite3.next())) {
				System.out.println(toc.toString());
			}
		}

		System.out.println("list size = " + study_info.size());
		//System.out.println(study_info.toString());
		System.out.println();
	}

}
