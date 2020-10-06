package co.salpa.bookery.model.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class V_CalendarVo {
	private String sid_date;//"study_id:yyyy-mm-dd"
	private String type;//"chap","page"
	private int study_id;
	private Date date;
	private int plan;//# of planned pages or chapters of the day
	private int actual;//# of actual pages or chapters of the day
	private int status;//actual - plan
}
