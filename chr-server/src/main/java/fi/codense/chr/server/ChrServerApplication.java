package fi.codense.chr.server;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.annotation.PostConstruct;
import java.util.Locale;

@SpringBootApplication(
		scanBasePackages = {
				"fi.codense.chr.server"

		})
@EntityScan("fi.codense.chr.model.jpa")
@EnableJpaRepositories(basePackages = {
		"fi.codense.chr.repository.jpa"
})
@EnableTransactionManagement(proxyTargetClass = false)
public class ChrServerApplication {

	private static final Logger log = LoggerFactory.getLogger(ChrServerApplication.class);


	@Autowired
	private InitService initService;

	public static void main(String[] args) {

		System.out.println("Loc:"  + Locale.forLanguageTag("az_Latn_AZ"));

		//SpringApplication.run(ChrServerApplication.class, args);
	}
//
//	@Bean
//	public LoadTimeWeaver loadTimeWeaver()  throws Throwable {
//		InstrumentationLoadTimeWeaver loadTimeWeaver = new InstrumentationLoadTimeWeaver();
//		return loadTimeWeaver;
//	}

	@PostConstruct
	void init() {
		checkHibernateWeavingEnabled();
	}


	static void checkHibernateWeavingEnabled() {

		final Class<?> inspectedClass = fi.codense.chr.model.jpa.Locale.class;

		log.info("Checking if Hibernate build-time enhancements are available...");


		// enableLazyInitialization (REQUIRED)
		try {
			inspectedClass.getDeclaredMethod("$$_hibernate_getInterceptor");
			log.info("Hibernate lazy initialization enhancements seem to be available");
		} catch (final NoSuchMethodException e) {
			log.error("Hibernate lazy initialization enhancements not found");
			throw new RuntimeException("Required Hibernate build-time enhancement may not be enabled", e);
		}


		// enableDirtyTracking (OPTIONAL)
		try {
			inspectedClass.getDeclaredMethod("$$_hibernate_hasDirtyAttributes");
			log.info("Hibernate dirtyTracking enhancement seems to be available");
		} catch (final NoSuchMethodException e) {
			log.warn("Hibernate dirtyTracking enhancements not found");
			throw new RuntimeException("Required Hibernate build-time enhancement may not be enabled", e);
		}


		log.info("Required Hibernate build-time enhancements are available");

	}

}
