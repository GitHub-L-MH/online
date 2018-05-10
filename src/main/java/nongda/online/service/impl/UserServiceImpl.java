package nongda.online.service.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import nongda.online.dao.UserDao;
import nongda.online.domain.User;
import nongda.online.service.UserService;
@Service(value="userServiceImpl")
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userDao;

	@Override
	public User login(Map<String, Object> paramMap) throws Exception {
		
		return userDao.login(paramMap);
	}

}
