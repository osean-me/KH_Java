package com.d0.spring;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.d0.spring.entity.CategoryDTO;
import com.d0.spring.entity.ItemsDTO;
import com.d0.spring.service.MarketService;

@RunWith(SpringJUnit4ClassRunner.class) // Spring + Junit4 연동
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml" }) // 설정파일 위치 정보
@WebAppConfiguration // 웹과 관련된 설정 무시
public class Test02 {

	@Autowired
	private MarketService marketService;
	
	@Test
	public void test() {
		CategoryDTO a = CategoryDTO.builder().c_no(2).c_name("음식").build();
		ItemsDTO b = ItemsDTO.builder().i_no(2).i_name("맛있는 우삼겹").c_no(a.getC_no()).build();
		
		marketService.add(a, b);		
	}
}
