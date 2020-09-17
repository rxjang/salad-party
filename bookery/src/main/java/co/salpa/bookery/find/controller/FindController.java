package co.salpa.bookery.find.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import co.salpa.bookery.model.TocDao;
import lombok.Setter;

@Controller
public class FindController {
   private final String CLIENTID = "INyNwc8RvDNjUoCD9lHg"; // HyeongJin naver api key
   private final String CLIENTSECRET = "e4hlkduAe3";

	@Autowired
	TocDao tocDao;

	@RequestMapping("/find") // 검색페이지로 이동
	public String find() {
		return "/find/find"; // find폴더아래 find.jsp
	}

	@RequestMapping("/find/result") // 검색페이지에 검색결과 전달
	public ModelAndView searchBooks(String search, String select,HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		//request.setCharacterEncoding("utf-8");
		response.setContentType("application/json;charset=utf-8");
		//String text = request.getParameter("search");// 정보처리
		String start = "&start=" + request.getParameter("start");// 검색결과 문서들 읽는 시작순서.
		
		//select = {제목,저자,출판사} 상세검색 요청변수 생성
		String findOpt=detailSeach(select,search);

		System.out.println(search + start);
		try {
			search = URLEncoder.encode(search, "UTF-8");
			System.out.println(search);
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException("encoding error", e);
		} // catch

		String apiURL = "https://openapi.naver.com/v1/search/book.json?query=" + search + start+findOpt; // book search json
		System.out.println(apiURL);

		Map<String, String> requestHeaders = new HashMap<>();
		requestHeaders.put("X-Naver-Client-Id", CLIENTID);
		requestHeaders.put("X-Naver-Client-Secret", CLIENTSECRET);
		String responseBody = get(apiURL, requestHeaders);// 네이버북 검색결과 페이지 내용을 responseBody에 담음

		System.out.println(responseBody);

		PrintWriter out = response.getWriter(); // bookery검색페이지에 네이버책 페이지문서를 전달함
		out.print(responseBody);
		out.close();

		return null;// ajax통신이라 view가 없음
	}// searchBooks

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
	
	public String detailSeach(String select, String word) {
		String findOpt = null;
		if(select.equals("저자")) {
			findOpt = "&d_auth=";
		}else if(select.equals("제목")) {
			findOpt = "&d_titl=";
		}else if(select.equals("출판사")) {
			findOpt = "&d_publ=";
		}
		findOpt+=word;
		return findOpt;
	}

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

	/***************************
	 * 책상세보기 페이지가 로딩될 때 비동기로 책정보 크롤링해서 가져감
	 **********************************/
	@RequestMapping("/find/crawling")
	public ModelAndView crawlingBook(int bid, HttpServletResponse response) throws IOException {
//		int bid = Integer.parseInt(request.getParameter("bid"));
		String url = "https://book.naver.com/bookdb/book_detail.nhn?bid=" + bid;
		Document doc = null;
		System.out.println("크롤링!! url = " + url);
		try {
			doc = Jsoup.connect(url).get();
			// System.out.println(doc);
		} catch (IOException e) {
			e.printStackTrace();
		}
		//System.out.println(doc);
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.print(doc);
		out.close();
		return null;
	}// crawlingBook

}//classEnd