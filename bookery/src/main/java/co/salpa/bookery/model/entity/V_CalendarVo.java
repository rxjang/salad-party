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
	private String title;// boot title
	private String url;// mylib/study_id link address
	private int user_id;
	private String sid_date;//"study_id:yyyy-mm-dd"
	private String type;//"chap","page"
	private int study_id;
	private Date start;// date
	private int plan_accum;//누적 페이지/챕터수
	private int actual_accum;//누적 페이지/챕터수
	private int plan_perday;//그날의 페이지/챕터수
	private int actual_perday;//그날의 페이지/챕터수
	private int status;//actual_perday - plan_perday; 그날의 목표량 달성정도 수치
	private String color;//달력에 사용할 배경색
	private String textColor;//달력에 사용할 글자색
}