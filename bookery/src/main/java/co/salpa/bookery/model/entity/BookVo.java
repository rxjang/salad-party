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
public class BookVo {

	private int bid;
	private String title,writer,publisher;
	private int pages;
	private String category,translator,titleoriginal,revision;
	private Date publicationdate;
	private String coverurl;
	
	
}
