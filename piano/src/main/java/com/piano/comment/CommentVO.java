package com.piano.comment;



import java.sql.Timestamp;

import lombok.Data;


@Data
public class CommentVO {

	private Long parentCommentSeq;
	private String commentText;
	private Long commentSeq;
	private Long boardSeq;
	private Long boardGrpSeq;
	private Long regUserSeq;
	private String commentNm;
	private Timestamp regDt;
	private Long modiUserSeq;
	private Timestamp modiDt;
	private Long delUserSeq;
	private Timestamp delDt;
	private String delYn;
	private String userNickname;	// 사용자 닉네임
	private Long level;				//댓글 들여쓰기

}
