package co.salpa.bookery.model.entity;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter@Getter
@NoArgsConstructor
@ToString
public class BoardVo {

	private int id;
	private Date createtime;
	private Date updatetime;
	private String title;
	private String content;
	private int ref;
	private int depth;
	private int num;
	private boolean deleted;
	private int user_id;
	private int book_bid;
}
