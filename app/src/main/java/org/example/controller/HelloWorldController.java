package org.example.controller;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class HelloWorldController {

    /**
     * Hello World test endpoint
     * @return {@link ResponseEntity} with 'Hello World' body, {@link org.springframework.http.HttpStatusCode} = <code>200</code>
     */
    @GetMapping("/hello")
    public ResponseEntity<?> sayHello() {
        return ResponseEntity.ok("Hello World");
    }
}