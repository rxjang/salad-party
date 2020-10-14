package co.salpa.bookery.today.service;

import static org.junit.Assert.*;

import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.Scanner;

import org.apache.ibatis.session.SqlSession;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import co.salpa.bookery.model.CheckPageDao;
import co.salpa.bookery.model.entity.CheckPageVo;
import lombok.NonNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = "classpath:/applicationContext.xml")
public class TodayPageServiceImplTest {

	@Autowired
	SqlSession sqlSession;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
	}

	@Before
	public void setUp() throws Exception {

	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testListV_StudyService() {
	}

	@Test
	public void testGetV_StudyService() {
	}

	@Test
	public void testCheckPageService() throws SQLException {
		// assertNotNull(sqlSession);
		// '34', '2020-09-23 00:00:00', '920', NULL, '0', '3'

		// CheckPageDao dao = sqlSession.getMapper(CheckPageDao.class);
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");

		// java.util.Date now = new Date(2020, 8, 23);

		Date today = Date.valueOf(sdf.format(new java.util.Date()));

		System.out.println(today);

		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.setTime(today);
		cal.add(Calendar.DATE, -1);
		// SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
		String yesterday = sdf.format(cal.getTime());

		System.out.println(yesterday);

//		CheckPageVo bean = new CheckPageVo(34, 920, 909, 3, today, 0);
//		System.out.println(bean);
//		dao.updateOne(bean);

	}

	@Test
	public void testbid() {

		System.out.println(System.currentTimeMillis());
		System.out.println((System.currentTimeMillis() + "").substring(1, 11));
		Scanner sc = new Scanner(System.in);

		while (true) {
			String input = sc.nextLine();
			if (input == "qqq") {
				break;
			} else {
				String s = (System.currentTimeMillis() + "").substring(2, 11);
				System.out.println(-Integer.parseInt(s));

			}

		}
 
	}

}