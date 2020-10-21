package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;

	@Transactional
	@Override
	public int register(ReplyVO reply) {

		log.info("register....." + reply);
		boardMapper.updateReplyCnt(reply.getBno(), 1);
		return mapper.insert(reply);
	}

	@Override
	public ReplyVO get(Long rno) {

		log.info("get....." + rno);

		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO reply) {

		log.info("modify....." + reply);

		return mapper.update(reply);
	}
	
	@Transactional
	@Override
	public int remove(Long rno) {

		log.info("remove....." + rno);
		ReplyVO reply = mapper.read(rno);
		boardMapper.updateReplyCnt(reply.getBno(), -1);
		return mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long bno) {

		log.info("get Reply List....." + bno);

		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {

		return new ReplyPageDTO(mapper.getTotalCount(bno), mapper.getListWithPaging(cri, bno));
	}
}
