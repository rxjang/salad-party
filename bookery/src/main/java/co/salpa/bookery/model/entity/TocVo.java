package co.salpa.bookery.model.entity;

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
public class TocVo { //목차테이블
	
	//toc id는 자동증가ai
	private int book_bid;
	private String toc;
}
