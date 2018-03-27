package fi.codense.chr.model.jpa;

import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(
		schema = "chr",
		name = "person"
)
@Data
@SequenceGenerator(name="entity_seq", sequenceName = "entity_seq", allocationSize = 50)
public class Person {

	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "entity_seq")
	private Long id;

	@Basic(optional = true)
	@Column(length = 255, nullable = true)
	private String firstName;

	@Basic(optional = true)
	@Column(length = 255, nullable = true)
	private String lastName;

	@Basic(optional = true)
	@Column(length = 255, nullable = true)
	private String emailAddress;

	@Basic(optional = true)
	@Column(length = 1, nullable = true)
	private String gender;

//	@OneToMany(mappedBy = "person", fetch = FetchType.LAZY)
//	@OrderBy("endDate desc, startDate desc")
//	private List<JobPosition> jobPositions;
}
