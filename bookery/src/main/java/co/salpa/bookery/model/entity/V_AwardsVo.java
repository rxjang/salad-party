package co.salpa.bookery.model.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter@Setter
@ToString@NoArgsConstructor
@AllArgsConstructor
public class V_AwardsVo {
	private int id, user_id,checked,award_id;
	private Date awarddate;
	private String medal,criteria;
}
