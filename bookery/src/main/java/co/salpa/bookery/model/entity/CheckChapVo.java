package co.salpa.bookery.model.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class CheckChapVo {
	
	private int id;
	private String toc;
	private Date plantime,actultime;
	private int deleted;
	private int study_id;
}
