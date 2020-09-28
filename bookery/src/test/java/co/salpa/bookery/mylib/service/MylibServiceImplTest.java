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
