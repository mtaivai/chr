package fi.codense.chr.repository.jpa;

import fi.codense.chr.model.jpa.Locale;
import fi.codense.chr.model.jpa.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RepositoryRestResource
public interface LocaleRepository extends JpaRepository<Locale, Long> {

	List<Locale> findByLanguage(String language);
	List<Locale> findByLanguageAndCountry(String language, String country);
	List<Locale> findByLanguageAndCountryAndVariant(String language, String country, String variant);
	Locale findByLanguageAndCountryAndVariantAndScript(String language, String country, String variant, String script);
}
