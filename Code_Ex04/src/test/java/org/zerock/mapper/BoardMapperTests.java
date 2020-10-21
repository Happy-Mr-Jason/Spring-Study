package org.zerock.mapper;

import java.util.List;

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
public class BoardMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Test
	@Ignore
	public void testGetlist() {
		mapper.getList().forEach(board -> log.info(board));
	}
	
	@Test
	@Ignore
	public void testPaging() {
		Criteria cri = new Criteria(3, 10);
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}
	
	@Test
//	@Ignore
	public void testSearch() {
		Criteria cri = new Criteria();
		cri.setKeyword("");
		cri.setType("");
		List<BoardVO> list = mapper.getListWithPaging(cri);
		list.forEach(board -> log.info(board));
	}
	
	@Test
	@Ignore
	public void testInsert() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글2");
		board.setContent("새로 작성된 내용2");
		board.setWriter("sjlee");
		
		mapper.insert(board);
		
		log.info(board);
	}
	
	@Test
	@Ignore
	public void testInsertSelectKey() {
		BoardVO board = new BoardVO();
		board.setTitle("새로 작성하는 글 select key");
		board.setContent("새로 작성된 내용 select key");
		board.setWriter("sjlee");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
	
	@Test
	@Ignore
	public void testRead() {
		BoardVO board = mapper.read(27L);
		log.info(board);
	}
	
	@Test
	@Ignore
	public void testDelete() {
		int result = mapper.delete(27L);
		log.info("Delete Count : " + result);
	}
	
	@Test
	@Ignore
	public void testUpdate() {
		BoardVO board = new BoardVO();
		board.setBno(5L);
		board.setTitle("업데이트된 제목");
		board.setContent("업데이트된 내용");
		board.setWriter("user00");
		
		int count = mapper.update(board);
		log.info("Update Count : " + count);
	}
	
}
