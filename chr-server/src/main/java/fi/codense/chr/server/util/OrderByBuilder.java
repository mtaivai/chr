package fi.codense.chr.server.util;

import org.jooq.Field;
import org.jooq.SortField;
import org.jooq.SortOrder;
import org.jooq.Table;
import org.springframework.data.domain.Sort;

import java.util.*;
import java.util.function.Function;


public final class OrderByBuilder {
	private final List<SortField<?>> orderBy = new ArrayList<>();
	private final Set<String> addedSortColumns = new HashSet<>();
	private Function<String, String> propertyMapper;
	private Function<String, String> columnMapper;
	private Table<?> table;

	public OrderByBuilder() {
		super();
	}
	public OrderByBuilder(final Table<?> table) {
		this.table = table;
	}

	public final OrderByBuilder withTable(final Table<?> table) {
		this.table = table;
		return this;
	}

	public final OrderByBuilder withPropertyToColumnMapper(final Function<String, String> mapper) {
		this.propertyMapper = mapper;
		return this;
	}
	public final OrderByBuilder withColumnToPropertyMapper(final Function<String, String> mapper) {
		this.columnMapper = mapper;
		return this;
	}

	public final OrderByBuilder add(final Sort sort) {
		sort.forEach(this::add);
		return this;
	}

	public final OrderByBuilder add(final Sort.Order order) {
		if (table == null) {
			throw new IllegalStateException("'table' is required for Sort.Order mapping");
		}
		final String property = order.getProperty();

		final String column;
		final boolean mapped;
		if (propertyMapper != null) {
			column = propertyMapper.apply(property);
			mapped = true;
		} else {
			column = property;
			mapped = false;
		}

		Field<?> f = table.field(column);
		if (mapped && f == null) {
			// Try unmapped
			f = table.field(property);
		}

		if (f == null) {
			// TODO log error
		} else if (!addedSortColumns.contains(column)) {
			orderBy.add(order.isDescending() ? f.desc() : f.asc());
			addedSortColumns.add(column);
		}

		return this;
	}

	public final OrderByBuilder add(final SortField sortField) {

		final String column = sortField.getName();

		if (!addedSortColumns.contains(column)) {
			orderBy.add(sortField);
			addedSortColumns.add(column);
		}
		return this;
	}

	public final OrderByBuilder add(final Collection<?> orders) {
		orders.forEach((order) -> {
			if (order instanceof Sort.Order) {
				this.add((Sort.Order)order);
			} else if (order instanceof SortField) {
				this.add((SortField)order);
			} else {
				throw new IllegalArgumentException("Only Sort.Order and SortField are supported; got: " + order);
			}
		});
		return this;
	}

	public List<Sort.Order> toOrders() {
		if (table == null) {
			throw new IllegalStateException("'table' is required for Sort.Order mapping");
		}

		final List<Sort.Order> l = new ArrayList<>(orderBy.size());
		orderBy.forEach((orderBy) -> {
			final String column = orderBy.getName();

			final String property;
			final Field<?> f = table.field(column);
			if (f == null) {
				// No such property found; don't map!
				property = column;
			} else {
				property = columnMapper != null ? columnMapper.apply(column) : column;
			}

			if (property != null) {
				l.add(new Sort.Order(
						orderBy.getOrder() == SortOrder.DESC
								? Sort.Direction.DESC
								: Sort.Direction.ASC,
						property));
			}
		});
		return l;
	}

	public final List<SortField<?>> build() {
		return new ArrayList<>(orderBy);
	}
}
