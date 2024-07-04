package com.piano.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.piano.service.CommentService;
import com.piano.vo.CommentVO;

import lombok.extern.log4j.Log4j2;

@Log4j2
//@Controller: 메서드가 반환하는 값이 뷰 이름으로 간주되며, 그 뷰를 통해 HTML 페이지를 렌더링합니다.
//@RestController: 메서드가 반환하는 값이 HTTP 응답 본문으로 직접 변환됩니다.
@RestController

//이 컨트롤러의 기본 URL 경로를 /comments로 설정합니다. 이 클래스의 모든 메서드는 /comments 경로를 기준으로 매핑됩니다.
@RequestMapping("/comments")
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	
	
	 //댓글 작성
    @PostMapping("/")
    public String commentWrite(@RequestBody CommentVO commentVO) {
    	log.info("CommentController commentWrite()");
    	log.info("commentVO :" + commentVO);
    	
        // 댓글 서비스에서 댓글 객체를 삽입하여 새 댓글을 데이터베이스에 저장
		commentService.commentWrite(commentVO);
        // 성공 메시지를 반환
        return "SUCCESS";
    }

	
    //댓글 목록
    @GetMapping("/{boardSeq}")
    public List<CommentVO> getComments(@PathVariable Long boardSeq) {
        return commentService.getCommentsByBoardSeq(boardSeq);
    }

    

}
