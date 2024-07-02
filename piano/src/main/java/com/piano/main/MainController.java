package com.piano.main;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class MainController {

	// 메인화면
	@GetMapping("/")
	public String main(Model model) {
		log.info("MainController main()");

		return "/main/main";
	}

}