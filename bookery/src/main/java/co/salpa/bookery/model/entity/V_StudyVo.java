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
	private Date createtime;// datetime
	private Date updatetime;// datetime
	private Date startdate;// date
	private Date enddate;// date
	private String memo;// text
	private String type;// varchar(4)
	private int plan_cnt;// bigint
	private int actual_cnt;// bigint
	private int total_cnt;// bigint
	private int total_days;// bigint
	private int days_todate;// bigint
	private int total_pages;// int
	private int plan_page;// int
	private int actual_page;// int
	private double progress_rate;// decimal(28,4)
	private double success_rate;// decimal(28,4)
}
