package nongda.online.dao;

import java.util.Map;

import nongda.online.domain.User;

public interface UserDao {
	
	public User login(Map<String,Object> paramMap) throws Exception;

    Integer updateUser(User user);
}
