package com.example.library.service;

import com.example.library.dto.request.MemberRequest;
import com.example.library.dto.response.MemberResponse;
import com.example.library.entity.Member;
import com.example.library.exception.DuplicateResourceException;
import com.example.library.exception.ResourceNotFoundException;
import com.example.library.mapper.MemberMapper;
import com.example.library.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class MemberService {

    private final MemberRepository memberRepository;
    private final MemberMapper memberMapper;

    public Page<MemberResponse> getAll(Pageable pageable) {
        return memberRepository.findAll(pageable).map(memberMapper::toResponse);
    }

    public MemberResponse getById(Long id) {
        return memberMapper.toResponse(findOrThrow(id));
    }

    public Page<MemberResponse> searchByName(String name, Pageable pageable) {
        return memberRepository.searchByName(name, pageable).map(memberMapper::toResponse);
    }

    @Transactional
    public MemberResponse create(MemberRequest request) {
        if (memberRepository.existsByEmail(request.getEmail())) {
            throw new DuplicateResourceException("A member with email '" + request.getEmail() + "' already exists.");
        }
        Member member = memberMapper.toEntity(request);
        return memberMapper.toResponse(memberRepository.save(member));
    }

    @Transactional
    public MemberResponse update(Long id, MemberRequest request) {
        Member member = findOrThrow(id);
        if (!member.getEmail().equals(request.getEmail()) && memberRepository.existsByEmail(request.getEmail())) {
            throw new DuplicateResourceException("A member with email '" + request.getEmail() + "' already exists.");
        }
        memberMapper.updateEntityFromRequest(request, member);
        return memberMapper.toResponse(memberRepository.save(member));
    }

    @Transactional
    public void delete(Long id) {
        findOrThrow(id);
        memberRepository.deleteById(id);
    }

    private Member findOrThrow(Long id) {
        return memberRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Member", id));
    }
}
