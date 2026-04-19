package com.example.library.mapper;

import com.example.library.dto.request.BookRequest;
import com.example.library.dto.response.BookResponse;
import com.example.library.entity.Book;
import org.mapstruct.*;

@Mapper(componentModel = "spring", uses = {AuthorMapper.class})
public interface BookMapper {

    BookResponse toResponse(Book book);

    @Mapping(target = "author", ignore = true)
    Book toEntity(BookRequest request);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    @Mapping(target = "author", ignore = true)
    void updateEntityFromRequest(BookRequest request, @MappingTarget Book book);
}
