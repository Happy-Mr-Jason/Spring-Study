package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@AllArgsConstructor
@Log4j
public class BoardServiceimpl implements BoardService {
	
	private BoardMapper boardMapper;
	
	private BoardAttachMapper attachMapper;

	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register....." + board);
		boardMapper.insertSelectKey(board);
		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}
		boardMapper.updateAttachCnt(board.getBno(), board.getAttachList().size());
		board.getAttachList().forEach(attach -> {
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get....." + bno);
		return boardMapper.read(bno);
	}
	
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify....." + board);
		attachMapper.deleteAll(board.getBno());
		boolean modifyResult = boardMapper.update(board) == 1;
		if(modifyResult && board.getAttachList() !=null && board.getAttachList().size() >0) {
			board.getAttachList().forEach(attach -> {
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		boardMapper.updateAttachCnt(board.getBno(), board.getAttachList().size());
		return boardMapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove....." + bno);
		attachMapper.deleteAll(bno);
		return boardMapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with criteria :" + cri);
		return boardMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get Total count");
		return boardMapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno" + bno);
		return attachMapper.findByBno(bno);
	}

//	@Override
//	public List<BoardVO> getList() {
//		log.info("getList.....");
//		return boardMapper.getList();
//	}
	
	

}
