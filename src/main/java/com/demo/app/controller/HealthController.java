package com.demo.app.controller;

import com.demo.app.model.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthController {
    @GetMapping("/health")
    public ResponseEntity<ApiResponse<?>> health() {
        return ResponseEntity.ok(
                ApiResponse.ok("UP", "Application is running")
        );
    }
    @GetMapping("/actuator/health")
    public ResponseEntity<ApiResponse<?>> actuatorHealth() {
        try {
            return ResponseEntity.ok(
                    ApiResponse.ok("UP", "Application is running")
            );
        } catch (Exception e) {
            // Tránh trường hợp ApiResponse bị lỗi
            return ResponseEntity.ok(ApiResponse.ok("UP", "Application is running with warning"));
        }
    }
}
