package com.piano.service;

import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.piano.mapper.BoardMapper;
import com.piano.vo.BoardVO;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;
	
	//목록조회
	@Override
	public List<BoardVO> getList(){
		log.info("BoardServiceImpl getList()");
		
		return mapper.getList();
	}
	
	//글 작성	
	@Override
	public void contentWrite(BoardVO boardVO) {
		mapper.contentWrite(boardVO);
	}
	
	//최신 글 번호
	@Override
	public int boardSeq() {
		return mapper.boardSeq();
	}
	
	//글 조회
	@Override
	public BoardVO getContent(long boardSeq) {
		
		return mapper.getContent(boardSeq);
	}
	
	//글 수정
	@Override
	public void contentModify(BoardVO boardVO) {
		mapper.contentModify(boardVO);
	}
	
	//글 삭제
	public void contentDelete(long boardSeq) {
		mapper.contentDelete(boardSeq);
	}
}
