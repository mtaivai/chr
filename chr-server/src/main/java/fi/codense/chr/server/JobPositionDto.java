package fi.codense.chr.server;

import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class JobPositionDto {
//	private PersonDto person;
	private OrganizationDto organization;
	private String title;
	private String description;
	private LocalDate startDate;
	private LocalDate endDate;

	private List<TaskDto> tasks;
}
