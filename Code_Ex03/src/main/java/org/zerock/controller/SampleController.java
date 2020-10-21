package org.zerock.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.SampleVO;
import org.zerock.domain.Ticket;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/sample")
@Log4j
public class SampleController {

	@GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE : " + MediaType.TEXT_PLAIN_VALUE);
		return "하이~";
	}

	@GetMapping(value = "/getSample", produces = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
	public SampleVO getSample() {
		return new SampleVO(777, "성진", "이");
	}

	@GetMapping("/getSample2")
	public SampleVO getSample2() {
		return new SampleVO(888, "길동", "홍");
	}

	@GetMapping("/getList")
	public List<SampleVO> getSampleList() {
		List<SampleVO> list = new ArrayList<SampleVO>();
		list.add(new SampleVO(111, "길동", "홍"));
		list.add(new SampleVO(222, "순신", "이"));
		list.add(new SampleVO(333, "철수", "이"));
		list.add(new SampleVO(444, "영희", "김"));
		list.add(new SampleVO(555, "길동", "고"));
		return list;
	}

	@GetMapping("/getMap")
	public Map<String, SampleVO> getMap() {
		Map<String, SampleVO> map = new HashMap<String, SampleVO>();
		map.put("User", new SampleVO(111, "길동", "홍"));
		
		return map;
	}
	
	@GetMapping(value="/check", params= {"h", "w"})
	public ResponseEntity<SampleVO> check(Double h, Double w){
		SampleVO vo = new SampleVO(111, "순희", "박");
		ResponseEntity<SampleVO> result = null;
		
		if(h<150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		} else {
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		
		return result;
	}
	
	@GetMapping("product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat,@PathVariable("pid") Integer pid) {
		return new String[] {"category : " + cat, "productid : " + pid};
	}
	
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		log.info("convert.....ticket" + ticket);
		return ticket;
	}
}
