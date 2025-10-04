package org.example.controller;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class HelloWorldController {
    @GetMapping("/hello")
    public ResponseEntity<?> sayHello() {
        return ResponseEntity.ok("Hello World");
    }
}