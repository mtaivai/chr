package fi.codense.chr.model.jpa;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;

/**
 * Task or project in an Organization.
 */
@Entity
@Table(
		schema = "chr",
		name = "task"
)
@Data
@SequenceGenerator(name="entity_seq", sequenceName = "entity_seq", allocationSize = 50)
public class Task implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "entity_seq")
	private Long id;

	@Basic(optional = false)
	@Column(length = 100, nullable = false)
	private String name;

	@Basic(optional = true)
	@Column(length = 5_000, nullable = true)
	private String description;

	@Basic(optional = true)
	@Column(nullable = true)
	private LocalDate startDate;

	@Basic(optional = true)
	@Column(nullable = true)
	private LocalDate endDate;

	@ManyToOne(optional = false, fetch = FetchType.LAZY)
	@JoinColumn
	private Organization organization;

}
