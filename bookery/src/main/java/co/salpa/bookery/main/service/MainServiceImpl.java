package co.salpa.bookery.main.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import co.salpa.bookery.model.BookDao;
import co.salpa.bookery.model.entity.BookVo;

@Repository
public class MainServiceImpl implements MainService{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public Model bookCoverService(Model model) throws DataAccessException {
		BookDao bookDao=sqlSession.getMapper(BookDao.class);
		
		List<BookVo> list=bookDao.selectThirtyBook();
		return model.addAttribute("list",list);
	}

}
