package com.piano.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

import com.piano.service.BoardService;
import com.piano.service.CommentService;
import com.piano.vo.BoardVO;
import com.piano.vo.CommentVO;

//import ch.qos.logback.core.model.Model;
import org.springframework.ui.Model;


//import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j2;   

@Log4j2
@Controller
public class BoardController {

	@Autowired
	//의존성 주입 기능을 지원하는 어노테이션.
	//의존성 주입 : 객체가 의존하는 또 다른 객체를 외부에서 선언하고 이를 주입하는 것이 의존성 주입(DI)이다.
	//스프링이 자동으로 의존성을 주입하는 역할을 수행한다.
	//클래스 A가 다른 클래스 B를 이용할 때 A가 B에 의존한다고 한다. 이런 관계에서 A는 B없이 작동할 수 없다.	
	private BoardService boardService;
	@Autowired
	private CommentService commentService;
	
	//목록 조회
    @GetMapping("/list")
    public String list(Model model) {
		log.info("BoardController list()");
		
		model.addAttribute("list", boardService.getList());
		
		return "list";
    }
    
    //글쓰기 페이지
    @GetMapping("/contentWriteForm")
    public String contentWriteForm() {
    	log.info("BoardController contentWriteForm()");
    	
    	return "contentWriteForm";
    }
    
    //글작성
    @PostMapping("/contentWrite")
    public ResponseEntity<String> contentWrite(@RequestBody BoardVO boardVO){
    	log.info("BoardController contentWrite()");
    	log.info("boardVO :" +boardVO);
    	ResponseEntity<String> entity = null;
    	
    	try {
    		boardService.contentWrite(boardVO);
    		
    		int boardSeq = boardService.boardSeq();
    		String strBoardSeq = Integer.toString(boardSeq);
    		log.info("boardSeq :" +boardSeq);
    		
    		entity = new ResponseEntity<String>(strBoardSeq, HttpStatus.OK);
    	}catch(Exception e) {
    		e.printStackTrace();
    		entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
    	}//end
    	
    	return entity;
    } 
    
    
    //글 조회
//    @GetMapping("/board/{boardSeq}")
//    public String contentViewForm(Model model, BoardVO boardVO) {
//    	log.info("BoardController contentViewForm()");
//    	log.info("boardVO :" + boardVO);
//    	
//    	long boardSeq = boardVO.getBoardSeq();
//    	log.info("boardSeq :" + boardSeq);
//    	
//    	model.addAttribute("content", boardService.getContent(boardSeq));
//    	
//    	return "contentViewForm";
//    	
//    }
    
    // 글 조회
    @GetMapping("/board/{boardSeq}")
    public String contentViewForm(Model model, @PathVariable("boardSeq") long boardSeq) {
        // 게시글 내용 조회
        BoardVO board = boardService.getContent(boardSeq);
        model.addAttribute("content", board);

        // 댓글 목록 조회
        //service로 가저오는 방법
        List<CommentVO> commentList = commentService.getCommentList(boardSeq);
        model.addAttribute("commentList", commentList);

        //CommentController의 메서드를 직접 호출하는 방법
        
        
        return "contentViewForm"; // contentViewForm.jsp 페이지로 반환
    }
    
    
    //글 수정 페이지
    @GetMapping("/contentModifyForm/{boardSeq}")
    public String contentModifyForm(Model model, BoardVO boardVO) {
    	log.info("BoardController contentModifyForm()");
    	log.info("boardVO :" + boardVO);
    	
    	long boardSeq = boardVO.getBoardSeq(); 
    	log.info("boardSeq :" + boardSeq);
    	
    	model.addAttribute("content", boardService.getContent(boardSeq));
    	
    	return "contentModifyForm";
    }
    
    
    //글 수정
    @PutMapping("/board/{boardSeq}")
    public ResponseEntity<String> contentModify(@RequestBody BoardVO boardVO){
     	log.info("BoardController contentModify()");
    	log.info("boardVO : " + boardVO);
    	
    	ResponseEntity<String> entity = null;
    	
    	try {
    		boardService.contentModify(boardVO);
    		
    		entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
    		
    	}catch(Exception e) {
    		e.printStackTrace();
    		entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
    		
    	}
    	
    	return entity;
    }
    
    //글 삭제
    @DeleteMapping("/board/{boardSeq}")
    public ResponseEntity<String> contentDelete(@RequestBody BoardVO boardVO) {
		log.info("BoardController contentDelete()");
		log.info("boardVO : " + boardVO);

		ResponseEntity<String> entity = null;
		long boardSeq = boardVO.getBoardSeq();
	
		try {
			boardService.contentDelete(boardSeq);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
						
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}//end
		
		return entity;
    }
    
}


