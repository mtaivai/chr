package fi.codense.chr.server;

import fi.codense.chr.model.jooq.psql.tables.pojos.Person;
import fi.codense.chr.model.jooq.psql.tables.records.PersonRecord;
import org.jooq.DSLContext;
import org.jooq.SortField;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;
import java.util.LinkedHashSet;

import static fi.codense.chr.model.jooq.psql.Tables.PERSON;


@RequestMapping("/people")
@RestController
@CrossOrigin()
public class PersonController {

	@Autowired
	DSLContext dsl;


	protected Collection<SortField> getDefaultSort() {
		final Collection<SortField> defaultSort = new LinkedHashSet<>();
		defaultSort.add(PERSON.LAST_NAME.asc());
		defaultSort.add(PERSON.FIRST_NAME.asc());
		defaultSort.add(PERSON.ID.asc());
		return defaultSort;
	}



	@GetMapping
	public ResultsPage<Person> findAll(
			Pageable pageable) {


		return ResultsPage.fetchPage(
				PERSON,
				dsl.selectFrom(PERSON),
				Person.class,
				pageable,
				this::getDefaultSort);

	}

	@PostMapping
	public Long addPerson(@RequestBody final PersonUpdateRequest person) {

		final PersonRecord rec = dsl.newRecord(PERSON);
		rec.setFirstName(person.getFirstName());
		rec.setLastName(person.getLastName());
		rec.store();
		final Long id = rec.getId();
		return id;
	}
}
