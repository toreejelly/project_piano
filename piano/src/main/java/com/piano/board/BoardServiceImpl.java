package com.piano.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
		
		return mapper.getListContent();
	}
	
	//글 조회
	@Override
	public BoardVO getContent(long boardSeq) {
		log.info("BoardServiceImpl getContent()");
		return mapper.getListContent(boardSeq);
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
	
	
	//글 수정 삭제
	@Override
	public void contentModiAndDel(BoardVO boardVO) {
		mapper.contentModiAndDel(boardVO);
	}
	
	//조회수 증가
	@Override
	public void boardView(BoardVO boardVO) {
		log.info("BoardServiceImpl boardView()");
		mapper.contentModiAndDel(boardVO);
	}
}
