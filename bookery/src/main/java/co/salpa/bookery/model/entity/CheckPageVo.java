package co.salpa.bookery.model.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@NoArgsConstructor
@RequiredArgsConstructor
@AllArgsConstructor
public class CheckPageVo {

	private int id;
	private int planpage;
	private int planpageperday;
	@NonNull
	private int actualpage;
	private int actualpageperday;
	@NonNull
	private int study_id;
	@NonNull
	private Date date;
	@NonNull
	private int deleted;
	
	private Date updatetime;
	
	public CheckPageVo(Date date, int planpage, int study_id) {
		super();
		this.planpage = planpage;
		this.study_id = study_id;
		this.date = date;
	}

}