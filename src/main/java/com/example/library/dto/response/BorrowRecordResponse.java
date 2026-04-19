package com.example.library.dto.response;

import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BorrowRecordResponse {
    private Long id;
    private LocalDate borrowDate;
    private LocalDate returnDate;
    private BookResponse book;
    private MemberResponse member;
}
