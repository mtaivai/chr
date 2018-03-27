package fi.codense.chr.server;

import fi.codense.chr.server.util.OrderByBuilder;
import fi.codense.chr.server.util.PropertyColumnMapper;
import lombok.Data;
import org.jooq.DSLContext;
import org.jooq.SelectOrderByStep;
import org.jooq.SortField;
import org.jooq.Table;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.function.Supplier;

@Data
public class ResultsPage<T> {
	private List<T> content;
	private Integer numberOfElements;
	private Integer totalElements;
	private Integer number;
	private Integer size;
	private Integer totalPages;
	private boolean first;
	private boolean last;
	private String[] sort;

	public static <T> ResultsPage<T> fetchPage(
			final Table<?> table,
			final SelectOrderByStep<?> select,
			final Class<T> intoClass,
			final Pageable pageable,
			final Supplier<Collection<SortField>> defaultSortSupplier) {

		final DSLContext dsl = select.configuration().dsl();
		select.getQuery().asTable();
		final int total = dsl.fetchCount(select);

		final Sort sort = pageable.getSort();

		final Collection<SortField> defaultSort;
		if (defaultSortSupplier != null) {
			defaultSort = defaultSortSupplier.get();
		} else {
			defaultSort = Collections.emptyList();
		}


		final List<SortField<?>> orderBy = new OrderByBuilder(table)
				.withPropertyToColumnMapper(PropertyColumnMapper.INSTANCE.propertyToColumnMapper(intoClass))
				.add(sort)
				.add(defaultSort)
				.build();

		final List<T> pojos = select
				.orderBy(orderBy)
				.limit((int)pageable.getOffset(), pageable.getPageSize())
				.fetch()
				.into(intoClass);

		return new ResultsPage<>(
				pojos, pageable, total,
				new OrderByBuilder(table)
						.withColumnToPropertyMapper(
								PropertyColumnMapper.INSTANCE.columnToPropertyMapper(intoClass))
						.add(orderBy)
						.toOrders());
	}

	public ResultsPage() {
		this.content = new ArrayList<>();
		this.numberOfElements = 0;
		this.totalElements = 0;
		this.number = 0;
		this.size = 0;
		this.totalPages = 0;
		this.first = true;
		this.last = true;
		this.sort = new String[0];
	}

	public ResultsPage(final List<T> content, final Pageable pageable, final int totalElements, final List<Sort.Order> actualSort) {

		final PageImpl<T> pg = new PageImpl<>(content, pageable, totalElements);

		this.content = content;
		this.numberOfElements = pg.getNumberOfElements();
		this.totalElements = totalElements;

		this.number = pg.getNumber();
		this.size = pg.getSize();
		this.totalPages = pg.getTotalPages();

		this.first = pg.isFirst();
		this.last = pg.isLast();

		final List<String> orders = new ArrayList<>();
		final Iterable<Sort.Order> sort;

		if (actualSort != null) {
			sort = actualSort;
		} else {
			sort = pg.getSort();
		}

		sort.forEach((order) -> {
			order.getProperty();
			order.getDirection();
			orders.add(order.getProperty() + "," +
					order.getDirection().name());
		});
		this.sort = orders.toArray(new String[orders.size()]);

	}

}
