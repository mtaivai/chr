package fi.codense.chr.repository.jpa;

import fi.codense.chr.model.jpa.Country;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.data.rest.core.config.Projection;
import org.springframework.stereotype.Repository;

@Repository
@RepositoryRestResource()
public interface CountryRepository extends JpaRepository<Country, Integer> {

	Country findOneByCode(String code);
	Country findOneByCodeOrCode2OrCode3(String code, String code2, String code3);

}
