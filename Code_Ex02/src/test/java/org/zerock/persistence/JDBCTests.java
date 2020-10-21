package org.zerock.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testConnction() {
		try (Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "BOOK_EX",
				"bookadmin")) {
			log.info(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}

	}
}
