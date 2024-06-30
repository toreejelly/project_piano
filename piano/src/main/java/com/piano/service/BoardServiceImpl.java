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
	
}
