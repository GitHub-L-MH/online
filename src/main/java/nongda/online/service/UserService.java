package nongda.online.service;

import java.util.Map;

import nongda.online.domain.User;

public interface UserService {

	public User login(Map<String,Object> paramMap) throws Exception;

	public Integer updateUser(User user);
}
