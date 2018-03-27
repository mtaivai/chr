package fi.codense.chr.model.jpa;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(
	schema = "chr",
	name = "country_loc"
)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CountryLoc {

	@Embeddable
	@Data
	@AllArgsConstructor @NoArgsConstructor
	public static class PK implements Serializable {
		@ManyToOne(optional = false, fetch = FetchType.LAZY)
		private Country country;

		@ManyToOne(optional = false, fetch = FetchType.LAZY)
		private Locale locale;

	}
	@EmbeddedId
	private PK pk;

	@Basic(optional = false)
	private String name;
}
