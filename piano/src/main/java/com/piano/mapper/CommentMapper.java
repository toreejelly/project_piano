package com.piano.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.piano.vo.CommentVO;

@Mapper
public interface CommentMapper {

	//댓글 작성
	public void commentWrite(CommentVO commentVO);
	

	//댓글 목록
	public List<CommentVO> getCommentList(long boardSeq); 
	
	//대댓글 작성
	public void replyInsert(CommentVO commentVO);
	
}
