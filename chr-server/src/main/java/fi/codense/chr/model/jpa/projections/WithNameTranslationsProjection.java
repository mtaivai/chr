package fi.codense.chr.model.jpa.projections;

import fi.codense.chr.model.jpa.Country;
import org.springframework.data.rest.core.config.Projection;

@Projection(name = "withNameTranslations", types = { Country.class })
public interface WithNameTranslationsProjection {
	String getCode();
	String getName();
//	Translations getNameTranslations();

//	@Value("#{target.nameTranslations.forCurrentLang}")
//	String getCurrentLanguageName();
}
