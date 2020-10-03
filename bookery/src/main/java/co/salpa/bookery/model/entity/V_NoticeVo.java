package co.salpa.bookery.model.entity;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class V_NoticeVo {
	private int id,deleted,user_id;
	private String title,content,answer;
	private Timestamp createtime, answertime;
}
