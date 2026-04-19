package com.example.library.service;

import com.example.library.dto.request.BookRequest;
import com.example.library.dto.response.BookResponse;
import com.example.library.entity.Author;
import com.example.library.entity.Book;
import com.example.library.exception.DuplicateResourceException;
import com.example.library.exception.ResourceNotFoundException;
import com.example.library.mapper.BookMapper;
import com.example.library.repository.AuthorRepository;
import com.example.library.repository.BookRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class BookService {

    private final BookRepository bookRepository;
    private final AuthorRepository authorRepository;
    private final BookMapper bookMapper;

    public Page<BookResponse> getAll(Pageable pageable) {
        // Uses JOIN FETCH to avoid N+1 (each book would otherwise fire a separate query for its author)
        return bookRepository.findAllWithAuthor(pageable).map(bookMapper::toResponse);
    }

    public BookResponse getById(Long id) {
        Book book = bookRepository.findByIdWithAuthor(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book", id));
        return bookMapper.toResponse(book);
    }

    @Transactional
    public BookResponse create(BookRequest request) {
        if (bookRepository.existsByIsbn(request.getIsbn())) {
            throw new DuplicateResourceException("A book with ISBN '" + request.getIsbn() + "' already exists.");
        }
        Author author = authorRepository.findById(request.getAuthorId())
                .orElseThrow(() -> new ResourceNotFoundException("Author", request.getAuthorId()));

        Book book = bookMapper.toEntity(request);
        book.setAuthor(author);
        return bookMapper.toResponse(bookRepository.save(book));
    }

    @Transactional
    public BookResponse update(Long id, BookRequest request) {
        Book book = bookRepository.findByIdWithAuthor(id)
                .orElseThrow(() -> new ResourceNotFoundException("Book", id));

        // Check ISBN uniqueness only if it changed
        if (!book.getIsbn().equals(request.getIsbn()) && bookRepository.existsByIsbn(request.getIsbn())) {
            throw new DuplicateResourceException("A book with ISBN '" + request.getIsbn() + "' already exists.");
        }

        Author author = authorRepository.findById(request.getAuthorId())
                .orElseThrow(() -> new ResourceNotFoundException("Author", request.getAuthorId()));

        bookMapper.updateEntityFromRequest(request, book);
        book.setAuthor(author);
        return bookMapper.toResponse(bookRepository.save(book));
    }

    @Transactional
    public void delete(Long id) {
        if (!bookRepository.existsById(id)) {
            throw new ResourceNotFoundException("Book", id);
        }
        bookRepository.deleteById(id);
    }

    public List<BookResponse> search(String title, String genre, Integer publishedYear) {
        return bookRepository.searchBooks(title, genre, publishedYear)
                .stream()
                .map(bookMapper::toResponse)
                .collect(Collectors.toList());
    }
}
