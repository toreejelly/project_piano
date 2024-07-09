package com.piano.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
@RequestMapping("/comment")
public class CommentController {
	
	@Autowired
	private CommentService commentService;
	
	
//	 //댓글 작성
//    @PostMapping("/")
//    public String commentWrite(@RequestBody CommentVO commentVO) {
//    	log.info("CommentController commentWrite()");
//    	log.info("commentVO :" + commentVO);
//    	
//        // 댓글 서비스에서 댓글 객체를 삽입하여 새 댓글을 데이터베이스에 저장
//		commentService.commentWrite(commentVO);
//        // 성공 메시지를 반환
//        return "SUCCESS";
//    }
	// 댓글 작성
	@PostMapping("/")
	public ResponseEntity<String> commentWrite(@RequestBody CommentVO commentVO) {
		try {
			log.info("CommentController commentWrite()");
			log.info("commentVO :" + commentVO);
			commentService.commentWrite(commentVO);
			return ResponseEntity.ok("SUCCESS");
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("FAILED");
		}
	}


	// 특정 게시글의 댓글 목록 조회
	@GetMapping("/{boardSeq}")
	// @PathVariable : URL 경로의 일부를 메서드 파라미터로 전달받기 위해 사용됩니다.
	public List<CommentVO> getCommentList(@PathVariable("boardSeq") long boardSeq) {
		log.info("CommentController getCommentList()");
		log.info("boardSeq :" + boardSeq);
		return commentService.getCommentList(boardSeq);
	}

	 //대댓글 작성
//    @PostMapping("/reply")
//    public String replyWrite(@RequestBody CommentVO commentVO) {
//    	log.info("CommentController commentWrite()");
//    	log.info("commentVO :" + commentVO);
//    	
//        // 댓글 서비스에서 댓글 객체를 삽입하여 새 댓글을 데이터베이스에 저장
//		commentService.replyWrite(commentVO);
//        // 성공 메시지를 반환
//        return "SUCCESS";
//    }

	// 대댓글 작성
	@PostMapping("/reply")
	public ResponseEntity<String> writeReply(@RequestBody CommentVO commentVO) {
		log.info("CommentController writeReply()");
		log.info("commentVO :" + commentVO);

		try {
			commentService.writeReply(commentVO);
			return ResponseEntity.ok("SUCCESS");
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("FAILED");
		}
	}

	// 댓글 수정
	@PutMapping("/{commentSeq}")
	public ResponseEntity<String> modifyComment(@PathVariable("commentSeq") long commentSeq, @RequestBody CommentVO commentVO) {
		log.info("CommentController modifyComment()");
		log.info("CommentVO : " + commentVO);

		ResponseEntity<String> entity = null;

		try {
			commentVO.setBoardSeq(commentSeq); // 요청 URL에서 받은 boardSeq 설정

			commentService.modifyComment(commentVO);

			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}

		return entity;
	}

	// 댓글 삭제
	@DeleteMapping("/{commentSeq}")
	public ResponseEntity<String> deleteComment(@RequestBody CommentVO commentVO) {
		log.info("CommentController deleteComment()");
		log.info("commentVO : " + commentVO);

		ResponseEntity<String> entity = null;
		long commentSeq = commentVO.getCommentSeq();
	
		try {
			commentService.deleteComment(commentSeq);			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
						
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}//end
		
		return entity;
	}

}
