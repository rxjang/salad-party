package co.salpa.bookery.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import co.salpa.bookery.model.entity.UserVo;

public class LoginInterceptor implements HandlerInterceptor {

	private static final String USER = "user";
    private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	 
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
        
        if(session.getAttribute(USER) != null) {
        
            // 기존 HttpSession에 남아있는 정보가 있는 경우 이를 삭제
            logger.info("clear login data before");
            session.removeAttribute(USER);
        }
        
        return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		HttpSession session = request.getSession();
		UserVo userBean = (UserVo) session.getAttribute("user");
//        Object userVo = modelMap.get("user");
//        
//        System.out.println((UserVo)userVo);
//        
        if(userBean != null) {
//        
            // 로그인 성공시 Session에 저장후, 초기 화면 이동
            logger.info("new login success");
            session.setAttribute("user", userBean);
            Object dest = session.getAttribute("dest");
            
//            if(dest != null) 
//            	response.sendRedirect((String)dest);
//            response.sendRedirect("/");
        }
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		
	}

}
