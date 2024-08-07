package com.piano.user;

import com.piano.main.CommonVO;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper=false)
public class UserVO extends CommonVO {

	// USER 사용자
	private Long userSeq; // 사용자 순번
	private String userId; // 사용자 아이디
	private String userNm; // 사용자 이름
	private String password; // 비밀번호
	private String userType; // 사용자 타입

}
