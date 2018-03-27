create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, name_translations json, name_translation_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
create table chr.translation (id int8 not null, primary key (id))
create table chr.translation_content (variant varchar(255) not null, language varchar(255) not null, country varchar(255) not null, content varchar(255) not null, translation_id int8 not null, primary key (variant, translation_id, language, country))
create table chr.translation_i18n (translation_id int8 not null, i18n_variant varchar(255) not null, i18n_translation_id int8 not null, i18n_language varchar(255) not null, i18n_country varchar(255) not null, country varchar(255) not null, language varchar(255) not null, variant varchar(255) not null, primary key (translation_id, country, language, variant))
alter table if exists chr.translation_i18n add constraint UK_m3qdt5sqoomg7n4if5yn20cf8 unique (i18n_variant, i18n_translation_id, i18n_language, i18n_country)
alter table if exists chr.country add constraint FK7hiqju4nsv9s6scxbard33u4y foreign key (name_translation_id) references chr.translation
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
alter table if exists chr.translation_content add constraint FK5kpm5qol3bmt3byqg0gs7agbq foreign key (translation_id) references chr.translation
alter table if exists chr.translation_i18n add constraint FK6s6igrge2dijqsvprf9q9qytk foreign key (i18n_variant, i18n_translation_id, i18n_language, i18n_country) references chr.translation_content
alter table if exists chr.translation_i18n add constraint FKgh4x4pc8e67pjvkg6wrw7bxha foreign key (translation_id) references chr.translation
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, name_translation_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKiu228fdsnr4t1y1pbnl8pje5c foreign key (name_translation_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK5wj0nkvdfh6phbf2dajfbrned foreign key (locale_id) references chr.localized_text
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, name_translation_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKiu228fdsnr4t1y1pbnl8pje5c foreign key (name_translation_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK5wj0nkvdfh6phbf2dajfbrned foreign key (locale_id) references chr.localized_text
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, name_translation_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKiu228fdsnr4t1y1pbnl8pje5c foreign key (name_translation_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK5wj0nkvdfh6phbf2dajfbrned foreign key (locale_id) references chr.localized_text
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK5wj0nkvdfh6phbf2dajfbrned foreign key (locale_id) references chr.localized_text
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK5wj0nkvdfh6phbf2dajfbrned foreign key (locale_id) references chr.localized_text
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK5wj0nkvdfh6phbf2dajfbrned foreign key (locale_id) references chr.localized_text
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK5wj0nkvdfh6phbf2dajfbrned foreign key (locale_id) references chr.localized_text
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(255), language varchar(255), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
create table chr.tester (id int4 not null, value varchar(255), primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
create table chr.tester (id int4 not null, value varchar(255), primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
create table chr.tester (id int4 not null, value varchar(255), primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
create table chr.tester (id int4 not null, value varchar(255), primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
create table chr.tester (id int4 not null, value varchar(255), primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
create table chr.tester (id int4 not null, value varchar(255), primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
create table chr.tester (id  serial not null, value varchar(255), primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
create table chr.tester (id  serial not null, value varchar(255), primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id int8 not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3), default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4), variant varchar(255), primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (code varchar(16) not null, name varchar(200) not null, localized_name_id int8, primary key (code))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country add constraint FKp1mkcybvf8gpkej1bgaca2urt foreign key (localized_name_id) references chr.localized_text
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (country_id int4 not null, name varchar(255), locale_id int8 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (country_id int4 not null, name varchar(255), locale_id int8 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (country_id int4 not null, name varchar(255), locale_id int8 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (country_id int4 not null, name varchar(255), locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (country_id int4 not null, name varchar(255), locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (country_id int4 not null, name varchar(255), locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (country_id int4 not null, name varchar(255), locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  bigserial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int8 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (country_id int4 not null, name varchar(255), locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (country_id int4 not null, name varchar(255), locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (country_id int4 not null, name varchar(255), locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
create sequence chr.entity_seq start 1 increment 50
create table chr.country (id  serial not null, code varchar(3), code2 varchar(2), code3 varchar(3), name varchar(255) not null, primary key (id))
create table chr.country_loc (name varchar(255) not null, country_id int4 not null, locale_id int4 not null, primary key (country_id, locale_id))
create table chr.job_position (id int8 not null, description varchar(2000), end_date date, start_date date not null, title varchar(255) not null, organization_id int8 not null, person_id int8 not null, primary key (id))
create table chr.job_position_task (allocation int4 not null check (allocation<=100 AND allocation>=0), task_id int8 not null, job_position_id int8 not null, primary key (task_id, job_position_id))
create table chr.locale (id  serial not null, country varchar(3) not null, default_weight int4, family varchar(255), iso_name varchar(255), language varchar(8) not null, native_name varchar(255), notes varchar(1024), script varchar(4) not null, variant varchar(255) not null, primary key (id))
create table chr.localized_text (id int8 not null, primary key (id))
create table chr.localized_text_content (content varchar(255) not null, localized_text_id int8 not null, locale_id int4 not null, primary key (localized_text_id, locale_id))
create table chr.organization (id int8 not null, name varchar(255) not null, primary key (id))
create table chr.person (id int8 not null, email_address varchar(255), first_name varchar(255), gender varchar(1), last_name varchar(255), primary key (id))
create table chr.task (id int8 not null, description varchar(5000), end_date date, name varchar(100) not null, start_date date, organization_id int8 not null, primary key (id))
alter table if exists chr.country_loc add constraint FKvayl10idklry566efdcu70f1 foreign key (country_id) references chr.country
alter table if exists chr.country_loc add constraint FKneeufntinkryk6mcqhi3j9jye foreign key (locale_id) references chr.locale
alter table if exists chr.job_position add constraint FKpihf4daockmwiqkfexq71u4am foreign key (organization_id) references chr.organization
alter table if exists chr.job_position add constraint FKfinw48or4lxxk1qvdtsngypoa foreign key (person_id) references chr.person
alter table if exists chr.job_position_task add constraint FK1m1ygsuww0jgrnbbm6gfcjv9n foreign key (task_id) references chr.task
alter table if exists chr.job_position_task add constraint FKe8fvflhjk2dxdpphyxo1gov3b foreign key (job_position_id) references chr.job_position
alter table if exists chr.localized_text_content add constraint FK9pkxog1yvuac70dgugcutigw4 foreign key (localized_text_id) references chr.localized_text
alter table if exists chr.localized_text_content add constraint FK8m7ha39c8e2if8dvlq3hv9own foreign key (locale_id) references chr.locale
alter table if exists chr.task add constraint FKlr7r6n58jgscnls4brj8c6fg2 foreign key (organization_id) references chr.organization
