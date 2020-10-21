package org.zerock.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j2
@ContextConfiguration({ "file:src/main/resource/config/spring/root-context.xml",
		"file:src/main/resource/config/spring/security-context.xml" })
public class MemberTests {
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_ = @Autowired)
	private DataSource ds;
	
	@Test
	@Ignore
	public void testinsertMember() {
		String sql = "insert into tbl_member(userid, userpw, username, enabled) values(?, ?, ?, 'Y')";
		
		for(int i = 0 ; i < 100 ; i++) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				pstmt.setString(2,  pwencoder.encode("pw" + i));
				
				if(i<80) {
					pstmt.setString(1, "user" + i);
					pstmt.setString(3, "일반사용자"+i);
				}else if(i<90) {
					pstmt.setString(1, "manager" + i);
					pstmt.setString(3, "운영자"+i);
				}else {
					pstmt.setString(1, "admin" + i);
					pstmt.setString(3, "관리자"+i);
				}
				
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				
				if(con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	@Test
	@Ignore
	public void testinsertAuth() {
		String sql = "insert into tbl_member_auth(userid, auth) values(?, ?)";
		
		for(int i = 0 ; i < 100 ; i++) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				if(i<80) {
					pstmt.setString(1, "user" + i);
					pstmt.setString(2, "ROLE_USER");
				}else if(i<90) {
					pstmt.setString(1, "manager" + i);
					pstmt.setString(2, "ROLE_MEMBER");
				}else {
					pstmt.setString(1, "admin" + i);
					pstmt.setString(2, "ROLE_ADMIN");
				}
				
				pstmt.executeUpdate();
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				
				if(con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
	}
}
