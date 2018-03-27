package fi.codense.chr.server.init;

import cldr.LocaleData;
import fi.codense.chr.model.jooq.psql.Tables;
import fi.codense.chr.model.jpa.Country;
import fi.codense.chr.model.jpa.CountryLoc;
import fi.codense.chr.model.jpa.Locale;
import fi.codense.chr.repository.jpa.CountryLocRepository;
import fi.codense.chr.repository.jpa.CountryRepository;
import fi.codense.chr.repository.jpa.LocaleRepository;
import org.apache.commons.lang3.StringUtils;
import org.jooq.DSLContext;
import org.jooq.impl.DSL;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@Order
@Transactional
public class LocaleDataInitializer implements ApplicationRunner {
	private static final Logger log = LoggerFactory.getLogger(LocaleDataInitializer.class);

	@Autowired
	private LocaleRepository localeRepository;

	@Autowired
	private CountryRepository countryRepository;

	@Autowired
	private CountryLocRepository countryLocRepository;

	@Autowired
	private DSLContext dsl;


	@Override
	public void run(ApplicationArguments args) throws Exception {

		importCLDR();
	}


	// TODO @PreAuthorize
	public void importCLDR() {

		log.info("Importing CLDR data from Java Locales");
		// Java 9 default: java.locale.providers=CLDR,COMPAT,SPI
		// Java 8 default: java.locale.providers=JRE,SPI
		System.err.println("WARNING: Don't know if we have CLDR or not!");

		// for (LocaleProviderAdapter.Type type : LocaleProviderAdapter.getAdapterPreference()) {
		//                LocaleProviderAdapter lda = LocaleProviderAdapter.forType(type);
		//                if (lda != null) {
		//                    LocaleServiceProvider lsp = lda.getLocaleServiceProvider(providerClass);
		//                    if (lsp != null) {
		//                        Locale[] locales = lsp.getAvailableLocales();
		//                        for (Locale locale: locales) {
		//                            availableLocales.add(getLookupLocale(locale));
		//                        }
		//                    }
		//                }
		//            }

		importCountries();


	}
	private static class PerfDuration {
		private final long duration;
		private PerfDuration(final long duration) {
			this.duration = duration;
		}
		long getNanos() {
			return duration;
		}
		double getMicros() {
			return (double)duration / 1_000.0;
		}
		double getMillis() {
			return (double)duration / 1_000_000.0;
		}
		double getSecs() {
			return (double)duration / 1_000_000_000.0;
		}
	}

	private static class PerfTimer {
		private long startTime;
		private final String name;
		PerfTimer(final String name) {
			super();
			this.name = name;
			startTime = System.nanoTime();
		}

		private PerfDuration get() {
			synchronized (this) {
				final long t = System.nanoTime();
				final long dt = t - startTime;
				return new PerfDuration(dt);
			}
		}
		private PerfDuration stop() {
			synchronized (this) {
				final long t = System.nanoTime();
				final long dt = t - startTime;
				startTime = t;
				return new PerfDuration(dt);
			}
		}
		private PerfDuration report(final String phase) {
			final PerfDuration x = get();
			synchronized(System.out) {
				System.out.printf("Timed %s:%s:%.2f ms", name, phase, x.getMillis());
			}
			return x;
		}
	}


	private void importCountries() {
		final PerfTimer timer = new PerfTimer("importCountries");

		timer.stop();
		final Map<String, Map<String, String>> countryNames = LocaleData.getTerritoryNames();
		timer.report("getTerritoryNames");

		log.info("Importing {} countries", countryNames.size());

		timer.stop();

		countryNames.forEach((country, translations) -> {
			final List<Integer> existingIds = dsl.selectFrom(Tables.COUNTRY)
				.where(Tables.COUNTRY.CODE.eq(country))
				.limit(1)
				.fetch(Tables.COUNTRY.ID);
			if (existingIds.size() > 0) {
				// Already exists, update
			} else {
				final String englishName = translations.get("en");

				final Integer newId = dsl.insertInto(Tables.COUNTRY)
					.columns(Tables.COUNTRY.CODE, Tables.COUNTRY.NAME)
					.values(country, englishName)
					.returning(Tables.COUNTRY.ID)
					.fetchOne()
					.getId();
				// Translations


				translations.forEach((lang, translation) -> {
					// Find locale by lang
					final Integer localeId = dsl.select(Tables.LOCALE.ID)
						.where(Tables.LOCALE.LANGUAGE.eq(""))
						.and(Tables.LOCALE.COUNTRY.eq(""))
						.and(Tables.LOCALE.VARIANT.eq(""))
						.and(Tables.LOCALE.SCRIPT.eq(""))
						.fetchOne(Tables.LOCALE.ID);

					dsl.insertInto(Tables.COUNTRY_LOC)
						.columns(
							Tables.COUNTRY_LOC.COUNTRY_ID,
							Tables.COUNTRY_LOC.LOCALE_ID,
							Tables.COUNTRY_LOC.NAME);
				});

			}

		});
		timer.report("update countries");

	}
	private void importLocales() {

//		if (true) {
//
//			final List<Country> countries = entityManager.createQuery("select c from Country c", Country.class).getResultList();
//			final Country fi = countries.get(0);
//			final Map<Integer, String> names = fi.getTranslatedNames();
//			System.out.println(names);
//
//
//			return;
//		}

		final java.util.Locale[] systemLocales = java.util.Locale.getAvailableLocales();

		if (log.isInfoEnabled()) {
			final long dbLocaleCount = localeRepository.count();
			log.info("System has {} and database {} Locales", systemLocales.length, dbLocaleCount);
		}

		int addedCount = 0;
		int updatedCount = 0;
		final Set<Integer> addedIds = new HashSet<>();

		final Map<java.util.Locale, Locale> localesInDb = new HashMap<>(systemLocales.length);


		for (final java.util.Locale locale : systemLocales) {
			final Locale existing = findLocaleForJul(locale);
			if (existing == null) {
				final Locale newLocale = new Locale();
				updateLocale(newLocale, locale);
				localeRepository.save(newLocale);
//				log.debug("Added new Locale to database: {}", newLocale);
				addedIds.add(newLocale.getId());

				localesInDb.put(locale, newLocale);
				addedCount++;
			} else {

				if (addedIds.contains(existing.getId())) {
					log.error("Attempt to update a previously added locale with {}: {}", locale, existing);
					throw new RuntimeException("Attempted to import locale twice: " + locale);
				}

				// TODO how do we know if it's really modified after our import?

				//updateLocale(existing, locale);

				//log.debug("Updating Locale: {}", existing);

				localesInDb.put(locale, existing);
				updatedCount++;

			}


		}
		log.info("Added {} new and updated {} existing Locales", addedCount, updatedCount);

		// Second pass: add / update countries:
		log.info("Updating countries for {} locales", localesInDb.size());


		for (final java.util.Locale locale: localesInDb.keySet()) {
			// Add / update country
			saveOrUpdateCountry(locale, localesInDb);
			countryLocRepository.flush();
		}
	}

	private Locale findLocaleForJul(final java.util.Locale locale) {
		final String language = locale.getLanguage();
		final String country = StringUtils.trimToEmpty(locale.getCountry());
		final String variant = StringUtils.trimToEmpty(locale.getVariant());
		final String script = StringUtils.trimToEmpty(locale.getScript());
		return localeRepository.findByLanguageAndCountryAndVariantAndScript(language, country, variant, script);

	}

	private void updateLocale(final Locale target, final java.util.Locale source) {

		target.setLanguage(source.getLanguage());
		target.setCountry(StringUtils.trimToEmpty(source.getCountry()));
		target.setVariant(StringUtils.trimToEmpty(source.getVariant()));
		target.setScript(StringUtils.trimToNull(source.getScript()));

		final String isoName = source.getDisplayName(java.util.Locale.ENGLISH);
		target.setIsoName(isoName);

		final String nativeName = source.getDisplayName(source);
		target.setNativeName(nativeName);
	}

	private void saveOrUpdateCountry(final java.util.Locale systemLocale, final Map<java.util.Locale, Locale> localeMapping) {

		final String c = systemLocale.getCountry();

		final long startTime = System.nanoTime();

		Country country = countryRepository.findOneByCode(c);
		System.out.printf("T0: %.3f: \n", (double)(System.nanoTime() - startTime) / 1000.0f);

		if (country == null) {
			final String nativeName = systemLocale.getDisplayCountry(systemLocale);
			System.out.printf("T0.1: %.3f: \n", (double)(System.nanoTime() - startTime) / 1000.0f);

			String c3;
			try {
				c3 = systemLocale.getISO3Country();
			} catch (Exception e) {
				c3 = null;
			}

			// In own language:

			final Country.CountryBuilder cb = Country.builder()
				.code(c)
				.code2(c.length() == 2 ? c : null)
				.code3(c3)
				.name(nativeName);

			final Country newCountry = cb.build();

			country = countryRepository.save(newCountry);



//			log.debug("Added new Country: {}", newCountry);

		} else {
			// Just update translations
			final String nativeName = systemLocale.getDisplayCountry(systemLocale);
			System.out.printf("T0.2: %.3f: \n", (double)(System.nanoTime() - startTime) / 1000.0f);

			if (nativeName != null && nativeName.length() > 0) {
				System.out.println(systemLocale + " > " + country.getCode() + " > " + nativeName);

				if (!Objects.equals(country.getName(), nativeName)) {
					country.setName(nativeName);
				}

			}

		}
		System.out.printf("T1: %.3f: \n", (double)(System.nanoTime() - startTime) / 1000.0f);

		// Translations for all locales
		int updatedTranslationCount = 0;
		int addedTranslationCount = 0;


		final java.util.Locale[] allLocales = java.util.Locale.getAvailableLocales();

		System.out.printf("T2: %.3f: \n", (double)(System.nanoTime() - startTime) / 1000.0f);


		for (final java.util.Locale otherSystemLocale: allLocales) {

			final Locale otherLocale = null != localeMapping ?
				localeMapping.get(otherSystemLocale) : findLocaleForJul(otherSystemLocale);
			if (otherLocale == null) {
				continue;
			}

			final String translatedName = systemLocale.getDisplayCountry(otherSystemLocale);
			if (translatedName == null || translatedName.isEmpty()) {
				continue;
			}

			final CountryLoc translation = countryLocRepository.findById(
				new CountryLoc.PK(country, otherLocale)).orElse(null);

			if (translation == null) {
				countryLocRepository.save(CountryLoc.builder()
					.pk(new CountryLoc.PK(country, otherLocale))
					.name(translatedName)
					.build());
				addedTranslationCount++;

			} else if (!Objects.equals(translation.getName(), translatedName)) {
				translation.setName(translatedName);
				updatedTranslationCount++;
			}
		}
		log.debug("Added translation in {} languages and updated in {}",
			addedTranslationCount, updatedTranslationCount);


		System.out.printf("T3: %.3f: \n", (double)(System.nanoTime() - startTime) / 1000.0f);


	}
}
