package cldr.tools;

import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;

abstract class ParseContext<TParent extends ParseContext> {
	final TParent parentContext;
	final String name;

	public static void parse(final XMLStreamReader xr, final ParseContext rootContext) throws XMLStreamException {

		ParseContext ctx = rootContext;

		int nextTok = -1;
		while (xr.hasNext()) {
			final int tok = (nextTok >= 0) ? nextTok : xr.next();
			nextTok = -1;
			switch (tok) {
				case XMLStreamReader.START_ELEMENT:
					ctx = ctx.startElement(xr);
					break;
				case XMLStreamReader.END_ELEMENT:
					ctx = ctx.endElement(xr);
					break;
				case XMLStreamReader.CHARACTERS:
				case XMLStreamReader.SPACE:
					ctx.characters(xr);
					break;
				case XMLStreamReader.CDATA:
					throw new UnsupportedOperationException("CDATA is not implemented");
				default:
			}
			if (tok != xr.getEventType()) {
				// Stream was processed by the current context
				nextTok = xr.getEventType();
			}
		}
	}

	private static class DefaultParseContext extends ParseContext {
		public DefaultParseContext(String name, ParseContext parent) {
			super(name, parent);
		}

		@Override
		public boolean isDefault() {
			return true;
		}
		@Override
		protected ParseContext startElement(XMLStreamReader xr) {
			return defaultStartElement(xr);
		}

		@Override
		protected ParseContext endElement(XMLStreamReader xr) {
			return defaultEndElement(xr);
		}
	}

	protected ParseContext(final String name, final TParent parent) {
		this.name = name;
		this.parentContext = parent;
	}

	public boolean isDefault() {
		return false;
	}

//	/**
//	 * Normally returns <em>this</em>, but
//	 * if the element is already parsed in whole, e.g. by calling
//	 * {@link XMLStreamReader#getElementText()}, returns the parent
//	 * context.
//	 * @return logical current context
//	 */
//	protected ParseContext getCurrentContext() {
//		return this;
//	}

	protected abstract ParseContext startElement(final XMLStreamReader xr) throws XMLStreamException;
	protected abstract ParseContext endElement(final XMLStreamReader xr) throws XMLStreamException;

	protected void characters(final XMLStreamReader xr) {
		// NOP
	}

	protected final ParseContext defaultStartElement(final XMLStreamReader xr) {
		return new DefaultParseContext(xr.getLocalName(), this);
	}
	protected final ParseContext defaultEndElement(final XMLStreamReader xr) {
		return parentContext;
	}

	@Override
	public String toString() {
		final StringBuilder sb = new StringBuilder();
		if (parentContext != null) {
			sb.append(parentContext.toString());
			sb.append('/');
		}
		sb.append(name);
		return sb.toString();
	}
}

abstract class RootContext extends ParseContext {
	RootContext() {
		super("",null);
	}


}
