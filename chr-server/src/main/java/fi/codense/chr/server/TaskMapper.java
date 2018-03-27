package fi.codense.chr.server;

import fi.codense.chr.model.jooq.psql.tables.pojos.Task;
import org.jooq.Record;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import static fi.codense.chr.model.jooq.psql.tables.Task.TASK;

@Mapper()
public interface TaskMapper {

	TaskMapper INSTANCE = Mappers.getMapper(TaskMapper.class);

	@Mapping(target = "organization", ignore = true)
//	@Mapping(target="description", ignore = true)
//	@Mapping(target="startDate", ignore = true)
//	@Mapping(target="endDate", ignore = true)
	TaskDto toTaskDto(final Task task);


	default TaskDto toTaskDto(final Record record) {

		final DateTimeMapper dtMapper = Mappers.getMapper(DateTimeMapper.class);

		final TaskDto target = new TaskDto();
		target.setId(record.get(TASK.ID));
		target.setName(record.get(TASK.NAME));
		target.setDescription(record.get(TASK.DESCRIPTION));
		target.setStartDate(dtMapper.toLocalDate(record.get(TASK.START_DATE)));
		target.setEndDate(dtMapper.toLocalDate(record.get(TASK.END_DATE)));

		final OrganizationDto org = new OrganizationDto();
		org.setId(record.get(TASK.ORGANIZATION_ID));

		target.setOrganization(org);

		return target;
	}

}
