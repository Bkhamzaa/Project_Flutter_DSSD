package com.example.quizapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.mongodb.core.MongoTemplate;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;

@SpringBootApplication
public class QuizappApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(QuizappApiApplication.class, args);
	}

	    // MongoDB Client Bean
    @Bean
    public MongoClient mongoClient() {
        return MongoClients.create("mongodb+srv://hboubaker59:aSMsAY9OApz0hjcM@apps.tkxquq8.mongodb.net/quiz_app?retryWrites=true&w=majority&tls=true&tlsAllowInvalidCertificates=true");
    }

    // MongoTemplate Bean for database operations
    @Bean
    public MongoTemplate mongoTemplate() {
        return new MongoTemplate(mongoClient(), "quiz_app");
    }


}
