package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceTests {

	@Setter(onMethod_ = {@Autowired})
	private BoardService service;
	
	@Test
	@Ignore
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	@Ignore
	public void testRegister() {
		BoardVO board = new BoardVO();
		board.setTitle("서비스에서 새로 작성한 글");
		board.setContent("서비스에서 새로 작성한 내용");
		board.setWriter("arkang");
		
		service.register(board);
		log.info("생성된 게시물의 번호 : " + board.getBno());
		
	}
	
	@Test
//	@Ignore
	public void testGetList() {
//		service.getList().forEach(board -> log.info(board));
		service.getList(new Criteria(3,10)).forEach(board -> log.info(board)); 
	}
	
	@Test
	@Ignore
	public void testGet() {
		log.info(service.get(1L));
	}
	
	@Test
	@Ignore
	public void testDelete() {
		log.info("Remove Result : " + service.remove(1L));
	}

	@Test
	@Ignore
	public void testUpdate() {
		BoardVO board = service.get(1L);
		
		if(board ==null)
			return;
		
		board.setTitle("서비스에서 제목 수정됨");
		log.info("Modify Result : " + service.modify(board));
	}
}
