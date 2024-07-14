package com.piano.comment;

import java.util.List;



import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface CommentMapper {

	//댓글 작성
	public void commentWrite(CommentVO commentVO);
	
	//댓글 목록
	public List<CommentVO> getCommentList(long boardSeq); 
	
	//대댓글 작성
	public void insertReply(CommentVO commentVO);
	
	//댓글 수정
	public void updateComment(CommentVO commentVO);
	
	//댓글 삭제
	public void deleteComment(long commentSeq);
	
}
