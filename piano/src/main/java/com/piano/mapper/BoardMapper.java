package com.piano.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import com.piano.vo.BoardVO;

@Mapper
public interface BoardMapper {

	//목록조회
	public List<BoardVO> getList();
	

}
