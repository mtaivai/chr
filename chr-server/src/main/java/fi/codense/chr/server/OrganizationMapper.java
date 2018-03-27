package fi.codense.chr.server;

import org.jooq.Record;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;
import static fi.codense.chr.model.jooq.psql.tables.Organization.ORGANIZATION;

@Mapper
public interface OrganizationMapper {

	OrganizationMapper INSTANCE = Mappers.getMapper(OrganizationMapper.class);

	default OrganizationDto toOrganizationDto(final Record record) {
		final OrganizationDto target = new OrganizationDto();
		target.setId(record.get(ORGANIZATION.ID));
		target.setName(record.get(ORGANIZATION.NAME));
		return target;
	}

}
