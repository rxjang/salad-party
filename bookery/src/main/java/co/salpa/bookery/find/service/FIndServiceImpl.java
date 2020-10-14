package co.salpa.bookery.find.service;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.imageio.ImageIO;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.jsoup.Connection;
import org.jsoup.Connection.Response;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.parser.Parser;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.salpa.bookery.model.BookDao;
import co.salpa.bookery.model.ClubDao;
import co.salpa.bookery.model.StudyDao;
import co.salpa.bookery.model.TocDao;
import co.salpa.bookery.model.V_Readers_cntDao;
import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.StudyVo;
import co.salpa.bookery.model.entity.TocVo;
import co.salpa.bookery.model.entity.V_Readers_cntVo;

//클래스 내 메소드들을 트랜잭션 처리함. 예외발생 시 데이터액세스 작업의 경우 롤백처리
@Transactional
@Service
public class FIndServiceImpl implements FindService {

	Logger log = LoggerFactory.getLogger(this.getClass());
	@Autowired
	SqlSession sqlSession;

	@Value("#{naver['naver.clientid']}")
	private String client;
	@Value("#{naver['naver.clientsecret']}")
	private String secret;

	/**
	 * sql type 오늘 날짜 구하기 2020-09-24
	 */
	public Date getSqlToday() {
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
		Date today = Date.valueOf(sdf.format(new java.util.Date()));
		return today;
	}// getSqlToday

	/*
	 * 검색페이지에서 검색항목(저자, 출판사, 제목) 선택해서 검색하면 검색결과를 보여주는 순서 start와 검색어search, 검색항목
	 * select를 받아 검색한 뒤 html문서 전체를 결과로 String으로 반환해준다.
	 * 
	 */
	@Override
	public String searchService(int start, String search, String select) {
		// TODO Auto-generated method stub
		// System.out.println(client + secret);
		String param_start = "&start=" + start;// 검색결과 문서들 읽는 시작순서.
		String findOpt = null;
		// select = {제목,저자,출판사} 상세검색 요청변수 생성

		System.out.println(search + start);
		try {
			search = URLEncoder.encode(search.trim(), "UTF-8");// 검색단어는 UTF-8 url로 전달
			System.out.println(search);
			findOpt = detailSearch(select.trim(), search.trim());
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("encoding error", e);

		} // catch
		String apiURL = null;
		if (select.equals("출판사") || select.equals("저자") || select.equals("제목")) {
			param_start = "start=" + start;
			apiURL = "https://openapi.naver.com/v1/search/book_adv.xml?" + param_start + findOpt; // book
		} else {
			apiURL = "https://openapi.naver.com/v1/search/book.xml?query=" + search + param_start; // book
		}
		// search
		System.out.println(apiURL);

		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", client);
		requestHeaders.put("X-Naver-Client-Secret", secret);
		String responseBody = get(apiURL, requestHeaders);// 네이버북 검색결과 페이지 내용을 responseBody에 담음

		return responseBody;
	}// searchService

	public String detailSearch(String select, String word) { // apiURL 요청변수 양식에 맞게 변환
		String findOpt = null;
		if (select.equals("저자")) {
			findOpt = "&d_auth=";
		} else if (select.equals("제목")) {
			findOpt = "&d_titl=";
		} else if (select.equals("출판사")) {
			findOpt = "&d_publ=";
		} else {
			findOpt = "";
		}
		findOpt += word;
		return findOpt;
	}

	private static String get(String apiUrl, Map<String, String> requestHeaders) {
		HttpURLConnection con = connect(apiUrl);
		try {
			con.setRequestMethod("GET");
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				con.setRequestProperty(header.getKey(), header.getValue());
			}

			int responseCode = con.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) { // success 연결성공
				return readBody(con.getInputStream());
			} else { // error
				return readBody(con.getErrorStream());
			}
		} catch (IOException e) {
			throw new RuntimeException("API request, response fail", e);
		} finally {
			con.disconnect();
		}
	}// get

	private static HttpURLConnection connect(String apiUrl) {
		try {
			URL url = new URL(apiUrl);
			return (HttpURLConnection) url.openConnection();
		} catch (MalformedURLException e) {
			throw new RuntimeException("API URL is wrong : " + apiUrl, e);
		} catch (IOException e) {
			throw new RuntimeException("connection fail : " + apiUrl, e);
		}
	}// HttpURLConnection

	private static String readBody(InputStream body) throws UnsupportedEncodingException {
		InputStreamReader streamReader = new InputStreamReader(body, "utf-8");
		// 검색한 책 페이지의 문서내용을 responseBody에 담아서 반환한다.
		try (BufferedReader lineReader = new BufferedReader(streamReader)) {
			StringBuilder responseBody = new StringBuilder();

			String line;
			while ((line = lineReader.readLine()) != null) {
				responseBody.append(line);
			}
			String tmp = new String(responseBody.toString());
			// System.out.println("tmp = " + tmp);
			return tmp;
		} catch (IOException e) {
			throw new RuntimeException("API Reading response fail", e);
		}
	}// readBody

	/****
	 * 
	 * naver books bid로 책 상세검색을 한 결과를 jsoup Document 타입으로 반환한다.
	 * 
	 ****/

	@Override
	public Model crawlingService(int bid, Model model) {
		// TODO Auto-generated method stub
		String url = "https://book.naver.com/bookdb/book_detail.nhn?bid=" + bid;
		Document doc = null;
		String result = null;
		try {
			doc = Jsoup.connect(url).header("path", "/bookdb/book_detail.nhn?bid=" + bid)
					.header("authority", "book.naver.com").header("scheme", "https")
					.header("accept",
							"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9")
					.header("cache-control", "max-age=0").header("accept-encoding", "book.naver.com")
					.header("accept-language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7")
					.header("sec-fetch-dest", "document").header("sec-fetch-mode", "navigate")
					.header("sec-fetch-site", "none").header("sec-fetch-user", "?1")
					.userAgent(
							"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36")
					.timeout(5000).data("query", "Java").get();
			Elements e1 = doc.select("div.book_info");
			Elements e2 = doc.select("div.book_info_inner");
			Elements e3 = doc.select("div#bookIntroContent");
			Elements e4 = doc.select("div#tableOfContentsContent");
			result = e1.toString() + e2.toString() + e3.toString() + e4.toString();
		} catch (IOException e1) {
			e1.printStackTrace();
		}

		return model.addAttribute("crawlingDoc", result);
	}// crawlingService

	/****
	 * 
	 * 목차 중복 처리 및 목차입력, 서비스 트랜잭션과 비즈니스로직 분리
	 * 
	 ****/
	@Override
	public Model listTocService(Model model, int bid) throws DataAccessException {
		// TODO Auto-generated method stub
		BookDao bookDao = sqlSession.getMapper(BookDao.class);
		TocDao tocDao = sqlSession.getMapper(TocDao.class);
		model.addAttribute("book", bookDao.selectOne(bid));
		model.addAttribute("toc", tocDao.selectOne(bid));

		// bookDao.insertOne(new BookVo(1212, null, null, null, 0, null, null, null,
		// null, null, null));
		/*
		 * 트랜잭션 속성에 list* 메소드 read-only속성을 지정해둬서 데이터조작 이 발생하면 예외가 발생한다. SQL [];
		 * Connection is read-only. Queries leading to data modification are not
		 * allowed; nested exception is java.sql.DataAccessException: Connection is
		 * read-only.
		 */
		return model;
	}//

	/****
	 * 
	 * 책 리스트 반환
	 * 
	 ****/
	@Override
	public Model listBookService(Model model) throws DataAccessException {
		// TODO Auto-generated method stub
		BookDao bookDao = sqlSession.getMapper(BookDao.class);
		return model.addAttribute("books", bookDao.selectAll());
	}

	/****
	 * 
	 * 목차 중복 처리 및 목차입력, 서비스 트랜잭션과 비즈니스로직 분리
	 * 
	 ****/

	public void tocsPut(BookVo book, TocDao tocDao, String chapters) throws DataAccessException {

		if (tocDao.selectOne(book.getBid()).size() != 0) {
		} else {
			String[] tmp = chapters.split("\n");
			System.out.println(tmp.toString());
			for (String chapter : tmp) {
				if (chapter.trim().equals("")) { // 빈줄제거
					continue;
				} else {
					tocDao.insertOne(new TocVo(book.getBid(), chapter.trim()));// 목차와 해당목차의 책번호
					// 트랜잭션
					// throw new Exception(); 목차를 하나 입력하고 강제예외발생시키면
					// 먼저 입력한 책 제목 또한 롤백처리됨.
				} // if
			} // for
		} // out if
	}// tocsPut

	/****
	 * 
	 * 검색해서 선택한 책정보를 book테이블에 추가하고 그 책의 목차를 toc테이블에 추가한다.
	 * 
	 * 그리고 study테이블에도 책정보와함게 스터디생성 Transactional 어노테이션으로 insertStudyService 메소드가
	 * 정상종료되기전에 예외가 발생하면 모두 롤백된다. throws SQLException
	 * 
	 ****/
	@Override

	public void insertStudyService(BookVo book, StudyVo study, String chapters) throws DataAccessException {

		// TODO Auto-generated method stub
		BookDao bookDao = sqlSession.getMapper(BookDao.class);
		TocDao tocDao = sqlSession.getMapper(TocDao.class);
		StudyDao studyDao = sqlSession.getMapper(StudyDao.class);

		bookDao.insertOne(book);// 책입력
		tocsPut(book, tocDao, chapters);// 목차들 입력
		studyDao.insertOne(study);// 스터디생성

	}// studyAddService

	/****
	 * 
	 * 가장 많이 공부중인 책 리스트
	 * 
	 ****/

	@Override
	public Model listMostBookService(Model model) throws DataAccessException {
		// TODO Auto-generated method stub
		BookDao bookDao = sqlSession.getMapper(BookDao.class);
		List<BookVo> list = bookDao.selectMostBook();
		model.addAttribute("most_list", list);
		return model;
	}

	/**
	 * DB에 저장되어 있는 책 정보 받아오기. bid 사용
	 */
	@Override
	public Model getBookService(int bid, Model model) throws DataAccessException {
		BookDao bookDao = sqlSession.getMapper(BookDao.class);
		model.addAttribute("book", bookDao.selectOne(bid));
		return model;
	}// detailService

	/**
	 * user id와 bid를 이용해 study중인 공부가 있는지 검사. enddate가 오늘이전인 것중에. ****추후에 좀 더 구체적인
	 * 검증처리할것. 화면에서 내서재담기 버튼을 보일지 말지 결정
	 */

	@Override
	public Model getStudyOverlapChk(int id, int bid, Model model) {
		StudyDao studyDao = sqlSession.getMapper(StudyDao.class);
		List<StudyVo> study = null;
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_id", id + "");
		map.put("book_bid", bid + "");
		map.put("createtime", getSqlToday() + " 23:59:59");// 오늘날짜.
		System.out.println(getSqlToday() + " 23:59:59");
		study = studyDao.selectOneByIdAndBid(map);
		System.out.println(study.toString());

		if (study.size() == 0) {
			System.out.println("중복아님");
			model.addAttribute("studyOverlap", 1); // 중복아닌경우
		} else if (study.size() != 0) {
			System.out.println("중복임");
			model.addAttribute("studyOverlap", 0); // 중복인경우
		}
		model.addAttribute("bid", bid);
		return model;
	}

	@Override
	public void updateService() throws DataAccessException {
		// TODO Auto-generated method stub

	}//

	@Override
	public void deleteService() throws DataAccessException {
		// TODO Auto-generated method stub

	}//

	/*
	 * 책제목, 커버, 함꼐읽는 사람수. 리스트로 반환.
	 */
	@Override
	public String listReadersService() throws DataAccessException {
		V_Readers_cntDao v_Readers_cntDao = sqlSession.getMapper(V_Readers_cntDao.class);

		ObjectMapper mapper = new ObjectMapper();

		List<V_Readers_cntVo> wordCloud = v_Readers_cntDao.selectAll();
		List<String> titles = new ArrayList<String>();
		
		String data = "";
		for (V_Readers_cntVo v_Readers_cntVo : wordCloud) {
			titles.add(v_Readers_cntVo.getTitle());
			data += v_Readers_cntVo.getTitle() + " ";
		}
		String jsonStr = null;
		try {
			jsonStr = mapper.writeValueAsString(titles);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return data;
		// return model.addAttribute("cntReaders", v_Readers_cntDao.selectAll());
	}// listReadersService

	
	

	
	@Override
	public void imageResize(String coverurl, String savedName) throws Exception {
		 
	//	path = "C:\\Users\\jhj71\\Desktop\\eGovFrameDev-3.9.0-64bit\\sts-bundle\\sts-3.9.13.RELEASE\\stsworkspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\bookery\\resources\\cover";
	//	savedName = "ca4afc9b-23b6-4f69-8ed6-f41bb5cdcd31bell-icon.png";
		 
	
		
		Image originalImage = ImageIO.read(new File(coverurl,savedName));

		  int originWidth = originalImage.getWidth(null);
		  int originHeight = originalImage.getHeight(null);

		  int newWidth = 140;

		if (originWidth > 100) {
			 System.out.println("reSize");
		    int newHeight = (originHeight * newWidth) / originWidth;

			Image resizeImage = originalImage.getScaledInstance(newWidth, newHeight, Image.SCALE_SMOOTH);

		    BufferedImage newImage = new BufferedImage(newWidth, newHeight, BufferedImage.TYPE_INT_ARGB);
		    Graphics graphics = newImage.getGraphics();
		    graphics.drawImage(resizeImage, 0, 0, null);
			graphics.dispose();
			
			String resizeImgName = savedName;
			File newFile = new File(coverurl+File.separator+savedName);
		    String formatName = savedName.substring(savedName.lastIndexOf(".") + 1);
		    ImageIO.write(newImage, formatName.toLowerCase(), newFile);
		    
			//transparency(path + File.separator + formatName.toLowerCase());
		    
		  } 
		}//resizeImageFile
	
	
	
	
	
}// ClassEnd
