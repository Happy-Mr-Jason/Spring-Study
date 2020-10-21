package myspring.di.xml.annot.test;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import myspring.di.xml.annot.Hello;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:config/annot.xml")
public class HelloBeanAnnotTest {
	@Autowired
	ApplicationContext context;
	
	@Test
	public void test() {
		Hello hello = context.getBean("hello", Hello.class);
//		assertEquals("Hello Spring", hello.sayHello());
		assertEquals("Hello Spring(in Properties file)", hello.sayHello());
	}
}
