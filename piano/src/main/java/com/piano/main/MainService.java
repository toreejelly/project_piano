package com.piano.main;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.piano.user.UserMapper;
import com.piano.user.UserVO;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class MainService {
	
	@Autowired
	private UserMapper userMapper;

	// 로그인
	public HashMap<String, Object> loginIn(HashMap<String, Object> param, HttpServletRequest request) {
		HashMap<String, Object> mapReturn = new HashMap<String, Object>();
		
		try {
			
			List<UserVO> userList = userMapper.selectUserList(param);
			mapReturn.put("selectUserList", userList); 
			
			if (userList != null && userList.size() == 1) {
				UserVO userVo = userList.get(0);
				HttpSession session = request.getSession();
				session.setAttribute("userSeq", userVo.getUserSeq());
				session.setAttribute("userId", userVo.getUserId());
				session.setAttribute("userNm", userVo.getUserNm());
				session.setAttribute("userType", userVo.getUserType());
				mapReturn.put("result", "success");
				
			} else {
				mapReturn.put("result", "fail");	
			}
			
		} catch (Exception e) {
			mapReturn.put("result", "error");
			mapReturn.put("message", e.getMessage());
		}
		
		return mapReturn;
	}
	
	// 로그아웃
	public HashMap<String, Object> loginOut(HttpServletRequest request) {
		HashMap<String, Object> mapReturn = new HashMap<String, Object>();
		
		try {

			HttpSession session = request.getSession(false);

			if (session != null) {
				session.invalidate();
				mapReturn.put("result", "success");

			} else {
				mapReturn.put("result", "fail");	
			}

		} catch (Exception e) {
			mapReturn.put("result", "error");
			mapReturn.put("message", e.getMessage());
		}

		return mapReturn;
	}

}