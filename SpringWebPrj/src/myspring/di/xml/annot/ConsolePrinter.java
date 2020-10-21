package myspring.di.xml.annot;

import org.springframework.stereotype.Component;

@Component("consolPrinter")
public class ConsolePrinter implements Printer {

	@Override
	public void print(String message) {
		System.out.println(message);

	}

}
