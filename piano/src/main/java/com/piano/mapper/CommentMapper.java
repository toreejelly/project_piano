package com.piano.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.piano.vo.CommentVO;

@Mapper
public interface CommentMapper {

	//댓글 작성
	public void commentWrite(CommentVO commentVO);
	
}
