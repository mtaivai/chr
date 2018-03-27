package fi.codense.chr.server;

import org.mapstruct.Mapper;

import java.time.LocalDate;

@Mapper
public class DateTimeMapper {
	public LocalDate toLocalDate(final java.util.Date date) {
		if (date == null) {
			return null;
		}
		return LocalDate.from(date.toInstant());
	}
	public LocalDate toLocalDate(final java.sql.Date date) {
		if (date == null) {
			return null;
		}
		return date.toLocalDate();
	}
}
