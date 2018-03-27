package fi.codense.chr.model.jpa;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.*;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.Map;

@Entity
@Table(
		schema = "chr",
		name = "country"
)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Country implements Serializable {

	@Id @GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;

	@Basic(optional = true)
	@Column(length = 3)
	private String code;

	@Basic(optional = true)
	@Column(length = 2)
	private String code2;

	@Basic(optional = true)
	@Column(length = 3)
	private String code3;

	@Basic(optional = false)
	@Column(length = 255, nullable = false)
	@NotNull
	private String name;

//	@ElementCollection(fetch = FetchType.LAZY)
//	@CollectionTable( schema = "chr", name="country_loc",
//		joinColumns = @JoinColumn(name="country_id"))
//	@Column(name="name")
//	@MapKeyColumn(name = "locale_id")
//	@Singular
//	//@MapKeyJoinColumn(name = "locale_id", referencedColumnName = "id")
//	private Map<Integer, String> translatedNames;


//	@OneToMany(mappedBy = "country", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
//	//@MapKeyColumn(name = "locale_id")
//	@MapKeyJoinColumn(name = "locale_id")
//	@Singular
//	private Map<Locale, CountryLoc> translations;
}




// @Entity
//      public class VideoStore {
//         @Id int id;
//         String name;
//         Address location;
//         ...
//         @ElementCollection
//         @CollectionTable(name="INVENTORY",
//                          joinColumns=@JoinColumn(name="STORE"))
//         @Column(name="COPIES_IN_STOCK")
//         @MapKeyJoinColumn(name="MOVIE", referencedColumnName="ID")
//         Map<Movie, Integer> videoInventory;
//         ...
//       }
//
//       @Entity
//       public class Movie {
//          @Id long id;
//          String title;
//          ...
//       }
