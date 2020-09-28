package co.salpa.bookery.model.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class StudyVo {

	private int id;
	private Date createtime,updatetime,startdate,enddate;
	private String type,memo;
	private int user_id,book_bid;
	
}
