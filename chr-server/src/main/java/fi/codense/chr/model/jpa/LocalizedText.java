package fi.codense.chr.model.jpa;

import com.fasterxml.jackson.annotation.JsonIgnore;
import fi.codense.chr.model.jpa.util.WebContextUtils;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.orm.jpa.EntityManagerHolder;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.persistence.*;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.constraints.NotNull;
import java.util.*;

@Entity
@Table(
		schema = "chr",
		name = "localized_text"
)
@Data
@EqualsAndHashCode(of = {"id"})
@SequenceGenerator(name="entity_seq", sequenceName = "entity_seq", allocationSize = 50)
@NamedStoredProcedureQuery(
		name=LocalizedText.SPQ_FIND_BEST_CONTENT,
		procedureName = LocalizedText.SPQ_FIND_BEST_CONTENT_PROC_NAME,
		parameters = {
				@StoredProcedureParameter(
						name=LocalizedText.SPQ_FIND_BEST_CONTENT_P_LOCALIZED_TEXT_ID,
						type=Long.class),
				@StoredProcedureParameter(
						name=LocalizedText.SPQ_FIND_BEST_CONTENT_P_LANGUAGE,
						type=String.class),
				@StoredProcedureParameter(
						name=LocalizedText.SPQ_FIND_BEST_CONTENT_P_COUNTRY,
						type=String.class),
				@StoredProcedureParameter(
						name=LocalizedText.SPQ_FIND_BEST_CONTENT_P_VARIANT,
						type=String.class)
		},
		resultClasses = LocalizedTextContent.class
)
public class LocalizedText {
	private static final Logger log = LoggerFactory.getLogger(LocalizedText.class);

	public static final String SPQ_FIND_BEST_CONTENT =
			"LocalizedText.find_best_localized_text_content";

	public static final String SPQ_FIND_BEST_CONTENT_PROC_NAME =
			"chr.find_best_localized_text_content";

	public static final String SPQ_FIND_BEST_CONTENT_P_LOCALIZED_TEXT_ID = "localized_text_id";
	public static final String SPQ_FIND_BEST_CONTENT_P_LANGUAGE = "language";
	public static final String SPQ_FIND_BEST_CONTENT_P_COUNTRY= "country";
	public static final String SPQ_FIND_BEST_CONTENT_P_VARIANT = "variant";


	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "entity_seq")
	private Long id;


	@OneToMany(mappedBy = "localizedText", fetch = FetchType.LAZY)
	@JsonIgnore
	private Set<LocalizedTextContent> contents;

	public LocalizedText() {
		super();
	}



	@Transient
	public LocalizedTextContent getTranslation() {
		final EntityManager em = WebContextUtils.getEntityManager();
		if (em == null) {
			log.error("EntityManager is not available in the context");
			return null;
		} else {
			final java.util.Locale locale = WebContextUtils.getCurrentLocale();
			log.info("Finding best translation for locale: {}", locale);
			return this.findBestContent(locale.getLanguage(), locale.getCountry(), locale.getVariant(), em)
					.orElse(null);
		}
	}

	@Transient
	@JsonIgnore
	public Map<String, String> getTranslations() {
		final Set<LocalizedTextContent> contents = getContents();
		final Map<String, String> map = new HashMap<>(contents.size());
		contents.forEach((ltc) -> {
			final String ltag = ltc.getLocale().toLanguageTag();
			if (ltag != null) {
				map.put(ltag, ltc.getContent());
			}
		});
		return map;
	}

	public Optional<LocalizedTextContent> findBestContent(
			final String language,
			@NotNull final EntityManager entityManager) {
		return findBestContent(language, null, null, entityManager);
	}
	public Optional<LocalizedTextContent> findBestContent(
			final String language,
			final String country,
			@NotNull final EntityManager entityManager) {
		return findBestContent(language, country, null, entityManager);
	}

	public Optional<LocalizedTextContent> findBestContent(
			final String language,
			final String country,
			final String variant,
			@NotNull final EntityManager entityManager) {
		Objects.requireNonNull(language, "language");
		Objects.requireNonNull(entityManager, "entityManager");

		StoredProcedureQuery spq = entityManager.createNamedStoredProcedureQuery(SPQ_FIND_BEST_CONTENT);

		spq.setParameter(SPQ_FIND_BEST_CONTENT_P_LOCALIZED_TEXT_ID, getId());
		spq.setParameter(SPQ_FIND_BEST_CONTENT_P_LANGUAGE, language);
		spq.setParameter(SPQ_FIND_BEST_CONTENT_P_COUNTRY, country);
		spq.setParameter(SPQ_FIND_BEST_CONTENT_P_VARIANT, variant);
		spq.setMaxResults(1);
		final List results = spq.getResultList();
		if (results.isEmpty()) {
			return Optional.empty();
		} else {
			return Optional.of((LocalizedTextContent)results.get(0));
		}
	}
}
