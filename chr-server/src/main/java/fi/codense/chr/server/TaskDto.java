package fi.codense.chr.server;

import lombok.Data;

import java.time.LocalDate;

@Data
public class TaskDto {
	private Long id;
	private OrganizationDto organization;
	private LocalDate startDate;
	private LocalDate endDate;
	private String name;
	private String description;

}
