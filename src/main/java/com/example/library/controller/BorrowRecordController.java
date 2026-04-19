package com.example.library.controller;

import com.example.library.dto.request.BorrowRequest;
import com.example.library.dto.response.BorrowRecordResponse;
import com.example.library.service.BorrowRecordService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/borrow-records")
@RequiredArgsConstructor
public class BorrowRecordController {

    private final BorrowRecordService borrowRecordService;

    @PostMapping
    public ResponseEntity<BorrowRecordResponse> borrowBook(@Valid @RequestBody BorrowRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(borrowRecordService.borrowBook(request));
    }

    @PutMapping("/{id}/return")
    public ResponseEntity<BorrowRecordResponse> returnBook(@PathVariable Long id) {
        return ResponseEntity.ok(borrowRecordService.returnBook(id));
    }

    @GetMapping("/member/{memberId}")
    public ResponseEntity<List<BorrowRecordResponse>> getByMember(@PathVariable Long memberId) {
        return ResponseEntity.ok(borrowRecordService.getByMember(memberId));
    }

    @GetMapping("/active")
    public ResponseEntity<List<BorrowRecordResponse>> getActive() {
        return ResponseEntity.ok(borrowRecordService.getActive());
    }
}
