package co.salpa.bookery.model.entity;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter@Setter
@ToString@NoArgsConstructor
public class V_StudyVo {
	private int user_id;
	private String nickname; // varchar(45)
	private int book_bid;// int
	private String title;// varchar(300)
	private String coverurl;// varchar(300)
	private int study_id;// int
	private int pages;
	private Date createtime;// datetime
	private Date updatetime;// datetime
	private Date startdate;// date
	private Date enddate;// date
	private String memo;// text
	private String type;// varchar(4)
	
	private int plan_chap;// bigint
	private int plan_chap_yesterday;// bigint
	private int actual_chap_yesterday;// bigint
	private int actual_chap;// bigint
	private int total_chap;// bigint
	
	private int total_pages;// int
	private int plan_page;// int
	private int plan_page_yesterday;// bigint
	private int actual_page_yesterday;// bigint
	private int actual_page;// int
	
	private int total_days;// bigint 목표설정한 날짜 count
	private int plan_days_yesterday;// bigint 목표 설정한 날짜 count by 어젯밤
	private int actual_days_yesterday;// bigint 공부입력한 날짜 count by 어젯밤
	private int remain_days;// bigint 오늘 포함 남은 날짜 count
	private double progress_rate;// decimal(28,4)
	private double success_rate;// decimal(28,4)
}