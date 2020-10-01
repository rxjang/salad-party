package co.salpa.bookery.model.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class V_Readers_cntVo {
	private int book_bid,readers;
	private String title, coverurl;
}
