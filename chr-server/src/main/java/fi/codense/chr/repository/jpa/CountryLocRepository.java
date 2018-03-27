package fi.codense.chr.repository.jpa;

import fi.codense.chr.model.jpa.Country;
import fi.codense.chr.model.jpa.CountryLoc;
import fi.codense.chr.model.jpa.Locale;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.stereotype.Repository;

@Repository
@RepositoryRestResource()
public interface CountryLocRepository extends JpaRepository<CountryLoc, CountryLoc.PK>,
	CountryLocRepositoryCustom {

//	Country findOneByCode(String code);
//	Country findOneByCodeOrCode2OrCode3(String code, String code2, String code3);

//	CountryLoc findOneByLocaleAndCountry(Locale locale, Country country);


}
