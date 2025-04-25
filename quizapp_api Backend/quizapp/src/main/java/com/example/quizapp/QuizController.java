package com.example.quizapp;

import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.web.bind.annotation.*;
import org.bson.types.ObjectId;

import java.util.*;

@RestController
@RequestMapping("/api")
public class QuizController {

    private final MongoTemplate mongoTemplate;

    public QuizController(MongoTemplate mongoTemplate) {
        this.mongoTemplate = mongoTemplate;
    }

    @GetMapping("/status")
    public Map<String, String> status() {
        try {
            mongoTemplate.getDb().runCommand(new org.bson.Document("ping", 1));
            return Map.of("status", "MongoDB connected");
        } catch (Exception e) {
            return Map.of("status", "MongoDB not connected", "error", e.getMessage());
        }
    }

    @GetMapping("/questions")
    public List<Map<String, Object>> getQuestions() {
        List<?> rawList = mongoTemplate.findAll(Map.class, "questions");
        List<Map<String, Object>> questions = new ArrayList<>();
        for (Object obj : rawList) {
            if (obj instanceof Map<?, ?> map) {
                @SuppressWarnings("unchecked")
                Map<String, Object> question = (Map<String, Object>) map;
                question.put("_id", ((ObjectId) question.get("_id")).toString());

                // Convert answer to index
                Object answerObj = question.get("answer");
                Object optionsObj = question.get("options");

                if (answerObj instanceof String && optionsObj instanceof List) {
                    List<String> options = (List<String>) optionsObj;
                    int index = options.indexOf((String) answerObj);
                    question.put("answer", index);
                }

                questions.add(question);
            }
        }
        return questions;
    }

    @PostMapping("/results")
    public Map<String, String> saveResult(@RequestBody Map<String, Object> result) {
        try {
            mongoTemplate.insert(result, "results");
            return Map.of("message", "Result stored successfully");
        } catch (Exception e) {
            return Map.of("error", e.getMessage());
        }
    }

    @GetMapping("/results")
    public List<Map<String, Object>> getResults() {
        List<?> rawList = mongoTemplate.findAll(Map.class, "results");
        List<Map<String, Object>> results = new ArrayList<>();
        for (Object obj : rawList) {
            if (obj instanceof Map<?, ?> map) {
                @SuppressWarnings("unchecked")
                Map<String, Object> result = (Map<String, Object>) map;
                result.put("_id", ((ObjectId) result.get("_id")).toString());
                results.add(result);
            }
        }
        return results;
    }
}
