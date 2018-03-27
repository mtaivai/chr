package cldr;

import com.google.gson.Gson;

import java.io.InputStreamReader;
import java.util.Map;

public class LocaleData {

	// TODO caching of parsed data!

	public static Map<String, Map<String, String>> getTerritoryNames() {
		Gson gson = new Gson();

		@SuppressWarnings("unchecked")
		final Map<String, Map<String, Map<String, String>>> map =
			(Map<String, Map<String, Map<String, String>>>)
				gson.fromJson(new InputStreamReader(LocaleData.class.getResourceAsStream("/cldr/main.json")), Map.class);

		final Map<String, Map<String, String>> territories = map.get("territories");
		return territories;
	}

}
