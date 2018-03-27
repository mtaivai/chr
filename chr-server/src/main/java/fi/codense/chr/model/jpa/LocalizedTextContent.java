package fi.codense.chr.model.jpa;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.databind.annotation.JsonAppend;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Optional;

@Entity
@Table(
		schema = "chr",
		name = "localized_text_content"
)
@Data
@EqualsAndHashCode(of = {"locale", "content"})
@ToString(exclude = {"localizedText"})
public class LocalizedTextContent implements Serializable{

	@Id
	@ManyToOne(fetch = FetchType.LAZY)
	private LocalizedText localizedText;

	@Id
	@ManyToOne(fetch = FetchType.LAZY)
	private Locale locale;


	@Basic(optional = false, fetch = FetchType.LAZY)
	private String content;


	@Transient
	@JsonInclude
	public String getLanguageTag() {
		final Locale l = getLocale();
		return l != null ? l.toLanguageTag() : null;
	}



}
