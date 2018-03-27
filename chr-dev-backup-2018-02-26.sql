--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 10.0

-- Started on 2018-02-26 10:41:17 EET

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 16386)
-- Name: chr; Type: SCHEMA; Schema: -; Owner: chr-dev
--

CREATE SCHEMA chr;


ALTER SCHEMA chr OWNER TO "chr-dev";

--
-- TOC entry 1 (class 3079 OID 12390)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2331 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = chr, pg_catalog;

--
-- TOC entry 223 (class 1255 OID 16707)
-- Name: canonicalize_locale_keys(); Type: FUNCTION; Schema: chr; Owner: chr-dev
--

CREATE FUNCTION canonicalize_locale_keys() RETURNS trigger
    LANGUAGE plpgsql
    AS $$BEGIN
	NEW.language = TRIM(both FROM LOWER(NEW.language));
    
    IF NEW.country IS NULL THEN
    	NEW.country = '';
    ELSE
    	NEW.country = TRIM(both FROM UPPER(NEW.country));
    END IF;
    
    if NEW.variant IS NULL THEN
    	NEW.variant = '';
    ELSE
    	NEW.variant = TRIM(both FROM NEW.variant);
    END IF;
    
    if NEW.script IS NULL THEN
    	NEW.script = '';
    ELSE
    	NEW.script = TRIM(both FROM NEW.script);
    END IF;
    
    return NEW;
END


$$;


ALTER FUNCTION chr.canonicalize_locale_keys() OWNER TO "chr-dev";

--
-- TOC entry 201 (class 1259 OID 16785)
-- Name: locale_id_seq; Type: SEQUENCE; Schema: chr; Owner: chr-dev
--

CREATE SEQUENCE locale_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locale_id_seq OWNER TO "chr-dev";

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 198 (class 1259 OID 16700)
-- Name: locale; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE locale (
    id integer DEFAULT nextval('locale_id_seq'::regclass) NOT NULL,
    language character varying(8) NOT NULL,
    country character varying NOT NULL,
    variant character varying NOT NULL,
    family character varying,
    iso_name character varying,
    native_name character varying(255),
    notes character varying(1024),
    default_weight integer,
    script character varying NOT NULL
);


ALTER TABLE locale OWNER TO "chr-dev";

--
-- TOC entry 2332 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN locale.language; Type: COMMENT; Schema: chr; Owner: chr-dev
--

COMMENT ON COLUMN locale.language IS 'ISO 639 alpha-2 or alpha-3 language code, or registered language subtags up to 8 alpha letters (for future enhancements). When a language has both an alpha-2 code and an alpha-3 code, the alpha-2 code must be used. You can find a full list of valid language codes in the IANA Language Subtag Registry (search for "Type: language"). The language field is case insensitive, but Locale always canonicalizes to lower case.';


--
-- TOC entry 2333 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN locale.country; Type: COMMENT; Schema: chr; Owner: chr-dev
--

COMMENT ON COLUMN locale.country IS 'ISO 3166 alpha-2 country code or UN M.49 numeric-3 area code. You can find a full list of valid country and region codes in the IANA Language Subtag Registry (search for "Type: region"). The country (region) field is case insensitive, but Locale always canonicalizes to upper case.';


--
-- TOC entry 2334 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN locale.variant; Type: COMMENT; Schema: chr; Owner: chr-dev
--

COMMENT ON COLUMN locale.variant IS 'Any arbitrary value used to indicate a variation of a Locale. Where there are two or more variant values each indicating its own semantics, these values should be ordered by importance, with most important first, separated by underscore(''_''). The variant field is case sensitive.';


--
-- TOC entry 2335 (class 0 OID 0)
-- Dependencies: 198
-- Name: COLUMN locale.script; Type: COMMENT; Schema: chr; Owner: chr-dev
--

COMMENT ON COLUMN locale.script IS 'The script for this locale, which should either be the empty string or an ISO 15924 4-letter script code. The first letter is uppercase and the rest are lowercase, for example, ''Latn'', ''Cyrl''.';


--
-- TOC entry 224 (class 1255 OID 16816)
-- Name: find_best_locales(character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: chr; Owner: chr-dev
--

CREATE FUNCTION find_best_locales(language character varying, country character varying DEFAULT NULL::character varying, variant character varying DEFAULT NULL::character varying, script character varying DEFAULT NULL::character varying, requiredcolumns character varying DEFAULT 'l'::character varying) RETURNS SETOF locale
    LANGUAGE plpgsql
    AS $$DECLARE
	lang_ ALIAS FOR language;
    country_ ALIAS FOR country;
    variant_ ALIAS FOR variant;
    script_ ALIAS FOR script;
    langIsOptional boolean;
    countryIsOptional boolean;
    variantIsOptional boolean;
    scriptIsOptional boolean;
BEGIN
	--IF lang_ IS NULL THEN
    --	RETURN;
    --END IF;
    
    IF lang_ IS NULL AND country_ IS NULL AND variant_ IS NULL THEN
    	RETURN QUERY SELECT l.* FROM chr.locale l ORDER BY l.language, l.country, l.variant;
    END IF;
    
    IF lang_ IS NOT NULL THEN
    	lang_ = TRIM(both FROM LOWER(lang_));
    END IF;
    
    IF country_ IS NOT NULL THEN
    	country_ = TRIM(both FROM UPPER(country_));
    END IF;
    
    IF variant_ IS NOT NULL THEN
    	variant_ = TRIM(both FROM variant_);
    END IF;
    
     IF script_ IS NOT NULL THEN
    	script_ = TRIM(both FROM script_);
    END IF;
    
    langIsOptional = position('l' in requiredColumns) = 0;
    countryIsOptional = position('c' in requiredColumns) = 0;
    variantIsOptional = position('v' in requiredColumns) = 0;
    scriptIsOptional = position('s' in requiredColumns) = 0;

	RETURN QUERY SELECT l.* FROM chr.locale l 
    	WHERE 
        (
          (
            (langIsOptional OR l.language = lang_)
          	AND (countryIsOptional OR l.country = country_)
          	AND (variantIsOptional OR l.variant = variant_)
          	AND (scriptIsOptional OR l.script = script_)
            AND
            (
              (country_ IS NULL OR l.country = country_)
              OR 
              (variant_ IS NULL OR l.variant = variant_)
              OR 
              (script_ IS NULL OR l.script = script_)
            )
          )
          OR l.default_weight > 0	
        )
        ORDER BY 
        (16 - (
            CASE WHEN lang_ IS NOT NULL AND l.language = lang_ THEN 8 ELSE 0 END + 
            CASE WHEN script_ IS NOT NULL AND l.script = script_ THEN 4 ELSE 0 END +
            CASE WHEN country_ IS NOT NULL AND l.country = country_ THEN 2 ELSE 0 END +
            CASE WHEN variant_ IS NOT NULL AND l.variant = variant_ THEN 1 ELSE 0 END
        )), 
        l.default_weight,
        l.language, 
        l.script,
        l.country,
        l.variant;

END;

$$;


ALTER FUNCTION chr.find_best_locales(language character varying, country character varying, variant character varying, script character varying, requiredcolumns character varying) OWNER TO "chr-dev";

--
-- TOC entry 222 (class 1255 OID 16742)
-- Name: find_best_locales_OLD1(character varying, character varying, character varying); Type: FUNCTION; Schema: chr; Owner: chr-dev
--

CREATE FUNCTION "find_best_locales_OLD1"(language character varying, country character varying DEFAULT NULL::character varying, variant character varying DEFAULT NULL::character varying) RETURNS SETOF locale
    LANGUAGE plpgsql
    AS $$DECLARE
	lang_ ALIAS FOR language;
    country_ ALIAS FOR country;
    variant_ ALIAS FOR variant;
BEGIN
	--IF lang_ IS NULL THEN
    --	RETURN;
    --END IF;
    
    IF lang_ IS NULL AND country_ IS NULL AND variant_ IS NULL THEN
    	RETURN QUERY SELECT l.* FROM chr.locale l ORDER BY l.language, l.country, l.variant;
    END IF;
    
    IF lang_ IS NOT NULL THEN
    	lang_ = TRIM(both FROM LOWER(lang_));
    END IF;
    
    IF country_ IS NOT NULL THEN
    	country_ = TRIM(both FROM UPPER(country_));
    END IF;
    
    IF variant_ IS NOT NULL THEN
    	variant_ = TRIM(both FROM variant_);
    END IF;
    
    -- language must match if specified
    -- Was previously:
    --     (lang_ IS NOT NULL AND l.language = lang_)
    --      OR (country_ IS NOT NULL AND l.country = country_)
    --      OR (variant_ IS NOT NULL AND l.variant = variant_)
    --      OR l.default_weight > 0
	RETURN QUERY SELECT l.* FROM chr.locale l 
    	WHERE 
        (
          (
            (lang_ IS NULL OR l.language = lang_)
          	AND
            (
              (country_ IS NULL OR l.country = country_)
              OR 
              (variant_ IS NULL OR l.variant = variant_)
            )
          )
          OR l.default_weight > 0	
        )
        ORDER BY 
        CASE 
          WHEN -- all match
          (
            lang_ IS NOT NULL AND l.language = lang_
          	AND country_ IS NOT NULL AND l.country = country_
          	AND variant_ IS NOT NULL AND l.variant = variant_
          ) THEN 1
          
          WHEN -- language and country match
          (
            lang_ IS NOT NULL AND l.language = lang_
          	AND country_ IS NOT NULL AND l.country = country_
          ) THEN 2
          
          WHEN  -- language and variant match
          (
            lang_ IS NOT NULL AND l.language = lang_
          	AND variant_ IS NOT NULL AND l.variant = variant_
          ) THEN 3
                
          WHEN -- language matches
          	lang_ IS NOT NULL AND l.language = lang_
          	THEN 5
            
          WHEN -- country and variant match
          (
            country_ IS NOT NULL AND l.country = country_
          	AND variant_ IS NOT NULL AND l.variant = variant_
          ) THEN 6
          
          WHEN -- country matches 
          	country_ IS NOT NULL AND l.country = country_
          	THEN 7
            
          WHEN -- variant matches
          	variant_ IS NOT NULL AND l.variant = variant_
            THEN 8
            
          WHEN -- default_weight defined
          	l.default_weight > 0
            THEN 20 + l.default_weight
            
          ELSE NULL
        END, 
        l.language, l.country, l.variant;
END;
$$;


ALTER FUNCTION chr."find_best_locales_OLD1"(language character varying, country character varying, variant character varying) OWNER TO "chr-dev";

--
-- TOC entry 225 (class 1255 OID 16814)
-- Name: find_best_locales_OLD2(character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: chr; Owner: chr-dev
--

CREATE FUNCTION "find_best_locales_OLD2"(language character varying, country character varying DEFAULT NULL::character varying, variant character varying DEFAULT NULL::character varying, script character varying DEFAULT NULL::character varying) RETURNS SETOF locale
    LANGUAGE plpgsql
    AS $$DECLARE
	lang_ ALIAS FOR language;
    country_ ALIAS FOR country;
    variant_ ALIAS FOR variant;
    script_ ALIAS FOR script;
    requiredColumns_ character varying;
    langIsOptional boolean;
    countryIsOptional boolean;
    variantIsOptional boolean;
    scriptIsOptional boolean;
BEGIN
	--IF lang_ IS NULL THEN
    --	RETURN;
    --END IF;
    
    IF lang_ IS NULL AND country_ IS NULL AND variant_ IS NULL THEN
    	RETURN QUERY SELECT l.* FROM chr.locale l ORDER BY l.language, l.country, l.variant;
    END IF;
    
    IF lang_ IS NOT NULL THEN
    	lang_ = TRIM(both FROM LOWER(lang_));
    END IF;
    
    IF country_ IS NOT NULL THEN
    	country_ = TRIM(both FROM UPPER(country_));
    END IF;
    
    IF variant_ IS NOT NULL THEN
    	variant_ = TRIM(both FROM variant_);
    END IF;
    
     IF script_ IS NOT NULL THEN
    	script_ = TRIM(both FROM script_);
    END IF;
    
    requiredColumns_ = 'l---';
    
    langIsOptional = position('l' in requiredColumns_) > 0;
    countryIsOptional = position('c' in requiredColumns_) > 0;
    variantIsOptional = position('v' in requiredColumns_) > 0;
    scriptIsOptional = position('s' in requiredColumns_) > 0;

	RETURN QUERY SELECT l.* FROM chr.locale l 
    	WHERE 
        (
          (
            (langIsOptional OR l.language = lang_)
          	AND
            (
              (country_ IS NULL OR l.country = country_)
              OR 
              (variant_ IS NULL OR l.variant = variant_)
              OR 
              (script_ IS NULL OR l.script = script_)
            )
          )
          OR l.default_weight > 0	
        )
        ORDER BY 
        (16 - (
            CASE WHEN lang_ IS NOT NULL AND l.language = lang_ THEN 8 ELSE 0 END + 
            CASE WHEN country_ IS NOT NULL AND l.country = country_ THEN 4 ELSE 0 END +
            CASE WHEN variant_ IS NOT NULL AND l.variant = variant_ THEN 2 ELSE 0 END +
            CASE WHEN script_ IS NOT NULL AND l.script = script_ THEN 1 ELSE 0 END
        )), 
        l.default_weight,
        l.language, 
        l.country, 
        l.variant,
        l.script;

END;

$$;


ALTER FUNCTION chr."find_best_locales_OLD2"(language character varying, country character varying, variant character varying, script character varying) OWNER TO "chr-dev";

--
-- TOC entry 197 (class 1259 OID 16689)
-- Name: localized_text_content; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE localized_text_content (
    localized_text_id bigint NOT NULL,
    locale_id bigint NOT NULL,
    content text NOT NULL
);


ALTER TABLE localized_text_content OWNER TO "chr-dev";

--
-- TOC entry 221 (class 1255 OID 16745)
-- Name: find_best_localized_text_content(bigint, character varying, character varying, character varying); Type: FUNCTION; Schema: chr; Owner: chr-dev
--

CREATE FUNCTION find_best_localized_text_content(localized_text_id bigint, language character varying, country character varying DEFAULT NULL::character varying, variant character varying DEFAULT NULL::character varying) RETURNS SETOF localized_text_content
    LANGUAGE sql
    AS $$
SELECT 
	ltc.*
FROM chr.find_best_locales(language, country, variant) 
	WITH ORDINALITY AS loc
JOIN chr.localized_text_content ltc
	ON ltc.localized_text_id = localized_text_id 
    AND ltc.locale_id in (loc.id)
ORDER BY loc.ordinality;
$$;


ALTER FUNCTION chr.find_best_localized_text_content(localized_text_id bigint, language character varying, country character varying, variant character varying) OWNER TO "chr-dev";

--
-- TOC entry 220 (class 1255 OID 16740)
-- Name: find_locale_id(character varying, character varying, character varying); Type: FUNCTION; Schema: chr; Owner: chr-dev
--

CREATE FUNCTION find_locale_id(language character varying, country character varying DEFAULT NULL::character varying, variant character varying DEFAULT NULL::character varying) RETURNS bigint
    LANGUAGE plpgsql
    AS $$DECLARE
	lang_ ALIAS FOR language;
    country_ ALIAS FOR country;
    variant_ ALIAS FOR variant;
	locale_id BIGINT;
BEGIN
	IF lang_ IS NULL THEN
    	RETURN NULL;
    END IF;
    
    lang_ = TRIM(both FROM LOWER(lang_));
    
    IF country_ IS NOT NULL THEN
    	country_ = TRIM(both FROM UPPER(country_));
    END IF;
    
    IF variant_ IS NOT NULL THEN
    	variant_ = TRIM(both FROM UPPER(variant_));
    END IF;
    
    SELECT l.id FROM chr.locale l 
    	WHERE l.language = lang_
        AND (country_ IS NULL OR l.country = country_)
        AND (variant_ IS NULL OR l.variant = variant_)
        INTO locale_id;
    
    RETURN locale_id;
END;
$$;


ALTER FUNCTION chr.find_locale_id(language character varying, country character varying, variant character varying) OWNER TO "chr-dev";

--
-- TOC entry 204 (class 1259 OID 16868)
-- Name: country; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE country (
    id integer NOT NULL,
    code2 character varying(2),
    code3 character varying(3),
    name character varying(255) NOT NULL,
    code character varying(3)
);


ALTER TABLE country OWNER TO "chr-dev";

--
-- TOC entry 203 (class 1259 OID 16866)
-- Name: country_id_seq; Type: SEQUENCE; Schema: chr; Owner: chr-dev
--

CREATE SEQUENCE country_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE country_id_seq OWNER TO "chr-dev";

--
-- TOC entry 2336 (class 0 OID 0)
-- Dependencies: 203
-- Name: country_id_seq; Type: SEQUENCE OWNED BY; Schema: chr; Owner: chr-dev
--

ALTER SEQUENCE country_id_seq OWNED BY country.id;


--
-- TOC entry 207 (class 1259 OID 16958)
-- Name: country_loc; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE country_loc (
    country_id integer NOT NULL,
    locale_id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE country_loc OWNER TO "chr-dev";

--
-- TOC entry 188 (class 1259 OID 16400)
-- Name: entity_seq; Type: SEQUENCE; Schema: chr; Owner: chr-dev
--

CREATE SEQUENCE entity_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_seq OWNER TO "chr-dev";

--
-- TOC entry 192 (class 1259 OID 16462)
-- Name: cv; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE cv (
    id bigint DEFAULT nextval('entity_seq'::regclass) NOT NULL,
    person_id bigint NOT NULL
);


ALTER TABLE cv OWNER TO "chr-dev";

--
-- TOC entry 206 (class 1259 OID 16904)
-- Name: entity_type; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE entity_type (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE entity_type OWNER TO "chr-dev";

--
-- TOC entry 205 (class 1259 OID 16902)
-- Name: entity_type_id_seq; Type: SEQUENCE; Schema: chr; Owner: chr-dev
--

CREATE SEQUENCE entity_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE entity_type_id_seq OWNER TO "chr-dev";

--
-- TOC entry 2337 (class 0 OID 0)
-- Dependencies: 205
-- Name: entity_type_id_seq; Type: SEQUENCE OWNED BY; Schema: chr; Owner: chr-dev
--

ALTER SEQUENCE entity_type_id_seq OWNED BY entity_type.id;


--
-- TOC entry 187 (class 1259 OID 16393)
-- Name: job_position; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE job_position (
    id bigint DEFAULT nextval('entity_seq'::regclass) NOT NULL,
    title character varying(255) NOT NULL,
    start_date date NOT NULL,
    end_date date,
    organization_id bigint NOT NULL,
    person_id bigint NOT NULL,
    description character varying(2000)
);


ALTER TABLE job_position OWNER TO "chr-dev";

--
-- TOC entry 195 (class 1259 OID 16606)
-- Name: job_position_task; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE job_position_task (
    job_position_id bigint NOT NULL,
    task_id bigint NOT NULL,
    allocation integer DEFAULT 100 NOT NULL
);


ALTER TABLE job_position_task OWNER TO "chr-dev";

--
-- TOC entry 202 (class 1259 OID 16850)
-- Name: localized_text_id_seq; Type: SEQUENCE; Schema: chr; Owner: chr-dev
--

CREATE SEQUENCE localized_text_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE localized_text_id_seq OWNER TO "chr-dev";

--
-- TOC entry 196 (class 1259 OID 16683)
-- Name: localized_text; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE localized_text (
    id integer DEFAULT nextval('localized_text_id_seq'::regclass) NOT NULL
);


ALTER TABLE localized_text OWNER TO "chr-dev";

--
-- TOC entry 186 (class 1259 OID 16387)
-- Name: organization; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE organization (
    id bigint DEFAULT nextval('entity_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE organization OWNER TO "chr-dev";

--
-- TOC entry 189 (class 1259 OID 16407)
-- Name: person; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE person (
    id bigint DEFAULT nextval('entity_seq'::regclass) NOT NULL,
    first_name character varying(255),
    last_name character varying(255),
    email_address character varying(255),
    gender character(1)
);


ALTER TABLE person OWNER TO "chr-dev";

--
-- TOC entry 191 (class 1259 OID 16447)
-- Name: person_skill; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE person_skill (
    person_id bigint NOT NULL,
    skill_id bigint NOT NULL,
    skill_level integer NOT NULL
);


ALTER TABLE person_skill OWNER TO "chr-dev";

--
-- TOC entry 194 (class 1259 OID 16565)
-- Name: person_task_skill; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE person_task_skill (
    person_id bigint NOT NULL,
    task_id bigint NOT NULL,
    skill_id bigint NOT NULL
);


ALTER TABLE person_task_skill OWNER TO "chr-dev";

--
-- TOC entry 199 (class 1259 OID 16751)
-- Name: service; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE service (
    id bigint DEFAULT nextval('entity_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE service OWNER TO "chr-dev";

--
-- TOC entry 190 (class 1259 OID 16435)
-- Name: skill; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE skill (
    id bigint DEFAULT nextval('entity_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(4000)
);


ALTER TABLE skill OWNER TO "chr-dev";

--
-- TOC entry 200 (class 1259 OID 16757)
-- Name: sync_status; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE sync_status (
    id bigint NOT NULL,
    service_id bigint NOT NULL,
    item_type character varying(255) NOT NULL
);


ALTER TABLE sync_status OWNER TO "chr-dev";

--
-- TOC entry 193 (class 1259 OID 16496)
-- Name: task; Type: TABLE; Schema: chr; Owner: chr-dev
--

CREATE TABLE task (
    id bigint DEFAULT nextval('entity_seq'::regclass) NOT NULL,
    start_date date,
    end_date date,
    name character varying(100) NOT NULL,
    description character varying(5000),
    organization_id bigint NOT NULL
);


ALTER TABLE task OWNER TO "chr-dev";

--
-- TOC entry 2099 (class 2604 OID 16871)
-- Name: country id; Type: DEFAULT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY country ALTER COLUMN id SET DEFAULT nextval('country_id_seq'::regclass);


--
-- TOC entry 2101 (class 2604 OID 16907)
-- Name: entity_type id; Type: DEFAULT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY entity_type ALTER COLUMN id SET DEFAULT nextval('entity_type_id_seq'::regclass);


--
-- TOC entry 2321 (class 0 OID 16868)
-- Dependencies: 204
-- Data for Name: country; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY country (id, code2, code3, name, code) FROM stdin;
\.


--
-- TOC entry 2324 (class 0 OID 16958)
-- Dependencies: 207
-- Data for Name: country_loc; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY country_loc (country_id, locale_id, name) FROM stdin;
\.


--
-- TOC entry 2309 (class 0 OID 16462)
-- Dependencies: 192
-- Data for Name: cv; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY cv (id, person_id) FROM stdin;
3	2
\.


--
-- TOC entry 2323 (class 0 OID 16904)
-- Dependencies: 206
-- Data for Name: entity_type; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY entity_type (id, name) FROM stdin;
\.


--
-- TOC entry 2304 (class 0 OID 16393)
-- Dependencies: 187
-- Data for Name: job_position; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY job_position (id, title, start_date, end_date, organization_id, person_id, description) FROM stdin;
6	Software Architect	2015-01-04	\N	1	2	\N
\.


--
-- TOC entry 2312 (class 0 OID 16606)
-- Dependencies: 195
-- Data for Name: job_position_task; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY job_position_task (job_position_id, task_id, allocation) FROM stdin;
6	7	100
\.


--
-- TOC entry 2315 (class 0 OID 16700)
-- Dependencies: 198
-- Data for Name: locale; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY locale (id, language, country, variant, family, iso_name, native_name, notes, default_weight, script) FROM stdin;
\.


--
-- TOC entry 2313 (class 0 OID 16683)
-- Dependencies: 196
-- Data for Name: localized_text; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY localized_text (id) FROM stdin;
\.


--
-- TOC entry 2314 (class 0 OID 16689)
-- Dependencies: 197
-- Data for Name: localized_text_content; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY localized_text_content (localized_text_id, locale_id, content) FROM stdin;
\.


--
-- TOC entry 2303 (class 0 OID 16387)
-- Dependencies: 186
-- Data for Name: organization; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY organization (id, name) FROM stdin;
1	Codense Consulting Oy
51	Uusi
52	Toinen
\.


--
-- TOC entry 2306 (class 0 OID 16407)
-- Dependencies: 189
-- Data for Name: person; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY person (id, first_name, last_name, email_address, gender) FROM stdin;
2	Mikko	Taivainen	mikko.taivainen@codense.fi	M
8	Niilo	Nimetön	\N	\N
9	John	Doe	\N	\N
10	Jane	Doe	\N	\N
14	Toinen	Testaaja	\N	\N
15	123	\N	\N	\N
16	123	\N	\N	\N
17	AAAA	AAAA	\N	\N
18	Erkki	Esimerkki	\N	\N
19	\N	\N	\N	\N
20	Jaska	Jokunen	\N	\N
21	Etunimi	Sukunimi	\N	\N
\.


--
-- TOC entry 2308 (class 0 OID 16447)
-- Dependencies: 191
-- Data for Name: person_skill; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY person_skill (person_id, skill_id, skill_level) FROM stdin;
2	4	1
2	5	1
\.


--
-- TOC entry 2311 (class 0 OID 16565)
-- Dependencies: 194
-- Data for Name: person_task_skill; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY person_task_skill (person_id, task_id, skill_id) FROM stdin;
2	7	4
\.


--
-- TOC entry 2316 (class 0 OID 16751)
-- Dependencies: 199
-- Data for Name: service; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY service (id, name) FROM stdin;
\.


--
-- TOC entry 2307 (class 0 OID 16435)
-- Dependencies: 190
-- Data for Name: skill; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY skill (id, name, description) FROM stdin;
4	Java	\N
5	AWS	\N
\.


--
-- TOC entry 2317 (class 0 OID 16757)
-- Dependencies: 200
-- Data for Name: sync_status; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY sync_status (id, service_id, item_type) FROM stdin;
\.


--
-- TOC entry 2310 (class 0 OID 16496)
-- Dependencies: 193
-- Data for Name: task; Type: TABLE DATA; Schema: chr; Owner: chr-dev
--

COPY task (id, start_date, end_date, name, description, organization_id) FROM stdin;
7	\N	\N	Linlex	Lakitietokanta	1
\.


--
-- TOC entry 2338 (class 0 OID 0)
-- Dependencies: 203
-- Name: country_id_seq; Type: SEQUENCE SET; Schema: chr; Owner: chr-dev
--

SELECT pg_catalog.setval('country_id_seq', 1093, true);


--
-- TOC entry 2339 (class 0 OID 0)
-- Dependencies: 188
-- Name: entity_seq; Type: SEQUENCE SET; Schema: chr; Owner: chr-dev
--

SELECT pg_catalog.setval('entity_seq', 17450, true);


--
-- TOC entry 2340 (class 0 OID 0)
-- Dependencies: 205
-- Name: entity_type_id_seq; Type: SEQUENCE SET; Schema: chr; Owner: chr-dev
--

SELECT pg_catalog.setval('entity_type_id_seq', 1, false);


--
-- TOC entry 2341 (class 0 OID 0)
-- Dependencies: 201
-- Name: locale_id_seq; Type: SEQUENCE SET; Schema: chr; Owner: chr-dev
--

SELECT pg_catalog.setval('locale_id_seq', 6674, true);


--
-- TOC entry 2342 (class 0 OID 0)
-- Dependencies: 202
-- Name: localized_text_id_seq; Type: SEQUENCE SET; Schema: chr; Owner: chr-dev
--

SELECT pg_catalog.setval('localized_text_id_seq', 1, false);


--
-- TOC entry 2095 (class 2606 OID 16622)
-- Name: job_position_task check_allocation_valid; Type: CHECK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE job_position_task
    ADD CONSTRAINT check_allocation_valid CHECK (((allocation >= 0) AND (allocation <= 100))) NOT VALID;


--
-- TOC entry 2343 (class 0 OID 0)
-- Dependencies: 2095
-- Name: CONSTRAINT check_allocation_valid ON job_position_task; Type: COMMENT; Schema: chr; Owner: chr-dev
--

COMMENT ON CONSTRAINT check_allocation_valid ON job_position_task IS 'allocation >= 0 AND allocation <= 100';


--
-- TOC entry 2100 (class 2606 OID 16988)
-- Name: country check_country_code; Type: CHECK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE country
    ADD CONSTRAINT check_country_code CHECK (((code IS NOT NULL) OR (code2 IS NOT NULL) OR (code3 IS NOT NULL))) NOT VALID;


--
-- TOC entry 2148 (class 2606 OID 16873)
-- Name: country country_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id);


--
-- TOC entry 2122 (class 2606 OID 16467)
-- Name: cv cv_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY cv
    ADD CONSTRAINT cv_pkey PRIMARY KEY (id);


--
-- TOC entry 2162 (class 2606 OID 16912)
-- Name: entity_type entity_type_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY entity_type
    ADD CONSTRAINT entity_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2112 (class 2606 OID 16397)
-- Name: job_position job_position_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY job_position
    ADD CONSTRAINT job_position_pkey PRIMARY KEY (id);


--
-- TOC entry 2130 (class 2606 OID 16611)
-- Name: job_position_task job_position_task_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY job_position_task
    ADD CONSTRAINT job_position_task_pkey PRIMARY KEY (job_position_id, task_id);


--
-- TOC entry 2141 (class 2606 OID 16789)
-- Name: locale locale_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY locale
    ADD CONSTRAINT locale_pkey PRIMARY KEY (id);


--
-- TOC entry 2137 (class 2606 OID 16696)
-- Name: localized_text_content localized_text_content_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY localized_text_content
    ADD CONSTRAINT localized_text_content_pkey PRIMARY KEY (localized_text_id, locale_id);


--
-- TOC entry 2132 (class 2606 OID 16854)
-- Name: localized_text localized_text_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY localized_text
    ADD CONSTRAINT localized_text_pkey PRIMARY KEY (id);


--
-- TOC entry 2104 (class 2606 OID 16391)
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- TOC entry 2114 (class 2606 OID 16415)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 2120 (class 2606 OID 16451)
-- Name: person_skill person_skill_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY person_skill
    ADD CONSTRAINT person_skill_pkey PRIMARY KEY (person_id, skill_id);


--
-- TOC entry 2128 (class 2606 OID 16569)
-- Name: person_task_skill person_task_skill_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY person_task_skill
    ADD CONSTRAINT person_task_skill_pkey PRIMARY KEY (person_id, task_id, skill_id);


--
-- TOC entry 2144 (class 2606 OID 16756)
-- Name: service service_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY service
    ADD CONSTRAINT service_pkey PRIMARY KEY (id);


--
-- TOC entry 2116 (class 2606 OID 16484)
-- Name: skill skill_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY skill
    ADD CONSTRAINT skill_pkey PRIMARY KEY (id);


--
-- TOC entry 2146 (class 2606 OID 16761)
-- Name: sync_status sync_status_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY sync_status
    ADD CONSTRAINT sync_status_pkey PRIMARY KEY (id);


--
-- TOC entry 2124 (class 2606 OID 16501)
-- Name: task task_pkey; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_pkey PRIMARY KEY (id);


--
-- TOC entry 2106 (class 2606 OID 16444)
-- Name: organization uix_organization_name; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY organization
    ADD CONSTRAINT uix_organization_name UNIQUE (name);


--
-- TOC entry 2118 (class 2606 OID 16492)
-- Name: skill uix_skill_name; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY skill
    ADD CONSTRAINT uix_skill_name UNIQUE (name);


--
-- TOC entry 2126 (class 2606 OID 16544)
-- Name: task uix_task_organization_id_name; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY task
    ADD CONSTRAINT uix_task_organization_id_name UNIQUE (organization_id, name);


--
-- TOC entry 2154 (class 2606 OID 16986)
-- Name: country uk_country_code; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY country
    ADD CONSTRAINT uk_country_code UNIQUE (code);


--
-- TOC entry 2156 (class 2606 OID 16897)
-- Name: country uk_country_code2; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY country
    ADD CONSTRAINT uk_country_code2 UNIQUE (code2);


--
-- TOC entry 2158 (class 2606 OID 16899)
-- Name: country uk_country_code3; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY country
    ADD CONSTRAINT uk_country_code3 UNIQUE (code3);


--
-- TOC entry 2169 (class 2606 OID 16962)
-- Name: country_loc uk_country_lock_c_l; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY country_loc
    ADD CONSTRAINT uk_country_lock_c_l PRIMARY KEY (country_id, locale_id);


--
-- TOC entry 2160 (class 2606 OID 16895)
-- Name: country uk_country_name; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY country
    ADD CONSTRAINT uk_country_name UNIQUE (name);


--
-- TOC entry 2165 (class 2606 OID 16914)
-- Name: entity_type uk_entity_type_name; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY entity_type
    ADD CONSTRAINT uk_entity_type_name UNIQUE (name);


--
-- TOC entry 2139 (class 2606 OID 16917)
-- Name: localized_text_content uk_localized_text_content_lti_li; Type: CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY localized_text_content
    ADD CONSTRAINT uk_localized_text_content_lti_li UNIQUE (localized_text_id, locale_id);


--
-- TOC entry 2166 (class 1259 OID 16978)
-- Name: fki_fk_country_loc_country_id; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE INDEX fki_fk_country_loc_country_id ON country_loc USING btree (country_id);


--
-- TOC entry 2167 (class 1259 OID 16984)
-- Name: fki_fk_country_loc_locale_id; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE INDEX fki_fk_country_loc_locale_id ON country_loc USING btree (locale_id);


--
-- TOC entry 2133 (class 1259 OID 16738)
-- Name: fki_fk_localized_text_content_locale_id; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE INDEX fki_fk_localized_text_content_locale_id ON localized_text_content USING btree (locale_id);


--
-- TOC entry 2134 (class 1259 OID 16729)
-- Name: fki_fk_localized_text_content_localized_text_id; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE INDEX fki_fk_localized_text_content_localized_text_id ON localized_text_content USING btree (localized_text_id);


--
-- TOC entry 2107 (class 1259 OID 16432)
-- Name: fki_job_position_organization_id_fk; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE INDEX fki_job_position_organization_id_fk ON job_position USING btree (organization_id);


--
-- TOC entry 2108 (class 1259 OID 16426)
-- Name: fki_job_position_person_id_fk; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE INDEX fki_job_position_person_id_fk ON job_position USING btree (person_id);


--
-- TOC entry 2109 (class 1259 OID 16433)
-- Name: ix_job_position_o_p; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE INDEX ix_job_position_o_p ON job_position USING btree (organization_id, person_id);


--
-- TOC entry 2110 (class 1259 OID 16434)
-- Name: ix_job_position_p_o; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE INDEX ix_job_position_p_o ON job_position USING btree (person_id, organization_id);


--
-- TOC entry 2135 (class 1259 OID 16925)
-- Name: ix_localized_text_content_lti_li_c; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE INDEX ix_localized_text_content_lti_li_c ON localized_text_content USING btree (localized_text_id, locale_id, content);


--
-- TOC entry 2102 (class 1259 OID 16392)
-- Name: organization_name_uindex; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE UNIQUE INDEX organization_name_uindex ON organization USING btree (name);


--
-- TOC entry 2149 (class 1259 OID 16987)
-- Name: uindex_country_code; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE UNIQUE INDEX uindex_country_code ON country USING btree (code);


--
-- TOC entry 2150 (class 1259 OID 16891)
-- Name: uindex_country_code2; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE UNIQUE INDEX uindex_country_code2 ON country USING btree (code2);


--
-- TOC entry 2151 (class 1259 OID 16892)
-- Name: uindex_country_code3; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE UNIQUE INDEX uindex_country_code3 ON country USING btree (code3);


--
-- TOC entry 2152 (class 1259 OID 16893)
-- Name: uindex_country_name; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE UNIQUE INDEX uindex_country_name ON country USING btree (name);


--
-- TOC entry 2163 (class 1259 OID 16915)
-- Name: uindex_entity_type_name; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE UNIQUE INDEX uindex_entity_type_name ON entity_type USING btree (name);


--
-- TOC entry 2142 (class 1259 OID 16811)
-- Name: uindex_locale_l_c_v_s; Type: INDEX; Schema: chr; Owner: chr-dev
--

CREATE UNIQUE INDEX uindex_locale_l_c_v_s ON locale USING btree (language, country, variant, script);


--
-- TOC entry 2185 (class 2620 OID 16708)
-- Name: locale canonicalize_locale_keys_cu_trigger; Type: TRIGGER; Schema: chr; Owner: chr-dev
--

CREATE TRIGGER canonicalize_locale_keys_cu_trigger BEFORE INSERT OR UPDATE ON locale FOR EACH ROW EXECUTE PROCEDURE canonicalize_locale_keys();


--
-- TOC entry 2183 (class 2606 OID 16973)
-- Name: country_loc fk_country_loc_country_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY country_loc
    ADD CONSTRAINT fk_country_loc_country_id FOREIGN KEY (country_id) REFERENCES country(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2184 (class 2606 OID 16979)
-- Name: country_loc fk_country_loc_locale_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY country_loc
    ADD CONSTRAINT fk_country_loc_locale_id FOREIGN KEY (locale_id) REFERENCES locale(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2174 (class 2606 OID 16468)
-- Name: cv fk_cv_person_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY cv
    ADD CONSTRAINT fk_cv_person_id FOREIGN KEY (person_id) REFERENCES person(id);


--
-- TOC entry 2179 (class 2606 OID 16612)
-- Name: job_position_task fk_job_position_task_job_position_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY job_position_task
    ADD CONSTRAINT fk_job_position_task_job_position_id FOREIGN KEY (job_position_id) REFERENCES job_position(id);


--
-- TOC entry 2180 (class 2606 OID 16617)
-- Name: job_position_task fk_job_position_task_task_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY job_position_task
    ADD CONSTRAINT fk_job_position_task_task_id FOREIGN KEY (task_id) REFERENCES task(id);


--
-- TOC entry 2181 (class 2606 OID 16817)
-- Name: localized_text_content fk_localized_text_content_locale_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY localized_text_content
    ADD CONSTRAINT fk_localized_text_content_locale_id FOREIGN KEY (locale_id) REFERENCES locale(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2182 (class 2606 OID 16855)
-- Name: localized_text_content fk_localized_text_content_localized_text_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY localized_text_content
    ADD CONSTRAINT fk_localized_text_content_localized_text_id FOREIGN KEY (localized_text_id) REFERENCES localized_text(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2172 (class 2606 OID 16452)
-- Name: person_skill fk_person_skill_person_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY person_skill
    ADD CONSTRAINT fk_person_skill_person_id FOREIGN KEY (person_id) REFERENCES person(id);


--
-- TOC entry 2173 (class 2606 OID 16485)
-- Name: person_skill fk_person_skill_skill_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY person_skill
    ADD CONSTRAINT fk_person_skill_skill_id FOREIGN KEY (skill_id) REFERENCES skill(id);


--
-- TOC entry 2176 (class 2606 OID 16588)
-- Name: person_task_skill fk_person_task_skill_person_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY person_task_skill
    ADD CONSTRAINT fk_person_task_skill_person_id FOREIGN KEY (person_id) REFERENCES person(id);


--
-- TOC entry 2178 (class 2606 OID 16598)
-- Name: person_task_skill fk_person_task_skill_skill_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY person_task_skill
    ADD CONSTRAINT fk_person_task_skill_skill_id FOREIGN KEY (skill_id) REFERENCES skill(id);


--
-- TOC entry 2177 (class 2606 OID 16593)
-- Name: person_task_skill fk_person_task_skill_task_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY person_task_skill
    ADD CONSTRAINT fk_person_task_skill_task_id FOREIGN KEY (task_id) REFERENCES task(id);


--
-- TOC entry 2175 (class 2606 OID 16545)
-- Name: task fk_task_organization_id; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY task
    ADD CONSTRAINT fk_task_organization_id FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 2171 (class 2606 OID 16427)
-- Name: job_position job_position_organization_id_fk; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY job_position
    ADD CONSTRAINT job_position_organization_id_fk FOREIGN KEY (organization_id) REFERENCES organization(id);


--
-- TOC entry 2170 (class 2606 OID 16421)
-- Name: job_position job_position_person_id_fk; Type: FK CONSTRAINT; Schema: chr; Owner: chr-dev
--

ALTER TABLE ONLY job_position
    ADD CONSTRAINT job_position_person_id_fk FOREIGN KEY (person_id) REFERENCES person(id);


-- Completed on 2018-02-26 10:41:17 EET

--
-- PostgreSQL database dump complete
--

