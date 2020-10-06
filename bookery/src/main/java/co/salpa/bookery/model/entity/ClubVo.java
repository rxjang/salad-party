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
@NoArgsConstructor
public class ClubVo {
	private int id,ref,depth,num,user_id,book_bid,start;
	private String title,content,book_title,coverurl,writer;
	private Date createtime;
	private Timestamp updatetime;
	private String search,nickname;
	private int reply;
	
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
				+ "\", \"updatetime\":\"" + updatetime + "\", \"start\":"+start+",\"nickname\":\""+nickname+"\",\"reply\":\""+reply+"\"}";
	}

	public ClubVo(int id, int ref, int depth, int num, int user_id, int book_bid, int start, String title,
			String content, Date createtime, Timestamp updatetime, String search, String nickname) {
		super();
		this.id = id;
		this.ref = ref;
		this.depth = depth;
		this.num = num;
		this.user_id = user_id;
		this.book_bid = book_bid;
		this.start = start;
		this.title = title;
		this.content = content;
		this.createtime = createtime;
		this.updatetime = updatetime;
		this.search = search;
		this.nickname = nickname;
	}

	public ClubVo(int id, int book_bid, String title, String content, String book_title, String coverurl, String writer,
			Date createtime, String nickname) {
		super();
		this.id = id;
		this.book_bid = book_bid;
		this.title = title;
		this.content = content;
		this.book_title = book_title;
		this.coverurl = coverurl;
		this.writer = writer;
		this.createtime = createtime;
		this.nickname = nickname;
	}

	
// "{ \"key\"  : array [ {}  {} {} {} {} {} {} ]  }";
}
