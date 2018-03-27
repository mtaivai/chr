package fi.codense.chr.repository.jpa;

import fi.codense.chr.model.jpa.Organization;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.stereotype.Repository;

@Repository
@RepositoryRestResource
public interface OrganizationRepository extends JpaRepository<Organization, Long> {
}
