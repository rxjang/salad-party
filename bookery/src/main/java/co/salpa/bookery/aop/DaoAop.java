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
	
	@Before("execution(* co.salpa.bookery.find.service.*Impl.*(..))")
	public void before() {
		log.debug("before dao...");
	}
	//serviceImpl.class내의 list로 시작하는 메소드
	@AfterReturning("execution(* co.salpa.bookery.find.service.*Impl.list*(..))")
	public void afterReturn() {
		log.debug("after success...");
	}
	//serviceImpl.class내의 one으로 시작하는 메소드
	@AfterThrowing("execution(* co.salpa.bookery.find.service.*Impl.one*(..))")
	public void afterThrow() {
		log.debug("after err...");
	}
}
