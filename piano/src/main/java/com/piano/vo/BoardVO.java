package com.piano.vo;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class BoardVO {
	
	    private Long boardSeq;             // 게시글 순서
	    private Long boardGrpSeq;          // 게시글 그룹 순서
	    private Long userSeq;              // 사용자 순서
	    private String boardText;          // 게시글 내용
	    private String boardTitle;         // 게시글 제목
	    private int boardLike;             // 좋아요 수
	    private int boardView;             // 조회수
	    private Long regUserSeq;           // 등록자 순서
	    private Timestamp regDt;           // 등록일
	    private Long modiUserSeq;          // 수정자 순서
	    private Timestamp modiDt;          // 수정 날짜
	    private Long delUserSeq;           // 삭제자 순서
	    private Timestamp delDt;           // 삭제일
	    private String delYn;                // 삭제 여부

	

}
