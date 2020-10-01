package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.V_Readers_cntVo;

public interface V_Readers_cntDao {
	
	List<V_Readers_cntVo> selectAll() throws DataAccessException; //같은 책읽는 사람 수 및 책정보. 
	V_Readers_cntVo selectOne(int book_bid) throws DataAccessException;
}
