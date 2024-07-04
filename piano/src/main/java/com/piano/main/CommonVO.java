package com.piano.main;

import lombok.Data;
import java.sql.Timestamp;

@Data
public class CommonVO {
	
	// 공통 사용 컬럼
	private Long regUserSeq; // 사용자 순서
	private Timestamp regDt; // 등록일
	private Long modiUserSeq; // 수정자 순서
	private Timestamp modiDt; // 수정 날짜
	private Long delUserSeq; // 삭제자 순서
	private Timestamp delDt; // 삭제일
	private String delYn; // 삭제 여부

}
