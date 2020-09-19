package co.salpa.bookery.aop;

import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository
@Aspect
public class DaoAop {
	
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	
	
	//서비스 클래스의 메소드들의 공통기능이 있다면 advice로 분리한다.
	//메소드 시작 전에 실행
	@Before("execution(* co.salpa.bookery.find.service.*Impl.*(..))")
	public void before() {
		log.debug("before dao...");
	}
	//serviceImpl.class내의 메소드가 수행을 마쳤을 때
	@AfterReturning("execution(* co.salpa.bookery.find.service.*Impl.*(..))")
	public void afterReturn() {
		log.debug("after success...");
	}
	//serviceImpl.class내의 메소드가 예외를 발생시켰을 시 동작
	@AfterThrowing("execution(* co.salpa.bookery.find.service.*Impl.*(..))")
	public void afterThrow() {
		log.debug("after err...");
	}
}
