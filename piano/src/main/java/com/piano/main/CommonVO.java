package com.piano.main;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CommonVO {

	// 공통
	private long regUserSeq; // 사용자 순서
	private Timestamp regDt; // 등록일
	private long modiUserSeq; // 수정자 순서
	private Timestamp modiDt; // 수정 날짜
	private long delUserSeq; // 삭제자 순서
	private Timestamp delDt; // 삭제일
	private String delYn; // 삭제 여부

}
