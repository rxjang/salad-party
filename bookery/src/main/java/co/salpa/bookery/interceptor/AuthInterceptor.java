package co.salpa.bookery.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
    
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        
        HttpSession session = request.getSession();
        
        if(session.getAttribute("user") == null) {
        
            logger.info("current user is not logined");
            
            // 로그인하지 않은 사용자일 경우 로그인 페이지로 이동
            response.sendRedirect("/bookery/account/login");
            saveDest(request);
            
            return false;
        }
        
        // 로그인한 사용자일 경우 Controller 호출
        logger.info("current user is logined");
        return true;
    }
	
	// 로그인 페이지 이동 전, 현재 페이지를 Session에 저장
	private void saveDest(HttpServletRequest request) {

	    String uri = request.getRequestURI();

	    String query = request.getQueryString();
	    
	    // 기존 URI에 parameter가 있을 경우, 이를 포함
	    if(query == null || query.equals("null")) {
	    	query = "";
	    } else {
	        query = "?" + query;
	    }
	    
	    if(request.getMethod().equals("GET")) {
	        logger.info("dest: " + (uri + query));
	        request.getSession().setAttribute("dest", uri + query);
	    }
	}
}
