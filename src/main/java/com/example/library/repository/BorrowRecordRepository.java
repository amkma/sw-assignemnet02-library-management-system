package com.example.library.repository;

import com.example.library.entity.BorrowRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BorrowRecordRepository extends JpaRepository<BorrowRecord, Long> {

    // Check if book is currently borrowed (returnDate is null)
    boolean existsByBookIdAndReturnDateIsNull(Long bookId);

    // Fetch records with book and member eagerly to prevent N+1
    @Query("SELECT br FROM BorrowRecord br JOIN FETCH br.book b JOIN FETCH b.author JOIN FETCH br.member WHERE br.member.id = :memberId")
    List<BorrowRecord> findAllByMemberIdWithDetails(@Param("memberId") Long memberId);

    @Query("SELECT br FROM BorrowRecord br JOIN FETCH br.book b JOIN FETCH b.author JOIN FETCH br.member WHERE br.returnDate IS NULL")
    List<BorrowRecord> findAllActiveWithDetails();
}
