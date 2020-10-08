package co.salpa.bookery.model;

import java.util.List;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.V_AwardsVo;

public interface V_AwardsDao {
	int countAchieveMedal(int id) throws DataAccessException;
	
	List<V_AwardsVo> selectAchieveMedal(int user_id) throws DataAccessException;
}
