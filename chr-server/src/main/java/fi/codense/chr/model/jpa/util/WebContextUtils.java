package fi.codense.chr.model.jpa.util;

import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.orm.jpa.EntityManagerHolder;
import org.springframework.transaction.support.TransactionSynchronizationManager;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

public final class WebContextUtils {

	private WebContextUtils() {

	}

	public static java.util.Locale getCurrentLocale() {
		java.util.Locale l = LocaleContextHolder.getLocale();
		return (l != null) ? l : java.util.Locale.getDefault();
	}

	public static HttpServletRequest getHttpServletRequest() {
		final RequestAttributes ra = RequestContextHolder.currentRequestAttributes();
		if (ra instanceof ServletRequestAttributes) {
			final ServletRequestAttributes wr = (ServletRequestAttributes)ra;
			return wr.getRequest();
		} else {
			return null;
		}
	}
	public static WebApplicationContext getWebApplicationContext() {
		return getWebApplicationContext(getHttpServletRequest());
	}

	public static WebApplicationContext getWebApplicationContext(final HttpServletRequest req) {
		if (req == null) {
			return null;
		}
		final ServletContext sc = req.getServletContext();
		return sc != null ? WebApplicationContextUtils.getWebApplicationContext(sc) : null;
	}

	public static EntityManagerFactory getEntityManagerFactory() {
		return getEntityManagerFactory(getWebApplicationContext());
	}
	public static EntityManagerFactory getEntityManagerFactory(final WebApplicationContext applicationContext) {
		if (applicationContext == null) {
			return null;
		}
		final EntityManagerFactory emf = applicationContext.getBean(EntityManagerFactory.class);
		return emf;
	}

	public static EntityManagerHolder getEntityManagerHolder(final EntityManagerFactory emf) {
		if (emf == null) {
			return null;
		}
		final EntityManagerHolder emh = (EntityManagerHolder) TransactionSynchronizationManager.getResource(emf);
		return emh;
	}

	public static EntityManager getEntityManager() {
		final EntityManagerHolder emh = getEntityManagerHolder(getEntityManagerFactory());
		return emh != null ? emh.getEntityManager() : null;
	}
	public static EntityManager getEntityManager(final EntityManagerFactory emf) {
		final EntityManagerHolder emh = getEntityManagerHolder(emf);
		return emh != null ? emh.getEntityManager() : null;
	}
}
