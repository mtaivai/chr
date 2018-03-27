package fi.codense.chr.server.util;

import org.springframework.beans.BeanUtils;

import javax.persistence.Column;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;

public class PropertyColumnMapper {

	public static final PropertyColumnMapper INSTANCE = new PropertyColumnMapper();

	private static final class Mappings {
		private Map<String, String> propertyToColumn;
		private Map<String, String> columnToProperty;

	}
	final Map<Class<?>, Mappings> classMappings = new HashMap<>();

	public Function<String, String> propertyToColumnMapper(final Class<?> clazz) {
		return (propertyName) -> columnName(clazz, propertyName);
	}

	public Function<String, String> columnToPropertyMapper(final Class<?> clazz) {
		return (columnName) -> propertyName(clazz, columnName);
	}

	public String columnName(final Class<?> clazz, final String propertyName) {
		final Mappings mappings = getMappings(clazz);
		return mappings.propertyToColumn.get(propertyName);
	}
	public String propertyName(final Class<?> clazz, final String columnName) {
		final Mappings mappings = getMappings(clazz);
		return mappings.columnToProperty.get(columnName);
	}

	private Mappings getMappings(final Class<?> clazz) {
		synchronized(classMappings) {
			Mappings mappings = classMappings.get(clazz);
			if (mappings == null) {
				mappings = mapClass(clazz);
				classMappings.put(clazz, mappings);
			}
			return mappings;
		}
	}

	private static Mappings mapClass(final Class<?> clazz) {
		//final Map<String, String> map = new HashMap<>();
		final Mappings mappings = new Mappings();
		mappings.propertyToColumn = new HashMap<>();
		mappings.columnToProperty = new HashMap<>();

		for (PropertyDescriptor pd: BeanUtils.getPropertyDescriptors(clazz)) {
			final String name = pd.getName();
			final Method getter = pd.getReadMethod();
			if (getter != null) {
				final Column column = getter.getAnnotation(Column.class);
				if (column != null) {
					final String columnName = column.name();
					if (columnName != null && !columnName.isEmpty()) {
						mappings.propertyToColumn.put(name, columnName);
						mappings.columnToProperty.put(columnName, name);
					}
				}

			}
		}
		return mappings;
	}
}
