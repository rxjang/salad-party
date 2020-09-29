package co.salpa.bookery.model;

import org.springframework.dao.DataAccessException;

public interface V_AwardsDao {
	int countAchieveMedal(int id) throws DataAccessException;
}
