package com.piano.comment;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	//댓글 목록
	@Override
	public List<CommentVO> getCommentList(long boardSeq){
		log.info("CommentServiceImpl getCommentList()");
		return mapper.getCommentList(boardSeq);
	} 
	
	
	//대댓글 작성
	@Override
	public void writeReply(CommentVO commentVO) {
		log.info("CommentServiceImpl replyWrite()");
		mapper.insertReply(commentVO);
	}

	//댓글 수정
	@Override
	public void modifyComment(CommentVO commentVO) {
		log.info("CommentServiceImpl modifyComment()");
		mapper.updateComment(commentVO);
	}
	
	//댓글 삭제
	@Override
	public void deleteComment(long commentSeq) {
		log.info("CommentServiceImpl deleteComment()");
		mapper.deleteComment(commentSeq);
		
	}
	
}
