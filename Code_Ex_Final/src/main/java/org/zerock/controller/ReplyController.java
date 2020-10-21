package org.zerock.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@RequestMapping("/replies/")
@RestController
@AllArgsConstructor
@Log4j2
public class ReplyController {

	private ReplyService service;
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new", consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody ReplyVO reply) {

		log.info("ReplyVO : " + reply);

		int insertCount = service.register(reply);

		log.info("Reply Insert Count : " + insertCount);

		return insertCount == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping(value = "/pages/{bno}/{page}", produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") Long bno) {

		log.info("getList.......");

		Criteria cri = new Criteria(page, 10);

		log.info(cri);
		
		ReplyPageDTO rpDTO = service.getListPage(cri, bno);
		log.info("DTO....." + rpDTO.toString());

		return new ResponseEntity<>(rpDTO, HttpStatus.OK);
	}

	@GetMapping(value = "/{rno}", produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE })
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {

		log.info("get : " + rno);

		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
	}

	@PreAuthorize("principal.username == #vo.replyer")
	@DeleteMapping(value = "/{rno}")
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo,  @PathVariable("rno") Long rno) {

		log.info("remove : " + rno);
		
		log.info("replyer: " + vo.getReplyer());

		return service.remove(vo.getRno()) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@PreAuthorize("principal.username == #reply.replyer")
	@RequestMapping(value = "/{rno}", method = { RequestMethod.PUT,
			RequestMethod.PATCH }, consumes = "application/json", produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> modify(@RequestBody ReplyVO reply, @PathVariable Long rno) {

		reply.setRno(rno);

		log.info("rno : " + rno);

		log.info("modify : " + reply);

		return service.modify(reply) == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}
}
