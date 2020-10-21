package myspring.di.xml.test;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import myspring.di.xml.Hello;
import myspring.di.xml.Printer;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:config/beans.xml")

public class HelloBeanSpringTest {

	@Autowired
	ApplicationContext context;

	@Test 
//	@Ignore
	public void test1() {
		Hello hello = (Hello) context.getBean("hello");
		assertEquals("Hello Spring", hello.sayHello());
		hello.print();

		Printer printer = (Printer) context.getBean("printer");
		assertEquals("Hello Spring", printer.toString());
	}

	@Test @Ignore
	public void test2() {
		Printer printer = (Printer) context.getBean("printer");
		Printer printer2 = context.getBean("printer", Printer.class);
		assertSame(printer, printer2);
	}
	
	@Test @Ignore
	public void test3() {
		Hello hello = (Hello) context.getBean("hello2");
		assertEquals(3,  hello.getNames().size());
		List<String> list = hello.getNames();
		
		for(String value : list) {
			System.out.println(value);
		}
	}
	
	@Test
	@Ignore
	public void test4() {
		Hello hello = (Hello) context.getBean("hello3");
		assertEquals(3,  hello.getNames().size());
		List<String> list = hello.getNames();
		
		for(String value : list) {
			System.out.println(value);
		}
	}
}
