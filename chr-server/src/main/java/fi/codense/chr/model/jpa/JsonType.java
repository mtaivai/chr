package fi.codense.chr.model.jpa;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.hibernate.HibernateException;
import org.hibernate.engine.spi.SharedSessionContractImplementor;
import org.hibernate.usertype.UserType;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Map;

public class JsonType implements UserType {

	private final ObjectMapper objectMapper;

	public JsonType() {
		this.objectMapper = new ObjectMapper();
	}

	@Override
	public int[] sqlTypes() {

		return new int[] {Types.JAVA_OBJECT};
	}

	@Override
	public Class returnedClass() {
		return Map.class;
	}

	@Override
	public boolean equals(Object x, Object y) throws HibernateException {
		if (x == y) {
			return true;
		} else if (x == null || y == null) {
			return false;
		} else {
			return x.equals(y);
		}
	}

	@Override
	public int hashCode(Object x) throws HibernateException {
		if (x == null) {
			return 0;
		} else {
			return x.hashCode();
		}
	}

	@Override
	public Object nullSafeGet(ResultSet rs, String[] names, SharedSessionContractImplementor session, Object owner) throws HibernateException, SQLException {
		final String content = rs.getString(names[0]);
		if (content == null) {
			return null;
		}
		try {
			final Object obj = objectMapper.readValue(content, Map.class);
			if (obj == null) {
				return null;
			} else if (!(obj instanceof Map)) {
				throw new HibernateException("Expected an instance of java.util.Map, got " + obj.getClass().getName());
			}

			return obj;
		} catch (final IOException e) {
			throw new SQLException(e);
		}
	}

	@Override
	public void nullSafeSet(PreparedStatement st, Object value, int index, SharedSessionContractImplementor session) throws HibernateException, SQLException {

		if (value == null) {
			st.setNull(index, Types.OTHER);
		}
		try {
			final String json = objectMapper.writeValueAsString(value);
			st.setObject(index, json, Types.OTHER);
		} catch (final JsonProcessingException e) {
			throw new SQLException(e);
		}
	}

	static Map deepCopyMap(Map source) throws IOException, ClassNotFoundException {
		if (source == null) {
			return null;
		}
		// expected size:
		final int bufSize = Math.max(source.size() * 255, 1024);

		// Serialize and read!
		final ByteArrayOutputStream buf = new ByteArrayOutputStream(bufSize);

		try (final ObjectOutputStream oos =
				     new ObjectOutputStream(buf)) {
			oos.writeObject(source);
			oos.flush();
			buf.flush();
		}

		try (final ObjectInputStream ois =
				     new ObjectInputStream(new ByteArrayInputStream(buf.toByteArray()))) {
			return (Map)ois.readObject();
		}
	}
	@Override
	public Object deepCopy(Object value) throws HibernateException {

		if (!(value instanceof Map)) {
			throw new HibernateException("Expected an instance of java.util.Map, got " + value.getClass().getName());
		}

		try {
			return deepCopyMap((Map)value);
		} catch (final IOException | ClassNotFoundException e) {
			throw new HibernateException(e);
		}
	}

	@Override
	public boolean isMutable() {
		return true;
	}

	@Override
	public Serializable disassemble(Object value) throws HibernateException {
		return (Serializable)deepCopy(value);
	}

	@Override
	public Object assemble(Serializable cached, Object owner) throws HibernateException {
		return deepCopy(cached);
	}

	@Override
	public Object replace(Object original, Object target, Object owner) throws HibernateException {
		return deepCopy(original);
	}

}
