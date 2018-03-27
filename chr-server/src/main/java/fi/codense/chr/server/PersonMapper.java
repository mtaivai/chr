package fi.codense.chr.server;

import fi.codense.chr.model.jooq.psql.tables.pojos.Person;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

@Mapper
public interface PersonMapper {

	PersonMapper INSTANCE = Mappers.getMapper( PersonMapper.class );

	CV personToPersonDto(final Person person);
}
