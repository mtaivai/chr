package fi.codense.chr.model.jpa;

import lombok.Data;
import org.hibernate.annotations.GeneratorType;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(
		schema = "chr",
		name = "organization"
)
@Data
@SequenceGenerator(name="entity_seq", sequenceName = "entity_seq", allocationSize = 50)
public class Organization {

	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "entity_seq")
	private Long id;

	@Basic(optional = false)
	@Column(length = 255, nullable = false)
	private String name;

	@OneToMany(mappedBy = "organization", fetch = FetchType.LAZY)
	@OrderBy("endDate desc, startDate desc, name asc")
	private List<Task> tasks;
}
