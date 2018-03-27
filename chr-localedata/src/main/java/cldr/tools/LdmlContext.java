package cldr.tools;

import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import java.util.Locale;
import java.util.Objects;

class LdmlRootContext extends RootContext {


	// Language type --> locale --> localized name
	private final LocaleDataBuilder ldBuilder;

	LdmlRootContext(final LocaleDataBuilder ldb) {
		this.ldBuilder = ldb;
	}

	@Override
	protected ParseContext startElement(XMLStreamReader xr) {
		final String tagName = xr.getLocalName();
		if (tagName.equals(LdmlContext.TAG_LDML)) {
			return new LdmlContext(this);
		} else {
			return defaultStartElement(xr);
		}
	}

	@Override
	protected ParseContext endElement(XMLStreamReader xr) {
		return defaultEndElement(xr);
	}

	void addLocale(final String language, final String country) {
		Objects.requireNonNull(language, "language is required");
		if (country == null) {
			ldBuilder.withLocaleTag(new Locale(language).toLanguageTag());
		} else {
			ldBuilder.withLocaleTag(new Locale(language, country).toLanguageTag());
		}
	}
	void addLanguageName(final String type, final Locale locale, final String name) {
		ldBuilder.withLanguageName(type, locale, name);
	}
	void addTerritoryName(final String type, final Locale locale, final String name) {
		ldBuilder.withTerritoryName(type, locale, name);
	}


}

class LdmlContext extends ParseContext<LdmlRootContext> {
	static final String TAG_LDML = "ldml";

	static final String ATTR_TYPE = "type";

	String language;
	String territory;
	String version;
//	Map<String, String> languageNames = new HashMap<>();
//	Map<String, String> territoryNames = new HashMap<>();
//

//	static ParseContext enterOrDefault(final XMLStreamReader xr, final ParseContext parent) {
//		final String tagName = xr.getLocalName();
//		if (tagName.equals(TAG_LDML)) {
//			return new LdmlContext(parent);
//		} else {
//			return parent.defaultStartElement(xr);
//		}
//	}

	LdmlContext(final LdmlRootContext parent) {
		super(TAG_LDML, parent);
	}

	@Override
	protected ParseContext startElement(XMLStreamReader xr) {
		final String tagName = xr.getLocalName();
		if (tagName.equals(IdentityContext.TAG_IDENTITY)) {
			return new IdentityContext(this);
		} else if (tagName.equals(LocaleDisplayNamesContext.TAG_LOCALE_DISPLAY_NAMES)) {
			return new LocaleDisplayNamesContext(this);
		} else {
			return defaultStartElement(xr);
		}
	}

	@Override
	protected ParseContext endElement(XMLStreamReader xr) {
		return defaultEndElement(xr);
	}

	void setLocale(final String language, final String territory) {
		this.language = language;
		this.territory = territory;
		parentContext.addLocale(language,territory);
	}
	void setVersionNumber(final String number) {
		this.version = number;
	}

	Locale thisLocale() {
		final Locale locale;
		if (this.territory == null) {
			locale = new Locale(this.language);
		} else {
			locale = new Locale(this.language, this.territory);
		}
		return locale;
	}
	void addLanguageName(final String type, final String name) {
		parentContext.addLanguageName(type, thisLocale(), name);
	}
	void addTerritoryName(final String type, final String name) {
		parentContext.addTerritoryName(type, thisLocale(), name);
	}
}

class IdentityContext extends ParseContext<LdmlContext> {
	static final String TAG_IDENTITY = "identity";
	private static final String TAG_VERSION = "version";
	private static final String TAG_LANGUAGE = "language";
	private static final String TAG_TERRITORY = "territory";
	private static final String ATTR_NUMBER = "number";

	String language;
	String territory;

	static class LanguageOrRegionContext extends ParseContext<IdentityContext> {
		private final String type;
		LanguageOrRegionContext(final String tag, final IdentityContext parent, final XMLStreamReader xr) {
			super(tag, parent);
			type = xr.getAttributeValue(null, LdmlContext.ATTR_TYPE);
		}

		@Override
		protected ParseContext startElement(XMLStreamReader xr) throws XMLStreamException {
			return defaultStartElement(xr);
		}

		@Override
		protected IdentityContext endElement(XMLStreamReader xr) throws XMLStreamException {
			if (this.name.equals(IdentityContext.TAG_LANGUAGE)) {
				parentContext.setLanguageCode(type);
			} else if (this.name.equals(IdentityContext.TAG_TERRITORY)) {
				parentContext.setTerritoryCode(type);
			}
			return (IdentityContext)defaultEndElement(xr);
		}
	}
	static class VersionContext extends ParseContext<IdentityContext> {
		private final String number;
		VersionContext(final IdentityContext parent, final XMLStreamReader xr) {
			super(TAG_VERSION, parent);
			number = xr.getAttributeValue(null, ATTR_NUMBER);
		}

		@Override
		protected ParseContext startElement(XMLStreamReader xr) throws XMLStreamException {
			return defaultStartElement(xr);
		}

		@Override
		protected IdentityContext endElement(XMLStreamReader xr) throws XMLStreamException {
			parentContext.setVersionNumber(number);
			return (IdentityContext)defaultEndElement(xr);
		}
	}

	IdentityContext(final LdmlContext parent) {
		super(TAG_IDENTITY, parent);
	}

	@Override
	protected ParseContext startElement(XMLStreamReader xr) {
		final String tagName = xr.getLocalName();
		// version, language, territory
		if (tagName.equals(IdentityContext.TAG_LANGUAGE) ||
				tagName.equals(IdentityContext.TAG_TERRITORY)) {
			return new LanguageOrRegionContext(tagName, this, xr);
		} else if (tagName.equals(IdentityContext.TAG_VERSION)) {
			return new VersionContext(this, xr);
		} else {
			return defaultStartElement(xr);
		}
	}

	@Override
	protected LdmlContext endElement(XMLStreamReader xr) {
		if (language != null || territory != null) {
			parentContext.setLocale(language, territory);
		}
		return (LdmlContext)defaultEndElement(xr);
	}

	void setLanguageCode(final String type) {
		this.language = type;
	}
	void setTerritoryCode(final String type) {
		this.territory = type;
	}
	void setVersionNumber(final String number) {
		parentContext.setVersionNumber(number);
	}

}




class LocaleDisplayNamesContext extends ParseContext<LdmlContext> {
	static final String TAG_LOCALE_DISPLAY_NAMES = "localeDisplayNames";


	LocaleDisplayNamesContext(final LdmlContext parent) {
		super(TAG_LOCALE_DISPLAY_NAMES, parent);
	}

	@Override
	protected ParseContext startElement(XMLStreamReader xr) {
		final String tagName = xr.getLocalName();
		if (tagName.equals(LanguagesContext.TAG_LANGUAGES)) {
			return new LanguagesContext(this);
		} else if (tagName.equals(TerritoriesContext.TAG_TERRITORIES)) {
			return new TerritoriesContext(this);
		} else {
			return defaultStartElement(xr);
		}
	}

	@Override
	protected LdmlContext endElement(XMLStreamReader xr) {
		return (LdmlContext)defaultEndElement(xr);
	}

	void addLanguageName(final String type, final String name) {
		parentContext.addLanguageName(type, name);
	}
	void addTerritoryName(final String type, final String name) {
		parentContext.addTerritoryName(type, name);
	}
}


class LanguagesContext extends ParseContext<LocaleDisplayNamesContext> {
	static final String TAG_LANGUAGES = "languages";
	static final String TAG_LANGUAGE = "language";

	private int childDepth = 0;

	LanguagesContext(final LocaleDisplayNamesContext parent) {
		super(TAG_LANGUAGES, parent);
	}

	@Override
	protected ParseContext startElement(XMLStreamReader xr) throws XMLStreamException {
		childDepth++;

		final String tagName = xr.getLocalName();
		if (tagName.equals(TAG_LANGUAGE)) {
			final String type = xr.getAttributeValue(null, LdmlContext.ATTR_TYPE);
			final String value = xr.getElementText();
			parentContext.addLanguageName(type, value);
		}
		return this;
	}

	@Override
	protected ParseContext endElement(XMLStreamReader xr) {
		if (childDepth <= 0) {
			return parentContext;
		} else {
			childDepth--;
			return this;
		}
	}
}

class TerritoriesContext extends ParseContext<LocaleDisplayNamesContext> {
	static final String TAG_TERRITORIES = "territories";
	static final String TAG_TERRITORY = "territory";

	private int childDepth = 0;

	TerritoriesContext(final LocaleDisplayNamesContext parent) {
		super(TAG_TERRITORIES, parent);
	}

	@Override
	protected ParseContext startElement(XMLStreamReader xr) throws XMLStreamException {
		childDepth++;

		final String tagName = xr.getLocalName();
		if (tagName.equals(TAG_TERRITORY)) {
			final String type = xr.getAttributeValue(null, LdmlContext.ATTR_TYPE);
			final String value = xr.getElementText();
			parentContext.addTerritoryName(type, value);
		}
		return this;
	}

	@Override
	protected ParseContext endElement(XMLStreamReader xr) {
		if (childDepth <= 0) {
			return parentContext;
		} else {
			childDepth--;
			return this;
		}
	}
}

