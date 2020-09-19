package co.salpa.bookery.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
@Aspect
public class LoggerAspect {

	Logger log = LoggerFactory.getLogger(this.getClass());

	//FindService 메소드에만 적용되어있다.
	// 메소드 시작 전에 실행
	@Before("execution(* co.salpa.bookery.find.service.*Impl.*(..))")
	public void before(JoinPoint joinPoint) {
		// getSignature : 조인포인트인 메소드에 대한 정보를 가진 시그니쳐오브젝트 반환
		log.debug("before dao..getDeclaringTypeName." + joinPoint.getSignature().getDeclaringTypeName());
		//Type
		log.debug("before dao..getName." + joinPoint.getSignature().getName());
		//Method Name
		for (Object obj : joinPoint.getArgs()) {
			log.debug("before dao..obj." + obj);
		} // for
		//Parameter Names
		
	}// before
		// serviceImpl.class내의 메소드가 수행을 마쳤을 때
	
	
	
	@AfterReturning(pointcut="execution(* co.salpa.bookery.find.service.*Impl.*(..))",returning="retval")
	public void afterReturn(Object retval) {
		log.debug("after success...");
		//log.debug("after success..retval."+retval);
	}//@AfterReturning target메소드가 정상종료됐을 때 수행. 리턴값을 받을 수 있다.

	
	/* @before @AfterReturning 어드바이스 로그 결과.
	 *  DEBUG: co.salpa.bookery.aop.DaoAop - before dao..getDeclaringTypeName.co.salpa.bookery.find.service.FindService
		DEBUG: co.salpa.bookery.aop.DaoAop - before dao..getName.searchService
		DEBUG: co.salpa.bookery.aop.DaoAop - before dao..obj.1
		DEBUG: co.salpa.bookery.aop.DaoAop - before dao..obj.정보처리
		DEBUG: co.salpa.bookery.aop.DaoAop - before dao..obj.제목
	
		DEBUG: co.salpa.bookery.aop.DaoAop - after success..retval.{"lastBuildDate": "Sat, 19 Sep 2020 17:12:48 +0900","total": 21092,"start": 1,
		"display": 10,"items": [{"title": "<b>정보처리</b>기사 실기(2020)(수제비) (NCS 기반으로 재구성한 합격비법서)",
		"link": "http://book.naver.com/bookdb/book_detail.php?bid=16311458",
		"image": "https://bookthumb-phinf.pstatic.net/cover/163/114/16311458.jpg?type=m1&udate=20200701",
		"author": "NCS <b>정보처리</b>기술사 연구회","price": "30000","discount": "27000",
		"publisher": "건기원","pubdate": "20200325","isbn": "115767500X 9791157675005",
		....................................}검색결과 
	 */

	// serviceImpl.class내의 메소드가 예외를 발생시켰을 시 동작
	@AfterThrowing("execution(* co.salpa.bookery.find.service.*Impl.*(..))")
	public void afterThrow() {
		log.debug("after err...");
	}
}
