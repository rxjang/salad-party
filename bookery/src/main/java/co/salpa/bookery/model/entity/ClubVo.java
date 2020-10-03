package co.salpa.bookery.model.entity;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class ClubVo {
	private int id,ref,depth,num,user_id,book_bid,start;
	private String title,content;
	private Date createtime;
	private Timestamp updatetime;
	private String search;
	
	public ClubVo(int id, int book_bid, String title, String content, Date createtime) {
		super();
		this.id = id;
		this.book_bid = book_bid;
		this.title = title;
		this.content = content;
		this.createtime = createtime;
	}
	
	public ClubVo(int id,int ref) {
		this.id = id;
		this.ref = ref;
	}

	public ClubVo(int book_bid, String title, String content, Timestamp updatetime) {
		super();
		this.book_bid = book_bid;
		this.title = title;
		this.content = content;
		this.updatetime = updatetime;
	}

	@Override
	public String toString() {
		return "{\"id\":" + id + ", \"ref\":" + ref + ", \"depth\":" + depth + ", \"num\":" + num + ", \"user_id\":" + user_id
				+ ", \"book_bid\":" + book_bid + ", \"title\":\"" + title + "\", \"content\":\"" + content + "\", \"createtime\":\"" + createtime
				+ "\", \"updatetime\":\"" + updatetime + "\", \"start\":"+start+"}";
	}
// "{ \"key\"  : array [ {}  {} {} {} {} {} {} ]  }";
}
