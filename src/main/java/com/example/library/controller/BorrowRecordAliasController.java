package com.example.library.controller;

import com.example.library.dto.response.BorrowRecordResponse;
import com.example.library.service.BorrowRecordService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * The assignment spec uses "/api/borrowrecords/member/{memberId}" (no hyphen) for one endpoint
 * but "/api/borrow-records" (with hyphen) for all others. This controller covers the no-hyphen path.
 */
@RestController
@RequestMapping("/api/borrowrecords")
@RequiredArgsConstructor
public class BorrowRecordAliasController {

    private final BorrowRecordService borrowRecordService;

    @GetMapping("/member/{memberId}")
    public ResponseEntity<List<BorrowRecordResponse>> getByMember(@PathVariable Long memberId) {
        return ResponseEntity.ok(borrowRecordService.getByMember(memberId));
    }
}
