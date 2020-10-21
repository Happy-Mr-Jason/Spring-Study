package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int pages;

	private int total;
	private Criteria cri;

	public PageDTO(Criteria cri, int total, int pages) {
		this.cri = cri;
		this.total = total;
		this.pages = pages;
		
		this.endPage = (int) (Math.ceil((double)cri.getPageNum() / pages)) * pages;
		this.startPage = this.endPage - this.pages + 1;
		
		int realEnd = (int)(Math.ceil((total * 1.0)/cri.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}

}
