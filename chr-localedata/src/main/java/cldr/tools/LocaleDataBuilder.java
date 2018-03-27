package cldr.tools;

import java.util.*;

public class LocaleDataBuilder {

	// Language type --> locale --> localized name

	private Set<String> localeTags = new HashSet<>();

	private Map<String, Map<Locale, String>> languageNames =
			new HashMap<>();

	private Map<String, Map<Locale, String>> territoryNames =
			new HashMap<>();

	Set<String> getLocaleTags() {
		return localeTags;
	}
	Map<String, Map<Locale, String>> getLanguageNames() {
		return languageNames;
	}
	Map<String, Map<Locale, String>> getTerritoryNames() {
		return territoryNames;
	}

	public LocaleDataBuilder withLocaleTag(final String localeTag) {
		localeTags.add(localeTag);
		return this;
	}

	public LocaleDataBuilder withLanguageName(final String type, final Locale locale, final String name) {
		Map<Locale, String> m = languageNames.get(type);
		if (m == null) {
			m = new HashMap<>();
			languageNames.put(type, m);
		}
		m.put(locale, name);
		return this;
	}
	public LocaleDataBuilder withTerritoryName(final String type, final Locale locale, final String name) {
		Map<Locale, String> m = territoryNames.get(type);
		if (m == null) {
			m = new HashMap<>();
			territoryNames.put(type, m);
		}
		m.put(locale, name);
		return this;
	}

}
