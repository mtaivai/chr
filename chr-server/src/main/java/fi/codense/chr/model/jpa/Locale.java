package fi.codense.chr.model.jpa;

import lombok.*;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.io.Serializable;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

@Entity
@Table(
		schema = "chr",
		name = "locale"
)
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(of = {"language", "country", "variant"})
public class Locale implements Serializable {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	/**
	 * Language code (such as 'en' or 'fr'), must be in lower case letters.
	 */
	@Basic(optional = false)
	@NotNull
	@Size(max = 8)
	@Pattern(regexp = "[a-z0-9]*")
	private String language;

	/**
	 * Country code (such as 'UK' or 'FR'), must be in upper case letters.
	 */

	@Basic(optional = false)
	@NotNull
	@Size(max = 3)
	@Pattern(regexp = "[A-Z0-9]*")
	private String country;

	@Basic(optional = false)
	@NotNull
	@Size(max = 255)
	private String variant;

	@Basic(optional = false)
	@NotNull
	@Size(max = 4)
	@Pattern(regexp = "([A-Z][A-Za-z]*)?")
	private String script;

	@Basic
	@Size(max = 255)
	private String family;

	@Basic
	@Size(max = 255)
	private String isoName;

	@Basic
	@Size(max = 255)
	private String nativeName;

	@Basic
	@Size(max = 1024)
	private String notes;

	@Basic
	private Integer defaultWeight;



	@PrePersist
	@PreUpdate
	private void prePersistOrUpdate() {
		// Normalize language, country and variant
		final String l = getLanguage();
		if (l != null) {
			// Language must be all lower case
			setLanguage(l.trim().toLowerCase());
		}

		// Country must be all upper case, null is not allowed but empty values are
		setCountry(StringUtils.trimToEmpty(getCountry()).toUpperCase());

		// Variant is case sensitive, null is not allowed but empty values are
		setVariant(StringUtils.trimToEmpty(getVariant()));

		// Script is case sensitive, null is not allowed byt empty values are
		setScript(StringUtils.trimToEmpty(getScript()));

	}

	public String toLanguageTag() {
		final String l = getLanguage();
		if (l == null) {
			return null;
		}
		final String c = getCountry();
		if (c == null) {
			return new java.util.Locale(l).toLanguageTag();
		}
		final String v = getVariant();
		if (v == null) {
			return new java.util.Locale(l, c).toLanguageTag();
		}
		return new java.util.Locale(l, c, v).toLanguageTag();
	}

}
