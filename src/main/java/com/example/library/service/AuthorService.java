package com.example.library.service;

import com.example.library.dto.request.AuthorRequest;
import com.example.library.dto.response.AuthorResponse;
import com.example.library.dto.response.BookResponse;
import com.example.library.entity.Author;
import com.example.library.exception.ResourceNotFoundException;
import com.example.library.mapper.AuthorMapper;
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
public class AuthorService {

    private final AuthorRepository authorRepository;
    private final BookRepository bookRepository;
    private final AuthorMapper authorMapper;
    private final BookMapper bookMapper;

    public Page<AuthorResponse> getAll(Pageable pageable) {
        return authorRepository.findAll(pageable).map(authorMapper::toResponse);
    }

    public AuthorResponse getById(Long id) {
        return authorMapper.toResponse(findOrThrow(id));
    }

    @Transactional
    public AuthorResponse create(AuthorRequest request) {
        Author author = authorMapper.toEntity(request);
        return authorMapper.toResponse(authorRepository.save(author));
    }

    @Transactional
    public AuthorResponse update(Long id, AuthorRequest request) {
        Author author = findOrThrow(id);
        authorMapper.updateEntityFromRequest(request, author);
        return authorMapper.toResponse(authorRepository.save(author));
    }

    @Transactional
    public void delete(Long id) {
        findOrThrow(id);
        authorRepository.deleteById(id);
    }

    public List<BookResponse> getBooksByAuthor(Long authorId) {
        findOrThrow(authorId);
        return bookRepository.findAllByAuthorId(authorId)
                .stream()
                .map(bookMapper::toResponse)
                .collect(Collectors.toList());
    }

    private Author findOrThrow(Long id) {
        return authorRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Author", id));
    }
}
