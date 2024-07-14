package com.piano.board;

import java.util.List;

public interface BoardService {


	//목록조회
	public List<BoardVO> getList();
	
	//글작성
	public void contentWrite(BoardVO boardVO);
	
	//최신 글 번호
	public int boardSeq();
	
	//글 조회
	public BoardVO getContent(long boardSeq);
	
	//글 수정 삭제
	public void contentModiAndDel(BoardVO boardVO);
	
	//조회수 증가
	public void boardView(BoardVO boardVO);

}
