package com.example.library.mapper;

import com.example.library.dto.response.BorrowRecordResponse;
import com.example.library.entity.BorrowRecord;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring", uses = {BookMapper.class, MemberMapper.class})
public interface BorrowRecordMapper {

    BorrowRecordResponse toResponse(BorrowRecord borrowRecord);
}
