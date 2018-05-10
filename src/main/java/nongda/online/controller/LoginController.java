package nongda.online.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import nongda.online.domain.User;
import nongda.online.service.UserService;


@Controller
@RequestMapping(value="/user")
public class LoginController {
	@Autowired
	private UserService userService;

	@RequestMapping(value="/login", method={RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public Object login(HttpServletRequest req,
			@RequestParam(value="userName",required=true)String userName,
			@RequestParam(value="passWord",required=true)String passWord,
			@RequestParam(value="flag",required=true)Integer flag){
		//去数据库验证登录
		Map<String,Object> paramMap = new HashMap<String,Object>();
		Map<String,Object> retMap=new HashMap<String,Object>();
		paramMap.put("userName", userName);
		paramMap.put("passWord", passWord);
		paramMap.put("flag", flag);
		try {
			User user = userService.login( paramMap);
			System.out.println(user.toString());
			if(null != user){
				//登陆成功
				retMap.put("errorMessage", "ok");
				//将登录用户存入session
				req.getSession().setAttribute("user", user);
			}
		} catch (Exception e) {
			e.printStackTrace();
			//登录失败..
			retMap.put("errorMessage", "您输入的手机号或密码有误");
		}
		
		return retMap;
	}
}
