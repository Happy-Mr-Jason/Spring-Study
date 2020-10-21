package org.zerock.mapper;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Test
	@Ignore
	public void testMapper() {
		log.info(mapper);
	}
	
	@Test
	@Ignore
	public void testInsert() {
		ReplyVO reply = new ReplyVO();
		reply.setBno(6291474L);
		reply.setReply("댓글 테스트");
		reply.setReplyer("sjlee");
		mapper.insert(reply);
	}
	
	@Test
	@Ignore
	public void testRead() {
		log.info(mapper.read(1L));
	}
	
	@Test
	@Ignore
	public void testUpdate() {
		ReplyVO reply = new ReplyVO();
		reply.setRno(1L);
		reply.setReply("댓글 테스트 수정됨");
		reply.setReplyer("sjlee");
		mapper.update(reply);
	}
	
	@Test
	@Ignore
	public void testDelete() {
		mapper.delete(2L);
	}
	
	@Test
	@Ignore
	public void testList() {
		Criteria cri = new Criteria();
		Long bno = 6291474L;
		List<ReplyVO> list = mapper.getListWithPaging(cri, bno);
		list.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void testList2() {
		Criteria cri = new Criteria(2,10);
		Long bno = 6291474L;
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bno);
		replies.forEach(reply -> log.info(reply));
	}
}
