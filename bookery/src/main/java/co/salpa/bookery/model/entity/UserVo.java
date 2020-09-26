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
public class UserVo {

	private int id;
	private String email;
	private String name;
	private String password;
	private String nickname;
	private Date createtime;
	private String tel;
	private String lvl;
	
	public UserVo(String email, String password, String name, String nickname, String tel) {
		this.email = email;
		this.password = password;
		this.name = name;
		this.nickname = nickname;
		this.tel = tel;
	}
}
