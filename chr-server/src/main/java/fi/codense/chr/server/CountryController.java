package fi.codense.chr.server;

import fi.codense.chr.model.jooq.psql.Tables;
import fi.codense.chr.model.jooq.psql.tables.pojos.Country;
import fi.codense.chr.model.jpa.LocalizedTextContent;
import org.jooq.DSLContext;
import org.jooq.SortField;
import org.jooq.impl.DSL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.List;

import static fi.codense.chr.model.jooq.psql.Tables.COUNTRY;


@RequestMapping("/custom-countries")
@RestController
@CrossOrigin()
public class CountryController {

	@Autowired
	DSLContext dsl;

	@PersistenceContext
	EntityManager entityManager;


	protected Collection<SortField> getDefaultSort() {
		final Collection<SortField> defaultSort = new LinkedHashSet<>();
		defaultSort.add(COUNTRY.NAME.asc());
		defaultSort.add(COUNTRY.CODE.asc());
		return defaultSort;
	}

	@GetMapping("/test")
	public String getTest() {
		return "test";

//		final List<LocalizedTextContent> tcs = entityManager.createQuery("select tc from LocalizedTextContent tc", LocalizedTextContent.class)
//				.getResultList();
//		tcs.forEach((tc) -> {
//			System.out.println(tc);
//		});
//
//		return dsl
//				.select(DSL.field("{0}->'fi'::varchar", String.class, Tables.COUNTRY.NAME_TRANSLATIONS))
//				.from(Tables.COUNTRY)
//				.where(Tables.COUNTRY.CODE.like("FI"))
//				//.getSQL();
//				.fetch()
//				.into(String.class)
//				.toString();

//				.
//		List results = entityManager.createNativeQuery(
//				"select c.name_translations->'fi'::::varchar from chr.country as c where c.code like 'FI'")
//				.getResultList();
//
//		return "";

	}

	@GetMapping
	public ResultsPage<Country> findAll(
			Pageable pageable) {

		return ResultsPage.fetchPage(
				COUNTRY,
				dsl.selectFrom(COUNTRY),
				Country.class,
				pageable,
				this::getDefaultSort);
	}

}
