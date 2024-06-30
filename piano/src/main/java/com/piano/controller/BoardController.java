package com.piano.controller;

import org.springframework.beans.factory.annotation.Autowired; 


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import com.piano.service.BoardService;


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
	
	
	//목록 조회
    @GetMapping("/list")
    public String list(Model model) {
		log.info("BoardController list()");
		
		model.addAttribute("list", boardService.getList());
		
		return "list";
    }
    
   
}


