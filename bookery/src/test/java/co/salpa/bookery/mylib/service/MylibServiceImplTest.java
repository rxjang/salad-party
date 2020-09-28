package co.salpa.bookery.mylib.service;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.*;

import java.sql.Date;
import java.util.Calendar;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import co.salpa.bookery.model.CheckPageDao;
import co.salpa.bookery.model.entity.CheckPageVo;
import co.salpa.bookery.model.entity.StudyVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = "classpath:/applicationContext.xml")
public class MylibServiceImplTest {
	
	@Autowired
	SqlSession sqlSession;
	
	StudyVo studyVo;
	
	CheckPageDao dao;
	
	@Before
	public void setUp(){
		studyVo=new StudyVo(7,new Date(2020,9,25),new Date(2020,9,25),new Date(2020,9,25),new Date(2020, 9, 27), "page",null,3,1579908);
	}

	@Test
	public void basicTest(){
		assertThat(this.studyVo,is(notNullValue()));
	}
	
	@Test
	public void testInsertPageStudyPlanService() {
		
	}

	@Test
	public void testInsertToCheckPage() {
		CheckPageDao checkPageDao=sqlSession.getMapper(CheckPageDao.class);
		MylibServiceImpl mylibService = new MylibServiceImpl();
		System.out.println(mylibService);
		mylibService.insertToCheckPage(checkPageDao, this.studyVo, 3, 100);
//		CheckPageVo checkPageVo=new CheckPageVo();
//		System.out.println(checkPageVo);
//		assertSame(checkPageVo.getPlanpage(),100);
		/*
		 * 테스트 연결이왜이렇게 안되는지 모르겠는데.,,,checkPageDao MylibService등 다 autowired가 안먹더라구요
		 * 그래서 테스트 메소드 안에서 이렇게하고 했는데 CheckPageVo를 객체로 만들면 기본값이니까 테스트가 안돼서...
		 * 본 메소드에서 syso하니까 나오네요 테스트하고싶으면 임시로 그렇게 해보셔도 됩니다 
		 * 나중에 수정하겠습니다
		 */
	}

	@Test
	public void testNextDay(){
		java.util.Date date=studyVo.getStartdate();
		System.out.println(date);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DATE,1);
		date=calendar.getTime();
		Date today=new Date(date.getTime());
		System.out.println(today);
	}
}
