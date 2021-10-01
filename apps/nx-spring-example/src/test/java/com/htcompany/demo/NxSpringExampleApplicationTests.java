package com.htcompany.demo;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class NxSpringExampleApplicationTests {

	@Test
	void contextLoads() {
	}

    @Test
    void whenTwoPlusTwoThenEqualFour() {
        assertEquals(4, 2 + 2);
    }

}
