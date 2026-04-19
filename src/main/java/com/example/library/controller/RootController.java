package com.example.library.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/")
public class RootController {

    @GetMapping
    public ResponseEntity<Map<String, Object>> index() {
        Map<String, Object> response = new LinkedHashMap<>();
        response.put("application", "Library Management System");
        response.put("version", "1.0.0");
        response.put("status", "UP");
        response.put("timestamp", LocalDateTime.now().toString());

        Map<String, String> endpoints = new LinkedHashMap<>();
        endpoints.put("GET  /api/authors",              "List all authors (paginated)");
        endpoints.put("GET  /api/authors/{id}",         "Get author by ID");
        endpoints.put("POST /api/authors",              "Create a new author");
        endpoints.put("PUT  /api/authors/{id}",         "Update an author");
        endpoints.put("DELETE /api/authors/{id}",       "Delete an author");
        endpoints.put("GET  /api/authors/{id}/books",   "Get all books by an author");

        endpoints.put("GET  /api/books",                "List all books (paginated)");
        endpoints.put("GET  /api/books/{id}",           "Get book by ID");
        endpoints.put("POST /api/books",                "Create a new book");
        endpoints.put("PUT  /api/books/{id}",           "Update a book");
        endpoints.put("DELETE /api/books/{id}",         "Delete a book");

        endpoints.put("GET  /api/members",              "List all members (paginated)");
        endpoints.put("GET  /api/members/{id}",         "Get member by ID");
        endpoints.put("POST /api/members",              "Create a new member");
        endpoints.put("PUT  /api/members/{id}",         "Update a member");
        endpoints.put("DELETE /api/members/{id}",       "Delete a member");

        endpoints.put("GET  /api/borrow-records",       "List all borrow records");
        endpoints.put("POST /api/borrow-records",       "Borrow a book");
        endpoints.put("PUT  /api/borrow-records/{id}/return", "Return a borrowed book");

        endpoints.put("GET  /h2-console",               "H2 in-memory database console");

        response.put("availableEndpoints", endpoints);
        return ResponseEntity.ok(response);
    }
}
