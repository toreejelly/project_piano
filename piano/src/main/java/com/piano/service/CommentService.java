package com.piano.service;

import java.util.List;



import com.piano.vo.CommentVO;

public interface CommentService {

	//댓글 작성
	public void commentWrite(CommentVO commentVO);

	//댓글 목록
	public List<CommentVO> getCommentList(long boardSeq); 

	//대댓글 작성
	public void replyWrite(CommentVO commentVO);


}


