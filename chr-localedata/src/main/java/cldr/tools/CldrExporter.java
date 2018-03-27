package cldr.tools;


import com.google.gson.Gson;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamException;
import javax.xml.stream.XMLStreamReader;
import java.io.*;
import java.net.URI;
import java.util.*;
import java.util.logging.Logger;
import java.util.zip.GZIPOutputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

public class CldrExporter {

	private static final Logger _log = Logger.getLogger(CldrExporter.class.getName());

	private static final String COMMON_MAIN_DIR = "common/main";

	private String inputFile;
	private String outputDir;
	private Set<String> types = new HashSet<>();
	private boolean compress = false;

	public static void main(String[] args) throws Exception {

		if (args.length < 1) {
			exitWithError("Invalid arguments");
		}


		final CldrExporter exporter = new CldrExporter();
		exporter.inputFile = args[0];

		for (int i = 1; i < args.length; i++) {
			final String arg = args[i];
			if (arg.equals("-o")) {
				if (i == args.length - 1) {
					exitWithError("Missing output directory");
				}
				i++;
				exporter.outputDir = args[i];
			} else if (arg.equals("-e")) {
				if (i == args.length - 1) {
					exitWithError("Missing type for last -e");
				}
				i++;
				exporter.types.add(args[i]);
			} else if (arg.equals("-z")) {
				exporter.compress = true;

			} else {
				exitWithError("Unknown option: " + arg);
			}
		}

		try {
			exporter.run();
			System.exit(0);
		} catch (Exception e) {
			e.printStackTrace(System.err);
			exitWithError(e.toString());
		}
	}

	private static void exitWithError(final String msg) {

		if (msg != null) {
			System.err.println("ERROR: " + msg);
		} else {
			System.err.println("ERROR");
		}
		System.err.println("Usage: <inputFile> [-o outputDir] [-e locales|languages|territories]*");
		System.exit(1);
	}
	private void run() throws Exception {

		final URI inputUri;
		if (inputFile.matches(".+\\/\\/.+")) {
			// URL
			inputUri = new URI(this.inputFile);
		} else {
			// FILE
			inputUri = new File(inputFile).toURI();
		}

		final File file = new File(inputUri);
		final ZipFile zf = new ZipFile(file);

		final String mainDirPrefix = COMMON_MAIN_DIR + "/";

		final LocaleDataBuilder ldb = new LocaleDataBuilder();

		final Enumeration<? extends ZipEntry> zee = zf.entries();
		while (zee.hasMoreElements()) {
			final ZipEntry ze = zee.nextElement();

			final String n = ze.getName();
			if (n.startsWith(mainDirPrefix) && n.endsWith(".xml")) {
				final String fileName = n.substring(mainDirPrefix.length());
				try (final InputStream in = new BufferedInputStream(zf.getInputStream(ze))){
					importLdml(in, fileName, ldb);
				} catch (final IOException | XMLStreamException ex) {
					throw new RuntimeException(ex);
				}

			}
		}

		final File outputDir = new File(this.outputDir);
		outputDir.mkdirs();


		final Map<String, Object> all = new HashMap<>();

		if (types.contains("locales")) {
			all.put("locales", ldb.getLocaleTags());
		}

		if (types.contains("territories")) {
			all.put("territories", ldb.getTerritoryNames());
		}

		if (types.contains("languages")) {
			all.put("languages", ldb.getLanguageNames());
		}


//		for (Map.Entry<String, Object> me: all.entrySet()) {
//			writeJson(me.getKey() + ".json", me.getValue());
//		}

		writeJson("main.json", all);

	}




//		final File outDir = new File("/Users/mikko/src/chr/chr-server/src/main/resources/cldr/common/main/");
//		outDir.mkdirs();
//
//		final Map<String, Object> json = new LinkedHashMap<>();
//		json.put("locales", ldb.getLocaleTags());
//		json.put("territories", ldb.getTerritoryNames());
//		json.put("languages", ldb.getLanguageNames());
//
//		// Write to separate files:
//		for (Map.Entry<String, Object> me: json.entrySet()) {
//			final String fileName = me.getKey() + ".json";
//			writeJsonFile(me.getValue(), new File(outDir, fileName));
//		}
//
//		System.exit(0);

	@FunctionalInterface
	private interface FilterSupplier {
		OutputStream get(final OutputStream out) throws IOException;
	}

	private void writeJson(final String name, final Object data) throws IOException {
		final Gson gson = new Gson();


		final FilterSupplier buf;

		if (this.compress) {
			buf = (out) -> new GZIPOutputStream(out, 2_097_152);
		} else {
			buf = (out) -> new BufferedOutputStream(out, 4192);
		}

		File outputFile = new File(outputDir, name);

		if (compress) {
			outputFile = new File(outputFile.getPath() + ".gz");
		}

		try (final Writer w =
			     new OutputStreamWriter(
				     buf.get(
				        new FileOutputStream(outputFile, false)))) {
			gson.toJson(data, w);
			w.flush();
		}
	}

	private static void importLdml(
			final InputStream in,
			final String name,
			final LocaleDataBuilder ldb)
			throws IOException, XMLStreamException {
//		log.debug("Importing ldml: {}", name);
		final XMLStreamReader xr =
			XMLInputFactory.newInstance().createXMLStreamReader(in);
		try {

			ParseContext.parse(xr, new LdmlRootContext(ldb));

		} finally {
			try {
				xr.close();
			} catch (final Exception e) {
				// Hmph... maybe it wasn't opened in the first place
				// NOP - we don't wont to mask real exceptions by
				// throwing redundant exceptions from here
			}
		}
	}

//
//	private static void writeJsonFile(Object json, final File outFile) throws IOException {
//
//		try (final BufferedWriter out = new BufferedWriter(new FileWriter(outFile, false))){
//
//			new ObjectMapper()
//					.configure(SerializationFeature.INDENT_OUTPUT, false)
//					.writeValue(out, json);
//		} finally {
//
//		}
//	}


}
