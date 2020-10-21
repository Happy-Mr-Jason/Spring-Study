package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class BoardServiceImpl implements BoardService {
	
	private BoardMapper boardMapper;

	@Override
	public void register(BoardVO board) {
		log.info("register....." + board);
		boardMapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get....." + bno);	
		return boardMapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify....." + board);
		return boardMapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove....." + bno);
		return boardMapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with criteria :" + cri );
		return boardMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get Total count");
		return boardMapper.getTotalCount(cri);
	}

//	@Override
//	public List<BoardVO> getList() {
//		log.info("getList.....");
//		return boardMapper.getList();
//	}
	
	
	

}
