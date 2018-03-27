package fi.codense.chr.model.jpa;

import lombok.Data;

import javax.persistence.*;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import java.io.Serializable;
import java.time.LocalDate;

@Entity
@Table(
		schema = "chr",
		name = "job_position_task"
)
@Data
public class JobPositionTask implements Serializable {


	@Id @ManyToOne(fetch = FetchType.EAGER)
	private JobPosition jobPosition;

	@Id @ManyToOne(fetch = FetchType.LAZY)
	private Task task;

	@Basic(optional = false)
	@Min(0)
	@Max(100)
	private Integer allocation;


}
