package myspring.di.xml.test;

import static org.junit.Assert.*;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;

import myspring.di.xml.Hello;
import myspring.di.xml.Printer;

public class HelloBeanJunitTest {

	private ApplicationContext context;

	@Before
	public void init() {
		context = new GenericXmlApplicationContext("classpath:config/beans.xml");
	}

	@Test 
	public void test1() {
		Hello hello = (Hello) context.getBean("hello");
		assertEquals("Hello Spring", hello.sayHello());
		hello.print();

		Printer printer = (Printer) context.getBean("printer");
		assertEquals("Hello Spring", printer.toString());
	}

	@Test
	public void test2() {
		Printer printer = (Printer) context.getBean("printer");
		Printer printer2 = context.getBean("printer", Printer.class);

		assertSame(printer, printer2);
	}
	
}
