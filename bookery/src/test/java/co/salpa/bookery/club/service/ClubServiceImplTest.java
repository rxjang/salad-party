package co.salpa.bookery.club.service;


import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.salpa.bookery.model.ClubDao;
import co.salpa.bookery.model.entity.UserVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = "classpath:/applicationContext.xml")
public class ClubServiceImplTest {

	@Autowired
	SqlSession sqlSession;
	
	ObjectMapper objectMapper = new ObjectMapper();
	
	@Test
	public void testListRecommendByUserService() {

		ClubDao clubDao = sqlSession.getMapper(ClubDao.class);
		List<Integer> list = clubDao.selectAllRecommend(3);
		System.out.println(list.toString());
		String json = "";
		
		try {
			json = objectMapper.writeValueAsString(list);
			System.out.println(json);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
