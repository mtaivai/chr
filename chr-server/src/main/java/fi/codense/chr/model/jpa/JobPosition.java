package fi.codense.chr.model.jpa;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(
		schema = "chr",
		name = "job_position"
)
@Data
@SequenceGenerator(name="entity_seq", sequenceName = "entity_seq", allocationSize = 50)
public class JobPosition implements Serializable {

	private static final long serialVersionUID = 1L;


	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "entity_seq")
	private Long id;

	@Basic(optional = false)
	@Column(length = 255, nullable = false)
	private String title;

	@Basic(optional = false)
	@Column(nullable = false)
	private LocalDate startDate;

	@Basic(optional = true)
	@Column(nullable = true)
	private LocalDate endDate;

	@Basic(optional = true)
	@Column(length = 2_000, nullable = true)
	private String description;

	@ManyToOne(optional = false, fetch = FetchType.LAZY)
	@JoinColumn
	private Organization organization;


	@ManyToOne(optional = false, fetch = FetchType.LAZY)
	@JoinColumn
	private Person person;

	@OneToMany(mappedBy = "jobPosition")
	@OrderBy("allocation desc")
	private List<JobPositionTask> tasks;
}
// select
//      tasks0_.job_position_id as job_posi3_2_0_,
//      tasks0_.task_id as task_id2_2_0_,
//      tasks0_.task_id as task_id2_2_1_,
//      tasks0_.job_position_id as job_posi3_2_1_,
//      tasks0_.allocation as allocati1_2_1_,
//      task1_.id as id1_5_2_,
//      task1_.description as descript2_5_2_,
//      task1_.end_date as end_date3_5_2_,
//      task1_.name as name4_5_2_,
//      task1_.organization_id as organiza6_5_2_,
//      task1_.start_date as start_da5_5_2_
// from chr.job_position_task tasks0_
// inner join chr.task task1_ on
//      tasks0_.task_id=task1_.id
// where tasks0_.job_position_id=?
// order by tasks0_.task.startDate desc, tasks0_.task.endDate desc, tasks0_.task.allocation desc, tasks0_.task.name asc
