package co.salpa.bookery.find.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.salpa.bookery.model.V_Readers_cntDao;
import co.salpa.bookery.model.entity.V_Readers_cntVo;

@Service
@Transactional
public class FindWordCloudService {

	@Autowired
	SqlSession sqlSession;

	ObjectMapper mapper = new ObjectMapper();

	/*
	 * 책제목, 커버, 함꼐읽는 사람수. 리스트로 반환.
	 */
	public String listReadersService() throws DataAccessException {
		V_Readers_cntDao v_Readers_cntDao = sqlSession.getMapper(V_Readers_cntDao.class);

		List<V_Readers_cntVo> wordCloud = v_Readers_cntDao.selectAll();
		List<Map<String, String>> titles = new ArrayList<Map<String, String>>();

		String data = "";
		for (V_Readers_cntVo v_Readers_cntVo : wordCloud) {
			// titles.add(v_Readers_cntVo.getTitle());
			// data += v_Readers_cntVo.getTitle() + " ";

			Map<String, String> map = new HashMap<String, String>();
			map.put("bid", v_Readers_cntVo.getBook_bid()+"");
			
			int title_length = v_Readers_cntVo.getTitle().length();
			if(title_length > 8) {
				map.put("title", v_Readers_cntVo.getTitle().substring(0,8));
			}else {
				map.put("title", v_Readers_cntVo.getTitle());
			}
			
			map.put("full_title", v_Readers_cntVo.getTitle());
			map.put("weight",(int)(Math.random()*100)+"");
			titles.add(map);

		}
		String jsonStr = null;
		try {
			jsonStr = mapper.writeValueAsString(titles);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonStr;
		// return model.addAttribute("cntReaders", v_Readers_cntDao.selectAll());
	}// listReadersService
}
