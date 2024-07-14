package com.piano.comment;

import java.util.List;

public interface CommentService {

	//댓글 작성
	public void commentWrite(CommentVO commentVO);

	//댓글 목록
	public List<CommentVO> getCommentList(long boardSeq); 

	//대댓글 작성
	public void writeReply(CommentVO commentVO);

	//댓글 수정
	public void modifyComment(CommentVO commentVO);
	
	//댓글 삭제
	public void deleteComment(long commentSeq);

}


