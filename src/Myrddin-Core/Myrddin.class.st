"
The main class of the Myrddin project.
"
Class {
	#name : #Myrddin,
	#superclass : #Object,
	#instVars : [
		'schema',
		'model',
		'folder',
		'xmlSchema'
	],
	#classVars : [
		'myrddin'
	],
	#classInstVars : [
		'icons'
	],
	#category : #'Myrddin-Core'
}

{ #category : #action }
Myrddin class >> chooseSQLFile [

	^Smalltalk ui theme 
   		chooseFullFileNameIn: World 
      title: 'Import schema from SQL file.' 
      extensions: #('sql') 
      path: FileSystem workingDirectory
		preview: nil 
]

{ #category : #singleton }
Myrddin class >> deleteInstance [
	myrddin := nil
]

{ #category : #singleton }
Myrddin class >> getInstance [
	^myrddin ifNil: [ myrddin := self new ]
]

{ #category : #'class initialization' }
Myrddin class >> initialize [
	self registerInWorldMenu
]

{ #category : #singleton }
Myrddin class >> isInstancied [
	^myrddin isNotNil
]

{ #category : #'class initialization' }
Myrddin class >> menuChooseSQLSchemaOn: aBuilder [
	<worldMenu>
	(aBuilder item: #ChooseSQLSchema)
		order: 70; 
		parent: #Myrddin;
		withSeparatorAfter;
		label: 'Choose SQL Schema...';
		action: [Myrddin startAfterSchemaSelection]


]

{ #category : #'class initialization' }
Myrddin class >> menuInformationsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Informations)
		order: 50; 
		parent: #Myrddin;
		label: 'Informations';
		action: [ MYInformations schema: (self getInstance schema) model: (self getInstance model) ]

]

{ #category : #'class initialization' }
Myrddin class >> menuMyrddinOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Myrddin) action: [self open]; icon: (Smalltalk ui icons smallMyrddin) 
]

{ #category : #'class initialization' }
Myrddin class >> menuOpenCircularTablesAndViewsDependenciesVisuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #CircularTablesAndViewsDependenciesVisu)
		order: 50; 
		parent: #GraphicalViews;
		label: 'Circular tables and views dependencies visualisation';
		action: [ MYCircularTablesAndViewsDependenciesVisualization model: (self getInstance model) ]


]

{ #category : #'class initialization' }
Myrddin class >> menuOpenEntitiesUsedByBrowserOn: aBuilder [
	<worldMenu>
	(aBuilder item: #EntitiesUsedByBrowser)
		order: 10; 
		parent: #Myrddin;
		label: MYEntitiesUsedByBrowser title;
		action: [MYEntitiesUsedByBrowser open]


]

{ #category : #'class initialization' }
Myrddin class >> menuOpenEntitiesWithDependenciesBrowserOn: aBuilder [
	<worldMenu>
	(aBuilder item: #EntitiesWithDependencies)
		order: 20; 
		parent: #Myrddin;
		label: MYEntitiesWithDependancesBrowser title;
		action: [MYEntitiesWithDependancesBrowser open]


]

{ #category : #'class initialization' }
Myrddin class >> menuOpenFunctionDependenciesVisuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #FunctionDependenciesVisu)
		order: 30; 
		parent: #GraphicalViews;
		label: 'Function dependencies visualisation';
		action: [ MYEntityDependenciesVisualization model: (self getInstance model) entityType: FmxSQLStoredProcedure ]


]

{ #category : #'class initialization' }
Myrddin class >> menuOpenTableDependenciesVisuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #TableDependenciesVisu)
		order: 10; 
		parent: #GraphicalViews;
		label: 'Table dependencies visualisation';
		action: [ MYEntityDependenciesVisualization model: (self getInstance model) entityType: FmxSQLTable ]


]

{ #category : #'class initialization' }
Myrddin class >> menuOpenTableRelationsVisuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #TableRelations)
		order: 60; 
		parent: #GraphicalViews;
		label: 'Tables and Relations visualisation';
		action: [ MYTableRelationsVisualization model: (self getInstance model) ]


]

{ #category : #'class initialization' }
Myrddin class >> menuOpenTriggerDependenciesVisuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #TriggerDependenciesVisu)
		order: 40; 
		parent: #GraphicalViews;
		label: 'Trigger dependencies visualisation';
		action: [ MYEntityDependenciesVisualization model: (self getInstance model) entityType: FmxSQLTrigger ]


]

{ #category : #'class initialization' }
Myrddin class >> menuOpenViewDependenciesVisuOn: aBuilder [
	<worldMenu>
	(aBuilder item: #ViewDependenciesVisu)
		order: 20; 
		parent: #GraphicalViews;
		label: 'View dependencies visualisation';
		action: [ MYEntityDependenciesVisualization model: (self getInstance model) entityType: FmxSQLView ]


]

{ #category : #'class initialization' }
Myrddin class >> menuOpengraphicalViewsOn: aBuilder [
	<worldMenu>
	(aBuilder item: #GraphicalViews)
		withSeparatorAfter;
		order: 40; 
		parent: #Myrddin;
		label: 'Graphical views'


]

{ #category : #'class initialization' }
Myrddin class >> registerInWorldMenu [
	self environment at: #TheWorldMenu ifPresent: [ :class |
		 ((class respondsTo: #registerOpenCommand:)
			and: [((class class >>#registerOpenCommand:) sendsSelector: #deprecated:) not])
 	     			ifTrue: [class registerOpenCommand: { 'Myrddin' . {self. #open}}]]
]

{ #category : #action }
Myrddin class >> startAfterSchemaSelection [
	| filename |
	filename := self chooseSQLFile.
	filename ifNotNil: [ self getInstance createModelWith: filename folder: '/tmp' xmlSchema: '/tmp/schema.xml' ]
]

{ #category : #accessing }
Myrddin >> folder [
	^ folder
]

{ #category : #accessing }
Myrddin >> folder: anObject [
	folder := anObject
]

{ #category : #'initialize-release' }
Myrddin >> initialize [
	super initialize.
	self model: MooseModel new.
]

{ #category : #accessing }
Myrddin >> model [
	^ (DBConnectionsManager current connectionNamed: 'appsi-20171010-test-op-app') fmxSQLModel
]

{ #category : #accessing }
Myrddin >> model: anObject [
	model := anObject
]

{ #category : #accessing }
Myrddin >> schema [
	^ schema
]

{ #category : #accessing }
Myrddin >> schema: anObject [
	schema := anObject
]

{ #category : #PostgreSQL }
Myrddin >> systemCatalogs [
	^'CREATE TABLE pg_statio_sys_sequences (
	schemaname name,
	blks_hit bigint,
	relid oid,
	blks_read bigint,
	relname name
);

CREATE TABLE pg_ts_config_map (
	mapseqno integer,
	mapcfg oid,
	maptokentype integer,
	mapdict oid
);

CREATE TABLE pg_language (
	lanplcallfoid oid,
	lanname name,
	lanpltrusted boolean,
	lanispl boolean,
	lanacl ARRAY,
	lanowner oid,
	lanvalidator oid,
	laninline oid
);

CREATE TABLE pg_event_trigger (
	evtfoid oid,
	evtname name,
	evtowner oid,
	evttags ARRAY,
	evtevent name,
	evtenabled "char"
);

CREATE TABLE pg_statio_sys_indexes (
	schemaname name,
	indexrelid oid,
	indexrelname name,
	idx_blks_read bigint,
	idx_blks_hit bigint,
	relname name,
	relid oid
);

CREATE TABLE pg_inherits (
	inhseqno integer,
	inhparent oid,
	inhrelid oid
);

CREATE TABLE pg_stat_activity (
	backend_start timestamp with time zone,
	state text,
	usename name,
	client_hostname text,
	datname name,
	state_change timestamp with time zone,
	backend_xmin xid,
	client_addr inet,
	query_start timestamp with time zone,
	query text,
	xact_start timestamp with time zone,
	pid integer,
	backend_xid xid,
	application_name text,
	usesysid oid,
	waiting boolean,
	datid oid,
	client_port integer
);

CREATE TABLE pg_shseclabel (
	objoid oid,
	provider text,
	label text,
	classoid oid
);

CREATE TABLE pg_matviews (
	hasindexes boolean,
	schemaname name,
	tablespace name,
	ispopulated boolean,
	matviewowner name,
	matviewname name,
	definition text
);

CREATE TABLE pg_tables (
	tablespace name,
	tableowner name,
	rowsecurity boolean,
	hastriggers boolean,
	tablename name,
	hasrules boolean,
	hasindexes boolean,
	schemaname name
);

CREATE TABLE pg_replication_slots (
	active boolean,
	slot_type text,
	restart_lsn pg_lsn,
	slot_name name,
	datoid oid,
	catalog_xmin xid,
	plugin name,
	database name,
	active_pid integer,
	xmin xid
);

CREATE TABLE pg_largeobject_metadata (
	lomacl ARRAY,
	lomowner oid
);

CREATE TABLE pg_views (
	viewowner name,
	viewname name,
	schemaname name,
	definition text
);

CREATE TABLE pg_cast (
	casttarget oid,
	castsource oid,
	castmethod "char",
	castcontext "char",
	castfunc oid
);

CREATE TABLE pg_attribute (
	attbyval boolean,
	attinhcount integer,
	attlen smallint,
	attfdwoptions ARRAY,
	attstorage "char",
	attcacheoff integer,
	attrelid oid,
	attname name,
	attalign "char",
	attisdropped boolean,
	atttypid oid,
	attcollation oid,
	attoptions ARRAY,
	attnum smallint,
	attnotnull boolean,
	attislocal boolean,
	attacl ARRAY,
	atttypmod integer,
	attndims integer,
	attstattarget integer,
	atthasdef boolean
);

CREATE TABLE pg_seclabels (
	objnamespace oid,
	label text,
	objoid oid,
	objtype text,
	provider text,
	objsubid integer,
	objname text,
	classoid oid
);

CREATE TABLE pg_prepared_statements (
	from_sql boolean,
	statement text,
	parameter_types ARRAY,
	prepare_time timestamp with time zone,
	name text
);

CREATE TABLE pg_ts_parser (
	prsheadline regproc,
	prstoken regproc,
	prsstart regproc,
	prslextype regproc,
	prsnamespace oid,
	prsend regproc,
	prsname name
);

CREATE TABLE pg_shdescription (
	description text,
	classoid oid,
	objoid oid
);

CREATE TABLE pg_rewrite (
	rulename name,
	ev_enabled "char",
	ev_qual pg_node_tree,
	ev_type "char",
	ev_class oid,
	ev_action pg_node_tree,
	is_instead boolean
);

CREATE TABLE pg_default_acl (
	defaclacl ARRAY,
	defaclrole oid,
	defaclnamespace oid,
	defaclobjtype "char"
);

CREATE TABLE pg_attrdef (
	adnum smallint,
	adrelid oid,
	adbin pg_node_tree,
	adsrc text
);

CREATE TABLE pg_am (
	ampredlocks boolean,
	amname name,
	ambuildempty regproc,
	amgettuple regproc,
	ammarkpos regproc,
	amrescan regproc,
	amstorage boolean,
	amkeytype oid,
	amcanreturn regproc,
	amoptions regproc,
	amcanorder boolean,
	amstrategies smallint,
	amsearcharray boolean,
	ambulkdelete regproc,
	aminsert regproc,
	amcanmulticol boolean,
	amgetbitmap regproc,
	amrestrpos regproc,
	amsearchnulls boolean,
	amcanbackward boolean,
	amcostestimate regproc,
	amclusterable boolean,
	ambuild regproc,
	amsupport smallint,
	ambeginscan regproc,
	amcanorderbyop boolean,
	amendscan regproc,
	amvacuumcleanup regproc,
	amoptionalkey boolean,
	amcanunique boolean
);

CREATE TABLE pg_stat_xact_sys_tables (
	relname name,
	relid oid,
	n_tup_del bigint,
	seq_tup_read bigint,
	n_tup_upd bigint,
	seq_scan bigint,
	n_tup_ins bigint,
	schemaname name,
	idx_scan bigint,
	idx_tup_fetch bigint,
	n_tup_hot_upd bigint
);

CREATE TABLE pg_stat_xact_user_tables (
	n_tup_hot_upd bigint,
	relname name,
	relid oid,
	n_tup_del bigint,
	n_tup_upd bigint,
	seq_tup_read bigint,
	seq_scan bigint,
	n_tup_ins bigint,
	idx_scan bigint,
	schemaname name,
	idx_tup_fetch bigint
);

CREATE TABLE pg_tablespace (
	spcowner oid,
	spcoptions ARRAY,
	spcname name,
	spcacl ARRAY
);

CREATE TABLE pg_foreign_table (
	ftserver oid,
	ftoptions ARRAY,
	ftrelid oid
);

CREATE TABLE pg_statio_user_sequences (
	blks_hit bigint,
	relid oid,
	blks_read bigint,
	relname name,
	schemaname name
);

CREATE TABLE pg_available_extension_versions (
	relocatable boolean,
	superuser boolean,
	comment text,
	installed boolean,
	requires ARRAY,
	version text,
	schema name,
	name name
);

CREATE TABLE pg_statio_sys_tables (
	schemaname name,
	tidx_blks_hit bigint,
	idx_blks_hit bigint,
	toast_blks_read bigint,
	toast_blks_hit bigint,
	heap_blks_read bigint,
	heap_blks_hit bigint,
	idx_blks_read bigint,
	relid oid,
	relname name,
	tidx_blks_read bigint
);

CREATE TABLE pg_depend (
	deptype "char",
	objid oid,
	refobjid oid,
	refobjsubid integer,
	refclassid oid,
	classid oid,
	objsubid integer
);

CREATE TABLE pg_stat_database_conflicts (
	confl_tablespace bigint,
	datname name,
	datid oid,
	confl_deadlock bigint,
	confl_snapshot bigint,
	confl_lock bigint,
	confl_bufferpin bigint
);

CREATE TABLE pg_auth_members (
	grantor oid,
	admin_option boolean,
	roleid oid,
	member oid
);

CREATE TABLE pg_stat_all_indexes (
	indexrelid oid,
	idx_tup_read bigint,
	idx_scan bigint,
	indexrelname name,
	relid oid,
	idx_tup_fetch bigint,
	relname name,
	schemaname name
);

CREATE TABLE pg_range (
	rngsubtype oid,
	rngcanonical regproc,
	rngtypid oid,
	rngsubdiff regproc,
	rngsubopc oid,
	rngcollation oid
);

CREATE TABLE pg_stat_sys_tables (
	n_tup_ins bigint,
	relname name,
	last_autoanalyze timestamp with time zone,
	last_analyze timestamp with time zone,
	n_tup_hot_upd bigint,
	idx_scan bigint,
	analyze_count bigint,
	seq_scan bigint,
	last_vacuum timestamp with time zone,
	last_autovacuum timestamp with time zone,
	n_tup_upd bigint,
	n_mod_since_analyze bigint,
	vacuum_count bigint,
	relid oid,
	n_live_tup bigint,
	seq_tup_read bigint,
	idx_tup_fetch bigint,
	n_tup_del bigint,
	schemaname name,
	autovacuum_count bigint,
	autoanalyze_count bigint,
	n_dead_tup bigint
);

CREATE TABLE pg_operator (
	oprcanhash boolean,
	oprowner oid,
	oprresult oid,
	oprname name,
	oprcode regproc,
	oprleft oid,
	oprcanmerge boolean,
	oprjoin regproc,
	oprcom oid,
	oprright oid,
	oprkind "char",
	oprnegate oid,
	oprnamespace oid,
	oprrest regproc
);

CREATE TABLE pg_description (
	description text,
	classoid oid,
	objsubid integer,
	objoid oid
);

CREATE TABLE pg_statio_user_indexes (
	schemaname name,
	indexrelid oid,
	indexrelname name,
	idx_blks_read bigint,
	relid oid,
	relname name,
	idx_blks_hit bigint
);

CREATE TABLE pg_available_extensions (
	default_version text,
	installed_version text,
	comment text,
	name name
);

CREATE TABLE pg_timezone_abbrevs (
	is_dst boolean,
	abbrev text,
	utc_offset interval
);

CREATE TABLE pg_stat_user_indexes (
	relid oid,
	relname name,
	idx_tup_fetch bigint,
	schemaname name,
	idx_tup_read bigint,
	idx_scan bigint,
	indexrelid oid,
	indexrelname name
);

CREATE TABLE pg_namespace (
	nspacl ARRAY,
	nspowner oid,
	nspname name
);

CREATE TABLE pg_opclass (
	opcname name,
	opcfamily oid,
	opcintype oid,
	opcowner oid,
	opcmethod oid,
	opckeytype oid,
	opcnamespace oid,
	opcdefault boolean
);

CREATE TABLE pg_ts_template (
	tmpllexize regproc,
	tmplname name,
	tmplnamespace oid,
	tmplinit regproc
);

CREATE TABLE pg_stat_archiver (
	last_failed_time timestamp with time zone,
	stats_reset timestamp with time zone,
	last_failed_wal text,
	archived_count bigint,
	failed_count bigint,
	last_archived_wal text,
	last_archived_time timestamp with time zone
);

CREATE TABLE pg_stat_all_tables (
	relname name,
	n_tup_hot_upd bigint,
	analyze_count bigint,
	seq_scan bigint,
	n_tup_ins bigint,
	last_autoanalyze timestamp with time zone,
	last_analyze timestamp with time zone,
	n_mod_since_analyze bigint,
	idx_scan bigint,
	n_live_tup bigint,
	last_autovacuum timestamp with time zone,
	last_vacuum timestamp with time zone,
	n_tup_upd bigint,
	seq_tup_read bigint,
	autovacuum_count bigint,
	vacuum_count bigint,
	relid oid,
	autoanalyze_count bigint,
	n_dead_tup bigint,
	idx_tup_fetch bigint,
	n_tup_del bigint,
	schemaname name
);

CREATE TABLE pg_indexes (
	indexname name,
	indexdef text,
	tablename name,
	schemaname name,
	tablespace name
);

CREATE TABLE pg_amproc (
	amprocfamily oid,
	amproc regproc,
	amprocnum smallint,
	amprocrighttype oid,
	amproclefttype oid
);

CREATE TABLE pg_constraint (
	conexclop ARRAY,
	connamespace oid,
	condeferred boolean,
	coninhcount integer,
	confkey ARRAY,
	contype "char",
	conindid oid,
	conppeqop ARRAY,
	conbin pg_node_tree,
	confmatchtype "char",
	connoinherit boolean,
	consrc text,
	conpfeqop ARRAY,
	confrelid oid,
	confupdtype "char",
	conffeqop ARRAY,
	condeferrable boolean,
	conislocal boolean,
	convalidated boolean,
	conname name,
	conrelid oid,
	conkey ARRAY,
	contypid oid,
	confdeltype "char"
);

CREATE TABLE pg_pltemplate (
	tmpltrusted boolean,
	tmpllibrary text,
	tmplname name,
	tmplinline text,
	tmplvalidator text,
	tmplhandler text,
	tmplacl ARRAY,
	tmpldbacreate boolean
);

CREATE TABLE pg_stat_ssl (
	version text,
	compression boolean,
	bits integer,
	ssl boolean,
	cipher text,
	pid integer,
	clientdn text
);

CREATE TABLE pg_ts_dict (
	dictowner oid,
	dictnamespace oid,
	dictname name,
	dictinitoption text,
	dicttemplate oid
);

CREATE TABLE pg_stat_replication (
	client_addr inet,
	pid integer,
	backend_xmin xid,
	sent_location pg_lsn,
	write_location pg_lsn,
	flush_location pg_lsn,
	replay_location pg_lsn,
	sync_priority integer,
	application_name text,
	state text,
	client_port integer,
	usesysid oid,
	backend_start timestamp with time zone,
	client_hostname text,
	usename name,
	sync_state text
);

CREATE TABLE pg_user_mappings (
	umid oid,
	srvname name,
	usename name,
	srvid oid,
	umoptions ARRAY,
	umuser oid
);

CREATE TABLE pg_collation (
	collencoding integer,
	collowner oid,
	collnamespace oid,
	collctype name,
	collname name,
	collcollate name
);

CREATE TABLE pg_statio_user_tables (
	tidx_blks_read bigint,
	heap_blks_read bigint,
	toast_blks_hit bigint,
	heap_blks_hit bigint,
	relid oid,
	schemaname name,
	tidx_blks_hit bigint,
	idx_blks_hit bigint,
	toast_blks_read bigint,
	idx_blks_read bigint,
	relname name
);

CREATE TABLE pg_stat_user_functions (
	total_time double precision,
	self_time double precision,
	funcname name,
	schemaname name,
	funcid oid,
	calls bigint
);

CREATE TABLE pg_roles (
	rolcreatedb boolean,
	rolpassword text,
	rolinherit boolean,
	rolvaliduntil timestamp with time zone,
	rolcreaterole boolean,
	rolsuper boolean,
	rolconfig ARRAY,
	rolconnlimit integer,
	oid oid,
	rolbypassrls boolean,
	rolcanlogin boolean,
	rolname name,
	rolreplication boolean,
);

CREATE TABLE pg_aggregate (
	aggmtransspace integer,
	aggminitval text,
	aggmfinalfn regproc,
	aggmfinalextra boolean,
	aggmtransfn regproc,
	aggfinalextra boolean,
	aggminvtransfn regproc,
	aggfnoid regproc,
	aggsortop oid,
	agginitval text,
	aggfinalfn regproc,
	aggtransfn regproc,
	aggkind "char",
	aggmtranstype oid,
	aggnumdirectargs smallint,
	aggtranstype oid,
	aggtransspace integer
);

CREATE TABLE pg_class (
	relallvisible integer,
	reloftype oid,
	relisshared boolean,
	relhasrules boolean,
	reltablespace oid,
	relowner oid,
	relhassubclass boolean,
	relforcerowsecurity boolean,
	relreplident "char",
	reloptions ARRAY,
	relchecks smallint,
	relpages integer,
	reltoastrelid oid,
	relfrozenxid xid,
	relrowsecurity boolean,
	relname name,
	relpersistence "char",
	relam oid,
	relhastriggers boolean,
	relispopulated boolean,
	relminmxid xid,
	relhasindex boolean,
	relkind "char",
	relnamespace oid,
	relfilenode oid,
	relhaspkey boolean,
	reltuples real,
	reltype oid,
	relacl ARRAY,
	relhasoids boolean,
	relnatts smallint
);

CREATE TABLE pg_replication_origin (
	roident oid,
	roname text
);

CREATE TABLE pg_statio_all_sequences (
	schemaname name,
	blks_hit bigint,
	relid oid,
	blks_read bigint,
	relname name
);

CREATE TABLE pg_settings (
	extra_desc text,
	category text,
	max_val text,
	sourcefile text,
	pending_restart boolean,
	min_val text,
	context text,
	reset_val text,
	name text,
	enumvals ARRAY,
	short_desc text,
	vartype text,
	unit text,
	setting text,
	boot_val text,
	source text,
	sourceline integer
);

CREATE TABLE pg_stats (
	schemaname name,
	null_frac real,
	elem_count_histogram ARRAY,
	most_common_elems anyarray,
	n_distinct real,
	most_common_vals anyarray,
	tablename name,
	inherited boolean,
	attname name,
	most_common_freqs ARRAY,
	avg_width integer,
	histogram_bounds anyarray,
	correlation real,
	most_common_elem_freqs ARRAY
);

CREATE TABLE pg_stat_xact_user_functions (
	schemaname name,
	funcid oid,
	calls bigint,
	total_time double precision,
	self_time double precision,
	funcname name
);

CREATE TABLE pg_ts_config (
	cfgnamespace oid,
	cfgname name,
	cfgparser oid,
	cfgowner oid
);

CREATE TABLE pg_trigger (
	tgtype smallint,
	tgconstrindid oid,
	tginitdeferred boolean,
	tgname name,
	tgattr ARRAY,
	tgconstrrelid oid,
	tgdeferrable boolean,
	tgfoid oid,
	tgisinternal boolean,
	tgconstraint oid,
	tgqual pg_node_tree,
	tgnargs smallint,
	tgargs bytea,
	tgrelid oid,
	tgenabled "char"
);

CREATE TABLE pg_seclabel (
	objoid oid,
	provider text,
	objsubid integer,
	label text,
	classoid oid
);

CREATE TABLE pg_statio_all_indexes (
	schemaname name,
	indexrelid oid,
	indexrelname name,
	idx_blks_read bigint,
	idx_blks_hit bigint,
	relname name,
	relid oid
);

CREATE TABLE pg_conversion (
	conforencoding integer,
	conowner oid,
	connamespace oid,
	condefault boolean,
	conname name,
	conproc regproc,
	contoencoding integer
);

CREATE TABLE pg_statio_all_tables (
	heap_blks_read bigint,
	schemaname name,
	tidx_blks_hit bigint,
	idx_blks_hit bigint,
	toast_blks_read bigint,
	toast_blks_hit bigint,
	relname name,
	tidx_blks_read bigint,
	idx_blks_read bigint,
	relid oid,
	heap_blks_hit bigint
);

CREATE TABLE pg_group (
	grolist ARRAY,
	grosysid oid,
	groname name
);

CREATE TABLE pg_type (
	typowner oid,
	typsend regproc,
	typispreferred boolean,
	typtypmod integer,
	typdefaultbin pg_node_tree,
	typlen smallint,
	typmodin regproc,
	typtype "char",
	typndims integer,
	typdefault text,
	typbyval boolean,
	typisdefined boolean,
	typrelid oid,
	typoutput regproc,
	typanalyze regproc,
	typelem oid,
	typmodout regproc,
	typnotnull boolean,
	typcategory "char",
	typdelim "char",
	typarray oid,
	typalign "char",
	typname name,
	typcollation oid,
	typacl ARRAY,
	typreceive regproc,
	typbasetype oid,
	typinput regproc,
	typnamespace oid,
	typstorage "char"
);

CREATE TABLE pg_policy (
	polcmd "char",
	polrelid oid,
	polqual pg_node_tree,
	polwithcheck pg_node_tree,
	polname name,
	polroles ARRAY
);

CREATE TABLE pg_stat_xact_all_tables (
	relid oid,
	n_tup_del bigint,
	seq_tup_read bigint,
	n_tup_upd bigint,
	n_tup_ins bigint,
	seq_scan bigint,
	schemaname name,
	idx_tup_fetch bigint,
	idx_scan bigint,
	n_tup_hot_upd bigint,
	relname name
);

CREATE TABLE pg_index (
	indcollation ARRAY,
	indrelid oid,
	indimmediate boolean,
	indclass ARRAY,
	indnatts smallint,
	indisreplident boolean,
	indpred pg_node_tree,
	indcheckxmin boolean,
	indoption ARRAY,
	indisclustered boolean,
	indisunique boolean,
	indisready boolean,
	indkey ARRAY,
	indexrelid oid,
	indisexclusion boolean,
	indexprs pg_node_tree,
	indisvalid boolean,
	indisprimary boolean,
	indislive boolean,
);

CREATE TABLE pg_prepared_xacts (
	transaction xid,
	owner name,
	prepared timestamp with time zone,
	gid text,
	database name
);

CREATE TABLE pg_database (
	dattablespace oid,
	datctype name,
	datminmxid xid,
	encoding integer,
	datlastsysoid oid,
	datname name,
	datacl ARRAY,
	datconnlimit integer,
	datdba oid,
	datallowconn boolean,
	datcollate name,
	datistemplate boolean,
	datfrozenxid xid
);

CREATE TABLE pg_stat_bgwriter (
	maxwritten_clean bigint,
	buffers_checkpoint bigint,
	buffers_backend bigint,
	stats_reset timestamp with time zone,
	checkpoints_timed bigint,
	buffers_alloc bigint,
	buffers_backend_fsync bigint,
	checkpoints_req bigint,
	checkpoint_write_time double precision,
	checkpoint_sync_time double precision,
	buffers_clean bigint
);

CREATE TABLE pg_foreign_data_wrapper (
	fdwname name,
	fdwvalidator oid,
	fdwhandler oid,
	fdwowner oid,
	fdwacl ARRAY,
	fdwoptions ARRAY
);

CREATE TABLE pg_shdepend (
	objid oid,
	refobjid oid,
	classid oid,
	refclassid oid,
	objsubid integer,
	dbid oid,
	deptype "char"
);

CREATE TABLE pg_stat_database (
	tup_returned bigint,
	stats_reset timestamp with time zone,
	temp_files bigint,
	blk_write_time double precision,
	datid oid,
	xact_commit bigint,
	datname name,
	tup_fetched bigint,
	tup_deleted bigint,
	temp_bytes bigint,
	blks_read bigint,
	blk_read_time double precision,
	numbackends integer,
	tup_inserted bigint,
	blks_hit bigint,
	conflicts bigint,
	xact_rollback bigint,
	tup_updated bigint,
	deadlocks bigint
);

CREATE TABLE pg_stat_sys_indexes (
	relid oid,
	schemaname name,
	idx_tup_read bigint,
	idx_tup_fetch bigint,
	idx_scan bigint,
	indexrelname name,
	indexrelid oid,
	relname name
);

CREATE TABLE pg_transform (
	trftype oid,
	trftosql regproc,
	trflang oid,
	trffromsql regproc
);

CREATE TABLE pg_enum (
	enumsortorder real,
	enumlabel name,
	enumtypid oid
);

CREATE TABLE pg_stat_user_tables (
	n_mod_since_analyze bigint,
	n_live_tup bigint,
	seq_tup_read bigint,
	n_tup_upd bigint,
	idx_tup_fetch bigint,
	autovacuum_count bigint,
	vacuum_count bigint,
	relid oid,
	autoanalyze_count bigint,
	n_dead_tup bigint,
	n_tup_del bigint,
	schemaname name,
	relname name,
	n_tup_hot_upd bigint,
	idx_scan bigint,
	analyze_count bigint,
	seq_scan bigint,
	n_tup_ins bigint,
	last_vacuum timestamp with time zone,
	last_autovacuum timestamp with time zone,
	last_autoanalyze timestamp with time zone,
	last_analyze timestamp with time zone
);

CREATE TABLE pg_opfamily (
	opfname name,
	opfmethod oid,
	opfowner oid,
	opfnamespace oid
);

CREATE TABLE pg_cursors (
	is_binary boolean,
	is_holdable boolean,
	creation_time timestamp with time zone,
	statement text,
	name text,
	is_scrollable boolean
);

CREATE TABLE pg_proc (
	prosecdef boolean,
	prolang oid,
	pronargdefaults smallint,
	proretset boolean,
	procost real,
	protransform regproc,
	proargdefaults pg_node_tree,
	proargmodes ARRAY,
	proconfig ARRAY,
	proleakproof boolean,
	provolatile "char",
	protrftypes ARRAY,
	proacl ARRAY,
	prorows real,
	prorettype oid
	proisagg boolean,
	pronargs smallint,
	proname name,
	proargnames ARRAY,
	prosrc text,
	proisstrict boolean,
	provariadic oid,
	pronamespace oid,
	proallargtypes ARRAY,
	proargtypes ARRAY,
	proowner oid,
	proiswindow boolean,
	probin text
);

CREATE TABLE pg_rules (
	definition text,
	rulename name,
	schemaname name,
	tablename name
);

CREATE TABLE pg_locks (
	transactionid xid,
	relation oid,
	mode text,
	virtualxid text,
	objsubid smallint,
	pid integer,
	classid oid,
	page integer,
	fastpath boolean,
	locktype text,
	objid oid,
	granted boolean,
	database oid,
	tuple smallint,
	virtualtransaction text
);

CREATE TABLE pg_db_role_setting (
	setrole oid,
	setdatabase oid,
	setconfig ARRAY
);

CREATE TABLE pg_foreign_server (
	srvowner oid,
	srvtype text,
	srvname name,
	srvfdw oid,
	srvoptions ARRAY,
	srvacl ARRAY,
	srvversion text
);

CREATE TABLE pg_timezone_names (
	is_dst boolean,
	abbrev text,
	utc_offset interval,
	name text
);

CREATE TABLE pg_policies (
	schemaname name,
	with_check text,
	roles ARRAY,
	qual text,
	policyname name,
	cmd text,
	tablename name
);

CREATE TABLE pg_amop (
	amopmethod oid,
	amopfamily oid,
	amopopr oid,
	amoppurpose "char",
	amopstrategy smallint,
	amoprighttype oid,
	amopsortfamily oid,
	amoplefttype oid
);

CREATE TABLE pg_user (
	usename name,
	usesuper boolean,
	valuntil abstime,
	useconfig ARRAY,
	usecreatedb boolean,
	passwd text,
	usesysid oid,
	userepl boolean,
	usebypassrls boolean
);

CREATE TABLE pg_extension (
	extnamespace oid,
	extowner oid,
	extcondition ARRAY,
	extversion text,
	extname name,
	extconfig ARRAY,
	extrelocatable boolean
);'
]

{ #category : #accessing }
Myrddin >> xmlSchema [
	^ xmlSchema
]

{ #category : #accessing }
Myrddin >> xmlSchema: anObject [
	xmlSchema := anObject
]
