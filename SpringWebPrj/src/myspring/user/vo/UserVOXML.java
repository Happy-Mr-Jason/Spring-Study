package myspring.user.vo;

import java.util.List;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name="users")
public class UserVOXML {
	private String status;
	private List<UserVO> userList;

	public UserVOXML() {}
	
	public UserVOXML(String status, List<UserVO> userList) {
		this.status = status;
		this.userList = userList;
	}

	public String getStatus() {
		return status;
	}

	@XmlElement
	public void setStatus(String status) {
		this.status = status;
	}

	public List<UserVO> getUserList() {
		return userList;
	}

	@XmlElement(name="user")
	public void setUserList(List<UserVO> userList) {
		this.userList = userList;
	}

	
	
}
