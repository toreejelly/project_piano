package com.piano.board;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardMapper {

	//목록조회
	public List<BoardVO> getListContent();
	
	//글 조회 목록조회 
	public BoardVO getListContent(long boardSeq);
	
	//글작성
	public void contentWrite(BoardVO boardVO);
	
	//최신 글 번호
	public int boardSeq();
		
	//글 수정 삭제 조회수증가
	public int contentModiAndDel(BoardVO boardVO);
		

}
