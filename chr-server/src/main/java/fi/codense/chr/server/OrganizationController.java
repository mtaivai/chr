package fi.codense.chr.server;

import fi.codense.chr.model.jooq.psql.tables.pojos.Organization;
import org.jooq.DSLContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static fi.codense.chr.model.jooq.psql.tables.Organization.ORGANIZATION;

@RestController
@RequestMapping("/custom_organizations")
public class OrganizationController {

	@Autowired
	DSLContext dsl;

	@GetMapping
	public List<Organization> findAll() {

		final List<Organization> pojos;

		pojos = dsl.selectFrom(ORGANIZATION)
				.fetch()
				.sortAsc(ORGANIZATION.NAME)
				.into(Organization.class);
		// Return foobar
		return pojos;
	}
}
