package com.piano.main;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class MainController {
	
	//---------------------------------------------------------
	// 페이지
	//---------------------------------------------------------

	// 메인화면
	@GetMapping("/")
	public String main(Model model) {
		log.info("MainController main()");

		return "/main/main";
	}
	
	// 로그인
	@GetMapping("/login")
	public String login(Model model) {
		log.info("MainController login()");

		return "/main/login";
	}
	
	// 회원가입
	@GetMapping("/signUp")
	public String signUp(Model model) {
		log.info("MainController signUp()");

		return "/main/signUp";
	}
	
	// 마이 페이지
	@GetMapping("/myPage")
	public String myPage(Model model) {
		log.info("MainController myPage()");

		return "/main/myPage";
	}

}