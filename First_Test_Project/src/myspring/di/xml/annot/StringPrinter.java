package myspring.di.xml.annot;

import org.springframework.stereotype.Component;

@Component("stringPrinter")
public class StringPrinter implements Printer{

	private StringBuffer buffer = new StringBuffer();
	
	@Override
	public void print(String message) {
		buffer.append(message);
		
	}

	@Override
	public String toString() {
		return buffer.toString();
	}
	
}
