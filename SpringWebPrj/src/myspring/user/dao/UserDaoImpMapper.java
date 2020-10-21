package myspring.user.dao;

//mybatis용 dao class /// Mapper interface 사용할 때

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import myspring.user.vo.UserVO;

@Repository("userDao")
public class UserDaoImpMapper implements UserDao {

	@Autowired
	private UserMapper userMapper;
	
	@Override
	public UserVO read(String id) {
		UserVO user  = userMapper.selectUserById(id);
		return user;
	}

	@Override
	public List<UserVO> readAll() {
		List<UserVO> userList = userMapper.selectUserList();
		return userList;
	}
	
	@Override
	public void insert(UserVO user) {
		userMapper.insertUser(user);
		System.out.println("등록된 Record UserId=" + user.getUserId() + " Name=" + user.getName());
	}

	@Override
	public void update(UserVO user) {
		userMapper.updateUser(user);
	}

	@Override
	public void delete(String id) {
		userMapper.deleteUser(id);
		System.out.println("삭제된 Record with ID = " + id ); 
	}
	
}
