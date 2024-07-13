package com.piano.main;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class MainController {
	
	@Autowired
	private MainService mainService;
	
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
	public String loginPage(Model model) {
		log.info("MainController loginPage()");

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
	
	
	
	//---------------------------------------------------------
	// 실행
	//---------------------------------------------------------
	// 로그인
	@PostMapping("/loginIn")
	@ResponseBody // json 형태로 받기 위해서라는데 더 알아봐야 할 것 같음 +++ 임시
	public HashMap<String, Object> loginIn(@RequestBody HashMap<String, Object> param, HttpServletRequest request) {
		//log.debug("MainController loginIn()");
		return mainService.loginIn(param, request);
	}
	
	// 로그아웃
	@GetMapping("/loginOut")
	public String loginOut(HttpServletRequest request) {
		//log.debug("MainController loginOut()");
		mainService.loginOut(request);
		return "redirect:/";
	}
	
}