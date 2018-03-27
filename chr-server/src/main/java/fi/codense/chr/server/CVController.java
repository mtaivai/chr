package fi.codense.chr.server;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.function.Consumer;

class Optionals {
	public static <T> boolean ifPresent(T value, Consumer<T> consumer) {
		if (value != null) {
			consumer.accept(value);
			return true;
		} else {
			return false;
		}
	}
}

@RestController
@RequestMapping("/cv")
public class CVController {

//	@Autowired
//	DSLContext dsl;
//
//
//	@GetMapping("/for-person/{personId}")
//	public CV getForPerson(@PathVariable("personId") final Long personId) {
////		final List<Cv> pojos = dsl.selectFrom(CV)
////				.where(CV.ID.equal(id))
////				.limit(1)
////				.fetch()
////				.into(Cv.class);
////		if (pojos.isEmpty()) {
////			throw new HttpClientErrorException(HttpStatus.NOT_FOUND);
////		}
////		return pojos.get(0);
//
//		final Person person = dsl.selectFrom(PERSON)
//				.where(PERSON.ID.eq(personId))
//				.fetchOne()
//				.into(Person.class);
//		if (person == null) {
//			throw new HttpClientErrorException(
//					HttpStatus.NOT_FOUND, "No such Person found");
//		}
//
//		// Job positions
//		final Result<Record> result = dsl.select()
//				.from(JOB_POSITION)
//				.join(ORGANIZATION).onKey()
////				.on(ORGANIZATION.ID.eq(JOB_POSITION.ORGANIZATION_ID))
//				.where(JOB_POSITION.PERSON_ID.eq(personId))
//				.orderBy(
//						JOB_POSITION.START_DATE.desc(),
//						JOB_POSITION.END_DATE.desc(),
//						JOB_POSITION.TITLE)
//
//				.fetch();
//
//
//		final List<JobPositionDto> jobPositions =
//				new ArrayList<>(result.size());
//
//		final OrganizationMapper orgMapper = OrganizationMapper.INSTANCE;
//		final TaskMapper taskMapper = TaskMapper.INSTANCE;
//
//		result.forEach((rec) -> {
//
//			final Long jobPositionid = rec.get(JOB_POSITION.ID);
//
//			final OrganizationDto org = orgMapper.toOrganizationDto(rec);
//
//
//			final JobPositionDto pos = new JobPositionDto();
//			pos.setOrganization(org);
//			Optionals.ifPresent(rec.get(JOB_POSITION.START_DATE), (startDate) ->
//					pos.setStartDate(startDate.toLocalDate())
//			);
//			Optionals.ifPresent(rec.get(JOB_POSITION.END_DATE), (endDate) ->
//					pos.setEndDate(endDate.toLocalDate())
//			);
//			pos.setTitle(rec.get(JOB_POSITION.TITLE));
//
//			final Result<Record> jbTasks = dsl.select()
//					.from(JOB_POSITION_TASK)
//					.join(TASK).onKey()
//					.where(JOB_POSITION_TASK.JOB_POSITION_ID.eq(jobPositionid))
//					.orderBy(JOB_POSITION_TASK.ALLOCATION.desc())
//					.fetch();
//
//			final List<TaskDto> tasks = new ArrayList<>(jbTasks.size());
//			jbTasks.forEach((jbTaskRecord) -> {
//
//				tasks.add(taskMapper.toTaskDto(jbTaskRecord));
//			});
//			pos.setTasks(tasks);
//
//			jobPositions.add(pos);
//		});
//		CV cv = new CV();
//		cv.setPerson(person);
//		cv.setJobPositions(jobPositions);
//
//		return cv;
//
//	}
}
