package com.piano.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.piano.mapper.CommentMapper;
import com.piano.vo.CommentVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class CommentServiceImpl implements CommentService{
	
	@Autowired
	private CommentMapper mapper;
	//댓글 작성
	@Override
    public void commentWrite(CommentVO commentVO) {
		log.info("CommentServiceImpl commentWrite()");
		mapper.commentWrite(commentVO);
    }
	
	
	
}
