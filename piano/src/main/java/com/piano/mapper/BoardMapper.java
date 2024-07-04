package com.piano.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.piano.vo.BoardVO;

@Mapper
public interface BoardMapper {

	//목록조회
	public List<BoardVO> getList();
	
	//글작성
	public void contentWrite(BoardVO boardVO);
	
	//최신 글 번호
	public int boardSeq();
	
	//글 조회
	public BoardVO getContent(long boardSeq);
	
	//글 수정
	public void contentModify(BoardVO boardVO);
	
	//글 삭제
	public void contentDelete(long boardSeq);
	
}
