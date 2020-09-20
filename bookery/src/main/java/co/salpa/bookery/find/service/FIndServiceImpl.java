package co.salpa.bookery.find.service;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import co.salpa.bookery.model.BookDao;
import co.salpa.bookery.model.StudyDao;
import co.salpa.bookery.model.TocDao;
import co.salpa.bookery.model.entity.BookVo;
import co.salpa.bookery.model.entity.StudyVo;
import co.salpa.bookery.model.entity.TocVo;

//클래스 내 메소드들을 트랜잭션 처리함. 예외발생 시 데이터액세스 작업의 경우 롤백처리
@Transactional
@Service
public class FIndServiceImpl implements FindService {

	Logger log = LoggerFactory.getLogger(this.getClass());

	private final String CLIENTID = "INyNwc8RvDNjUoCD9lHg"; // HyeongJin naver api key
	private final String CLIENTSECRET = "e4hlkduAe3";

	@Autowired
	SqlSession sqlsession;

	/****
	 * 
	 * 검색페이지에서 검색항목(저자, 출판사, 제목) 선택해서 검색하면 검색결과를 보여주는 순서 start와 검색어search, 검색항목
	 * select를 받아 검색한 뒤 html문서 전체를 결과로 String으로 반환해준다.
	 * 
	 ****/
	
	@Override
	public String searchService(int start, String search, String select) {
		// TODO Auto-generated method stub

		String param_start = "&start=" + start;// 검색결과 문서들 읽는 시작순서.
		String findOpt=null;
		// select = {제목,저자,출판사} 상세검색 요청변수 생성
			findOpt = detailSearch(select, search);

		System.out.println(search + start);
		try {
			search = URLEncoder.encode(search, "UTF-8");// 검색단어는 UTF-8 url로 전달
			System.out.println(search);
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("encoding error", e);
		} // catch

		String apiURL = "https://openapi.naver.com/v1/search/book.json?query=" + search + param_start + findOpt; // book
																													// search
		System.out.println(apiURL);
		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", CLIENTID);
		requestHeaders.put("X-Naver-Client-Secret", CLIENTSECRET);
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
	public Document crawlingService(int bid) {
		// TODO Auto-generated method stub
		String url = "https://book.naver.com/bookdb/book_detail.nhn?bid=" + bid;
		Document doc = null;
		System.out.println("크롤링 url = " + url);
		try {
			doc = Jsoup.connect(url).get();
			// System.out.println(doc);
		} catch (IOException e) {
			e.printStackTrace();
		}
		// System.out.println(doc);
		return doc;
	}// crawlingService

	/****
	 * 
	 * 목차 중복 처리 및 목차입력, 서비스 트랜잭션과 비즈니스로직 분리
	 * 
	 ****/
	@Override
	public Model listTocService(Model model, int bid) throws SQLException {
		// TODO Auto-generated method stub	
		BookDao bookDao = sqlsession.getMapper(BookDao.class);
		TocDao tocDao = sqlsession.getMapper(TocDao.class);
		model.addAttribute("book", bookDao.selectOne(bid));
		model.addAttribute("bookChapters", tocDao.selectOne(bid));
		
		//bookDao.insertOne(new BookVo(1212, null, null, null,  0, null, null, null, null, null, null));
		/*	트랜잭션 속성에 list* 메소드 read-only속성을 지정해둬서 데이터조작 이 발생하면 예외가 발생한다.
		 * SQL []; Connection is read-only. Queries leading to data modification are not allowed;
		 *  nested exception is java.sql.SQLException: Connection is read-only.
		 */
		return model;
	}//

	/****
	 * 
	 * 책 리스트 반환
	 * 
	 ****/
	@Override
	public Model listBookService(Model model) throws SQLException {
		// TODO Auto-generated method stub
		BookDao bookDao = sqlsession.getMapper(BookDao.class);
		return model.addAttribute("books", bookDao.selectAll());
	}

	/****
	 * 
	 * 목차 중복 처리 및 목차입력, 서비스 트랜잭션과 비즈니스로직 분리
	 * 
	 ****/

	public void tocsPut(BookVo book, TocDao tocDao, String chapters) throws SQLException {

		if (tocDao.selectOne(book.getBid()).size() != 0) {
		} else {
			String[] tmp = chapters.split("\n");
			System.out.println(tmp.toString());
			for (String chapter : tmp) {
				if (chapter.trim().equals("")) { // 빈줄제거
					continue;
				} else {
					tocDao.insertOne(new TocVo(book.getBid(), chapter.trim()));// 목차와 해당목차의 책번호
					//트랜잭션
					//throw new Exception(); 목차를 하나 입력하고 강제예외발생시키면 
					//먼저 입력한 책 제목 또한 롤백처리됨. 
				} // if
			} // for
		} // out if
	}// tocsPut

	/****
	 * 
	 * 검색해서 선택한 책정보를 book테이블에 추가하고 그 책의 목차를 toc테이블에 추가한다.
	 * 
	 * 그리고 study테이블에도 책정보와함게 스터디생성
	 * Transactional 어노테이션으로 insertStudyService 메소드가 정상종료되기전에 예외가 발생하면
	 * 모두 롤백된다.
	 * 
	 ****/
	@Override
	public void insertStudyService(BookVo book, StudyVo study, String chapters) throws SQLException {
		// TODO Auto-generated method stub
		BookDao bookDao = sqlsession.getMapper(BookDao.class);
		TocDao tocDao = sqlsession.getMapper(TocDao.class);
		StudyDao studyDao = sqlsession.getMapper(StudyDao.class);

		bookDao.insertOne(book);// 책입력
		tocsPut(book, tocDao, chapters);// 목차들 입력
	}// studyAddService

	

	/****
	 * 
	 * 가장 많이 공부중인 책 리스트
	 * 
	 ****/
	
	@Override
	public Model listMostBookService(Model model) throws SQLException {
		// TODO Auto-generated method stub
		BookDao bookDao = sqlsession.getMapper(BookDao.class);
		List<BookVo> list = bookDao.selectMostBook();
		model.addAttribute("most_list",list);
		return model;
	}
	@Override
	public void detailService() throws SQLException {
		// TODO Auto-generated method stub

	}//

	@Override
	public void updateService() throws SQLException {
		// TODO Auto-generated method stub

	}//

	@Override
	public void deleteService() throws SQLException {
		// TODO Auto-generated method stub

	}//


}// ClassEnd
