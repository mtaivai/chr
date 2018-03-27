package fi.codense.chr.server.init;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix="chr.locale-data")
@Data
public class LocaleDataConfigurationProperties {

//	private boolean importOnStartup = false;
//	private String cldrVersion;
//	private String cldrCommonUrl = "http://unicode.org/Public/cldr/{cldr-version}/cldr-common-{cldr-version}.zip";

}
