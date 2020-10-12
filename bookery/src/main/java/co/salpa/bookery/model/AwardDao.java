package co.salpa.bookery.model;

import org.springframework.dao.DataAccessException;

import co.salpa.bookery.model.entity.AwardVo;

public interface AwardDao {
	
	AwardVo selectAward01(int user_id) throws DataAccessException;
	
	void updateAwardChecked(int award_id) throws DataAccessException;

	void updateMedal1Checked(int user_id) throws DataAccessException;
}
