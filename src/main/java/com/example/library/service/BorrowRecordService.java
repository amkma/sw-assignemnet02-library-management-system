package com.example.library.service;

import com.example.library.dto.request.BorrowRequest;
import com.example.library.dto.response.BorrowRecordResponse;
import com.example.library.entity.Book;
import com.example.library.entity.BorrowRecord;
import com.example.library.entity.Member;
import com.example.library.exception.BookAlreadyBorrowedException;
import com.example.library.exception.ResourceNotFoundException;
import com.example.library.mapper.BorrowRecordMapper;
import com.example.library.repository.BookRepository;
import com.example.library.repository.BorrowRecordRepository;
import com.example.library.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class BorrowRecordService {

    private final BorrowRecordRepository borrowRecordRepository;
    private final BookRepository bookRepository;
    private final MemberRepository memberRepository;
    private final BorrowRecordMapper borrowRecordMapper;

    @Transactional
    public BorrowRecordResponse borrowBook(BorrowRequest request) {
        if (borrowRecordRepository.existsByBookIdAndReturnDateIsNull(request.getBookId())) {
            throw new BookAlreadyBorrowedException(request.getBookId());
        }

        Book book = bookRepository.findByIdWithAuthor(request.getBookId())
                .orElseThrow(() -> new ResourceNotFoundException("Book", request.getBookId()));

        Member member = memberRepository.findById(request.getMemberId())
                .orElseThrow(() -> new ResourceNotFoundException("Member", request.getMemberId()));

        BorrowRecord record = BorrowRecord.builder()
                .book(book)
                .member(member)
                .build();

        return borrowRecordMapper.toResponse(borrowRecordRepository.save(record));
    }

    @Transactional
    public BorrowRecordResponse returnBook(Long recordId) {
        BorrowRecord record = borrowRecordRepository.findById(recordId)
                .orElseThrow(() -> new ResourceNotFoundException("BorrowRecord", recordId));

        if (record.getReturnDate() != null) {
            throw new IllegalArgumentException("This borrow record has already been returned on " + record.getReturnDate());
        }

        record.setReturnDate(LocalDate.now());
        return borrowRecordMapper.toResponse(borrowRecordRepository.save(record));
    }

    public List<BorrowRecordResponse> getByMember(Long memberId) {
        if (!memberRepository.existsById(memberId)) {
            throw new ResourceNotFoundException("Member", memberId);
        }
        return borrowRecordRepository.findAllByMemberIdWithDetails(memberId)
                .stream()
                .map(borrowRecordMapper::toResponse)
                .collect(Collectors.toList());
    }

    public List<BorrowRecordResponse> getActive() {
        return borrowRecordRepository.findAllActiveWithDetails()
                .stream()
                .map(borrowRecordMapper::toResponse)
                .collect(Collectors.toList());
    }
}
