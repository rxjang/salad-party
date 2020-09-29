package co.salpa.bookery.model.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ClubVo {
	int id,ref,depth,num,user_id,book_bid;
	String title,content;
	Date createtime,updatetime;
	
	public ClubVo(int id, int book_bid, String title, String content, Date createtime) {
		super();
		this.id = id;
		this.book_bid = book_bid;
		this.title = title;
		this.content = content;
		this.createtime = createtime;
	}
	
	
}
