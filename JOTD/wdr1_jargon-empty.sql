-- MySQL dump 9.11
--
-- Host: localhost    Database: wdr1_jargon
-- ------------------------------------------------------
-- Server version	4.0.25-standard-log

--
-- Table structure for table `mw_archive`
--

DROP TABLE IF EXISTS archive;
CREATE TABLE archive (
  ar_namespace int(11) NOT NULL default '0',
  ar_title varchar(255) binary NOT NULL default '',
  ar_text mediumblob NOT NULL,
  ar_comment tinyblob NOT NULL,
  ar_user int(5) unsigned NOT NULL default '0',
  ar_user_text varchar(255) binary NOT NULL default '',
  ar_timestamp varchar(14) binary NOT NULL default '',
  ar_minor_edit tinyint(1) NOT NULL default '0',
  ar_flags tinyblob NOT NULL,
  ar_rev_id int(8) unsigned default NULL,
  ar_text_id int(8) unsigned default NULL,
  KEY name_title_timestamp (ar_namespace,ar_title,ar_timestamp)
) TYPE=InnoDB;

--
-- Dumping data for table `archive`
--


--
-- Table structure for table `categorylinks`
--

DROP TABLE IF EXISTS categorylinks;
CREATE TABLE categorylinks (
  cl_from int(8) unsigned NOT NULL default '0',
  cl_to varchar(255) binary NOT NULL default '',
  cl_sortkey varchar(86) binary NOT NULL default '',
  cl_timestamp timestamp(14) NOT NULL,
  UNIQUE KEY cl_from (cl_from,cl_to),
  KEY cl_sortkey (cl_to,cl_sortkey),
  KEY cl_timestamp (cl_to,cl_timestamp)
) TYPE=InnoDB;

--
-- Dumping data for table `categorylinks`
--


--
-- Table structure for table `externallinks`
--

DROP TABLE IF EXISTS externallinks;
CREATE TABLE externallinks (
  el_from int(8) unsigned NOT NULL default '0',
  el_to blob NOT NULL,
  el_index blob NOT NULL,
  KEY el_from (el_from,el_to(40)),
  KEY el_to (el_to(60),el_from),
  KEY el_index (el_index(60))
) TYPE=InnoDB;

--
-- Dumping data for table `externallinks`
--


--
-- Table structure for table `hitcounter`
--

DROP TABLE IF EXISTS hitcounter;
CREATE TABLE hitcounter (
  hc_id int(10) unsigned NOT NULL default '0'
) TYPE=HEAP MAX_ROWS=25000;

--
-- Dumping data for table `hitcounter`
--


--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS image;
CREATE TABLE image (
  img_name varchar(255) binary NOT NULL default '',
  img_size int(8) unsigned NOT NULL default '0',
  img_width int(5) NOT NULL default '0',
  img_height int(5) NOT NULL default '0',
  img_metadata mediumblob NOT NULL,
  img_bits int(3) NOT NULL default '0',
  img_media_type enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') default NULL,
  img_major_mime enum('unknown','application','audio','image','text','video','message','model','multipart') NOT NULL default 'unknown',
  img_minor_mime varchar(32) NOT NULL default 'unknown',
  img_description tinyblob NOT NULL,
  img_user int(5) unsigned NOT NULL default '0',
  img_user_text varchar(255) binary NOT NULL default '',
  img_timestamp varchar(14) binary NOT NULL default '',
  PRIMARY KEY  (img_name),
  KEY img_size (img_size),
  KEY img_timestamp (img_timestamp)
) TYPE=InnoDB;

--
-- Dumping data for table `image`
--


--
-- Table structure for table `imagelinks`
--

DROP TABLE IF EXISTS imagelinks;
CREATE TABLE imagelinks (
  il_from int(8) unsigned NOT NULL default '0',
  il_to varchar(255) binary NOT NULL default '',
  UNIQUE KEY il_from (il_from,il_to),
  KEY il_to (il_to)
) TYPE=InnoDB;

--
-- Dumping data for table `imagelinks`
--


--
-- Table structure for table `interwiki`
--

DROP TABLE IF EXISTS interwiki;
CREATE TABLE interwiki (
  iw_prefix char(32) NOT NULL default '',
  iw_url char(127) NOT NULL default '',
  iw_local tinyint(1) NOT NULL default '0',
  iw_trans tinyint(1) NOT NULL default '0',
  UNIQUE KEY iw_prefix (iw_prefix)
) TYPE=InnoDB;

--
-- Dumping data for table `interwiki`
--

INSERT INTO interwiki VALUES ('abbenormal','http://www.ourpla.net/cgi-bin/pikie.cgi?$1',0,0);
INSERT INTO interwiki VALUES ('acadwiki','http://xarch.tu-graz.ac.at/autocad/wiki/$1',0,0);
INSERT INTO interwiki VALUES ('acronym','http://www.acronymfinder.com/af-query.asp?String=exact&Acronym=$1',0,0);
INSERT INTO interwiki VALUES ('advogato','http://www.advogato.org/$1',0,0);
INSERT INTO interwiki VALUES ('aiwiki','http://www.ifi.unizh.ch/ailab/aiwiki/aiw.cgi?$1',0,0);
INSERT INTO interwiki VALUES ('alife','http://news.alife.org/wiki/index.php?$1',0,0);
INSERT INTO interwiki VALUES ('annotation','http://bayle.stanford.edu/crit/nph-med.cgi/$1',0,0);
INSERT INTO interwiki VALUES ('annotationwiki','http://www.seedwiki.com/page.cfm?wikiid=368&doc=$1',0,0);
INSERT INTO interwiki VALUES ('arxiv','http://www.arxiv.org/abs/$1',0,0);
INSERT INTO interwiki VALUES ('aspienetwiki','http://aspie.mela.de/Wiki/index.php?title=$1',0,0);
INSERT INTO interwiki VALUES ('bemi','http://bemi.free.fr/vikio/index.php?$1',0,0);
INSERT INTO interwiki VALUES ('benefitswiki','http://www.benefitslink.com/cgi-bin/wiki.cgi?$1',0,0);
INSERT INTO interwiki VALUES ('brasilwiki','http://rio.ifi.unizh.ch/brasilienwiki/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('bridgeswiki','http://c2.com/w2/bridges/$1',0,0);
INSERT INTO interwiki VALUES ('c2find','http://c2.com/cgi/wiki?FindPage&value=$1',0,0);
INSERT INTO interwiki VALUES ('cache','http://www.google.com/search?q=cache:$1',0,0);
INSERT INTO interwiki VALUES ('ciscavate','http://ciscavate.org/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('cliki','http://ww.telent.net/cliki/$1',0,0);
INSERT INTO interwiki VALUES ('cmwiki','http://www.ourpla.net/cgi-bin/wiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('codersbase','http://www.codersbase.com/$1',0,0);
INSERT INTO interwiki VALUES ('commons','http://commons.wikimedia.org/wiki/$1',0,0);
INSERT INTO interwiki VALUES ('consciousness','http://teadvus.inspiral.org/',0,0);
INSERT INTO interwiki VALUES ('corpknowpedia','http://corpknowpedia.org/wiki/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('creationmatters','http://www.ourpla.net/cgi-bin/wiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('dejanews','http://www.deja.com/=dnc/getdoc.xp?AN=$1',0,0);
INSERT INTO interwiki VALUES ('demokraatia','http://wiki.demokraatia.ee/',0,0);
INSERT INTO interwiki VALUES ('dictionary','http://www.dict.org/bin/Dict?Database=*&Form=Dict1&Strategy=*&Query=$1',0,0);
INSERT INTO interwiki VALUES ('disinfopedia','http://www.disinfopedia.org/wiki.phtml?title=$1',0,0);
INSERT INTO interwiki VALUES ('diveintoosx','http://diveintoosx.org/$1',0,0);
INSERT INTO interwiki VALUES ('docbook','http://docbook.org/wiki/moin.cgi/$1',0,0);
INSERT INTO interwiki VALUES ('dolphinwiki','http://www.object-arts.com/wiki/html/Dolphin/$1',0,0);
INSERT INTO interwiki VALUES ('drumcorpswiki','http://www.drumcorpswiki.com/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('dwjwiki','http://www.suberic.net/cgi-bin/dwj/wiki.cgi?$1',0,0);
INSERT INTO interwiki VALUES ('echei','http://www.ikso.net/cgi-bin/wiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('ecxei','http://www.ikso.net/cgi-bin/wiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('efnetceewiki','http://purl.net/wiki/c/$1',0,0);
INSERT INTO interwiki VALUES ('efnetcppwiki','http://purl.net/wiki/cpp/$1',0,0);
INSERT INTO interwiki VALUES ('efnetpythonwiki','http://purl.net/wiki/python/$1',0,0);
INSERT INTO interwiki VALUES ('efnetxmlwiki','http://purl.net/wiki/xml/$1',0,0);
INSERT INTO interwiki VALUES ('elibre','http://enciclopedia.us.es/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('eljwiki','http://elj.sourceforge.net/phpwiki/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('emacswiki','http://www.emacswiki.org/cgi-bin/wiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('eokulturcentro','http://esperanto.toulouse.free.fr/wakka.php?wiki=$1',0,0);
INSERT INTO interwiki VALUES ('evowiki','http://www.evowiki.org/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('eĉei','http://www.ikso.net/cgi-bin/wiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('finalempire','http://final-empire.sourceforge.net/cgi-bin/wiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('firstwiki','http://firstwiki.org/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('foldoc','http://www.foldoc.org/foldoc/foldoc.cgi?$1',0,0);
INSERT INTO interwiki VALUES ('foxwiki','http://fox.wikis.com/wc.dll?Wiki~$1',0,0);
INSERT INTO interwiki VALUES ('fr.be','http://fr.wikinations.be/$1',0,0);
INSERT INTO interwiki VALUES ('fr.ca','http://fr.ca.wikinations.org/$1',0,0);
INSERT INTO interwiki VALUES ('fr.fr','http://fr.fr.wikinations.org/$1',0,0);
INSERT INTO interwiki VALUES ('fr.org','http://fr.wikinations.org/$1',0,0);
INSERT INTO interwiki VALUES ('freebsdman','http://www.FreeBSD.org/cgi/man.cgi?apropos=1&query=$1',0,0);
INSERT INTO interwiki VALUES ('gamewiki','http://gamewiki.org/wiki/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('gej','http://www.esperanto.de/cgi-bin/aktivikio/wiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('gentoo-wiki','http://gentoo-wiki.com/$1',0,0);
INSERT INTO interwiki VALUES ('globalvoices','http://cyber.law.harvard.edu/dyn/globalvoices/wiki/$1',0,0);
INSERT INTO interwiki VALUES ('gmailwiki','http://www.gmailwiki.com/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('google','http://www.google.com/search?q=$1',0,0);
INSERT INTO interwiki VALUES ('googlegroups','http://groups.google.com/groups?q=$1',0,0);
INSERT INTO interwiki VALUES ('gotamac','http://www.got-a-mac.org/$1',0,0);
INSERT INTO interwiki VALUES ('greencheese','http://www.greencheese.org/$1',0,0);
INSERT INTO interwiki VALUES ('hammondwiki','http://www.dairiki.org/HammondWiki/index.php3?$1',0,0);
INSERT INTO interwiki VALUES ('haribeau','http://wiki.haribeau.de/cgi-bin/wiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('herzkinderwiki','http://www.herzkinderinfo.de/Mediawiki/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('hewikisource','http://he.wikisource.org/wiki/$1',1,0);
INSERT INTO interwiki VALUES ('hrwiki','http://www.hrwiki.org/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('iawiki','http://www.IAwiki.net/$1',0,0);
INSERT INTO interwiki VALUES ('imdb','http://us.imdb.com/Title?$1',0,0);
INSERT INTO interwiki VALUES ('infosecpedia','http://www.infosecpedia.org/pedia/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('jargonfile','http://sunir.org/apps/meta.pl?wiki=JargonFile&redirect=$1',0,0);
INSERT INTO interwiki VALUES ('jefo','http://www.esperanto-jeunes.org/vikio/index.php?$1',0,0);
INSERT INTO interwiki VALUES ('jiniwiki','http://www.cdegroot.com/cgi-bin/jini?$1',0,0);
INSERT INTO interwiki VALUES ('jspwiki','http://www.ecyrd.com/JSPWiki/Wiki.jsp?page=$1',0,0);
INSERT INTO interwiki VALUES ('kerimwiki','http://wiki.oxus.net/$1',0,0);
INSERT INTO interwiki VALUES ('kmwiki','http://www.voght.com/cgi-bin/pywiki?$1',0,0);
INSERT INTO interwiki VALUES ('knowhow','http://www2.iro.umontreal.ca/~paquetse/cgi-bin/wiki.cgi?$1',0,0);
INSERT INTO interwiki VALUES ('lanifexwiki','http://opt.lanifex.com/cgi-bin/wiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('lasvegaswiki','http://wiki.gmnow.com/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('linuxwiki','http://www.linuxwiki.de/$1',0,0);
INSERT INTO interwiki VALUES ('lojban','http://www.lojban.org/tiki/tiki-index.php?page=$1',0,0);
INSERT INTO interwiki VALUES ('lqwiki','http://wiki.linuxquestions.org/wiki/$1',0,0);
INSERT INTO interwiki VALUES ('lugkr','http://lug-kr.sourceforge.net/cgi-bin/lugwiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('lutherwiki','http://www.lutheranarchives.com/mw/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('mathsongswiki','http://SeedWiki.com/page.cfm?wikiid=237&doc=$1',0,0);
INSERT INTO interwiki VALUES ('mbtest','http://www.usemod.com/cgi-bin/mbtest.pl?$1',0,0);
INSERT INTO interwiki VALUES ('meatball','http://www.usemod.com/cgi-bin/mb.pl?$1',0,0);
INSERT INTO interwiki VALUES ('mediazilla','http://bugzilla.wikipedia.org/$1',1,0);
INSERT INTO interwiki VALUES ('memoryalpha','http://www.memory-alpha.org/en/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('metaweb','http://www.metaweb.com/wiki/wiki.phtml?title=$1',0,0);
INSERT INTO interwiki VALUES ('metawiki','http://sunir.org/apps/meta.pl?$1',0,0);
INSERT INTO interwiki VALUES ('metawikipedia','http://meta.wikimedia.org/wiki/$1',0,0);
INSERT INTO interwiki VALUES ('moinmoin','http://purl.net/wiki/moin/$1',0,0);
INSERT INTO interwiki VALUES ('mozillawiki','http://wiki.mozilla.org/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('muweb','http://www.dunstable.com/scripts/MuWebWeb?$1',0,0);
INSERT INTO interwiki VALUES ('netvillage','http://www.netbros.com/?$1',0,0);
INSERT INTO interwiki VALUES ('oeis','http://www.research.att.com/cgi-bin/access.cgi/as/njas/sequences/eisA.cgi?Anum=$1',0,0);
INSERT INTO interwiki VALUES ('openfacts','http://openfacts.berlios.de/index.phtml?title=$1',0,0);
INSERT INTO interwiki VALUES ('openwiki','http://openwiki.com/?$1',0,0);
INSERT INTO interwiki VALUES ('opera7wiki','http://nontroppo.org/wiki/$1',0,0);
INSERT INTO interwiki VALUES ('orgpatterns','http://www.bell-labs.com/cgi-user/OrgPatterns/OrgPatterns?$1',0,0);
INSERT INTO interwiki VALUES ('osi reference model','http://wiki.tigma.ee/',0,0);
INSERT INTO interwiki VALUES ('pangalacticorg','http://www.pangalactic.org/Wiki/$1',0,0);
INSERT INTO interwiki VALUES ('patwiki','http://gauss.ffii.org/$1',0,0);
INSERT INTO interwiki VALUES ('personaltelco','http://www.personaltelco.net/index.cgi/$1',0,0);
INSERT INTO interwiki VALUES ('phpwiki','http://phpwiki.sourceforge.net/phpwiki/index.php?$1',0,0);
INSERT INTO interwiki VALUES ('pikie','http://pikie.darktech.org/cgi/pikie?$1',0,0);
INSERT INTO interwiki VALUES ('pmeg','http://www.bertilow.com/pmeg/$1.php',0,0);
INSERT INTO interwiki VALUES ('ppr','http://c2.com/cgi/wiki?$1',0,0);
INSERT INTO interwiki VALUES ('purlnet','http://purl.oclc.org/NET/$1',0,0);
INSERT INTO interwiki VALUES ('pythoninfo','http://www.python.org/cgi-bin/moinmoin/$1',0,0);
INSERT INTO interwiki VALUES ('pythonwiki','http://www.pythonwiki.de/$1',0,0);
INSERT INTO interwiki VALUES ('pywiki','http://www.voght.com/cgi-bin/pywiki?$1',0,0);
INSERT INTO interwiki VALUES ('raec','http://www.raec.clacso.edu.ar:8080/raec/Members/raecpedia/$1',0,0);
INSERT INTO interwiki VALUES ('revo','http://purl.org/NET/voko/revo/art/$1.html',0,0);
INSERT INTO interwiki VALUES ('rfc','http://www.rfc-editor.org/rfc/rfc$1.txt',0,0);
INSERT INTO interwiki VALUES ('s23wiki','http://is-root.de/wiki/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('scoutpedia','http://www.scoutpedia.info/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('seapig','http://www.seapig.org/$1',0,0);
INSERT INTO interwiki VALUES ('seattlewiki','http://seattlewiki.org/wiki/$1',0,0);
INSERT INTO interwiki VALUES ('seattlewireless','http://seattlewireless.net/?$1',0,0);
INSERT INTO interwiki VALUES ('seeds','http://www.IslandSeeds.org/wiki/$1',0,0);
INSERT INTO interwiki VALUES ('senseislibrary','http://senseis.xmp.net/?$1',0,0);
INSERT INTO interwiki VALUES ('shakti','http://cgi.algonet.se/htbin/cgiwrap/pgd/ShaktiWiki/$1',0,0);
INSERT INTO interwiki VALUES ('slashdot','http://slashdot.org/article.pl?sid=$1',0,0);
INSERT INTO interwiki VALUES ('smikipedia','http://www.smikipedia.org/$1',0,0);
INSERT INTO interwiki VALUES ('sockwiki','http://wiki.socklabs.com/$1',0,0);
INSERT INTO interwiki VALUES ('sourceforge','http://sourceforge.net/$1',0,0);
INSERT INTO interwiki VALUES ('squeak','http://minnow.cc.gatech.edu/squeak/$1',0,0);
INSERT INTO interwiki VALUES ('strikiwiki','http://ch.twi.tudelft.nl/~mostert/striki/teststriki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('susning','http://www.susning.nu/$1',0,0);
INSERT INTO interwiki VALUES ('svgwiki','http://www.protocol7.com/svg-wiki/default.asp?$1',0,0);
INSERT INTO interwiki VALUES ('tavi','http://tavi.sourceforge.net/$1',0,0);
INSERT INTO interwiki VALUES ('tejo','http://www.tejo.org/vikio/$1',0,0);
INSERT INTO interwiki VALUES ('terrorwiki','http://www.liberalsagainstterrorism.com/wiki/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('theopedia','http://www.theopedia.com/$1',0,0);
INSERT INTO interwiki VALUES ('tmbw','http://www.tmbw.net/wiki/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('tmnet','http://www.technomanifestos.net/?$1',0,0);
INSERT INTO interwiki VALUES ('tmwiki','http://www.EasyTopicMaps.com/?page=$1',0,0);
INSERT INTO interwiki VALUES ('turismo','http://www.tejo.org/turismo/$1',0,0);
INSERT INTO interwiki VALUES ('twiki','http://twiki.org/cgi-bin/view/$1',0,0);
INSERT INTO interwiki VALUES ('twistedwiki','http://purl.net/wiki/twisted/$1',0,0);
INSERT INTO interwiki VALUES ('uea','http://www.tejo.org/uea/$1',0,0);
INSERT INTO interwiki VALUES ('unreal','http://wiki.beyondunreal.com/wiki/$1',0,0);
INSERT INTO interwiki VALUES ('ursine','http://ursine.ca/$1',0,0);
INSERT INTO interwiki VALUES ('usej','http://www.tejo.org/usej/$1',0,0);
INSERT INTO interwiki VALUES ('usemod','http://www.usemod.com/cgi-bin/wiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('visualworks','http://wiki.cs.uiuc.edu/VisualWorks/$1',0,0);
INSERT INTO interwiki VALUES ('warpedview','http://www.warpedview.com/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('webdevwikinl','http://www.promo-it.nl/WebDevWiki/index.php?page=$1',0,0);
INSERT INTO interwiki VALUES ('webisodes','http://www.webisodes.org/$1',0,0);
INSERT INTO interwiki VALUES ('webseitzwiki','http://webseitz.fluxent.com/wiki/$1',0,0);
INSERT INTO interwiki VALUES ('why','http://clublet.com/c/c/why?$1',0,0);
INSERT INTO interwiki VALUES ('wiki','http://c2.com/cgi/wiki?$1',0,0);
INSERT INTO interwiki VALUES ('wikia','http://www.wikia.com/wiki/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('wikibooks','http://en.wikibooks.org/wiki/$1',1,0);
INSERT INTO interwiki VALUES ('wikicities','http://www.wikicities.com/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('wikif1','http://www.wikif1.org/$1',0,0);
INSERT INTO interwiki VALUES ('wikimedia','http://wikimediafoundation.org/wiki/$1',0,0);
INSERT INTO interwiki VALUES ('wikinews','http://en.wikinews.org/wiki/$1',0,0);
INSERT INTO interwiki VALUES ('wikinfo','http://www.wikinfo.org/wiki.php?title=$1',0,0);
INSERT INTO interwiki VALUES ('wikiquote','http://en.wikiquote.org/wiki/$1',1,0);
INSERT INTO interwiki VALUES ('wikisource','http://sources.wikipedia.org/wiki/$1',1,0);
INSERT INTO interwiki VALUES ('wikispecies','http://species.wikipedia.org/wiki/$1',1,0);
INSERT INTO interwiki VALUES ('wikitravel','http://wikitravel.org/en/$1',0,0);
INSERT INTO interwiki VALUES ('wikiworld','http://WikiWorld.com/wiki/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('wikt','http://en.wiktionary.org/wiki/$1',1,0);
INSERT INTO interwiki VALUES ('wiktionary','http://en.wiktionary.org/wiki/$1',1,0);
INSERT INTO interwiki VALUES ('wlug','http://www.wlug.org.nz/$1',0,0);
INSERT INTO interwiki VALUES ('wlwiki','http://winslowslair.supremepixels.net/wiki/index.php/$1',0,0);
INSERT INTO interwiki VALUES ('ypsieyeball','http://sknkwrks.dyndns.org:1957/writewiki/wiki.pl?$1',0,0);
INSERT INTO interwiki VALUES ('zwiki','http://www.zwiki.org/$1',0,0);
INSERT INTO interwiki VALUES ('zzz wiki','http://wiki.zzz.ee/',0,0);

--
-- Table structure for table `ipblocks`
--

DROP TABLE IF EXISTS ipblocks;
CREATE TABLE ipblocks (
  ipb_id int(8) NOT NULL auto_increment,
  ipb_address varchar(40) binary NOT NULL default '',
  ipb_user int(8) unsigned NOT NULL default '0',
  ipb_by int(8) unsigned NOT NULL default '0',
  ipb_reason tinyblob NOT NULL,
  ipb_timestamp varchar(14) binary NOT NULL default '',
  ipb_auto tinyint(1) NOT NULL default '0',
  ipb_expiry varchar(14) binary NOT NULL default '',
  ipb_range_start varchar(32) NOT NULL default '',
  ipb_range_end varchar(32) NOT NULL default '',
  PRIMARY KEY  (ipb_id),
  KEY ipb_address (ipb_address),
  KEY ipb_user (ipb_user),
  KEY ipb_range (ipb_range_start(8),ipb_range_end(8))
) TYPE=InnoDB;

--
-- Dumping data for table `ipblocks`
--


--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS job;
CREATE TABLE job (
  job_id int(9) unsigned NOT NULL auto_increment,
  job_cmd varchar(255) NOT NULL default '',
  job_namespace int(11) NOT NULL default '0',
  job_title varchar(255) binary NOT NULL default '',
  job_params blob NOT NULL,
  PRIMARY KEY  (job_id),
  KEY job_cmd (job_cmd,job_namespace,job_title)
) TYPE=InnoDB;

--
-- Dumping data for table `job`
--


--
-- Table structure for table `logging`
--

DROP TABLE IF EXISTS logging;
CREATE TABLE logging (
  log_type varchar(10) NOT NULL default '',
  log_action varchar(10) NOT NULL default '',
  log_timestamp varchar(14) NOT NULL default '19700101000000',
  log_user int(10) unsigned NOT NULL default '0',
  log_namespace int(11) NOT NULL default '0',
  log_title varchar(255) binary NOT NULL default '',
  log_comment varchar(255) NOT NULL default '',
  log_params blob NOT NULL,
  KEY type_time (log_type,log_timestamp),
  KEY user_time (log_user,log_timestamp),
  KEY page_time (log_namespace,log_title,log_timestamp),
  KEY times (log_timestamp)
) TYPE=InnoDB;

--
-- Dumping data for table `logging`
--


--
-- Table structure for table `math`
--

DROP TABLE IF EXISTS math;
CREATE TABLE math (
  math_inputhash varchar(16) NOT NULL default '',
  math_outputhash varchar(16) NOT NULL default '',
  math_html_conservativeness tinyint(1) NOT NULL default '0',
  math_html text,
  math_mathml text,
  UNIQUE KEY math_inputhash (math_inputhash)
) TYPE=InnoDB;

--
-- Dumping data for table `math`
--


--
-- Table structure for table `objectcache`
--

DROP TABLE IF EXISTS objectcache;
CREATE TABLE objectcache (
  keyname varchar(255) binary NOT NULL default '',
  value mediumblob,
  exptime datetime default NULL,
  UNIQUE KEY keyname (keyname),
  KEY exptime (exptime)
) TYPE=InnoDB;

--
-- Dumping data for table `objectcache`
--

INSERT INTO objectcache VALUES ('wdr1_jargon:messages','���vW�(����u������%�5��Ԕ��J�K�\0dX@2\"@���}�Ͻn�H����������\'\0J�Z��+SD���<�y�������o����FoV^g��o|W����?�|���cB�IS&����s{����y�Ƀû\n%�Y%��\Z��\Z�����=O/3jjp��*�b�+@u�0б$$��v��ݳ׏_=��w�<\Zeu�)[���<��:�Bu��T�eQS���w��I�{�sgyQ�\Z����W�u���|��:��$��q�fi5��|�I��gi>m�[jy���U��Ӻ�)�q2)�d�^o#�J�d�eERgE��q�ߥJ�����fڭ�Z�d���\\��,m`�.���l������伬��N�,��u��S�/*��^/IG�rQ4u7�	�Fi��$���K�-U�\rs���RM3Y�MM��=H���M��$K\n��R�y�X��378����ػ��yݼ�Z���|>�Fy:=��u�V>~�v�/�E�%�����j,�\\�5מ�$o����:pZޥ�O�y�O��b�a�WY��t�H��#�t>��lnn�)t\r~$yA@�sg��O:��L�	>Lվ��l�-@�$YZ�p>���|�)����t���Кޤ�{��u�Ҥ*g<36�FV�$�)V����N��8��5��eU.�z������� ����^-��L(���uF�D̿x8�л*mʪ��ͮ��\\:d�iZ5�h��vdp|�>��E�βz��h[�9���N�`�[����T�>��`���a^���y=��K\\4z:�I�pc��v�9�>�N2���Oyq�C��^��<�j�9c�rU�7ɸ���ǻ(.��h�b��Yγ�X԰��;	�\"��N&t[Ҁ�n0�\ZǨG�|	�%Q�q9ZT,����Ll\Zb�q6IS�~ʟ�(����H�P��+N��$�ujx(4+�ϳ��~~�US��\\�AT�{�t��� ʦ^��e���{��Fϧ�E`<�0�c�;J�Grs��Ξ�M:L���URN&ݯ4��\'\0�	���9�@��	lB8���\'���ѽރ��GX3v���=���i�7\Z>��5S�k��jN]N���x�$�5<@�p����\n��C�)?\rg��NZQ��;�ɻQ��@7��9�EG�-���=+o2|!� �<+���.&��W�EMG��m:���?q��+������O�s����\'�9m�*�Ň���`?d�1�o�W{�7W	�T�H���-�+�nW]/�3~��eȞ_�y1�n�̤�OB5&l�boc��5��m�qp�Ґ&1 o1���MZ�uI�(�}��xA�WQ|��c�jn�Kء����\0XY\\>z����1����`�}���>V��G��U�t*W�	�>�KS�)<����x������gl��^�3��[��4�U`\"b?n���,+عS�Y����[p�s�	�bϺ�P����\rbD����{��&�d�1�QwOt�\0��Z\Z�B1�_i.\\8��4�dǁ��>�i4�8A6��TVɋ���~_BX�p�M���a��];��$^\Z#��w�TC�Q/B�&�>B�/��e$p؈a��0�]�osSoD�ix�G�\Z����6�~P�r����UI+��Ud\Z��N�Y���P�2c0|>�|����3���Pb&�^,fY���)�h�5B\n@ъ&�,azf���nr�]a�n~��魯`-ƌQ\05��e�Ms�ð2*�V&Y6�������4ͮ��~���_���b�a7X# @S�V=��;vB^|�����M^����2��K/�ɂ��F������M��5è�r���ùB~ܼ��/~W�o|��3�v>ݞ���.��=��7􀦔���Tѹ��6�*�����:���n�-O1�A&N	M\r�w�z��▣��L�&#�\'���;Z���{=�s,���ү�t��iє�3\Z�#���r�l�F�1���bK����}&°� ��Zî�̯��[�r��8L�i�Tٽ>��!{��t�I���۬��|�3@�+�)���D�Ӕ�_[�*��\"#RVn���>������c��p2��_­��gt�P8lX6��g�@Ii;`�P!�z�/��Tmk@]�pg�%����͛���P���U�.���b���٢)]�xMЭ>����.��==PO>�VD�EAܭ���\0���e��v��y0�H�����?����w�b:�~��ɛ�`���!o����Ha�4� ��i�^�3v�|ma���\n�&����H�\\�\0/�o����΋F:�N�W�.\nkvN9���9Nј�z\'�M��lL���no�7����l���vW�����lA\'1��f(ɐ8Aҷ��ϐiЕC�a�jY]�*�Ip3�x��)����W/\n8,�1��\'I`x�C~�)���F+�s�;	�ӒnUX��\04*XT��?�C�5Z�8���^I�.M��DҐ����cGg�ִE&\"2C��G�CC�\"Zfn��j<���\Z4�hB����N���]��Y�	����q[���!�f�5HgA8Hz�2~r;?����9B�9���S�\0K}]6n;c���([��#�5ɢ�������x:Uv�l��\'��	�iY��4��,�N3�^�t94�q��qƽ3����x��Q}���&+i;���B��Z	BA��\\\\��I�G[\0�=;@�ً@�����$��c�/��?��[Q������)�/U>\\��Qߗ7teWu;�m�EZ��Ŝ���\ns�o,s[�!�-L���F���n��݀w:4�=���n��F\ZQ��z !��|�W��Bx���]�p,Ǵ��qD� \':�� �c�U���ty�A�\Z��C���m9�G��s�Ce$cp;����1l�� ��N2�	���S���U�i:�rdڙ_����<��\'�GiN!��W���H���ۭpo�l��ߎ�8�-�\'V�C<p�8����h��\n�4�j�Ԟ^@Z�Vz�0b;�<T<�*�5Xᓐ XQ�gi�鲣�\r���*%;�IdQ��8�_ڮ��\"�2Ä/�;*��\0�4L�������t|Q�:�l@��B����벹��S\rw�(�☔��}f�����q�pϐ���|d	�V��2��`�d.������p�r\'��J��o0��$yTĈ�)|�zT@Z��SV�PѐkNN���p�A�_�I�?l�@h�8Bd0��M}jW����2��$>i�]t��{��!2�n�}�h��\Z��A�YN2�fC@(���,���̺�\"[�q��5x��/�R����j�SB�~�t<I7Yq�מn�T#�Ta�T� F���QDhN�@*��Cb�����Q҄?����[W���\0��!�B�\\<�[��E�MfPPa�8F[w۵�(+�:w8|�4a�w���Y�kN�I�h�q����=���.KD�H��������= \"�ՠ�T#�c������>G����}qS(���meI�!�로����q�򙪌ͮ&�/���&��U��0_�B$ͪZ_/mSg��\Z��t㳜9|�5\n_x�9sU�y�>���k�RM6����dk��ڶ��	 �\"�t�h�a�777�>E���I�zzM�EE���8\\bs�����͚0S�|���.\n�_��\"�&���9r$o��y:I��ڻ·�d����W���4�{`�I��;os�,CQ��&�\\D�Bⓦ��R��3(�)��K\0D��I�W�h�;�ʋg�I.���	�p������T�_�1���\nO�΃�y)�o�����s�Ĵ�˪y��?v�y7t�e�\0Pe���Pm^�T�8[��rZ�K�V�w�����N(��Y�l����? ��]�0x&%;���P��$�f�_��}^��x�3}���1�+�O�ν��v_�����N7����D��i{sb�R�Z��.�y#��g�����ÐR;x%�X@R*��E*v�4��Ub��60T�oF�\"G������N�[p=֍�t�l�\"�/������qi2sf;\n�Ӧ0������O�!|G</��H�i:�-�x��,̄xm�5�O���/���&Z\\^��T�]���J��3nD�NX%�y��t�����CZ�,�lk3Q��a9��{�X�9#\0;�Ç�C�ёH?!��\n)S�(� ��ppa5[��2�n���s�2�S���Q8�#7\rr������L��\"+�� �\"o ���������y!���-`7߲�(��Fp��	��2��A�4*�Y��vD\"34���5��z�R�C�x$?�A9��^�M�L�u�p}��#z`��+�c\0�\nO\"�v�_�#>�Ӛ3������nu�RT2zE��v2\\﭂�!(I�㿘W�E��b�j7\'��1��l�3�*�����Jԋ�/�\"�\'�o�����Q�I]����ּ\'?�F��tZ��r��+㶧�\'�b���S�;�K�bG��E�;�u6��c9����1p�h)�=�a���0J��)�yL̇L��G��pOyR����[�_�����`c����Aw�n��02��)_jrݩ��\0:����O\"c^�=��B���C�s�JF��+�BJ�3��䚐��#]�̼;�&�%_��F���\Zj?���͢;�e�����g�@�s�R�[�7���i�L��N[��f�K� Ы�u��\rFJ�ޭ�J���i[k��蛦���ceg\"�)IF�7s�a�3�ᔁg������A:��/���)ѽ �Ͻrar&m�b�\r:� �t�����S]�#����4h�q�˞+Ll�Hl4<\\���%P}WP(ҭ���2@�������D��\\�3�E����02@����+>\\��%Ͳj��dyp�!?��α�X��ZH������H�wY��1����g9]�w\r�T�,�P:��`2s�4���! ��܌u����V���L0˴�Q���o��o�%����]���۟�^���gO�o���|x���7��%o���zq~����!���~}�������f�)�4V��&sr������t����ߜ��m HL�)c��٨}�Z�����;��x����&�z�U������tJE�ΐjU\Z�*|��l\\�\ZU�Uv�H�[~���\"\Z�$	(�Hv�G-��E5������*�w�B�Z��I��6 �N��њr�,j_�~�T);���D��ӣ���C�ץ�du(��_2	Iǜ�B2�\r6)�D,6��\r	ER���!X)#�����rO	�-G4c�i�M��|D-\0�yi��5\0�]�UZ�ܤ�i�	����3��AӐ�9�ypߥ���#he�(X�h������Z���%,`�h �}g��)�g��a$�h����?4@dP�1\0����7�yC��Sd��$��i���[�&Y\r����f���1�\"yϚ�#3��/�GO,�q��D�\Zo�:��,�O���D\n9:�\Z:N�ƨ�>�.���m~��iHfy�޲��Q`H\"����Z�E��EM����\"�%[�ݤ�\Z�[�!hF@�>��B=|ءM���y����&$�58���抔�`�f�g8>�Ɵ�D���ꚜ�&��ܿ��h���8č������.FU��/��_���L��x�3D�g�:�(���\Z��g쳮�(};�7�p+N�fb��F-�j}`t�YT$l�w7����\"�gzF�\"��Y��O@�����騍I�\"�x��E��J���8��-ޅ�b�$n�k�MX}v����hP���M4�;�7z�P��I����ku\rxC��J�׍W;�C���q\r�\0�i��G_S�E�w��NЁ.��-L�Ի��t�O�f����֕m�?p���d���!b�?�0y��F�d�VH��67��,j�e^��a~�H���Y������J����I4�<�evr�/���*]�Ƀ��x�3�珈}�T�+-A֊s�$�UN�F�pA��X�єG�E����V+9\ntav+J��������܃���\Z(3쥚��cK�ףi\nX[e/�a���\n4���<K��J�5-��Vtb8yU\'�n�Z!=K��G�Qa�A�4��fO\r׭��X���\r�\0���D���V	�Sځc� ��e~��,x\n����W�聰Fl��j��0/szU!�iyS �R>��/�g�^������z0f�#sŜ�Li�n-h#���n�{f�*\'o�F�AW\\�8�+V��Nd�[�Z���b���N��yu�&��ϳJ�sW��g\"\0s?q���]XTr��/ �\r�4)�1$�)��تj�*��\Z�\0QJќ�j�����3 Ż�)GQ^�-����u�G(t�L*��\'��p���<�������FP$34��p��>_<d&��I���+1����h�3.ɉ��>Ԗ�����&/3:S���[�l�5����b0�?��J��F;\r����3�#+�d0���f��%[��ݪ�9��0�H~x|����N��(_�E�[NvQ�140Rw�\n�e�ݼC�J�,̀~J`O�]�*̫`ݘU�WǼq?<���������ux$HAc��J�mY��ZkS4��A*t��7���;d�������*	��Mڗ�@�x	@@��\Z�\nkE����[����M{N	�g�\\{8Lǒ#(q�zg����D�8t�Pj����4AĶN�d���0J\\jF� ��8�}9�n����\n��l�����͜�m��c��������d��\Z9��+!y�(��{��$��V̠�5��H�Nʰ�%���G-o��i���c�]\\Ң��\r.��Ƹ�t�1S��>�F�a?��C�\"��,��͙�˝�*|!� \0�YY�^o��<�W#�����n����x=�!�i���$�~h�4m\r3o8�:Q�RH��������� 8r������\rh8\"�ŧ�L�ef,�j��O*Vm�὿t���!B%!R�ԥ�Ў�yNϛL1\n�:$T�O��L�f�>>���e5�I����1�:��/���n�\r���y�E\0\r�@��w�;h�C��7K#����\'L����$;�lV�<ˈ��e0d�Ș.i��RѰ��6�����\\e����E�.U�S��|b*E�\'���{�{�#<��ϟ�!m�C�W��{o���݋w/��پ���ǯx���ٓ�g�Q���.>{���SH!�.Mxs�CJ�����g/���Bc��ν��> l��0�M���YZ-O�����^=>��?^�x����t��-�2VV���p�;s����/;7�ħx��Dso`��4����RqM�\Z(��l�kpϯx�\nF��)��jO&����c�o�!��:iS�N�`����I�N�E�Zb�)���.i}��o��t���Nj{v��gg����o�r�N��tō�}����t�g٘�A�����\r�&�(;]_a�\"�������H��vp����Hv)��H����T���R�>܃�����W���z\'�`�_��`h\'�h�����U��:͋�F���Y[��8��4D��6��$��غ�n�;�ߣt[��3D��<�\\e��9�,�WP�Z�7\r?hB��A�ݲ6�\rT�ϩ^Dщ�HG�0���kŰ5����5^�z��JmJ�i�Qe4o\n����\Z�dK��ϛd`㨸�m��6��������:�y,iv�`���y���*\Z���U��\"T.��\\~6/O�Q�(����.ɒ��z4I�(Ӫ\n�ؓ��IYN��Vkb�Ĕ$$�@�����~�^Lf�u�d���	��@e�5���*0EMI/\r�n��hV{_�dwO���K!��*ˤ�6�/�ʓ�(x�����/g�@��CЇ���_M��c٥��63����0�B*�����\n\"��\0_Ë9ˢ��J�\Z���=��P���>�!�D�9�U���}��ω�YQj_���z�����Z�񣺤�7��4��<Eޮ�^�M9���HHǗR�.A|NS��[[2���Rc	Is�����i(����(㶶��Zj�_�\r�%랋�D{pZA	��J���O�4�$��]\':���:e�:��zT�s\"y9�n��A�3��t�k	s����|��	f$!GO\\AA�\r�ĥلe��we���§E��s���E�O[؁R�Z�v�}�x�Z�ր��$�u7|O�̫�X��?P�ĩ�a�j?�\n���Jga�eoC�ʬJG�\n\'��zrU�8�j&}��}�?] E+�T[���;����ϯ����R�Z�V2�$\'�½E�(��3G�Y@T��t���J�F>1G�wT9A�����+�}��#�w��۲���7�%�a4-�l1O�WeS:�HH� �.d�a�K����15S�.�z(�kiji_hՃ����敻l��u��z7�r��F�ֽ�	x�rX�Q!�fvIG+���PJ~�DJ��J������1����%P��QM�B�;7�y }.\0ɚ�qwR,�v���}ڭ! n�`\'��o]Fv��͕��ˬ@r�ㅌ�`�����5�ͥg4/�L�A<w\r��@�� N|s�_�N�߻(��VC\0I�Hd��J=|A�@��l�+enC!ݎ��\'���\Z�_��V\r�>�)�V\"z=�#�N�O<^��.�\"���v/˛3������G@Ѿ\n=��Z�(x�|_�P���\\����/�Fd�O����&ڢ�&���mk,����jӯSƟ~x{�r�4�2�\"`u��	��k��j�\r��R���\'agAU\'���2�k=�a�cxwM{qMc�d���7+��E�j/�ڽ��V7�iX9�{)�_냖��\n�n*z����2t\rq4a]��;\nkO�Wz���t��R��t$�ȥ\'�^ͩu�⒱;ӽ�*�,��%�ww!ӵW-�V?_�9��U�6J�`P�R�T>���\"*@�b|�r���R:���]��\ZK��u�V|��]S��^����MM����*���?�`\\2ꙻS��y�6�J��d�AN�^�F|���B��9�L��J�}s�0K�p.�=��Eܕ�{��%��:x������9M����4�zJ��Yj��R遖|���\r�Ͱ˱�/��0I\0�{��c:ER���[\n�I�\'�E��t`���m��(1��;*��Ig�/���+5E,w����y���W������;�@���n+��ss�J�0N(qɇm��T��<�P^�m��p#36.��)c����EzĐ\0l\'�8/[iS�`ӏP���^���H�^�~D�u[��V	��x7FU��\nA���lz�[�x���������������U���w�`����B/�ӷ��^<��%�\n����.y?�ģ�N�8�tt�~��<���e>�#(��o&�w�	rQ��7/�=�����Pr���+A�ՊJ[���k�C�h\n��O�v�\n˨�Nا��S{8�v�4]Nm	N�\ZK�ɴ\\���M�����=Y����D`t��*�B2�.J8|�ľ�498��K����?�Qoo�/�w�D�2Y��KԀE�0_��d�P�:��rUDj�<�����C28����\\ׁ\"��T�����ї�9ҍq�o������\"�w���\"\'wyr���qFvg�}�FHS�\r�S��/\0���@Ƥ9ػh_��\"\0<%/�fQ`�i�J�\0� \r��9�}��I���0Ӳ#v����r�_iԉ^�Q��T=\ZB队\0\nR��,-T��ZX\0��\Z�\\�F//�Whf(�P�_�b�Yz�\"&�!��g��	��K��Y�#C\n���_I�*��C�����1Fj��B�}���K�@X6v��r�md���\0�f����P�����&�2��d�<4�J�Mcn\"���[��=ԚM�͕���7�$�i�#�Y��7n���*F��E�z$�M+�x�$NH������4����+���L�w�2.�Yِ�n�x���w��k�6��-٥�e��&N���ɓ����+:4�8��Ý��!�E\\��m�^���~�]$@#�4�2���%Q���u��n�Y|W�\nQ��%���d��\"�q�í~z�����\Zm���ٸ�2.v�Ŵ�!�F:\"�7�Vt<�\\	I㴪�4����r��et�(>-������g�-V��8���=4�Lb�$JEL���ָ��)�/�t)F�6�ɹ+���c�̊$t��/M���ݸFɒ�n�Fm��[Ή[\"�Ab��S�+�x}���j\'�����X�B���K�p�����L��Ȟ/4Q��F��1��)�S�V\0��l���g���W+�k��;�ے ����9��\Z�b\n���3�1�_���8 �_�ַ�Ē_�K�*.�2�@�׌�a~� Q�\rvOk)�m8�/\0b}�d��e�ί4�Kt��x�x�R�u�[줰�<�M���������D�)����&�5�{��z]V_(=���n��4���wy��]���Z^���Y(���Xy#��U9�j��������J\ra�\\��\\�O���a�h��\n����\n�V�2�h�$Ҩ9�j��E��A��*;W!� �&��)�٤b��(*���W�N真@A����L��DM~�j�X��dM��;{�l����������s��pSbJI�\"�,f��QM|E�+\Z�&Q�ՇIC�8Ë�H�w��L�����J�/Aȇn�vSI�=�B�u�ٗ(c�U:�ʯ�[��\'��h��/\Z脳�	�Z�^8��(�MY9��@�w���x�Z�X��8}��:+ux@U �*�Hz�}��\\5`Z�Gw�;IO��^h_�ݩ�K G0���s�tj�w���]��\ZhQD;u7F�_+dn�E�n�؁/F�2�/��wH�2\Z}[��G#\'��v�����V��8����=\\����pk�M&9E�9�?���^�2�����6i���@u*����б�3~����r����L6d�$��Dl�\'�?�&t�:g³=���#G#�ꁵf7ĵZ�\nYC*&f�>/�!���3�7f����4o؈q1�g��|~aN\",����J#ĺ�ؕG�R�r2O�˹ڢ���9�y�a�Uj�����-%|]^�oB�\0�K=zSL��\Z��Zi�=\n�DM�#\"��@v��ǵx��0��ZZ�Cq�r~S�Ӏ%tţ����QδN\r�w�@��8vv0��,J��\nc�v|8��\0ե���(V	�~��(mY�ϣ�F�ѱ�?��~�֨�p$�\'�s(�G�	��V�\\*���Нԅ��h,�CYWo��83��p%�����N����3Q!��!	�3���0��<�Y\0����V��b.����6�\r�[6\0ޡw2P��ex�#)D��l��=�s�BA�!��N�/��:}�U��c������jQ�K���;\\�9��Ke�ɥ,\"�Abd=�\r3ҽ쮆m�mp���h��t�rbg��ca�{b=T7lsv�1:��\Z����r	����s�8�Ϙ�����J)���Ms�Sn������g���ǅ6m�����+ٺ��o\"�Bq��58	cd�-�kDꔸ�$:������_��*&�ySxu\'$\0�\r�_���Z�����g6&�?�����^h�C��+�&u~ʱ�1��F��6\n��߰5���J�ʳ��VD&�A}�p�z$�>g3c�}07���\'�d�*B8r��0�^�BJ��6`\Z�$�l&1�|�aK�؇�Q/x��Ǚ�,���~|���,3�mۊ��e�Ue��&Z�\\�_-f��#��8b�̬���n�����\\�r�o*���j4��O�,<^Y�Ո����;ɫ����4y�^��e(�Ѓ��(�qa��H�ݥI�����%`#L�٪$cثd��;U�xEՄ3���;N�TP��6�X\n�arY͎��]�K�q��>�j\0� �E�(\n�7,-��9�/i�H�a���-�7|�4�������l��=���M!;���d���綂���\\�\\3-��P[\r\\�����5qaJ0r��,Fd�QZ���	��B��P	�P�V���0ڏ�0�H+D`��:\\X�v}�ꅋ�>D�\'~�����GgP��y�������h%��HbߊT�$kF4A��4����/�K�I���\Z8���y@�!��n\\f͆xL|�_�K*��}� ��W��� <�7b��o$�n�3�z��7��\rt����bf%��H�<����ʕ�%�lPdć8�����n���*�o��^k\Z6���@����5E�t��Z��t�%��v��9�\0D~`#�)�����#����}���������J3���q����΃�����C�8O���=�W���B�?yO���z�B/����\'��ڥhԻ�|��wՂ�;��O\n�`1�%�[1	K��R�4���o�\0cR�\0&?���\\���z\r��|―q�`CjUk�ǐ%��0Jr7\\/�r~w}6�=�T���qRe\'�	g\"�ƷZR��g�^u�v�a���C\n8��@��.��9\'ɾ^Ѱb�]�$��\Z�ul~�p���1�*\0��pV��l�C\'�{�bW��&�w��nC�ǫ��-��}�|�zo�%�����=m�ևJ��V]3i\0��7��m�Ά�E;�\\����!f�XW�$+��V�B��W*�ywM��ɘ�U���v�G�;w�S�\0�-�^[˭\'�Ze��G��6ρ�+��F�w1�1�+|B�]�.f`���JB��h�4Gg��@�I�w<�!D+��O�ϟ�ꇿ��ϳ��ϲ_��N$�eN�s%n��؏�r/M��hrd�w�B@��D��I?��<�~����1�4by �1�{�����7�\0�^LC�!LJ\\�\'5�H�_����Rk������V��,��yf��=M�m�K��ӓN�٥F�c5��Dbv���:,\"op�#�*3oq�Q�h������N������f\Z��%��l��v���4�}�����ᬃDs���)l�\n�B����p�yj8�\r ���Ӎ][v���y۪w�>]\0����A����[`AD�ѿ��G:v*�ce��XnB;}kAǔ��K3�xq	S����\r$\'&�ʾ�)�:\"�@ݤK�s�\n���k@�Q�)�t\Z�M��yt?�j���JHX��-z����0Oa�G^;��P�,tHR��U6Ћ���B�\Z��SW4�\"!�s�~�_ʡc(�B��7f�q���\'`��R�X��瞨��`�\0-���\"��,V���!�C$�7u�9z�Ĭ�x�օ>�[#�������ݨ���k�vD\0_��i��X��M���q�g��U���at�L�[������q$tt\ZB�_8�i�X]k�2D�\r��$�����>j��*�.{G�tķ��<���[��Z�p�\0[~��P�`�0(�\"_���\'(���Q�lf��b��Y8KE���μ��oA�~.��)]_�hqb����������(��٬B�E���Xޑ�,ĩY@��w�Y�{��_�a���TiWN3�`��lI�,-D3�\'���~O3dZ�,�H��B��ha}nY�W,A){�۶�I[�S�V� ��=I���o@B�|���r\"6�� a٦�v���%s\n98�Q�Lܵ$v5R✐���]_�GYuZD��vg\r_#���f�xDQ<n��.F�[FJ�`8߄��%�=���χ,�lX�m���^�\'b�EC�;�Z����\"���{*Ӯ\\;���O��a�xc~���t^���N\Z�@�\"��2w]�Ki��p��2�롲�c���i6WŤh\rY+��:�9	^��d/#]tm,���ib|Ɖ�\0�iq���b)g\rBѢ�7�biG��;dH�\r���v��WdBai����h���C&�U�yU��+v,���4�;	\r7lG�W��-}~A\ZV>�4m����-��#6�����<v)��ߌ!���;�s����4B��3����l�+Y�?C.#�~f������\'sM�-(#� �3��[�5TbN<��o�<��&f>,�����}�����w�O����࿀�ȹɲO��g�O�����W����_,�?v5E@�%l�S�����ԟC^����Ԕ�4��Di|���	N^5dW�h0^�������|�p�/���8b�Y4�E!ˬǼj��߿�\Zj\rȢ7�h�{Ě6�TŜ���vZN/\0k�G-D��;�gp�ʯ�װ����ۍ-rBrrx�8|_˹cq�I>�A:�GN����R�y��P�i�k�~-[?�\'l�R�\r~(^ݳ�\"��/#c�VJ_!���t#|P7�����%�\'�e���z\n7��\"��h_\"�9Jz��F�b-\ns����(�rL+�P�V�B�\Z��NY��G�eH*Ȩ����#��{}�}��`�Çu�|�[ˠ���A�	BopW&�ej|�Đ�:�����`��}7GŤV� ^���y�}�0~}e���a�k�B_\ZŎcj���ʟ��xk��^z����)��\'*&ъ���A��M��~���Z,:Q��������9�������o��{��v;�|���{��6.��.*6�r�0��H�T�)��g���¶�N]�h#c6��c�,tzn�<�gPe��ET�*/$��)��\"ty(aa���f��q��}ya��N4�ȉ\"�U�`��_$�R�F���d!O:�e�Ď58�9��� ۡ{׎(�Ӱ��?M˶$���\Z��E;Z�<U�ՠ8�0�݈�ȃ&����r�Fl(����\'�L��$�UT��L��(����^��FR,0d8�%]>��&�`aKN�9I��Y\0�->��C���i���WA\Z_�E{	��V(�L�U�.�\0���\Z%�WhdB�MP��WI5EZ�ɘ�r��i���,�	��QcdQ�����L�,���U�n��{�ʨ�\\t�H݋�<>�۰����%G���g�(�ˀ�A=KE�1��iy�j<\0��eU�|,���>�4�$�EI��},����G� �1�C}����Xw�6p��=���d��y[���x��D�°�sQ��靡�)b����f��@�?L���I���Qwak9Q�4�+����`�0��P9����J;�m\n.�M\'39s�6�/ƀR���?�b���O���))�A�p���\"�A�|`q��R.T.�G�d��c���C��5���Ld6���)�֭�2��L�;�4��xM:�4�c-�Z�x��>�C0���M����ǎo~H�$ 	�Bڋ�%nU�����bR�CS��D{V���G8�]�Oq��\n��R�*��2\n�����ݖ�cU~���	�<��vv��%C$X�0�L��V:�h$��iɸm]�iXKT��O����y����\\7y�8�Y,�A�NBg�s�1�Y@�l�����i{���hi;�F�.WKm�����5�kS�E��OC�|�(tM��珻�<�z�>v+��W�L��Q���h�Q|.��xCf�೥�j�I��RQr���2ܸ�p�/GWD��,�s,��?+o�\'�~�-��c����+L_ݡ���i��y���nJ��M\"tA�l�D?�dAt�^i�?.G��8K�Uy+��6�|�� ��_q���o����\n��s�N�m��(z96�.�x�ֶ��<|�����̀	#�k�A%ř���>�>\".���b �������_�:	|������\0}iqJTĤ�o���_ �ꓠ=��q��3}�t��6�1���<Q����)�R�U<ec|�\0%�������}NHR�_��7��O#-0��1��E��ڮÌC{�z����|b�U!�;]�i����;z\\S�	�|\Z�@���N�:�Z�L̝�v\\I�k;����8%Ah�B`ҵ��&P�A���0/*8�ci�Qȹ�DXw;���)U��+֎�Kx����S�PU?+�j�+*��~&P��v��W�/�H�W�߬�T}J�V�*q/Z�#�Ʌ��d�QF�J�25�2�rOjfF)+p�6#�gcW�����(K�Ee�#��HL�\r�xWi;܂��A�ˈzZ�V�l��[S�U�c\"�E�TR볛c�:�n8^@(5%\\&�V�9�Xd���$r`:NU����BDh�{�g�\\���C�\\]�� zs���@8-6���Y���\"H[[�JVĞ���*kfsȤ���V2�[U��*��\r�x���,�*�0��X�����bb,^d���_�}��w�^Q��~�����9�����j�V��-<#�Y�9�%Q\Z����ͺ1��kJL��l� �B3Bm���g�?E+�20`�~��J�\Z��ތ�i�(k�:]/�&��;�i���+�;|gd�N�����汐�,ؓ�k\06�$���xۉ����t\r.�_�����8�&��;4�\0o�7����{ 	j\"�\\��S{D�\n�~	\r@%�W���-9ꡣ���T�⢻EX)��rC�V�Pն�ypU=�����b[�������6g�����$NX>\rȷ��n�i�D_a�쯕!90+��[���x��/��Bb��@cEݘ8Xh�̆��GEw�P�!�UKG�ClA減���Ԫ�̖(8��l���T�j��.\n�o;6$�\02�)AR�W+��M���3^�����s<m����#Y\"\0Z�b���\"�*�+�FB����\n%�3{\0	�[�7��P�,�4��o����&�b��\"2ɦ�׊h���i�0��1�_<�4ڢ�1�+점�Z)��c��^����ټk���]$I7r1m�J��\\�ӌ�uC\re�J�(aN�:�mv�J(�t�9:��\\0 F��[�p媒5��Sy�I���\':�*whXc�a<_��^�`�*�7���#=&�~D)2w��\'qN�	�W��7F�`�>��}ǌCa�ťY�\Z�iګ�~�N�Əw�Pb��T����KӮ���1����DkE �ǀ�L�xsɢ�/�.��ѽ�����%�	���P`h%���I�X8Yp���1i���@J��d��6����A=¶<l����*L��,�Ec����E9,�O�3V�P����,�Z�����皋%��<��E�\0�YD����vV��_�g��^�FS�SxBY��m��Oٲ�����5�r����$��9o�Kn�͏����fwsg��R��c~(�<�/{��moL>�)���*36[Z�ZgK�o?��+����wy��0�u���&k���P͕\'�jt��v��\r���]h*�����V�Y�5G�t2u-�GL7��қ%T�B����EW��s�%�U<�v}z�%;xʝ3C��tg�\Z���������uՋ�AaG�Ь�	\"M�x�~GA�I�ud2���$.���~(� �/R�PR�9\ZnX�k6���ۍ�+4��x�&U��؆�k��X�t]�#n8܈\r��3�C��c�U���j�z�����j�SN܄�\n��v��\n�\\1~�ڥƸ�l���zk���Y����;`L�o�i����Տ�v�3�Xp��!��%ndmC����?�;+9S���C�����k�2�Z� �kAn�;:u�?e�+d���p�п��0�<\'�Dt$��i��9���	rxܲ(�g�M�x��j�����h���ϱP�2�׫9���jYmL��v�U����1�]�p�9�������5�@��*��Y322����07(U\r�Ȥ�cW�)-Q-�2����OU��]����\'�o��.D�˥�V_4��ǬU�\'����jP�Fk�	�2��uK~v~�`��\"�\nb�u�#I�]�ٍ_��\nȾ�q[#*`�\'bK�RR7��5�D��D%bkJ�F~��ʊֿ\ZLa�*岸E���v-�h����0p����7��]��O��0�^7Q��44���bY���2��L�S?ns��o���&ɳ���t�]i�f����sr�������7�\'�n�/U�l0f�T�J�_�Àڥ�]^QIX���w�+���\0i�\"A�A����2�4Q�&B��).���X�b�t3�Kb@␔5{�1w���VS&!S�9O�-pS��G�qè��*��ـT\n����9��&�:k�d\"�:s̖N1��#���8�,�;_\r�?����<8/�Zc6Jg�\Z����Àä���o���p܋UP u���J��}�5E�]��1WF���k+�)�n�h����w¼�1�+��:E�J1RZ,w���.�R��%O��u#6���梀�Q#g��s\0\Zi�����N���	:u#%�C�7��W#i�xXC�-nhQ�G�W�.у42��ӿ�Vq��U�.���9F\n��s�3��)yt���Me�d��>�$V�̫L���%�K9|�e��Ǒ;Z��eTY�Q9���lO|Q�vHK\\ӱ� u�DA\\�~G�+��Pv��m\\.�/NI*h��\"hl��Z\\_�ٞ# Ųd� W�8]��:�YP�lɎr�6�e	k��lY�簻��Ƚ�	�Ujط�y��V��Ԡ�ݔ���9���)e}$d5t��>TWI<�β���J/R�:��@�l\r���H�KN��a̒:�-�?�\'��	�X� ����8s}0TU�o���c�d\\������ۢ(=���˹y���#rL�K:]c���jT]c��Y�F��P@Tru�\rot����nx�ût��J��[�4yd�m�7(���jfS������K�u�j�eQb�N�޾��j�r��X��*���Yat ���J�r,!�� X�1�\\U�4�KZx.�Jr�u�.Q3��5��s���#�F���� ��E䰿��Zv�����0�X:�&ᯔ�hoL�����ޗ�@���Y�%1v�G�=�`�Z-�^uBA�feq\n�����19b6Wf#�8-օ��F&Ny�\Z���%��f	�&!0.�y�6=����;�ˬF%\r��e�.�Mƨ��k\n��\'E�Hv��?��?�w]���l(��5�������΋�H����2�]tɱ��+/o�xq�H77q;MV��Y.}���o�T�Q��˞�bCY\n�*��	�9�\Z��>-ُ�c01ϣ,�EmW��0HG���7K)�յG\'��P�+`3�z�W��L�%7V���۟��a�b���(���%$�9�3z,zn�ם��NP)��P�vj\Z��R�:}�[*�B0������ћ��7J�l�0�Ġ���-��k9�8y��u�1���|������C�i�m��F4���+�4���{��0��&ZV^,�p5U��)4s�7��?Q���S���0[�\0�\Za�[@]���z�Y������Ď�33jc6��Y��Y��\0U�r������Vq�����4�T��\"����-��G�\r�l�l�r^q/��R��V����7dV��;��T@.�Dl��FW)0ᢣ}C\'�]�!�ʆ�;��M`�����.���_*��4�!�e���쟠Z�!���h��L�͸7�)p�&t�C�R��у�Y!��H����)���9�\n>�h�j/\n�v�;oVLw�P�?ſ�^��\'p#B��V�ɟ���8{,�5yFU]��������`_}I��h�.l��`P�)��욅���M���[�i�$;�.ӈ.X?~솋@�mz�=q�F�(:��/��m+%�kB�B�O$9y����S��eq,���N���f?q�QA�C.�p�.K��\":��K6K�`l滙c?ة�cF7���.#څ<������&�8�Z�C�\\��+E����U�Ry~���Mй��JE!=�g&����O�a=��B��p ��:Ôe#��9!w��^v:e%Ql�,.X��$1n&*�m���m��V�C.K���;&5?��]���	�э�g�9���v�3��v�����9�i\0���ͺ0�e�v��NuGph�w�6���\rs}�8B�جd�����{Y�4�&�#^���So�ߧ�Xc��^�iˤ�x���^��y��0S�\n�)x����UQNp�3hCW��񗙢;�pu_���1���i���&��B��}V�E���.�`�#��7�SN0�zВ�L�{���i�~ʒ\r����x(6v:ly�o*}���ܬ��prfU	�\'˸�j�l��B���h�\n�N5��谲�&��؁�Û0B-�{O�\'�k�򦟢�\"e٬>O���<�[(�4K>U�K�>�\\�NN\'F���N����x}|�����r�@���԰}o�1L�u]�;-�D�	/�}��(�c���1M,$����ZU�E��Y�3;����t1 C\Z���ټ��4D��Rq(�\"���p�:��Z|�.\n�\'���H+wӤ���ŏ6����^��[/!�>i���v�\'��em�y6E#���zE:�-�ǵ���hs+j��Y*��E�-�i͈LOD�cm�A�����hӜ���yM=��`�kc�{}�F�c]]f��z4��\rǠ\Z��F�	q��F��D�׈��\'쮐\r�j�Л���\'�k�β=Q�?�HQ�<��԰/�s%H$��Pf�n�]�����%��#z���h)��^(^���/Z�kr2���e�JT�0Z-qSQ-�&���||�=3��{0�Σy4�=+��5����4��D�=���Iii\"������L.{E]~ӌ���>σ�צR!H�cw0�4	���+Sr�E��\0��W�ز��jr��`�w4<��3��yy{�\n�%DB����{�J3�V2[}?\n�>&\n�<�l�e�������\\���v���\r*�l-Q<pg	�D��3q��`PP�j�(z�D�JW{�z~��_pP�Y���6�z�Z�Ɲ����D�������%uT�\0�\Z��9}#�=���*�F����7���_�;o��6[��t�E�%F�.qJ�y��2��7��<?	���f�(�ͼc�})��C�CLe�E9���}�{x���2�Ş��;�!f��ATeJ�C�b����J��HG�Vf����$Dg�2�)��w��\r�5a��;3$��&c�ı\"\\%bR!c+J䁆�7<$I�\0�-�7�w6ļ!1�&�YXJ���R�~��X�u���	�1 � B^AzًV6nՇ���(�g�M^_E!��O�oOd�\'֮,d\'�<���xj̇j���/\n53�\\^����d�Z�ES�a�I-���馷��v��.�L	QW���1c�H�D׵7MY\ZΊ��~�f��ʄ ��L��d�g,�r�$�o�#<7��x�1՚����i���Pd�O��4y�w���a���#�G̒�Na:�%-��ʡB�\r3\"��\"m���#��MseX	�]��D�\".�f	�w���z����q!FO���d<��hE+\\�}I(p\'X�Rk��Ds�ځRbRq�X[!���:\r�*ߒ��n\r���\05��jwQ���~1\ZJ��������I��BG����	�I[,�l.���n+�\r�����Ar��ݪuC���Q�\"q��\Z���~�ʙ\\=95ɉ��\'����_�a=�.9��{��މu\'�>}%)�%M@�0)	i��V\"�k��bk�&��h��S@I����WU�����!��Hz\r�U��gj���C٘�������PI�O�����vk�ql�$�<>6��5�-�0{��GN.G*)�~�m�9�C�.v͋5��&C�*��3Hb2�O�T;�*QM�Y!�U�\n��K\\���Z����{P�]���E]������sC�s9���W�X+++��=SU��04���?崊׫}���2�o|��@��D6�c}���n�������뫧]�)#�:�-���J1�Jώ�#�_{{�U�u*�yq�ܫ��;qPS��w&f5�2k=�G䛘�ї6�E��������M7������C@��43d\Z�\\kdℲs���on>� �M��c��H�K��[���ؔ۶��u:Z�cB��`�R/��S�1-|*Y�\0UJt�_���sW|.��%�ԯ~(����J��}�}�վ(Z�ϦjWF��\nr3��VI?@RGrL��=�t1�h�L2�X?)�ˮ;\r���^�1�<nkH�U�H��\Z_\\�K7�V��f7�����{�\0˱c\0)���\Z:�p�!�ȁ �*�G\r0:E�Ъ	t�hOK�M~T�R�������i؜T��}�=U��XҴ���вq�Mk֦F���#9^�\'^�A=���Bj8+2������,F��c�&�Z�-��WC���=y|��n �]���y\r+�R+�`�ƶ�q߻[o��w2Sԋ�;ќF��ƪa�]�h,�V����suԹ�H@g;�j*RMa�\r��;�z�T�\\���Iw{w�{�$����r����#�Vzk����ӫ�U?���鮳�e{	����KIS��o�q���G�.�U�hȸ]r���m��e�=`���x���b\Z,ő���h�9�g�A���֐�\'e��r��%abg���-+D�����p�\\dD�s֮���|LRr�T�]�Ju�QV��y��κE~ս,���	��_��dt��i4?<�\0���/���9U�/c��>�הQ�/�/�D�M?�C��\n������P���s�[KGS]I.?q��u8[��2Ǧrm���\'N�`O�h7�:N�}*чB��G���yM\0\'{պϽ�V�:3�f�Y�_6�߀�T�T��9W_�3\nUD�}�9*╏/�U1\naĻ�0�8>]�,�N4�`dA�l��<��Nz16>�y=j�q���q��a�F\ZX��\0�~o��K�!S*�8��C_���ѓL�td�wH��PIU�	VI���骢�?r6\r�.���>Eb�����kD�+�o�|P-���\ZHߜ45�$g\rK.�r��I�_eMH�*�Q��}i1� ��T�Sxe6^�F\rn��$x%\\��FP\"��5x��4L?��uÄa+:a�C0n�f-G���T��Q��LBL�QF4,���y6b?�~��<Sh�\'R�[J<�Vis�)L���(2Rd��	-4vw1*��<]�}��l\r2�z9��.�*y��F�ԣ*g6o<A�S�v�Ζ����j�8{��4�<�����#x�W��iʾ\r�>�B@��S�[���&ը���jo(o\'2�Mk�/p���z��|����#��`.1�X|���i�\\�!6U��:����\\�k_���ZjIW 6%OjY�ʔگ��	���d��iʑ<O]�JtD ��:��;2��;�!t�2X�jP����&�]Xͱ�I��(=k�E�[��!c5�\r��o�&���#(E�V)�3�>���*��j,�{gW�:l�Z5�:nA�f!�\\&/�I��%@)�l��GX�i\ZL��n��C*�b����A,��Ydt�(3���\'���X/z�d�B����a]8v����D�S��l� �ӻ���\n(u�%�-�����̲P+d�+/Ɂ&&�*�54�H�/ߨq?��+q�h?>sL��dڎ]�k\\�㣝F��a,����׍G皶�T��go^t�026�LD�`���]S/?��0��[ʄ_��~��(���#О¢����V��UF8R�SfQ��߇!?G�Uj�\r2[�ځ[�\Z�<��#�tsQ�9\r���$;+<ݒ�4;k�^�@��漧���-��\r\'D��S��տ��n��i�o\r��?�m2����+w��Z��w�x1Q��&��ة�������jQ-x�_\'#@5���]y�Pŗ���\r1��C��<:3��C�QB���h�\Z���Qo�\"(p&c��,/�s�?c���س��?ޝ�h,/?v;��\0�K�2bӌ��/��ző�]�dM�,#7w�u�����sfGU��po����A�W�9���L�ϕ����+�����d�Ⱦ�,܃�b�Ċn5�3�O�bS���R���$�I�����J�{)\n��5g���v�FQ���N��o��J�7�O���&\Z����di��ѕ���i�����Q�l�����&ddF�J=޴.�W���D���Ց����\\�j��p�kIS�±>��ƴW%6_�j$�<g����\Zr��Vѿ�`���������A���vD	=s�;�Z|ג3(v!���b&�Q���ހ��T	��J�������&��s�v�1\'CS����:`��@�}S�´��-�䉂�3u�/A,��,}�)O�Xv`��\\{Lw������x�\r���?��_�����U���ߏ�Uv;6�l�zr�X��g���\'������.��Ӻ4Q����k�I8~�0���\Z�)��2�d%��{�n�$o\r�Nx�߷+n�}gvMrl�M�n9�]g=aF�v�?�v�H�T+���B 1s|��\'�E�I�HxZ�2��w�˝g̈́������Us�<�3$X�9�ᎤO\'�ُ���1��M	�I9��ƲY+��N�Y0va\Z~�����\Z�B��ɺ�����G��.?�<Gf���Y�Og�mog�9���1al��@�+�\"	�\Z����Zs뛨�R������:}�W�j0B�� �,e^磴Z.U�\r��#���$ޡ�ۀ�I�T��UUX\'TC�Ym�I�-�e���髪�GEzZ5�ah���H�@5ȟ��T�b�9�\n����;8��K���&�_�4p���=��\Z�bY�fs+y�y��P��\\#m����)�	f�G��f�����OH5��[�t�\ZF1$,���D �^79LA�y��$T�ƟC�GI/d��:�g�S�Z�Ha]*n�q�m)�8&�~Fw(P�+�+����)B�\'��^2�[���&1�W�Oyr\'\"�u�G\n�\Z�pH-�����*1n��D��5��ڊ���PO\'����,�G���&g��2�b\\߉���{H���\r����l���P�@�SP�?����P�9d�ϳy����ycVi�o�kiN-�xOS,�x���ΧhYs�܇j�揀��?d ku�BO�9�,��5��&Ƶ�	�q��@�pB�Շjm�JT(z�qg����b\';3�ա�ӵ�`�w<�|������\Z�܁�7	�Aeٝ�{��k�(�/$C|�qz\0��sz����|ޠ�k��\"�������X�>fǇ�B�eu�z��)���L;_w4+>��ɾ\Z��4�%��a�ub�ˁ�a1;4#jL9���y�u��I)��m�+�aP4�*#�Y��b�$�Ԉg��c�W��U���,��q�:k�������W��J��Wû҄����N>�$�EK���W��R�!�Mw�ܔĆĭHW4*�qN7v�e���<��Y���(�R\rST�H7q�oVmBf_�\Z\";�mv��z�G�0YTTM[a�.�VM�K����n�1���~��R\'[�Z?yvʛa	����MA3qK�C9坭��ֽ���jR���m}�&S6���:��-A6jъ$�|�!��,U\\Ƕ��t+�(��.`�Nq�ł�G�������,�G���뤥<B���n(�e8�X(\'J�8d���v��i�Q.MFєjLP�:cN:+ �$��-�uu�����D�N|��87����h�� H��~�R$RY�>1m4�3�\\�w�6�K3??B��/��`���Ig��@�b.�N<�윍�~H3><^�\ZZ���M�[N8����(���ţ���&�;�|�l2¿�P�T���E��]�����d���2�a<F����I6�f1����*�%q�c�	c��E:%Ou�*��v��*�JΤw��,\r��r.z0���A\'�5A�e��1��H}�&)��]�Je�\0-��m�\r�y���o�>�z�ɸ����9�vJ���`�,-VV܄x��C�F)�D9c%0�,�N!��\\/��T�r�Я�	��\'[8�TҰ/;��O����#>+\'�֙�#�C��R$�h4���U`R���m�z�0&��[u�W	��$��?H��Uo8>��P�����ow��b0}n\n0�ax#ߜ}�<}}��Kj�H�/Xy�B�.��ooU�7�@�iK��a��Xc]T��?r�ƻ o��<MQ��l����Rg�%&:O����\Z%��j:�N��Н���1yxW��p|�sS��~����B��\n51�^R���gՏ��n.����6<\rj�B%_�3�Ѥ�dh[!L�.,C���a8��@�9�Rx�%����Ꝡ������U�о�� U��Y�2�dz�\"U	\r��uL��kp�\\$���H��2�V�3�9�[�p�F����Xh�Y�z(*L��ĕ0��j<�};}��Mt3ޮ�}Y��Z�:G- ��>������2��u�ח�h�mC�W~5{��*co󶯉mK�sx�1�+�nӱv��&Pg��(�&c8_W]r�&�ĥ�.��\r���%͡���t�.���Gߨ������_����>���M������AQj�vq���tW�|z2(���_T�L\Z>p���k�߳��yЛ\"]��X|4���[��\\4��G���i��k�9k�8��x��w����䜙c1�U��-|>_��������C�GM�\\�0��Á������b���p�dO���iV������*w�����W��,�Y�t�)�	v��ɰZ�@�\0H���e&	F�`�7ŧb��b��z`\\V���׫R�\Z����~�:(%�n<�fw7�F8mH��kʯ*1����\\N����ڞvA�����m���{���y\0�4�H��8`^L^�b��t�Q\'ZbM���I��wW�ٰ@�3��S��8��\\dU%^�al��C�\"P���:���SU�	�U�����H���_�6�	\'&�چ*\'Q���������l}�,�x�[�+@4j�[�p$t������d���\'�a��q~\'n�V���j1w�X,�� _zW^��3+�8:LK+Q\'/$�K��yŲ��T��S��@�Oxc���B#�p�����6�?�H��Z-�i[Rͪ%�?���फ़�۸�� ަ�����\Z�:g�u�V���+��yVz?���c����3u-��g�\'��=)C�0f\Z�ݬ�����;��ن�O^���x QA�+�����]?�E䉃�(\Zj�GN�Zo�п�q�$6v�S`�\Z�q��hZ�a�J�&-�|�@�_eW����+^L�`-���mS�au:��Qi�j��s�IZ��5;Q�5:Ko�\n���U1cښ�~�`)�P��ﳹ�l��t[��W0�Em�[.2�싾��)+&zOs�KX���߀�\r�?R���dك4\\v�pcC5YQ+��(�w����Q��Ni&ѩ�i�Vʒ>\Z�Fy�\',�m�b�FZ�\'K]�?�g����U:��v\r֭��tu!e�s���ZTi�(ɩ�.�SVI����T��!���*���V\\������A.%jS\\�\\��H�J�r��YنJ�[%%`��1��M��yC	V�C	�Y\'�.{�,��Y�7f�^Q�E��\r�����*:��g�����Z]CRUj]�D�a�=���T��ព��HYҿ��N��N�_lY����-��_h��3��)x�����BxN����x���:�A�V��l%\nW�j���n�xY�P�9n��t]zC��\Zj�;07����T�վb�bu�s׏k�9\\)O�f�wj�5��g��wY#S�^��N�Hx�L_F�X�l�57�@���>@{�3�V����r�����Ic�=�T�U86�^D�.V�����e�mOWK�k���W5א��kp[�p�<��h���Mc@�:EӠo���ǰ|\\u匽�����9�r���N��^��B�}�7�X1�\nN>�����\n�֯���:n>*z�p�&yHF�������{�D|���P����f�c4̸h4�2�#Dp-��?�:��(*\rF��jg!�#���)P�\n�ݎ����s�:���AA�I�)?mf�ջZ���������eu�*\'~W-��48W��c��,2%�V��;;�c��*=���f*!�L��5����չ���ņ��̭���&�V9�3G���,��m����c���x�T]A�/�����fIH��e����$�g�V�H(L9SdLya;!OyM��Lvq�g����fu�,8E�P�eA�P����}���_W/ﷲ�q��[���{�.iY�����zO7��	�:�dP����!ۃ�V���bb��=��>/��R�zN������G���u��5s�#wQn:Ƒ�~�;a�\r4{O��x��g5hp�l���ըC�US0q&�Jh\"v�D���բ&E.\0�SG7��V��\"1��n�!�-[�af���X�٢���c���dC�RA�Ç%A�����X\'�D��z�F��1��	%TV<���!�C��Ȫ>r�Pel���F��9+J�#���ld3����B6�Up`f&{y�!D]G\"�&�H;>\Z��	���}UBcl���w�#X�����b��f�TS��&�<,Z�.��}c	��������k�j���\'гa{�~[L�8m�Uк�	N!�I�QfO�2��+���3 \0���8~9�\'A&I ��g�7�\n�<���[���˷�tg�#2f7�\0��>����<M}�n�������[�Z�<�EqV27�`��EvJ��ѽy7����oY	+7��g_0�}��*�:N�1Y�=f��|�~��W��d��5DJ=�RaǑ��1&����|��=lx!�b^b�ޑ��	��L�i�:�Z$�{�է�.���Ǿ�0g��|U摡ώ���t��Y���ڙ�L`؛����5\\,5a���-\'�%��ˮm�yp����7������A����8���q|^!\'~������@����z��ȁG����Z�/\Z\n�ZXؑ��г��j��Ʒ����Z� �@�]��)�\\gWy�Pn�%H�@A��gn{b�.X����Ƈ1�]�h��`�H6GaB܏�l�Z�t�:]\n��޵�i$G#��^�Ӎ�@\07s\\��!��8�爚3F���G���}p�H���ƑE��U��0����K������a3s4qR�Ֆ|\Z�J��y��x\r,8Q��R�t�}P��A��/3����\"�4�^�/�G�\nLEM۠(R���Cr�z\r)�\r�x�܆^����a\nf�x��ʸd%��\"���<���0�TsM���A�_����lR��G]\Z�]�\'�HZ`s\"��-Ż�h�q8\"�!�j��#\rپ�lfMK�����4��;�p�m�����E�Ԕ����f&��k��\"M��v�\"���2?d(LC�ƚ2���q����ir��C;�a�׭M�vrh�V\Z�h��lB��Hl\nD����׸Ȅ� ��EoT\roT��؍�����.���&\\��~:�mO�N�X��0E/0���.�\"��?�Ef{F�V\"\\\r.\Z㪑�墟Î%���J��\"��P$?�T��=��\0բ�]\'!���b��2�����;_������%\"*.���n_K�P[���l��,��z�u�;�:���Xmk�	|�<eJ�T\'�8�ưi��68u�6襀�{�����B�Px��\r��D���E�/��H+Q^TS,Q�@awYb�C��U}	�0��_j��=����/���!�a�c���6��l��9�\Z�(�O�����<��C��v�Y��d|��Ÿ�9�+[��C+;hƧa�[�D��\\�*(�J\'8bq�v�����+�sJ�R��4!�.�@X�L�9\rz��\nt�o��\r;kص�3���r�tG5��/���rF1l̈��- V��]rp��,��ʢ��\'.��|^�\n�y�`�����U!��//KCŗ��.O����U���Q��m�)�;\r�=���!�$�˗��π97�,���*%�p�C���2�T�J���~�l�Y��6Q{�������j�)ն��I+�|>�O�9�JpAhl(��~�������ݨ�����9瘂�1�Ġ5����6[��0a��Ṇ�i�(�En\n;�}���ɻ��ɿ&/�I�<Q���`M�g����L$���Ƒ��*<o:�2WU_�suI\Z�}��VU�i1�<����]Y�x�1��٬\ZH�߅���m@��ҝ������>^k�ն��!M�w̆j֒l����͘G��D��Yro�m����\n�`c�wk��?ptq�nF�\0!��M���_\\M��U�/��_����t�����jwTĨ��J�^^}���ԉ�����F�)�0����|zUl�K2�]X�`{��H�5.n����\"���?�k(Ă��ʽ�F��������C����sX���tM�u\"��!�h���U(�Q�D�o���?�ɥ����\'e8���l�h�����3�w��\n���X\n~ s�Uv����=͈F/��v�Ijz�~3,i�4�r����Pf�q����\r�R���4��ηn[|P��}�?R���:?���������� >���G��l����*f$�2�\ZQ��v�e����%�R|��pW�#���-{�#\raB���O�\"�1�\r�vB�-��}��;R���cJ�7-;�C�g6O�e���]�XH���{��@�)�D�5p@�t�����Vv��}䲕�\"u�&�h-�,�hSw}ar�-VYʇ:˚�r�kQ�OУc����NΙ����q5��R�/F��r8un��:�����{7F\r\Z�7\n�M\Z�,KS+\'����B�\Z����G���|9�f�[^�VmX>�0}��b�ٸ0E��7˦h\n�Jv�<|�H�l�o��)�Q��Ֆ�w��dUKy�5.�/�5��Z	�c��t�,�\'���%�Z\\�Ӂ���)����l�4��`��5�.�<�v�`�$&2��0�W���&\ncftQ�N�Vbxxu��bl�+��l��\\�k���q];�Q��$�%���X�i��� ����;T헻SeA��-&�2D��%&��`��Ly�0z�5t]tv���Ă/��¬F�d�@���.���c��-�ܤ,\ZtԷ(Wp/�\n�;���j`\0�0,�c!��U�z,\n��ps�E�+���C�d�Њ^�.jH��Rպ�㵡c�:kt�ȦI�C?L�/A}��m.��㪯�)�;�	�;��ӌ;ݶ�a��\r�{Z@d�]�L����hP0c&�W9���	�zk[�>�/���ݐ$8Mܶ�v��=���$d��ˌA��uܪ	p-����J��<->}�:8ĸ5��F«�k��1u��uE(㋮�*\"!JG�\n|N̽j:�m��R���WN�g\rS,D��}�;\Z�a.�e|)���7�H�=����¯�1����a�D\ZM��>�?�Z!U�Q�I�@B\Z�:f��\Z����U�V�~��','2007-03-11 09:50:46');
INSERT INTO objectcache VALUES ('wdr1_jargon:messages-status','+�2�R��OL��KW�\0','2007-03-10 09:51:45');
INSERT INTO objectcache VALUES ('wdr1_jargon:pcache:idhash:1-0!1!0!0!!en!2','�UmO�0��_�Z���y)�2\'�4!�&��4�}���M.���D�CA�����t�Tm�����s�9g�ц�\Zں3Mg���jv�hu׆F\Z%�{��M�E���2���KAJ��@ݥ)h�wR����RB���<���>4�Q�t\'\r1%�����|JKc\Z���-����-|��o�;\"�W����t\"JRɵ��(��Kb�߀a$�ڂ�RU絔��&V=��)c�\'$�[��7�V���pAYl���,x��g�jŕ�W�!�)���2�e�\rkEQ���m!�PBn�As���&O�/T��*�k�)���PϸP�O��׼j\"���֑{^y��t��cT����0ƲǢ�2�ؓ6П���t�x��V����5��Q�\rAb����I,E�G���W���d�W�Ȇa���Z�ڙ^맕�%�[�~dF�fD\n�R��Ā���w�w���lѽE���`Ņ�\Z+���mx�����!W��T��!{!�?�Ap\rĢ���*��������|�W�qB��#)O���\\�\rYdm8[�\rk����V��a��~���#�U�QU�M\\5d�`/�7����I�-�}܌�\\�۩P��F���u!ꎸ��n<TL��V�T���\"�ќ1p���:_�x��J����.��m��{]C\\؂�w6\n�ml�n�t�P5�>�[�+ꡭ\r�xU�\rξ{A�+�Yv�^��`��?a;��\nd��I vrV\'�!۱g�&��~�[����o','2007-03-11 09:50:46');

--
-- Table structure for table `oldimage`
--

DROP TABLE IF EXISTS oldimage;
CREATE TABLE oldimage (
  oi_name varchar(255) binary NOT NULL default '',
  oi_archive_name varchar(255) binary NOT NULL default '',
  oi_size int(8) unsigned NOT NULL default '0',
  oi_width int(5) NOT NULL default '0',
  oi_height int(5) NOT NULL default '0',
  oi_bits int(3) NOT NULL default '0',
  oi_description tinyblob NOT NULL,
  oi_user int(5) unsigned NOT NULL default '0',
  oi_user_text varchar(255) binary NOT NULL default '',
  oi_timestamp varchar(14) binary NOT NULL default '',
  KEY oi_name (oi_name(10))
) TYPE=InnoDB;

--
-- Dumping data for table `oldimage`
--


--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS page;
CREATE TABLE page (
  page_id int(8) unsigned NOT NULL auto_increment,
  page_namespace int(11) NOT NULL default '0',
  page_title varchar(255) binary NOT NULL default '',
  page_restrictions tinyblob NOT NULL,
  page_counter bigint(20) unsigned NOT NULL default '0',
  page_is_redirect tinyint(1) unsigned NOT NULL default '0',
  page_is_new tinyint(1) unsigned NOT NULL default '0',
  page_random double unsigned NOT NULL default '0',
  page_touched varchar(14) binary NOT NULL default '',
  page_latest int(8) unsigned NOT NULL default '0',
  page_len int(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (page_id),
  UNIQUE KEY name_title (page_namespace,page_title),
  KEY page_random (page_random),
  KEY page_len (page_len)
) TYPE=InnoDB;

--
-- Dumping data for table `page`
--

INSERT INTO page VALUES (1,0,'Main_Page','',1,0,0,0.182135895099,'20070310095006',1,455);
INSERT INTO page VALUES (2,8,'1movedto2','sysop',0,0,0,0.20295996833,'20070310095006',2,22);
INSERT INTO page VALUES (3,8,'1movedto2_redir','sysop',0,0,0,0.930023572931,'20070310095006',3,36);
INSERT INTO page VALUES (4,8,'Monobook.css','sysop',0,0,0,0.49626798357,'20070310095006',4,71);
INSERT INTO page VALUES (5,8,'Monobook.js','sysop',0,0,0,0.6896589263,'20070310095006',5,3353);
INSERT INTO page VALUES (6,8,'About','sysop',0,0,0,0.825751382203,'20070310095006',6,5);
INSERT INTO page VALUES (7,8,'Aboutpage','sysop',0,0,0,0.733333256432,'20070310095006',7,13);
INSERT INTO page VALUES (8,8,'Aboutsite','sysop',0,0,0,0.401327177541,'20070310095006',8,18);
INSERT INTO page VALUES (9,8,'Accesskey-compareselectedversions','sysop',0,0,0,0.516685055019,'20070310095006',9,1);
INSERT INTO page VALUES (10,8,'Accesskey-diff','sysop',0,0,0,0.505628884772,'20070310095006',10,1);
INSERT INTO page VALUES (11,8,'Accesskey-minoredit','sysop',0,0,0,0.849742031574,'20070310095006',11,1);
INSERT INTO page VALUES (12,8,'Accesskey-preview','sysop',0,0,0,0.076621242905,'20070310095006',12,1);
INSERT INTO page VALUES (13,8,'Accesskey-save','sysop',0,0,0,0.223460833018,'20070310095006',13,1);
INSERT INTO page VALUES (14,8,'Accesskey-search','sysop',0,0,0,0.879170639244,'20070310095006',14,1);
INSERT INTO page VALUES (15,8,'Accmailtext','sysop',0,0,0,0.751722294082,'20070310095006',15,42);
INSERT INTO page VALUES (16,8,'Accmailtitle','sysop',0,0,0,0.657313851138,'20070310095006',16,14);
INSERT INTO page VALUES (17,8,'Acct_creation_throttle_hit','sysop',0,0,0,0.345664760974,'20070310095006',17,69);
INSERT INTO page VALUES (18,8,'Actioncomplete','sysop',0,0,0,0.41997556665,'20070310095006',18,15);
INSERT INTO page VALUES (19,8,'Addedwatch','sysop',0,0,0,0.519617485732,'20070310095006',19,18);
INSERT INTO page VALUES (20,8,'Addedwatchtext','sysop',0,0,0,0.381067116052,'20070310095006',20,372);
INSERT INTO page VALUES (21,8,'Addgroup','sysop',0,0,0,0.398627502182,'20070310095006',21,9);
INSERT INTO page VALUES (22,8,'Addgrouplogentry','sysop',0,0,0,0.735697703789,'20070310095006',22,14);
INSERT INTO page VALUES (23,8,'Addsection','sysop',0,0,0,0.159974078868,'20070310095006',23,1);
INSERT INTO page VALUES (24,8,'Administrators','sysop',0,0,0,0.86213241588,'20070310095006',24,22);
INSERT INTO page VALUES (25,8,'Allarticles','sysop',0,0,0,0.957618286002,'20070310095006',25,12);
INSERT INTO page VALUES (26,8,'Allinnamespace','sysop',0,0,0,0.28847075677,'20070310095006',26,24);
INSERT INTO page VALUES (27,8,'Alllogstext','sysop',0,0,0,0.787782316404,'20070310095006',27,166);
INSERT INTO page VALUES (28,8,'Allmessages','sysop',0,0,0,0.039826799849,'20070310095006',28,15);
INSERT INTO page VALUES (29,8,'Allmessagescurrent','sysop',0,0,0,0.120291679513,'20070310095006',29,12);
INSERT INTO page VALUES (30,8,'Allmessagesdefault','sysop',0,0,0,0.309413261192,'20070310095006',30,12);
INSERT INTO page VALUES (31,8,'Allmessagesfilter','sysop',0,0,0,0.724466485289,'20070310095006',31,20);
INSERT INTO page VALUES (32,8,'Allmessagesmodified','sysop',0,0,0,0.726691097304,'20070310095006',32,18);
INSERT INTO page VALUES (33,8,'Allmessagesname','sysop',0,0,0,0.942649303201,'20070310095006',33,4);
INSERT INTO page VALUES (34,8,'AllmessagesnotsupportedDB','sysop',0,0,0,0.405534364982,'20070310095006',34,72);
INSERT INTO page VALUES (35,8,'AllmessagesnotsupportedUI','sysop',0,0,0,0.366110222491,'20070310095006',35,95);
INSERT INTO page VALUES (36,8,'Allmessagestext','sysop',0,0,0,0.648272122395,'20070310095006',36,72);
INSERT INTO page VALUES (37,8,'Allnonarticles','sysop',0,0,0,0.907607506216,'20070310095006',37,16);
INSERT INTO page VALUES (38,8,'Allnotinnamespace','sysop',0,0,0,0.629119474411,'20070310095006',38,31);
INSERT INTO page VALUES (39,8,'Allowemail','sysop',0,0,0,0.343531419075,'20070310095006',39,30);
INSERT INTO page VALUES (40,8,'Allpages','sysop',0,0,0,0.871950554975,'20070310095006',40,9);
INSERT INTO page VALUES (41,8,'Allpagesfrom','sysop',0,0,0,0.464853818299,'20070310095006',41,26);
INSERT INTO page VALUES (42,8,'Allpagesnext','sysop',0,0,0,0.920371963797,'20070310095006',42,4);
INSERT INTO page VALUES (43,8,'Allpagesprefix','sysop',0,0,0,0.254812416692,'20070310095006',43,26);
INSERT INTO page VALUES (44,8,'Allpagesprev','sysop',0,0,0,0.585256185103,'20070310095006',44,8);
INSERT INTO page VALUES (45,8,'Allpagessubmit','sysop',0,0,0,0.562082296253,'20070310095006',45,2);
INSERT INTO page VALUES (46,8,'Alphaindexline','sysop',0,0,0,0.300593728945,'20070310095006',46,8);
INSERT INTO page VALUES (47,8,'Already_bureaucrat','sysop',0,0,0,0.551852463104,'20070310095006',47,33);
INSERT INTO page VALUES (48,8,'Already_steward','sysop',0,0,0,0.92801523359,'20070310095006',48,30);
INSERT INTO page VALUES (49,8,'Already_sysop','sysop',0,0,0,0.116981292736,'20070310095006',49,37);
INSERT INTO page VALUES (50,8,'Alreadyloggedin','sysop',0,0,0,0.864583605953,'20070310095006',50,58);
INSERT INTO page VALUES (51,8,'Alreadyrolled','sysop',0,0,0,0.87267227415,'20070310095006',51,193);
INSERT INTO page VALUES (52,8,'Ancientpages','sysop',0,0,0,0.236606229769,'20070310095006',52,12);
INSERT INTO page VALUES (53,8,'And','sysop',0,0,0,0.470802566237,'20070310095006',53,3);
INSERT INTO page VALUES (54,8,'Anoneditwarning','sysop',0,0,0,0.47148318862,'20070310095006',54,84);
INSERT INTO page VALUES (55,8,'Anonnotice','sysop',0,0,0,0.680672255603,'20070310095006',55,1);
INSERT INTO page VALUES (56,8,'Anontalk','sysop',0,0,0,0.032497339399,'20070310095006',56,16);
INSERT INTO page VALUES (57,8,'Anontalkpagetext','sysop',0,0,0,0.236096854619,'20070310095006',57,443);
INSERT INTO page VALUES (58,8,'Anonymous','sysop',0,0,0,0.969448209574,'20070310095006',58,33);
INSERT INTO page VALUES (59,8,'Apr','sysop',0,0,0,0.981476354641,'20070310095006',59,3);
INSERT INTO page VALUES (60,8,'April','sysop',0,0,0,0.148318952347,'20070310095006',60,5);
INSERT INTO page VALUES (61,8,'Article','sysop',0,0,0,0.861909524522,'20070310095006',61,12);
INSERT INTO page VALUES (62,8,'Articleexists','sysop',0,0,0,0.696725468539,'20070310095006',62,105);
INSERT INTO page VALUES (63,8,'Articlepage','sysop',0,0,0,0.046285453068,'20070310095006',63,17);
INSERT INTO page VALUES (64,8,'Articletitles','sysop',0,0,0,0.889463655292,'20070310095006',64,29);
INSERT INTO page VALUES (65,8,'Aug','sysop',0,0,0,0.805083460096,'20070310095006',65,3);
INSERT INTO page VALUES (66,8,'August','sysop',0,0,0,0.316846380452,'20070310095006',66,6);
INSERT INTO page VALUES (67,8,'Autoblocker','sysop',0,0,0,0.224446572643,'20070310095006',67,126);
INSERT INTO page VALUES (68,8,'Badaccess','sysop',0,0,0,0.422366556008,'20070310095006',68,16);
INSERT INTO page VALUES (69,8,'Badaccesstext','sysop',0,0,0,0.113120145761,'20070310095006',69,92);
INSERT INTO page VALUES (70,8,'Badarticleerror','sysop',0,0,0,0.824495735127,'20070310095006',70,45);
INSERT INTO page VALUES (71,8,'Badfilename','sysop',0,0,0,0.410582112784,'20070310095006',71,35);
INSERT INTO page VALUES (72,8,'Badfiletype','sysop',0,0,0,0.459797906639,'20070310095007',72,45);
INSERT INTO page VALUES (73,8,'Badipaddress','sysop',0,0,0,0.691917081469,'20070310095007',73,18);
INSERT INTO page VALUES (74,8,'Badquery','sysop',0,0,0,0.055896304534,'20070310095007',74,25);
INSERT INTO page VALUES (75,8,'Badquerytext','sysop',0,0,0,0.226035742755,'20070310095007',75,273);
INSERT INTO page VALUES (76,8,'Badretype','sysop',0,0,0,0.263664862328,'20070310095007',76,39);
INSERT INTO page VALUES (77,8,'Badsig','sysop',0,0,0,0.695762799182,'20070310095007',77,39);
INSERT INTO page VALUES (78,8,'Badtitle','sysop',0,0,0,0.862239266989,'20070310095007',78,9);
INSERT INTO page VALUES (79,8,'Badtitletext','sysop',0,0,0,0.326167713428,'20070310095007',79,172);
INSERT INTO page VALUES (80,8,'Blanknamespace','sysop',0,0,0,0.858220689538,'20070310095007',80,6);
INSERT INTO page VALUES (81,8,'Blockedtext','sysop',0,0,0,0.494492165782,'20070310095007',81,430);
INSERT INTO page VALUES (82,8,'Blockedtitle','sysop',0,0,0,0.193969570986,'20070310095007',82,15);
INSERT INTO page VALUES (83,8,'Blockip','sysop',0,0,0,0.80427411348,'20070310095007',83,10);
INSERT INTO page VALUES (84,8,'Blockipsuccesssub','sysop',0,0,0,0.014003222891,'20070310095007',84,15);
INSERT INTO page VALUES (85,8,'Blockipsuccesstext','sysop',0,0,0,0.927018106314,'20070310095007',85,129);
INSERT INTO page VALUES (86,8,'Blockiptext','sysop',0,0,0,0.62677415796,'20070310095007',86,275);
INSERT INTO page VALUES (87,8,'Blocklink','sysop',0,0,0,0.126089181189,'20070310095007',87,5);
INSERT INTO page VALUES (88,8,'Blocklistline','sysop',0,0,0,0.114632515935,'20070310095007',88,22);
INSERT INTO page VALUES (89,8,'Blocklogentry','sysop',0,0,0,0.005375347994,'20070310095007',89,42);
INSERT INTO page VALUES (90,8,'Blocklogpage','sysop',0,0,0,0.480075657306,'20070310095007',90,9);
INSERT INTO page VALUES (91,8,'Blocklogtext','sysop',0,0,0,0.765824970095,'20070310095007',91,206);
INSERT INTO page VALUES (92,8,'Bold_sample','sysop',0,0,0,0.014966790786,'20070310095007',92,9);
INSERT INTO page VALUES (93,8,'Bold_tip','sysop',0,0,0,0.495791720576,'20070310095007',93,9);
INSERT INTO page VALUES (94,8,'Booksources','sysop',0,0,0,0.96422176253,'20070310095007',94,12);
INSERT INTO page VALUES (95,8,'Booksourcetext','sysop',0,0,0,0.356642137921,'20070310095007',95,140);
INSERT INTO page VALUES (96,8,'Brokenredirects','sysop',0,0,0,0.760169376294,'20070310095007',96,16);
INSERT INTO page VALUES (97,8,'Brokenredirectstext','sysop',0,0,0,0.161055368602,'20070310095007',97,51);
INSERT INTO page VALUES (98,8,'Bugreports','sysop',0,0,0,0.117395869998,'20070310095007',98,11);
INSERT INTO page VALUES (99,8,'Bugreportspage','sysop',0,0,0,0.692030380709,'20070310095007',99,19);
INSERT INTO page VALUES (100,8,'Bureaucratlog','sysop',0,0,0,0.097745089949,'20070310095007',100,14);
INSERT INTO page VALUES (101,8,'Bureaucratlogentry','sysop',0,0,0,0.178889760296,'20070310095007',101,45);
INSERT INTO page VALUES (102,8,'Bydate','sysop',0,0,0,0.908854478614,'20070310095007',102,7);
INSERT INTO page VALUES (103,8,'Byname','sysop',0,0,0,0.152939813529,'20070310095007',103,7);
INSERT INTO page VALUES (104,8,'Bysize','sysop',0,0,0,0.528836469818,'20070310095007',104,7);
INSERT INTO page VALUES (105,8,'Cachederror','sysop',0,0,0,0.151972383449,'20070310095007',105,80);
INSERT INTO page VALUES (106,8,'Cancel','sysop',0,0,0,0.161957141553,'20070310095007',106,6);
INSERT INTO page VALUES (107,8,'Cannotdelete','sysop',0,0,0,0.673299078943,'20070310095007',107,96);
INSERT INTO page VALUES (108,8,'Cantrollback','sysop',0,0,0,0.578013236072,'20070310095007',108,65);
INSERT INTO page VALUES (109,8,'Categories','sysop',0,0,0,0.740688285614,'20070310095007',109,10);
INSERT INTO page VALUES (110,8,'Categories1','sysop',0,0,0,0.64906253288,'20070310095007',110,8);
INSERT INTO page VALUES (111,8,'Categoriespagetext','sysop',0,0,0,0.476176396081,'20070310095007',111,43);
INSERT INTO page VALUES (112,8,'Category','sysop',0,0,0,0.226570667753,'20070310095007',112,8);
INSERT INTO page VALUES (113,8,'Category_header','sysop',0,0,0,0.975159029537,'20070310095007',113,25);
INSERT INTO page VALUES (114,8,'Categoryarticlecount','sysop',0,0,0,0.507299290022,'20070310095007',114,39);
INSERT INTO page VALUES (115,8,'Categoryarticlecount1','sysop',0,0,0,0.999832915036,'20070310095007',115,37);
INSERT INTO page VALUES (116,8,'Catseparator','sysop',0,0,0,0.151024992162,'20070310095007',116,1);
INSERT INTO page VALUES (117,8,'Changed','sysop',0,0,0,0.845142355946,'20070310095007',117,7);
INSERT INTO page VALUES (118,8,'Changegrouplogentry','sysop',0,0,0,0.096054967332,'20070310095007',118,16);
INSERT INTO page VALUES (119,8,'Changepassword','sysop',0,0,0,0.886340181738,'20070310095007',119,15);
INSERT INTO page VALUES (120,8,'Changes','sysop',0,0,0,0.82838743915,'20070310095007',120,7);
INSERT INTO page VALUES (121,8,'Clearyourcache','sysop',0,0,0,0.308724605127,'20070310095007',121,463);
INSERT INTO page VALUES (122,8,'Columns','sysop',0,0,0,0.968169705722,'20070310095007',122,8);
INSERT INTO page VALUES (123,8,'Compareselectedversions','sysop',0,0,0,0.306722829276,'20070310095007',123,25);
INSERT INTO page VALUES (124,8,'Confirm','sysop',0,0,0,0.177482583624,'20070310095007',124,7);
INSERT INTO page VALUES (125,8,'Confirm_purge','sysop',0,0,0,0.131360777952,'20070310095007',125,33);
INSERT INTO page VALUES (126,8,'Confirm_purge_button','sysop',0,0,0,0.686217572222,'20070310095007',126,2);
INSERT INTO page VALUES (127,8,'Confirmdelete','sysop',0,0,0,0.239495307816,'20070310095007',127,14);
INSERT INTO page VALUES (128,8,'Confirmdeletetext','sysop',0,0,0,0.885087063191,'20070310095007',128,248);
INSERT INTO page VALUES (129,8,'Confirmedittext','sysop',0,0,0,0.62360326308,'20070310095007',129,157);
INSERT INTO page VALUES (130,8,'Confirmedittitle','sysop',0,0,0,0.910998390805,'20070310095007',130,36);
INSERT INTO page VALUES (131,8,'Confirmemail','sysop',0,0,0,0.16400895859,'20070310095007',131,22);
INSERT INTO page VALUES (132,8,'Confirmemail_body','sysop',0,0,0,0.079916747125,'20070310095007',132,340);
INSERT INTO page VALUES (133,8,'Confirmemail_error','sysop',0,0,0,0.354551229018,'20070310095007',133,46);
INSERT INTO page VALUES (134,8,'Confirmemail_invalid','sysop',0,0,0,0.101709523531,'20070310095007',134,53);
INSERT INTO page VALUES (135,8,'Confirmemail_loggedin','sysop',0,0,0,0.823453510381,'20070310095007',135,43);
INSERT INTO page VALUES (136,8,'Confirmemail_send','sysop',0,0,0,0.739815033862,'20070310095007',136,24);
INSERT INTO page VALUES (137,8,'Confirmemail_sendfailed','sysop',0,0,0,0.100808676931,'20070310095007',137,71);
INSERT INTO page VALUES (138,8,'Confirmemail_sent','sysop',0,0,0,0.851434745266,'20070310095007',138,25);
INSERT INTO page VALUES (139,8,'Confirmemail_subject','sysop',0,0,0,0.995147992773,'20070310095007',139,40);
INSERT INTO page VALUES (140,8,'Confirmemail_success','sysop',0,0,0,0.641605873509,'20070310095007',140,78);
INSERT INTO page VALUES (141,8,'Confirmemail_text','sysop',0,0,0,0.430842738131,'20070310095007',141,281);
INSERT INTO page VALUES (142,8,'Confirmprotect','sysop',0,0,0,0.437190449262,'20070310095007',142,18);
INSERT INTO page VALUES (143,8,'Confirmprotecttext','sysop',0,0,0,0.054789551315,'20070310095007',143,40);
INSERT INTO page VALUES (144,8,'Confirmrecreate','sysop',0,0,0,0.797359477519,'20070310095007',144,170);
INSERT INTO page VALUES (145,8,'Confirmunprotect','sysop',0,0,0,0.250478935731,'20070310095007',145,20);
INSERT INTO page VALUES (146,8,'Confirmunprotecttext','sysop',0,0,0,0.245418962408,'20070310095007',146,42);
INSERT INTO page VALUES (147,8,'Contextchars','sysop',0,0,0,0.996463280074,'20070310095007',147,17);
INSERT INTO page VALUES (148,8,'Contextlines','sysop',0,0,0,0.205350900594,'20070310095007',148,14);
INSERT INTO page VALUES (149,8,'Contribs-showhideminor','sysop',0,0,0,0.586756610934,'20070310095007',149,14);
INSERT INTO page VALUES (150,8,'Contribslink','sysop',0,0,0,0.855851968595,'20070310095007',150,8);
INSERT INTO page VALUES (151,8,'Contribsub','sysop',0,0,0,0.895171255979,'20070310095007',151,6);
INSERT INTO page VALUES (152,8,'Contributions','sysop',0,0,0,0.788789843426,'20070310095007',152,18);
INSERT INTO page VALUES (153,8,'Copyright','sysop',0,0,0,0.933870247792,'20070310095007',153,30);
INSERT INTO page VALUES (154,8,'Copyrightpage','sysop',0,0,0,0.801324332436,'20070310095007',154,18);
INSERT INTO page VALUES (155,8,'Copyrightpagename','sysop',0,0,0,0.374592287976,'20070310095007',155,22);
INSERT INTO page VALUES (156,8,'Copyrightwarning','sysop',0,0,0,0.149732298238,'20070310095007',156,415);
INSERT INTO page VALUES (157,8,'Copyrightwarning2','sysop',0,0,0,0.768993948397,'20070310095007',157,403);
INSERT INTO page VALUES (158,8,'Couldntremove','sysop',0,0,0,0.175761722239,'20070310095007',158,28);
INSERT INTO page VALUES (159,8,'Createaccount','sysop',0,0,0,0.073702497508,'20070310095007',159,14);
INSERT INTO page VALUES (160,8,'Createaccountmail','sysop',0,0,0,0.142275207028,'20070310095007',160,9);
INSERT INTO page VALUES (161,8,'Createarticle','sysop',0,0,0,0.842807802957,'20070310095007',161,14);
INSERT INTO page VALUES (162,8,'Created','sysop',0,0,0,0.565315258056,'20070310095007',162,7);
INSERT INTO page VALUES (163,8,'Creditspage','sysop',0,0,0,0.174159944688,'20070310095007',163,12);
INSERT INTO page VALUES (164,8,'Cur','sysop',0,0,0,0.316116135953,'20070310095007',164,3);
INSERT INTO page VALUES (165,8,'Currentevents','sysop',0,0,0,0.85709945987,'20070310095007',165,14);
INSERT INTO page VALUES (166,8,'Currentevents-url','sysop',0,0,0,0.309314695518,'20070310095007',166,14);
INSERT INTO page VALUES (167,8,'Currentrev','sysop',0,0,0,0.375891909271,'20070310095007',167,16);
INSERT INTO page VALUES (168,8,'Currentrevisionlink','sysop',0,0,0,0.895254265426,'20070310095007',168,21);
INSERT INTO page VALUES (169,8,'Data','sysop',0,0,0,0.296198826132,'20070310095007',169,4);
INSERT INTO page VALUES (170,8,'Databaseerror','sysop',0,0,0,0.573378534713,'20070310095007',170,14);
INSERT INTO page VALUES (171,8,'Datedefault','sysop',0,0,0,0.598900866004,'20070310095007',171,13);
INSERT INTO page VALUES (172,8,'Dateformat','sysop',0,0,0,0.978342876032,'20070310095007',172,11);
INSERT INTO page VALUES (173,8,'Datetime','sysop',0,0,0,0.396410999959,'20070310095007',173,13);
INSERT INTO page VALUES (174,8,'Dberrortext','sysop',0,0,0,0.684113932545,'20070310095007',174,236);
INSERT INTO page VALUES (175,8,'Dberrortextcl','sysop',0,0,0,0.774828212543,'20070310095007',175,144);
INSERT INTO page VALUES (176,8,'Deadendpages','sysop',0,0,0,0.052760719594,'20070310095007',176,14);
INSERT INTO page VALUES (177,8,'Debug','sysop',0,0,0,0.997586776748,'20070310095007',177,5);
INSERT INTO page VALUES (178,8,'Dec','sysop',0,0,0,0.678047958341,'20070310095007',178,3);
INSERT INTO page VALUES (179,8,'December','sysop',0,0,0,0.855528223108,'20070310095007',179,8);
INSERT INTO page VALUES (180,8,'Default','sysop',0,0,0,0.159736639143,'20070310095007',180,7);
INSERT INTO page VALUES (181,8,'Defaultns','sysop',0,0,0,0.699651751531,'20070310095007',181,38);
INSERT INTO page VALUES (182,8,'Defemailsubject','sysop',0,0,0,0.192516679791,'20070310095007',182,19);
INSERT INTO page VALUES (183,8,'Delete','sysop',0,0,0,0.145096336226,'20070310095007',183,6);
INSERT INTO page VALUES (184,8,'Delete_and_move','sysop',0,0,0,0.70162213505,'20070310095007',184,15);
INSERT INTO page VALUES (185,8,'Delete_and_move_confirm','sysop',0,0,0,0.815775273471,'20070310095007',185,20);
INSERT INTO page VALUES (186,8,'Delete_and_move_reason','sysop',0,0,0,0.597886523506,'20070310095007',186,28);
INSERT INTO page VALUES (187,8,'Delete_and_move_text','sysop',0,0,0,0.369348951625,'20070310095007',187,122);
INSERT INTO page VALUES (188,8,'Deletecomment','sysop',0,0,0,0.458477649651,'20070310095007',188,19);
INSERT INTO page VALUES (189,8,'Deletedarticle','sysop',0,0,0,0.52131048764,'20070310095007',189,16);
INSERT INTO page VALUES (190,8,'Deletedrev','sysop',0,0,0,0.228910212016,'20070310095007',190,9);
INSERT INTO page VALUES (191,8,'Deletedrevision','sysop',0,0,0,0.413160803744,'20070310095007',191,24);
INSERT INTO page VALUES (192,8,'Deletedtext','sysop',0,0,0,0.466639209941,'20070310095007',192,63);
INSERT INTO page VALUES (193,8,'Deletedwhileediting','sysop',0,0,0,0.12097374996,'20070310095007',193,62);
INSERT INTO page VALUES (194,8,'Deleteimg','sysop',0,0,0,0.424350126528,'20070310095007',194,3);
INSERT INTO page VALUES (195,8,'Deleteimgcompletely','sysop',0,0,0,0.839202843096,'20070310095007',195,33);
INSERT INTO page VALUES (196,8,'Deletepage','sysop',0,0,0,0.556170714835,'20070310095007',196,11);
INSERT INTO page VALUES (197,8,'Deletesub','sysop',0,0,0,0.917781569943,'20070310095007',197,15);
INSERT INTO page VALUES (198,8,'Deletethispage','sysop',0,0,0,0.294598851215,'20070310095007',198,16);
INSERT INTO page VALUES (199,8,'Deletionlog','sysop',0,0,0,0.461598491053,'20070310095007',199,12);
INSERT INTO page VALUES (200,8,'Dellogpage','sysop',0,0,0,0.209124729621,'20070310095007',200,12);
INSERT INTO page VALUES (201,8,'Dellogpagetext','sysop',0,0,0,0.411650991099,'20070310095007',201,45);
INSERT INTO page VALUES (202,8,'Destfilename','sysop',0,0,0,0.711145837899,'20070310095007',202,20);
INSERT INTO page VALUES (203,8,'Developertext','sysop',0,0,0,0.79235483987,'20070310095007',203,97);
INSERT INTO page VALUES (204,8,'Developertitle','sysop',0,0,0,0.416779648242,'20070310095007',204,25);
INSERT INTO page VALUES (205,8,'Diff','sysop',0,0,0,0.578514363464,'20070310095007',205,4);
INSERT INTO page VALUES (206,8,'Difference','sysop',0,0,0,0.78197329479,'20070310095007',206,30);
INSERT INTO page VALUES (207,8,'Disambiguations','sysop',0,0,0,0.390800514861,'20070310095007',207,20);
INSERT INTO page VALUES (208,8,'Disambiguationspage','sysop',0,0,0,0.297612546919,'20070310095007',208,17);
INSERT INTO page VALUES (209,8,'Disambiguationstext','sysop',0,0,0,0.232533331311,'20070310095007',209,235);
INSERT INTO page VALUES (210,8,'Disclaimerpage','sysop',0,0,0,0.597298531229,'20070310095007',210,26);
INSERT INTO page VALUES (211,8,'Disclaimers','sysop',0,0,0,0.258548863708,'20070310095007',211,11);
INSERT INTO page VALUES (212,8,'Doubleredirects','sysop',0,0,0,0.419022285546,'20070310095007',212,16);
INSERT INTO page VALUES (213,8,'Doubleredirectstext','sysop',0,0,0,0.835434267447,'20070310095007',213,193);
INSERT INTO page VALUES (214,8,'Download','sysop',0,0,0,0.946386650659,'20070310095007',214,8);
INSERT INTO page VALUES (215,8,'Eauthentsent','sysop',0,0,0,0.547198561013,'20070310095007',215,217);
INSERT INTO page VALUES (216,8,'Edit','sysop',0,0,0,0.550304002939,'20070310095007',216,4);
INSERT INTO page VALUES (217,8,'Edit-externally','sysop',0,0,0,0.127920006439,'20070310095007',217,44);
INSERT INTO page VALUES (218,8,'Edit-externally-help','sysop',0,0,0,0.259915263579,'20070310095007',218,103);
INSERT INTO page VALUES (219,8,'Editcomment','sysop',0,0,0,0.072902853643,'20070310095007',219,34);
INSERT INTO page VALUES (220,8,'Editconflict','sysop',0,0,0,0.139482864819,'20070310095007',220,17);
INSERT INTO page VALUES (221,8,'Editcurrent','sysop',0,0,0,0.12034671707,'20070310095007',221,37);
INSERT INTO page VALUES (222,8,'Editgroup','sysop',0,0,0,0.427966844834,'20070310095007',222,10);
INSERT INTO page VALUES (223,8,'Edithelp','sysop',0,0,0,0.114450358545,'20070310095007',223,12);
INSERT INTO page VALUES (224,8,'Edithelppage','sysop',0,0,0,0.856644621866,'20070310095007',224,12);
INSERT INTO page VALUES (225,8,'Editing','sysop',0,0,0,0.277778675369,'20070310095007',225,10);
INSERT INTO page VALUES (226,8,'Editingcomment','sysop',0,0,0,0.3477862104,'20070310095007',226,20);
INSERT INTO page VALUES (227,8,'Editingold','sysop',0,0,0,0.168143501796,'20070310095007',227,146);
INSERT INTO page VALUES (228,8,'Editingsection','sysop',0,0,0,0.434667075445,'20070310095007',228,20);
INSERT INTO page VALUES (229,8,'Editsection','sysop',0,0,0,0.883617140027,'20070310095007',229,4);
INSERT INTO page VALUES (230,8,'Editsectionhint','sysop',0,0,0,0.994857937206,'20070310095007',230,16);
INSERT INTO page VALUES (231,8,'Editthispage','sysop',0,0,0,0.132876221278,'20070310095007',231,14);
INSERT INTO page VALUES (232,8,'Edittools','sysop',0,0,0,0.124004595736,'20070310095007',232,61);
INSERT INTO page VALUES (233,8,'Editusergroup','sysop',0,0,0,0.856969734962,'20070310095007',233,16);
INSERT INTO page VALUES (234,8,'Email','sysop',0,0,0,0.566864688033,'20070310095007',234,6);
INSERT INTO page VALUES (235,8,'Emailauthenticated','sysop',0,0,0,0.279307836306,'20070310095007',235,44);
INSERT INTO page VALUES (236,8,'Emailconfirmlink','sysop',0,0,0,0.423437594329,'20070310095007',236,27);
INSERT INTO page VALUES (237,8,'Emailforlost','sysop',0,0,0,0.161231891705,'20070310095007',237,252);
INSERT INTO page VALUES (238,8,'Emailfrom','sysop',0,0,0,0.242476637608,'20070310095007',238,4);
INSERT INTO page VALUES (239,8,'Emailmessage','sysop',0,0,0,0.945875048107,'20070310095007',239,7);
INSERT INTO page VALUES (240,8,'Emailnotauthenticated','sysop',0,0,0,0.118809000559,'20070310095007',240,120);
INSERT INTO page VALUES (241,8,'Emailpage','sysop',0,0,0,0.69309024301,'20070310095007',241,11);
INSERT INTO page VALUES (242,8,'Emailpagetext','sysop',0,0,0,0.597347718106,'20070310095007',242,265);
INSERT INTO page VALUES (243,8,'Emailsend','sysop',0,0,0,0.903793578881,'20070310095007',243,4);
INSERT INTO page VALUES (244,8,'Emailsent','sysop',0,0,0,0.368368506089,'20070310095007',244,11);
INSERT INTO page VALUES (245,8,'Emailsenttext','sysop',0,0,0,0.283748482936,'20070310095007',245,34);
INSERT INTO page VALUES (246,8,'Emailsubject','sysop',0,0,0,0.451327714566,'20070310095007',246,7);
INSERT INTO page VALUES (247,8,'Emailto','sysop',0,0,0,0.098610478213,'20070310095007',247,2);
INSERT INTO page VALUES (248,8,'Emailuser','sysop',0,0,0,0.032873358048,'20070310095007',248,16);
INSERT INTO page VALUES (249,8,'Emptyfile','sysop',0,0,0,0.748086859721,'20070310095007',249,144);
INSERT INTO page VALUES (250,8,'Enotif_body','sysop',0,0,0,0.035279848332,'20070310095007',250,692);
INSERT INTO page VALUES (251,8,'Enotif_lastvisited','sysop',0,0,0,0.301781145932,'20070310095007',251,45);
INSERT INTO page VALUES (252,8,'Enotif_mailer','sysop',0,0,0,0.411580653854,'20070310095007',252,32);
INSERT INTO page VALUES (253,8,'Enotif_newpagetext','sysop',0,0,0,0.659863160387,'20070310095007',253,19);
INSERT INTO page VALUES (254,8,'Enotif_reset','sysop',0,0,0,0.503003791892,'20070310095007',254,22);
INSERT INTO page VALUES (255,8,'Enotif_subject','sysop',0,0,0,0.005838439835,'20070310095007',255,70);
INSERT INTO page VALUES (256,8,'Enterlockreason','sysop',0,0,0,0.562082300845,'20070310095007',256,84);
INSERT INTO page VALUES (257,8,'Error','sysop',0,0,0,0.207283835219,'20070310095007',257,5);
INSERT INTO page VALUES (258,8,'Errorpagetitle','sysop',0,0,0,0.183155828824,'20070310095007',258,5);
INSERT INTO page VALUES (259,8,'Exbeforeblank','sysop',0,0,0,0.946374479623,'20070310095007',259,33);
INSERT INTO page VALUES (260,8,'Exblank','sysop',0,0,0,0.592252020504,'20070310095007',260,14);
INSERT INTO page VALUES (261,8,'Excontent','sysop',0,0,0,0.984393474636,'20070310095007',261,17);
INSERT INTO page VALUES (262,8,'Excontentauthor','sysop',0,0,0,0.274104703428,'20070310095007',262,53);
INSERT INTO page VALUES (263,8,'Exif-aperturevalue','sysop',0,0,0,0.909343428123,'20070310095007',263,8);
INSERT INTO page VALUES (264,8,'Exif-artist','sysop',0,0,0,0.695395107549,'20070310095007',264,6);
INSERT INTO page VALUES (265,8,'Exif-bitspersample','sysop',0,0,0,0.861144232319,'20070310095007',265,18);
INSERT INTO page VALUES (266,8,'Exif-brightnessvalue','sysop',0,0,0,0.643111400983,'20070310095007',266,10);
INSERT INTO page VALUES (267,8,'Exif-cfapattern','sysop',0,0,0,0.236390690363,'20070310095007',267,11);
INSERT INTO page VALUES (268,8,'Exif-colorspace','sysop',0,0,0,0.350296283482,'20070310095007',268,11);
INSERT INTO page VALUES (269,8,'Exif-colorspace-1','sysop',0,0,0,0.783881426248,'20070310095007',269,4);
INSERT INTO page VALUES (270,8,'Exif-colorspace-ffff.h','sysop',0,0,0,0.524026477921,'20070310095007',270,6);
INSERT INTO page VALUES (271,8,'Exif-componentsconfiguration','sysop',0,0,0,0.032569411343,'20070310095007',271,25);
INSERT INTO page VALUES (272,8,'Exif-componentsconfiguration-0','sysop',0,0,0,0.069598495852,'20070310095007',272,14);
INSERT INTO page VALUES (273,8,'Exif-componentsconfiguration-1','sysop',0,0,0,0.937373475243,'20070310095007',273,1);
INSERT INTO page VALUES (274,8,'Exif-componentsconfiguration-2','sysop',0,0,0,0.679886196531,'20070310095007',274,2);
INSERT INTO page VALUES (275,8,'Exif-componentsconfiguration-3','sysop',0,0,0,0.963146940884,'20070310095007',275,2);
INSERT INTO page VALUES (276,8,'Exif-componentsconfiguration-4','sysop',0,0,0,0.100726035438,'20070310095007',276,1);
INSERT INTO page VALUES (277,8,'Exif-componentsconfiguration-5','sysop',0,0,0,0.793309920805,'20070310095007',277,1);
INSERT INTO page VALUES (278,8,'Exif-componentsconfiguration-6','sysop',0,0,0,0.694951414247,'20070310095007',278,1);
INSERT INTO page VALUES (279,8,'Exif-compressedbitsperpixel','sysop',0,0,0,0.087695268476,'20070310095007',279,22);
INSERT INTO page VALUES (280,8,'Exif-compression','sysop',0,0,0,0.418060727303,'20070310095007',280,18);
INSERT INTO page VALUES (281,8,'Exif-compression-1','sysop',0,0,0,0.021085918618,'20070310095007',281,12);
INSERT INTO page VALUES (282,8,'Exif-compression-6','sysop',0,0,0,0.174862684534,'20070310095007',282,4);
INSERT INTO page VALUES (283,8,'Exif-contrast','sysop',0,0,0,0.448390798646,'20070310095007',283,8);
INSERT INTO page VALUES (284,8,'Exif-contrast-0','sysop',0,0,0,0.148194750069,'20070310095007',284,6);
INSERT INTO page VALUES (285,8,'Exif-contrast-1','sysop',0,0,0,0.408283123243,'20070310095007',285,4);
INSERT INTO page VALUES (286,8,'Exif-contrast-2','sysop',0,0,0,0.476620962788,'20070310095007',286,4);
INSERT INTO page VALUES (287,8,'Exif-copyright','sysop',0,0,0,0.691637934232,'20070310095007',287,16);
INSERT INTO page VALUES (288,8,'Exif-customrendered','sysop',0,0,0,0.742379217637,'20070310095007',288,23);
INSERT INTO page VALUES (289,8,'Exif-customrendered-0','sysop',0,0,0,0.718281660059,'20070310095007',289,14);
INSERT INTO page VALUES (290,8,'Exif-customrendered-1','sysop',0,0,0,0.59486151421,'20070310095007',290,14);
INSERT INTO page VALUES (291,8,'Exif-datetime','sysop',0,0,0,0.999038440789,'20070310095007',291,25);
INSERT INTO page VALUES (292,8,'Exif-datetimedigitized','sysop',0,0,0,0.927969814947,'20070310095007',292,27);
INSERT INTO page VALUES (293,8,'Exif-datetimeoriginal','sysop',0,0,0,0.017945647585,'20070310095007',293,32);
INSERT INTO page VALUES (294,8,'Exif-devicesettingdescription','sysop',0,0,0,0.364843914126,'20070310095007',294,27);
INSERT INTO page VALUES (295,8,'Exif-digitalzoomratio','sysop',0,0,0,0.093885011408,'20070310095007',295,18);
INSERT INTO page VALUES (296,8,'Exif-exifversion','sysop',0,0,0,0.86782018016,'20070310095007',296,12);
INSERT INTO page VALUES (297,8,'Exif-exposurebiasvalue','sysop',0,0,0,0.827642367334,'20070310095007',297,13);
INSERT INTO page VALUES (298,8,'Exif-exposureindex','sysop',0,0,0,0.618459940336,'20070310095007',298,14);
INSERT INTO page VALUES (299,8,'Exif-exposuremode','sysop',0,0,0,0.042676743584,'20070310095007',299,13);
INSERT INTO page VALUES (300,8,'Exif-exposuremode-0','sysop',0,0,0,0.487527663265,'20070310095007',300,13);
INSERT INTO page VALUES (301,8,'Exif-exposuremode-1','sysop',0,0,0,0.663262982934,'20070310095007',301,15);
INSERT INTO page VALUES (302,8,'Exif-exposuremode-2','sysop',0,0,0,0.098668727215,'20070310095007',302,12);
INSERT INTO page VALUES (303,8,'Exif-exposureprogram','sysop',0,0,0,0.726502034842,'20070310095007',303,16);
INSERT INTO page VALUES (304,8,'Exif-exposureprogram-0','sysop',0,0,0,0.171501863309,'20070310095007',304,11);
INSERT INTO page VALUES (305,8,'Exif-exposureprogram-1','sysop',0,0,0,0.52143055593,'20070310095007',305,6);
INSERT INTO page VALUES (306,8,'Exif-exposureprogram-2','sysop',0,0,0,0.269641619565,'20070310095007',306,14);
INSERT INTO page VALUES (307,8,'Exif-exposureprogram-3','sysop',0,0,0,0.054215664091,'20070310095007',307,17);
INSERT INTO page VALUES (308,8,'Exif-exposureprogram-4','sysop',0,0,0,0.936733669758,'20070310095007',308,16);
INSERT INTO page VALUES (309,8,'Exif-exposureprogram-5','sysop',0,0,0,0.089207074485,'20070310095007',309,47);
INSERT INTO page VALUES (310,8,'Exif-exposureprogram-6','sysop',0,0,0,0.056668851888,'20070310095007',310,49);
INSERT INTO page VALUES (311,8,'Exif-exposureprogram-7','sysop',0,0,0,0.853134117183,'20070310095007',311,67);
INSERT INTO page VALUES (312,8,'Exif-exposureprogram-8','sysop',0,0,0,0.770933057706,'20070310095007',312,66);
INSERT INTO page VALUES (313,8,'Exif-exposuretime','sysop',0,0,0,0.534510587576,'20070310095007',313,13);
INSERT INTO page VALUES (314,8,'Exif-exposuretime-format','sysop',0,0,0,0.420990299785,'20070310095007',314,11);
INSERT INTO page VALUES (315,8,'Exif-filesource','sysop',0,0,0,0.481564125485,'20070310095007',315,11);
INSERT INTO page VALUES (316,8,'Exif-filesource-3','sysop',0,0,0,0.660472506331,'20070310095007',316,3);
INSERT INTO page VALUES (317,8,'Exif-flash','sysop',0,0,0,0.663545374396,'20070310095007',317,5);
INSERT INTO page VALUES (318,8,'Exif-flashenergy','sysop',0,0,0,0.754433244192,'20070310095007',318,12);
INSERT INTO page VALUES (319,8,'Exif-flashpixversion','sysop',0,0,0,0.146791237933,'20070310095007',319,26);
INSERT INTO page VALUES (320,8,'Exif-fnumber','sysop',0,0,0,0.084808856471,'20070310095007',320,8);
INSERT INTO page VALUES (321,8,'Exif-fnumber-format','sysop',0,0,0,0.318718997265,'20070310095007',321,4);
INSERT INTO page VALUES (322,8,'Exif-focallength','sysop',0,0,0,0.633659986293,'20070310095007',322,17);
INSERT INTO page VALUES (323,8,'Exif-focallength-format','sysop',0,0,0,0.030689411489,'20070310095007',323,5);
INSERT INTO page VALUES (324,8,'Exif-focallengthin35mmfilm','sysop',0,0,0,0.309443291859,'20070310095007',324,26);
INSERT INTO page VALUES (325,8,'Exif-focalplaneresolutionunit','sysop',0,0,0,0.725620622394,'20070310095007',325,27);
INSERT INTO page VALUES (326,8,'Exif-focalplaneresolutionunit-2','sysop',0,0,0,0.309218741355,'20070310095007',326,6);
INSERT INTO page VALUES (327,8,'Exif-focalplanexresolution','sysop',0,0,0,0.476876981083,'20070310095007',327,24);
INSERT INTO page VALUES (328,8,'Exif-focalplaneyresolution','sysop',0,0,0,0.849242856934,'20070310095007',328,24);
INSERT INTO page VALUES (329,8,'Exif-gaincontrol','sysop',0,0,0,0.793457240009,'20070310095007',329,13);
INSERT INTO page VALUES (330,8,'Exif-gaincontrol-0','sysop',0,0,0,0.399693998776,'20070310095007',330,4);
INSERT INTO page VALUES (331,8,'Exif-gaincontrol-1','sysop',0,0,0,0.622665779685,'20070310095007',331,11);
INSERT INTO page VALUES (332,8,'Exif-gaincontrol-2','sysop',0,0,0,0.647142433174,'20070310095007',332,12);
INSERT INTO page VALUES (333,8,'Exif-gaincontrol-3','sysop',0,0,0,0.083356979279,'20070310095007',333,13);
INSERT INTO page VALUES (334,8,'Exif-gaincontrol-4','sysop',0,0,0,0.758214178417,'20070310095007',334,14);
INSERT INTO page VALUES (335,8,'Exif-gpsaltitude','sysop',0,0,0,0.857902728492,'20070310095007',335,8);
INSERT INTO page VALUES (336,8,'Exif-gpsaltituderef','sysop',0,0,0,0.222751264098,'20070310095007',336,18);
INSERT INTO page VALUES (337,8,'Exif-gpsareainformation','sysop',0,0,0,0.959970605924,'20070310095007',337,16);
INSERT INTO page VALUES (338,8,'Exif-gpsdatestamp','sysop',0,0,0,0.411124315585,'20070310095007',338,8);
INSERT INTO page VALUES (339,8,'Exif-gpsdestbearing','sysop',0,0,0,0.099079262015,'20070310095008',339,22);
INSERT INTO page VALUES (340,8,'Exif-gpsdestbearingref','sysop',0,0,0,0.461664356994,'20070310095008',340,36);
INSERT INTO page VALUES (341,8,'Exif-gpsdestdistance','sysop',0,0,0,0.539073869206,'20070310095008',341,23);
INSERT INTO page VALUES (342,8,'Exif-gpsdestdistanceref','sysop',0,0,0,0.900414375447,'20070310095008',342,37);
INSERT INTO page VALUES (343,8,'Exif-gpsdestlatitude','sysop',0,0,0,0.599304204718,'20070310095008',343,20);
INSERT INTO page VALUES (344,8,'Exif-gpsdestlatituderef','sysop',0,0,0,0.857966473586,'20070310095008',344,37);
INSERT INTO page VALUES (345,8,'Exif-gpsdestlongitude','sysop',0,0,0,0.973058865292,'20070310095008',345,24);
INSERT INTO page VALUES (346,8,'Exif-gpsdestlongituderef','sysop',0,0,0,0.430156662882,'20070310095008',346,38);
INSERT INTO page VALUES (347,8,'Exif-gpsdifferential','sysop',0,0,0,0.720587098226,'20070310095008',347,27);
INSERT INTO page VALUES (348,8,'Exif-gpsdirection-m','sysop',0,0,0,0.587212539521,'20070310095008',348,18);
INSERT INTO page VALUES (349,8,'Exif-gpsdirection-t','sysop',0,0,0,0.664833954122,'20070310095008',349,14);
INSERT INTO page VALUES (350,8,'Exif-gpsdop','sysop',0,0,0,0.982725978705,'20070310095008',350,21);
INSERT INTO page VALUES (351,8,'Exif-gpsimgdirection','sysop',0,0,0,0.049206563555,'20070310095008',351,18);
INSERT INTO page VALUES (352,8,'Exif-gpsimgdirectionref','sysop',0,0,0,0.045517774375,'20070310095008',352,32);
INSERT INTO page VALUES (353,8,'Exif-gpslatitude','sysop',0,0,0,0.203385180177,'20070310095008',353,8);
INSERT INTO page VALUES (354,8,'Exif-gpslatitude-n','sysop',0,0,0,0.348905750892,'20070310095008',354,14);
INSERT INTO page VALUES (355,8,'Exif-gpslatitude-s','sysop',0,0,0,0.537598883693,'20070310095008',355,14);
INSERT INTO page VALUES (356,8,'Exif-gpslatituderef','sysop',0,0,0,0.055722884948,'20070310095008',356,23);
INSERT INTO page VALUES (357,8,'Exif-gpslongitude','sysop',0,0,0,0.366876639255,'20070310095008',357,9);
INSERT INTO page VALUES (358,8,'Exif-gpslongitude-e','sysop',0,0,0,0.476370428656,'20070310095008',358,14);
INSERT INTO page VALUES (359,8,'Exif-gpslongitude-w','sysop',0,0,0,0.067652940438,'20070310095008',359,14);
INSERT INTO page VALUES (360,8,'Exif-gpslongituderef','sysop',0,0,0,0.41003922556,'20070310095008',360,22);
INSERT INTO page VALUES (361,8,'Exif-gpsmapdatum','sysop',0,0,0,0.483683847699,'20070310095008',361,25);
INSERT INTO page VALUES (362,8,'Exif-gpsmeasuremode','sysop',0,0,0,0.045986134561,'20070310095008',362,16);
INSERT INTO page VALUES (363,8,'Exif-gpsmeasuremode-2','sysop',0,0,0,0.52954260726,'20070310095008',363,25);
INSERT INTO page VALUES (364,8,'Exif-gpsmeasuremode-3','sysop',0,0,0,0.049947524353,'20070310095008',364,25);
INSERT INTO page VALUES (365,8,'Exif-gpsprocessingmethod','sysop',0,0,0,0.322236240412,'20070310095008',365,29);
INSERT INTO page VALUES (366,8,'Exif-gpssatellites','sysop',0,0,0,0.722702805528,'20070310095008',366,31);
INSERT INTO page VALUES (367,8,'Exif-gpsspeed','sysop',0,0,0,0.434738639591,'20070310095008',367,21);
INSERT INTO page VALUES (368,8,'Exif-gpsspeed-k','sysop',0,0,0,0.173062841486,'20070310095008',368,19);
INSERT INTO page VALUES (369,8,'Exif-gpsspeed-m','sysop',0,0,0,0.356556297359,'20070310095008',369,14);
INSERT INTO page VALUES (370,8,'Exif-gpsspeed-n','sysop',0,0,0,0.650804653215,'20070310095008',370,5);
INSERT INTO page VALUES (371,8,'Exif-gpsspeedref','sysop',0,0,0,0.487066648343,'20070310095008',371,10);
INSERT INTO page VALUES (372,8,'Exif-gpsstatus','sysop',0,0,0,0.181152437551,'20070310095008',372,15);
INSERT INTO page VALUES (373,8,'Exif-gpsstatus-a','sysop',0,0,0,0.404600542824,'20070310095008',373,23);
INSERT INTO page VALUES (374,8,'Exif-gpsstatus-v','sysop',0,0,0,0.857324597242,'20070310095008',374,28);
INSERT INTO page VALUES (375,8,'Exif-gpstimestamp','sysop',0,0,0,0.625752469698,'20070310095008',375,23);
INSERT INTO page VALUES (376,8,'Exif-gpstrack','sysop',0,0,0,0.715015519024,'20070310095008',376,21);
INSERT INTO page VALUES (377,8,'Exif-gpstrackref','sysop',0,0,0,0.465402358184,'20070310095008',377,35);
INSERT INTO page VALUES (378,8,'Exif-gpsversionid','sysop',0,0,0,0.600417449829,'20070310095008',378,15);
INSERT INTO page VALUES (379,8,'Exif-imagedescription','sysop',0,0,0,0.453073291603,'20070310095008',379,11);
INSERT INTO page VALUES (380,8,'Exif-imagelength','sysop',0,0,0,0.199650537783,'20070310095008',380,6);
INSERT INTO page VALUES (381,8,'Exif-imageuniqueid','sysop',0,0,0,0.652474008552,'20070310095008',381,15);
INSERT INTO page VALUES (382,8,'Exif-imagewidth','sysop',0,0,0,0.562766376824,'20070310095008',382,5);
INSERT INTO page VALUES (383,8,'Exif-isospeedratings','sysop',0,0,0,0.79888208685,'20070310095008',383,16);
INSERT INTO page VALUES (384,8,'Exif-jpeginterchangeformat','sysop',0,0,0,0.397636187563,'20070310095008',384,18);
INSERT INTO page VALUES (385,8,'Exif-jpeginterchangeformatlength','sysop',0,0,0,0.138794598252,'20070310095008',385,18);
INSERT INTO page VALUES (386,8,'Exif-lightsource','sysop',0,0,0,0.239942748331,'20070310095008',386,12);
INSERT INTO page VALUES (387,8,'Exif-lightsource-0','sysop',0,0,0,0.738858052739,'20070310095008',387,7);
INSERT INTO page VALUES (388,8,'Exif-lightsource-1','sysop',0,0,0,0.411645577399,'20070310095008',388,8);
INSERT INTO page VALUES (389,8,'Exif-lightsource-10','sysop',0,0,0,0.343348763068,'20070310095008',389,14);
INSERT INTO page VALUES (390,8,'Exif-lightsource-11','sysop',0,0,0,0.199161856817,'20070310095008',390,5);
INSERT INTO page VALUES (391,8,'Exif-lightsource-12','sysop',0,0,0,0.974857828968,'20070310095008',391,39);
INSERT INTO page VALUES (392,8,'Exif-lightsource-13','sysop',0,0,0,0.619975925409,'20070310095008',392,40);
INSERT INTO page VALUES (393,8,'Exif-lightsource-14','sysop',0,0,0,0.732620641209,'20070310095008',393,41);
INSERT INTO page VALUES (394,8,'Exif-lightsource-15','sysop',0,0,0,0.236989742325,'20070310095008',394,37);
INSERT INTO page VALUES (395,8,'Exif-lightsource-17','sysop',0,0,0,0.797708641821,'20070310095008',395,16);
INSERT INTO page VALUES (396,8,'Exif-lightsource-18','sysop',0,0,0,0.663187080415,'20070310095008',396,16);
INSERT INTO page VALUES (397,8,'Exif-lightsource-19','sysop',0,0,0,0.886183041756,'20070310095008',397,16);
INSERT INTO page VALUES (398,8,'Exif-lightsource-2','sysop',0,0,0,0.957823784958,'20070310095008',398,11);
INSERT INTO page VALUES (399,8,'Exif-lightsource-20','sysop',0,0,0,0.487092171779,'20070310095008',399,3);
INSERT INTO page VALUES (400,8,'Exif-lightsource-21','sysop',0,0,0,0.893017111492,'20070310095008',400,3);
INSERT INTO page VALUES (401,8,'Exif-lightsource-22','sysop',0,0,0,0.254095561412,'20070310095008',401,3);
INSERT INTO page VALUES (402,8,'Exif-lightsource-23','sysop',0,0,0,0.182407102921,'20070310095008',402,3);
INSERT INTO page VALUES (403,8,'Exif-lightsource-24','sysop',0,0,0,0.426447331222,'20070310095008',403,19);
INSERT INTO page VALUES (404,8,'Exif-lightsource-255','sysop',0,0,0,0.037398513323,'20070310095008',404,18);
INSERT INTO page VALUES (405,8,'Exif-lightsource-3','sysop',0,0,0,0.527527871936,'20070310095008',405,29);
INSERT INTO page VALUES (406,8,'Exif-lightsource-4','sysop',0,0,0,0.305134655365,'20070310095008',406,5);
INSERT INTO page VALUES (407,8,'Exif-lightsource-9','sysop',0,0,0,0.635362304913,'20070310095008',407,12);
INSERT INTO page VALUES (408,8,'Exif-make','sysop',0,0,0,0.37823666135,'20070310095008',408,19);
INSERT INTO page VALUES (409,8,'Exif-make-value','sysop',0,0,0,0.117728389002,'20070310095008',409,2);
INSERT INTO page VALUES (410,8,'Exif-makernote','sysop',0,0,0,0.773047251188,'20070310095008',410,18);
INSERT INTO page VALUES (411,8,'Exif-maxaperturevalue','sysop',0,0,0,0.881346897855,'20070310095008',411,21);
INSERT INTO page VALUES (412,8,'Exif-meteringmode','sysop',0,0,0,0.250673333679,'20070310095008',412,13);
INSERT INTO page VALUES (413,8,'Exif-meteringmode-0','sysop',0,0,0,0.427674637055,'20070310095008',413,7);
INSERT INTO page VALUES (414,8,'Exif-meteringmode-1','sysop',0,0,0,0.999731277207,'20070310095008',414,7);
INSERT INTO page VALUES (415,8,'Exif-meteringmode-2','sysop',0,0,0,0.198330854926,'20070310095008',415,21);
INSERT INTO page VALUES (416,8,'Exif-meteringmode-255','sysop',0,0,0,0.335319959265,'20070310095008',416,5);
INSERT INTO page VALUES (417,8,'Exif-meteringmode-3','sysop',0,0,0,0.803812696228,'20070310095008',417,4);
INSERT INTO page VALUES (418,8,'Exif-meteringmode-4','sysop',0,0,0,0.85881704785,'20070310095008',418,9);
INSERT INTO page VALUES (419,8,'Exif-meteringmode-5','sysop',0,0,0,0.302766964284,'20070310095008',419,7);
INSERT INTO page VALUES (420,8,'Exif-meteringmode-6','sysop',0,0,0,0.047038334643,'20070310095008',420,7);
INSERT INTO page VALUES (421,8,'Exif-model','sysop',0,0,0,0.726170307682,'20070310095008',421,12);
INSERT INTO page VALUES (422,8,'Exif-model-value','sysop',0,0,0,0.146751807256,'20070310095008',422,2);
INSERT INTO page VALUES (423,8,'Exif-oecf','sysop',0,0,0,0.982501655979,'20070310095008',423,32);
INSERT INTO page VALUES (424,8,'Exif-orientation','sysop',0,0,0,0.157043252298,'20070310095008',424,11);
INSERT INTO page VALUES (425,8,'Exif-orientation-1','sysop',0,0,0,0.609158747894,'20070310095008',425,6);
INSERT INTO page VALUES (426,8,'Exif-orientation-2','sysop',0,0,0,0.409269300458,'20070310095008',426,20);
INSERT INTO page VALUES (427,8,'Exif-orientation-3','sysop',0,0,0,0.909362994637,'20070310095008',427,13);
INSERT INTO page VALUES (428,8,'Exif-orientation-4','sysop',0,0,0,0.393556065821,'20070310095008',428,18);
INSERT INTO page VALUES (429,8,'Exif-orientation-5','sysop',0,0,0,0.506064807661,'20070310095008',429,39);
INSERT INTO page VALUES (430,8,'Exif-orientation-6','sysop',0,0,0,0.111291999604,'20070310095008',430,15);
INSERT INTO page VALUES (431,8,'Exif-orientation-7','sysop',0,0,0,0.679260992137,'20070310095008',431,38);
INSERT INTO page VALUES (432,8,'Exif-orientation-8','sysop',0,0,0,0.3251456113,'20070310095008',432,16);
INSERT INTO page VALUES (433,8,'Exif-photometricinterpretation','sysop',0,0,0,0.518816489798,'20070310095008',433,17);
INSERT INTO page VALUES (434,8,'Exif-photometricinterpretation-2','sysop',0,0,0,0.52670264328,'20070310095008',434,3);
INSERT INTO page VALUES (435,8,'Exif-photometricinterpretation-6','sysop',0,0,0,0.630057962022,'20070310095008',435,5);
INSERT INTO page VALUES (436,8,'Exif-pixelxdimension','sysop',0,0,0,0.1499739788,'20070310095008',436,19);
INSERT INTO page VALUES (437,8,'Exif-pixelydimension','sysop',0,0,0,0.263059241252,'20070310095008',437,17);
INSERT INTO page VALUES (438,8,'Exif-planarconfiguration','sysop',0,0,0,0.444808649324,'20070310095008',438,16);
INSERT INTO page VALUES (439,8,'Exif-planarconfiguration-1','sysop',0,0,0,0.097992537591,'20070310095008',439,13);
INSERT INTO page VALUES (440,8,'Exif-planarconfiguration-2','sysop',0,0,0,0.694793964683,'20070310095008',440,13);
INSERT INTO page VALUES (441,8,'Exif-primarychromaticities','sysop',0,0,0,0.881159320191,'20070310095008',441,29);
INSERT INTO page VALUES (442,8,'Exif-referenceblackwhite','sysop',0,0,0,0.554425528568,'20070310095008',442,40);
INSERT INTO page VALUES (443,8,'Exif-relatedsoundfile','sysop',0,0,0,0.200872834243,'20070310095008',443,18);
INSERT INTO page VALUES (444,8,'Exif-resolutionunit','sysop',0,0,0,0.725676731443,'20070310095008',444,26);
INSERT INTO page VALUES (445,8,'Exif-rowsperstrip','sysop',0,0,0,0.625685501142,'20070310095008',445,24);
INSERT INTO page VALUES (446,8,'Exif-samplesperpixel','sysop',0,0,0,0.130621216995,'20070310095008',446,20);
INSERT INTO page VALUES (447,8,'Exif-saturation','sysop',0,0,0,0.395129528783,'20070310095008',447,10);
INSERT INTO page VALUES (448,8,'Exif-saturation-0','sysop',0,0,0,0.051039083145,'20070310095008',448,6);
INSERT INTO page VALUES (449,8,'Exif-saturation-1','sysop',0,0,0,0.077993963246,'20070310095008',449,14);
INSERT INTO page VALUES (450,8,'Exif-saturation-2','sysop',0,0,0,0.059775979762,'20070310095008',450,15);
INSERT INTO page VALUES (451,8,'Exif-scenecapturetype','sysop',0,0,0,0.585590115042,'20070310095008',451,18);
INSERT INTO page VALUES (452,8,'Exif-scenecapturetype-0','sysop',0,0,0,0.557492128269,'20070310095008',452,8);
INSERT INTO page VALUES (453,8,'Exif-scenecapturetype-1','sysop',0,0,0,0.196500464454,'20070310095008',453,9);
INSERT INTO page VALUES (454,8,'Exif-scenecapturetype-2','sysop',0,0,0,0.262287779044,'20070310095008',454,8);
INSERT INTO page VALUES (455,8,'Exif-scenecapturetype-3','sysop',0,0,0,0.997720944114,'20070310095008',455,11);
INSERT INTO page VALUES (456,8,'Exif-scenetype','sysop',0,0,0,0.710458654765,'20070310095008',456,10);
INSERT INTO page VALUES (457,8,'Exif-scenetype-1','sysop',0,0,0,0.013799257044,'20070310095008',457,29);
INSERT INTO page VALUES (458,8,'Exif-sensingmethod','sysop',0,0,0,0.902958414909,'20070310095008',458,14);
INSERT INTO page VALUES (459,8,'Exif-sensingmethod-1','sysop',0,0,0,0.928796488284,'20070310095008',459,9);
INSERT INTO page VALUES (460,8,'Exif-sensingmethod-2','sysop',0,0,0,0.478436230415,'20070310095008',460,26);
INSERT INTO page VALUES (461,8,'Exif-sensingmethod-3','sysop',0,0,0,0.484163999303,'20070310095008',461,26);
INSERT INTO page VALUES (462,8,'Exif-sensingmethod-4','sysop',0,0,0,0.485201242802,'20070310095008',462,28);
INSERT INTO page VALUES (463,8,'Exif-sensingmethod-5','sysop',0,0,0,0.109163863539,'20070310095008',463,28);
INSERT INTO page VALUES (464,8,'Exif-sensingmethod-7','sysop',0,0,0,0.952700019294,'20070310095008',464,16);
INSERT INTO page VALUES (465,8,'Exif-sensingmethod-8','sysop',0,0,0,0.954906811495,'20070310095008',465,30);
INSERT INTO page VALUES (466,8,'Exif-sharpness','sysop',0,0,0,0.181132461113,'20070310095008',466,9);
INSERT INTO page VALUES (467,8,'Exif-sharpness-0','sysop',0,0,0,0.405553344307,'20070310095008',467,6);
INSERT INTO page VALUES (468,8,'Exif-sharpness-1','sysop',0,0,0,0.7675781383,'20070310095008',468,4);
INSERT INTO page VALUES (469,8,'Exif-sharpness-2','sysop',0,0,0,0.545534597768,'20070310095008',469,4);
INSERT INTO page VALUES (470,8,'Exif-shutterspeedvalue','sysop',0,0,0,0.773130948524,'20070310095008',470,13);
INSERT INTO page VALUES (471,8,'Exif-software','sysop',0,0,0,0.991560587347,'20070310095008',471,13);
INSERT INTO page VALUES (472,8,'Exif-software-value','sysop',0,0,0,0.713447608334,'20070310095008',472,2);
INSERT INTO page VALUES (473,8,'Exif-spatialfrequencyresponse','sysop',0,0,0,0.846431832142,'20070310095008',473,26);
INSERT INTO page VALUES (474,8,'Exif-spectralsensitivity','sysop',0,0,0,0.985654098256,'20070310095008',474,20);
INSERT INTO page VALUES (475,8,'Exif-stripbytecounts','sysop',0,0,0,0.614699926751,'20070310095008',475,26);
INSERT INTO page VALUES (476,8,'Exif-stripoffsets','sysop',0,0,0,0.651795869582,'20070310095008',476,19);
INSERT INTO page VALUES (477,8,'Exif-subjectarea','sysop',0,0,0,0.95035228156,'20070310095008',477,12);
INSERT INTO page VALUES (478,8,'Exif-subjectdistance','sysop',0,0,0,0.543068479407,'20070310095008',478,16);
INSERT INTO page VALUES (479,8,'Exif-subjectdistance-value','sysop',0,0,0,0.549576297214,'20070310095008',479,9);
INSERT INTO page VALUES (480,8,'Exif-subjectdistancerange','sysop',0,0,0,0.034134439683,'20070310095008',480,22);
INSERT INTO page VALUES (481,8,'Exif-subjectdistancerange-0','sysop',0,0,0,0.6651955002,'20070310095008',481,7);
INSERT INTO page VALUES (482,8,'Exif-subjectdistancerange-1','sysop',0,0,0,0.078966197642,'20070310095008',482,5);
INSERT INTO page VALUES (483,8,'Exif-subjectdistancerange-2','sysop',0,0,0,0.214483666138,'20070310095008',483,10);
INSERT INTO page VALUES (484,8,'Exif-subjectdistancerange-3','sysop',0,0,0,0.90095284442,'20070310095008',484,12);
INSERT INTO page VALUES (485,8,'Exif-subjectlocation','sysop',0,0,0,0.5145087714,'20070310095008',485,16);
INSERT INTO page VALUES (486,8,'Exif-subsectime','sysop',0,0,0,0.738113071678,'20070310095008',486,19);
INSERT INTO page VALUES (487,8,'Exif-subsectimedigitized','sysop',0,0,0,0.954278765216,'20070310095008',487,28);
INSERT INTO page VALUES (488,8,'Exif-subsectimeoriginal','sysop',0,0,0,0.968306245407,'20070310095008',488,27);
INSERT INTO page VALUES (489,8,'Exif-transferfunction','sysop',0,0,0,0.872744531714,'20070310095008',489,17);
INSERT INTO page VALUES (490,8,'Exif-usercomment','sysop',0,0,0,0.431855558072,'20070310095008',490,13);
INSERT INTO page VALUES (491,8,'Exif-whitebalance','sysop',0,0,0,0.104624369298,'20070310095008',491,13);
INSERT INTO page VALUES (492,8,'Exif-whitebalance-0','sysop',0,0,0,0.569256131242,'20070310095008',492,18);
INSERT INTO page VALUES (493,8,'Exif-whitebalance-1','sysop',0,0,0,0.92514902752,'20070310095008',493,20);
INSERT INTO page VALUES (494,8,'Exif-whitepoint','sysop',0,0,0,0.473394224854,'20070310095008',494,24);
INSERT INTO page VALUES (495,8,'Exif-xresolution','sysop',0,0,0,0.843850297614,'20070310095008',495,21);
INSERT INTO page VALUES (496,8,'Exif-xyresolution-c','sysop',0,0,0,0.181595660688,'20070310095008',496,6);
INSERT INTO page VALUES (497,8,'Exif-xyresolution-i','sysop',0,0,0,0.219563982072,'20070310095008',497,6);
INSERT INTO page VALUES (498,8,'Exif-ycbcrcoefficients','sysop',0,0,0,0.467303848307,'20070310095008',498,46);
INSERT INTO page VALUES (499,8,'Exif-ycbcrpositioning','sysop',0,0,0,0.963995283692,'20070310095008',499,19);
INSERT INTO page VALUES (500,8,'Exif-ycbcrsubsampling','sysop',0,0,0,0.600869410664,'20070310095008',500,27);
INSERT INTO page VALUES (501,8,'Exif-yresolution','sysop',0,0,0,0.135754090701,'20070310095008',501,19);
INSERT INTO page VALUES (502,8,'Expiringblock','sysop',0,0,0,0.533353123538,'20070310095008',502,10);
INSERT INTO page VALUES (503,8,'Explainconflict','sysop',0,0,0,0.664347269551,'20070310095008',503,330);
INSERT INTO page VALUES (504,8,'Export','sysop',0,0,0,0.985572854026,'20070310095008',504,12);
INSERT INTO page VALUES (505,8,'Exportcuronly','sysop',0,0,0,0.383426260399,'20070310095008',505,55);
INSERT INTO page VALUES (506,8,'Exportnohistory','sysop',0,0,0,0.490974334627,'20070310095008',506,116);
INSERT INTO page VALUES (507,8,'Exporttext','sysop',0,0,0,0.342589834924,'20070310095008',507,568);
INSERT INTO page VALUES (508,8,'Externaldberror','sysop',0,0,0,0.256194327001,'20070310095008',508,114);
INSERT INTO page VALUES (509,8,'Extlink_sample','sysop',0,0,0,0.43444697637,'20070310095008',509,33);
INSERT INTO page VALUES (510,8,'Extlink_tip','sysop',0,0,0,0.467181274164,'20070310095008',510,39);
INSERT INTO page VALUES (511,8,'Faq','sysop',0,0,0,0.743177868732,'20070310095008',511,3);
INSERT INTO page VALUES (512,8,'Faqpage','sysop',0,0,0,0.581241016443,'20070310095008',512,11);
INSERT INTO page VALUES (513,8,'Feb','sysop',0,0,0,0.762778864876,'20070310095008',513,3);
INSERT INTO page VALUES (514,8,'February','sysop',0,0,0,0.289843316223,'20070310095008',514,8);
INSERT INTO page VALUES (515,8,'Feedlinks','sysop',0,0,0,0.599537921389,'20070310095008',515,5);
INSERT INTO page VALUES (516,8,'Filecopyerror','sysop',0,0,0,0.367924317293,'20070310095008',516,33);
INSERT INTO page VALUES (517,8,'Filedeleteerror','sysop',0,0,0,0.426039987953,'20070310095008',517,27);
INSERT INTO page VALUES (518,8,'Filedesc','sysop',0,0,0,0.218108767848,'20070310095008',518,7);
INSERT INTO page VALUES (519,8,'Fileexists','sysop',0,0,0,0.065341725326,'20070310095008',519,99);
INSERT INTO page VALUES (520,8,'Fileexists-forbidden','sysop',0,0,0,0.77987843739,'20070310095008',520,120);
INSERT INTO page VALUES (521,8,'Fileexists-shared-forbidden','sysop',0,0,0,0.493463188416,'20070310095008',521,150);
INSERT INTO page VALUES (522,8,'Fileinfo','sysop',0,0,0,0.17677536092,'20070310095008',522,32);
INSERT INTO page VALUES (523,8,'Filemissing','sysop',0,0,0,0.564531829787,'20070310095008',523,12);
INSERT INTO page VALUES (524,8,'Filename','sysop',0,0,0,0.946425650197,'20070310095008',524,8);
INSERT INTO page VALUES (525,8,'Filenotfound','sysop',0,0,0,0.902359484066,'20070310095008',525,25);
INSERT INTO page VALUES (526,8,'Filerenameerror','sysop',0,0,0,0.112811654383,'20070310095008',526,35);
INSERT INTO page VALUES (527,8,'Files','sysop',0,0,0,0.267903635677,'20070310095008',527,5);
INSERT INTO page VALUES (528,8,'Filesource','sysop',0,0,0,0.66428229441,'20070310095008',528,6);
INSERT INTO page VALUES (529,8,'Filestatus','sysop',0,0,0,0.190551005555,'20070310095008',529,16);
INSERT INTO page VALUES (530,8,'Fileuploaded','sysop',0,0,0,0.276413914237,'20070310095008',530,331);
INSERT INTO page VALUES (531,8,'Fileuploadsummary','sysop',0,0,0,0.008882193434,'20070310095008',531,8);
INSERT INTO page VALUES (532,8,'Formerror','sysop',0,0,0,0.888125946929,'20070310095008',532,28);
INSERT INTO page VALUES (533,8,'Friday','sysop',0,0,0,0.642091300007,'20070310095008',533,6);
INSERT INTO page VALUES (534,8,'Getimagelist','sysop',0,0,0,0.760425538757,'20070310095008',534,18);
INSERT INTO page VALUES (535,8,'Go','sysop',0,0,0,0.452915777219,'20070310095008',535,2);
INSERT INTO page VALUES (536,8,'Googlesearch','sysop',0,0,0,0.770373673308,'20070310095008',536,660);
INSERT INTO page VALUES (537,8,'Gotaccount','sysop',0,0,0,0.5329930865,'20070310095008',537,27);
INSERT INTO page VALUES (538,8,'Gotaccountlink','sysop',0,0,0,0.630279532953,'20070310095008',538,6);
INSERT INTO page VALUES (539,8,'Group-admin-desc','sysop',0,0,0,0.838019174653,'20070310095008',539,53);
INSERT INTO page VALUES (540,8,'Group-admin-name','sysop',0,0,0,0.695501432962,'20070310095008',540,13);
INSERT INTO page VALUES (541,8,'Group-anon-desc','sysop',0,0,0,0.924192714738,'20070310095008',541,15);
INSERT INTO page VALUES (542,8,'Group-anon-name','sysop',0,0,0,0.766269398776,'20070310095008',542,9);
INSERT INTO page VALUES (543,8,'Group-bureaucrat-desc','sysop',0,0,0,0.921981164101,'20070310095008',543,43);
INSERT INTO page VALUES (544,8,'Group-bureaucrat-name','sysop',0,0,0,0.922686989802,'20070310095008',544,10);
INSERT INTO page VALUES (545,8,'Group-loggedin-desc','sysop',0,0,0,0.177134948659,'20070310095008',545,23);
INSERT INTO page VALUES (546,8,'Group-loggedin-name','sysop',0,0,0,0.293258816063,'20070310095008',546,4);
INSERT INTO page VALUES (547,8,'Group-steward-desc','sysop',0,0,0,0.493591486413,'20070310095008',547,11);
INSERT INTO page VALUES (548,8,'Group-steward-name','sysop',0,0,0,0.543287627082,'20070310095008',548,7);
INSERT INTO page VALUES (549,8,'Groups','sysop',0,0,0,0.134217138682,'20070310095008',549,11);
INSERT INTO page VALUES (550,8,'Groups-addgroup','sysop',0,0,0,0.189340719783,'20070310095008',550,9);
INSERT INTO page VALUES (551,8,'Groups-already-exists','sysop',0,0,0,0.066932925516,'20070310095008',551,35);
INSERT INTO page VALUES (552,8,'Groups-editgroup','sysop',0,0,0,0.706842037563,'20070310095008',552,10);
INSERT INTO page VALUES (553,8,'Groups-editgroup-description','sysop',0,0,0,0.852973632433,'20070310095008',553,45);
INSERT INTO page VALUES (554,8,'Groups-editgroup-name','sysop',0,0,0,0.113199623137,'20070310095008',554,11);
INSERT INTO page VALUES (555,8,'Groups-editgroup-preamble','sysop',0,0,0,0.549356801746,'20070310095008',555,163);
INSERT INTO page VALUES (556,8,'Groups-existing','sysop',0,0,0,0.010809358253,'20070310095008',556,15);
INSERT INTO page VALUES (557,8,'Groups-group-edit','sysop',0,0,0,0.849861853676,'20070310095008',557,16);
INSERT INTO page VALUES (558,8,'Groups-lookup-group','sysop',0,0,0,0.608153259171,'20070310095008',558,19);
INSERT INTO page VALUES (559,8,'Groups-noname','sysop',0,0,0,0.658932428519,'20070310095008',559,33);
INSERT INTO page VALUES (560,8,'Groups-tableheader','sysop',0,0,0,0.765498472586,'20070310095008',560,35);
INSERT INTO page VALUES (561,8,'Guesstimezone','sysop',0,0,0,0.962797196354,'20070310095008',561,20);
INSERT INTO page VALUES (562,8,'Headline_sample','sysop',0,0,0,0.045755083511,'20070310095008',562,13);
INSERT INTO page VALUES (563,8,'Headline_tip','sysop',0,0,0,0.862949438665,'20070310095008',563,16);
INSERT INTO page VALUES (564,8,'Help','sysop',0,0,0,0.056745727532,'20070310095008',564,4);
INSERT INTO page VALUES (565,8,'Helppage','sysop',0,0,0,0.32621701046,'20070310095008',565,13);
INSERT INTO page VALUES (566,8,'Hide','sysop',0,0,0,0.112742448745,'20070310095008',566,4);
INSERT INTO page VALUES (567,8,'Hideresults','sysop',0,0,0,0.455739832734,'20070310095008',567,12);
INSERT INTO page VALUES (568,8,'Hidetoc','sysop',0,0,0,0.305005445877,'20070310095008',568,4);
INSERT INTO page VALUES (569,8,'Hist','sysop',0,0,0,0.455252363769,'20070310095008',569,4);
INSERT INTO page VALUES (570,8,'Histfirst','sysop',0,0,0,0.191174812315,'20070310095008',570,8);
INSERT INTO page VALUES (571,8,'Histlast','sysop',0,0,0,0.351887492378,'20070310095008',571,6);
INSERT INTO page VALUES (572,8,'Histlegend','sysop',0,0,0,0.14403493066,'20070310095008',572,221);
INSERT INTO page VALUES (573,8,'History','sysop',0,0,0,0.072503400831,'20070310095008',573,12);
INSERT INTO page VALUES (574,8,'History_copyright','sysop',0,0,0,0.774140877087,'20070310095008',574,1);
INSERT INTO page VALUES (575,8,'History_short','sysop',0,0,0,0.148017856656,'20070310095008',575,7);
INSERT INTO page VALUES (576,8,'Historywarning','sysop',0,0,0,0.569217156509,'20070310095008',576,56);
INSERT INTO page VALUES (577,8,'Hr_tip','sysop',0,0,0,0.165110289643,'20070310095008',577,31);
INSERT INTO page VALUES (578,8,'Ignorewarning','sysop',0,0,0,0.681003977292,'20070310095008',578,36);
INSERT INTO page VALUES (579,8,'Ignorewarnings','sysop',0,0,0,0.706400167397,'20070310095008',579,19);
INSERT INTO page VALUES (580,8,'Illegalfilename','sysop',0,0,0,0.789146131471,'20070310095008',580,125);
INSERT INTO page VALUES (581,8,'Ilsubmit','sysop',0,0,0,0.771674988184,'20070310095008',581,6);
INSERT INTO page VALUES (582,8,'Image_sample','sysop',0,0,0,0.40208974068,'20070310095008',582,11);
INSERT INTO page VALUES (583,8,'Image_tip','sysop',0,0,0,0.350807497196,'20070310095008',583,14);
INSERT INTO page VALUES (584,8,'Imagelinks','sysop',0,0,0,0.65395366079,'20070310095008',584,5);
INSERT INTO page VALUES (585,8,'Imagelist','sysop',0,0,0,0.681644667882,'20070310095008',585,9);
INSERT INTO page VALUES (586,8,'Imagelistall','sysop',0,0,0,0.394405543284,'20070310095008',586,3);
INSERT INTO page VALUES (587,8,'Imagelistforuser','sysop',0,0,0,0.183930199245,'20070310095008',587,38);
INSERT INTO page VALUES (588,8,'Imagelisttext','sysop',0,0,0,0.569896605009,'20070310095008',588,38);
INSERT INTO page VALUES (589,8,'Imagemaxsize','sysop',0,0,0,0.476985031607,'20070310095008',589,43);
INSERT INTO page VALUES (590,8,'Imagepage','sysop',0,0,0,0.568051255993,'20070310095008',590,15);
INSERT INTO page VALUES (591,8,'Imagereverted','sysop',0,0,0,0.67897853344,'20070310095008',591,41);
INSERT INTO page VALUES (592,8,'Imgdelete','sysop',0,0,0,0.605776362037,'20070310095008',592,3);
INSERT INTO page VALUES (593,8,'Imgdesc','sysop',0,0,0,0.553949648948,'20070310095008',593,4);
INSERT INTO page VALUES (594,8,'Imghistlegend','sysop',0,0,0,0.718326687237,'20070310095008',594,176);
INSERT INTO page VALUES (595,8,'Imghistory','sysop',0,0,0,0.805721267699,'20070310095008',595,12);
INSERT INTO page VALUES (596,8,'Imglegend','sysop',0,0,0,0.760907689437,'20070310095008',596,44);
INSERT INTO page VALUES (597,8,'Immobile_namespace','sysop',0,0,0,0.940630342658,'20070310095008',597,78);
INSERT INTO page VALUES (598,8,'Import','sysop',0,0,0,0.423411007954,'20070310095008',598,12);
INSERT INTO page VALUES (599,8,'Importfailed','sysop',0,0,0,0.49205189043,'20070310095008',599,17);
INSERT INTO page VALUES (600,8,'Importhistoryconflict','sysop',0,0,0,0.283297498583,'20070310095008',600,72);
INSERT INTO page VALUES (601,8,'Importing','sysop',0,0,0,0.097013867406,'20070310095008',601,12);
INSERT INTO page VALUES (602,8,'Importinterwiki','sysop',0,0,0,0.178785979755,'20070310095008',602,16);
INSERT INTO page VALUES (603,8,'Importnofile','sysop',0,0,0,0.254961174735,'20070310095009',603,28);
INSERT INTO page VALUES (604,8,'Importnosources','sysop',0,0,0,0.148951707827,'20070310095009',604,86);
INSERT INTO page VALUES (605,8,'Importnotext','sysop',0,0,0,0.341761573738,'20070310095009',605,16);
INSERT INTO page VALUES (606,8,'Importsuccess','sysop',0,0,0,0.72701548605,'20070310095009',606,17);
INSERT INTO page VALUES (607,8,'Importtext','sysop',0,0,0,0.200588287575,'20070310095009',607,118);
INSERT INTO page VALUES (608,8,'Importuploaderror','sysop',0,0,0,0.229636985339,'20070310095009',608,86);
INSERT INTO page VALUES (609,8,'Infiniteblock','sysop',0,0,0,0.582867244605,'20070310095009',609,8);
INSERT INTO page VALUES (610,8,'Info_short','sysop',0,0,0,0.083002216939,'20070310095009',610,11);
INSERT INTO page VALUES (611,8,'Infosubtitle','sysop',0,0,0,0.921596854015,'20070310095009',611,20);
INSERT INTO page VALUES (612,8,'Internalerror','sysop',0,0,0,0.291416736808,'20070310095009',612,14);
INSERT INTO page VALUES (613,8,'Intl','sysop',0,0,0,0.468305512534,'20070310095009',613,19);
INSERT INTO page VALUES (614,8,'Invalidemailaddress','sysop',0,0,0,0.600969374175,'20070310095009',614,137);
INSERT INTO page VALUES (615,8,'Invert','sysop',0,0,0,0.532585471924,'20070310095009',615,16);
INSERT INTO page VALUES (616,8,'Ip_range_invalid','sysop',0,0,0,0.889270313542,'20070310095009',616,17);
INSERT INTO page VALUES (617,8,'Ipaddress','sysop',0,0,0,0.8484856256,'20070310095009',617,10);
INSERT INTO page VALUES (618,8,'Ipadressorusername','sysop',0,0,0,0.232136864255,'20070310095009',618,22);
INSERT INTO page VALUES (619,8,'Ipb_expiry_invalid','sysop',0,0,0,0.648455530539,'20070310095009',619,20);
INSERT INTO page VALUES (620,8,'Ipbexpiry','sysop',0,0,0,0.91247588769,'20070310095009',620,6);
INSERT INTO page VALUES (621,8,'Ipblocklist','sysop',0,0,0,0.032922608872,'20070310095009',621,42);
INSERT INTO page VALUES (622,8,'Ipblocklistempty','sysop',0,0,0,0.690438447726,'20070310095009',622,23);
INSERT INTO page VALUES (623,8,'Ipboptions','sysop',0,0,0,0.385142470666,'20070310095009',623,155);
INSERT INTO page VALUES (624,8,'Ipbother','sysop',0,0,0,0.414766107484,'20070310095009',624,10);
INSERT INTO page VALUES (625,8,'Ipbotheroption','sysop',0,0,0,0.269078943511,'20070310095009',625,5);
INSERT INTO page VALUES (626,8,'Ipbreason','sysop',0,0,0,0.389584939044,'20070310095009',626,6);
INSERT INTO page VALUES (627,8,'Ipbsubmit','sysop',0,0,0,0.672218576651,'20070310095009',627,15);
INSERT INTO page VALUES (628,8,'Ipusubmit','sysop',0,0,0,0.305293099109,'20070310095009',628,20);
INSERT INTO page VALUES (629,8,'Ipusuccess','sysop',0,0,0,0.813069824827,'20070310095009',629,18);
INSERT INTO page VALUES (630,8,'Isbn','sysop',0,0,0,0.448410721889,'20070310095009',630,4);
INSERT INTO page VALUES (631,8,'Isredirect','sysop',0,0,0,0.297865894406,'20070310095009',631,13);
INSERT INTO page VALUES (632,8,'Istemplate','sysop',0,0,0,0.172681814899,'20070310095009',632,9);
INSERT INTO page VALUES (633,8,'Italic_sample','sysop',0,0,0,0.870526779486,'20070310095009',633,11);
INSERT INTO page VALUES (634,8,'Italic_tip','sysop',0,0,0,0.461059743476,'20070310095009',634,11);
INSERT INTO page VALUES (635,8,'Iteminvalidname','sysop',0,0,0,0.69277144052,'20070310095009',635,39);
INSERT INTO page VALUES (636,8,'Jan','sysop',0,0,0,0.708114315409,'20070310095009',636,3);
INSERT INTO page VALUES (637,8,'January','sysop',0,0,0,0.100754547902,'20070310095009',637,7);
INSERT INTO page VALUES (638,8,'Jul','sysop',0,0,0,0.896850831741,'20070310095009',638,3);
INSERT INTO page VALUES (639,8,'July','sysop',0,0,0,0.910669438672,'20070310095009',639,4);
INSERT INTO page VALUES (640,8,'Jumpto','sysop',0,0,0,0.431617744413,'20070310095009',640,8);
INSERT INTO page VALUES (641,8,'Jumptonavigation','sysop',0,0,0,0.369486029083,'20070310095009',641,10);
INSERT INTO page VALUES (642,8,'Jumptosearch','sysop',0,0,0,0.751611498154,'20070310095009',642,6);
INSERT INTO page VALUES (643,8,'Jun','sysop',0,0,0,0.530466028868,'20070310095009',643,3);
INSERT INTO page VALUES (644,8,'June','sysop',0,0,0,0.790962098223,'20070310095009',644,4);
INSERT INTO page VALUES (645,8,'Laggedslavemode','sysop',0,0,0,0.078940413273,'20070310095009',645,45);
INSERT INTO page VALUES (646,8,'Largefile','sysop',0,0,0,0.624837559959,'20070310095009',646,80);
INSERT INTO page VALUES (647,8,'Largefileserver','sysop',0,0,0,0.166142700967,'20070310095009',647,59);
INSERT INTO page VALUES (648,8,'Last','sysop',0,0,0,0.023998149233,'20070310095009',648,4);
INSERT INTO page VALUES (649,8,'Lastmodified','sysop',0,0,0,0.699190498402,'20070310095009',649,31);
INSERT INTO page VALUES (650,8,'Lastmodifiedby','sysop',0,0,0,0.527624363653,'20070310095009',650,37);
INSERT INTO page VALUES (651,8,'License','sysop',0,0,0,0.321394657661,'20070310095009',651,9);
INSERT INTO page VALUES (652,8,'Lineno','sysop',0,0,0,0.451412045453,'20070310095009',652,8);
INSERT INTO page VALUES (653,8,'Link_sample','sysop',0,0,0,0.247111233903,'20070310095009',653,10);
INSERT INTO page VALUES (654,8,'Link_tip','sysop',0,0,0,0.060532993332,'20070310095009',654,13);
INSERT INTO page VALUES (655,8,'Linklistsub','sysop',0,0,0,0.784421939343,'20070310095009',655,15);
INSERT INTO page VALUES (656,8,'Linkprefix','sysop',0,0,0,0.392853906525,'20070310095009',656,31);
INSERT INTO page VALUES (657,8,'Linkshere','sysop',0,0,0,0.521839747796,'20070310095009',657,33);
INSERT INTO page VALUES (658,8,'Linkstoimage','sysop',0,0,0,0.279100657167,'20070310095009',658,38);
INSERT INTO page VALUES (659,8,'Linktrail','sysop',0,0,0,0.478019347241,'20070310095009',659,18);
INSERT INTO page VALUES (660,8,'Listform','sysop',0,0,0,0.181087326145,'20070310095009',660,4);
INSERT INTO page VALUES (661,8,'Listingcontinuesabbrev','sysop',0,0,0,0.707657468603,'20070310095009',661,6);
INSERT INTO page VALUES (662,8,'Listredirects','sysop',0,0,0,0.69158353377,'20070310095009',662,14);
INSERT INTO page VALUES (663,8,'Listusers','sysop',0,0,0,0.596497874122,'20070310095009',663,9);
INSERT INTO page VALUES (664,8,'Loadhist','sysop',0,0,0,0.13010614847,'20070310095009',664,20);
INSERT INTO page VALUES (665,8,'Loadingrev','sysop',0,0,0,0.982696861845,'20070310095009',665,25);
INSERT INTO page VALUES (666,8,'Localtime','sysop',0,0,0,0.490585378344,'20070310095009',666,10);
INSERT INTO page VALUES (667,8,'Lockbtn','sysop',0,0,0,0.063335395235,'20070310095009',667,13);
INSERT INTO page VALUES (668,8,'Lockconfirm','sysop',0,0,0,0.788594028338,'20070310095009',668,40);
INSERT INTO page VALUES (669,8,'Lockdb','sysop',0,0,0,0.260143473024,'20070310095009',669,13);
INSERT INTO page VALUES (670,8,'Lockdbsuccesssub','sysop',0,0,0,0.670235303781,'20070310095009',670,23);
INSERT INTO page VALUES (671,8,'Lockdbsuccesstext','sysop',0,0,0,0.108356507781,'20070310095009',671,99);
INSERT INTO page VALUES (672,8,'Lockdbtext','sysop',0,0,0,0.949427324622,'20070310095009',672,294);
INSERT INTO page VALUES (673,8,'Locknoconfirm','sysop',0,0,0,0.915710485312,'20070310095009',673,39);
INSERT INTO page VALUES (674,8,'Log','sysop',0,0,0,0.788826045559,'20070310095009',674,4);
INSERT INTO page VALUES (675,8,'Logempty','sysop',0,0,0,0.899881332528,'20070310095009',675,25);
INSERT INTO page VALUES (676,8,'Login','sysop',0,0,0,0.842486603199,'20070310095009',676,6);
INSERT INTO page VALUES (677,8,'Loginend','sysop',0,0,0,0.906723769356,'20070310095009',677,0);
INSERT INTO page VALUES (678,8,'Loginerror','sysop',0,0,0,0.941696516766,'20070310095009',678,11);
INSERT INTO page VALUES (679,8,'Loginpagetitle','sysop',0,0,0,0.627626706099,'20070310095009',679,10);
INSERT INTO page VALUES (680,8,'Loginproblem','sysop',0,0,0,0.832925376285,'20070310095009',680,64);
INSERT INTO page VALUES (681,8,'Loginprompt','sysop',0,0,0,0.198980771948,'20070310095009',681,56);
INSERT INTO page VALUES (682,8,'Loginreqlink','sysop',0,0,0,0.839953003616,'20070310095009',682,6);
INSERT INTO page VALUES (683,8,'Loginreqpagetext','sysop',0,0,0,0.600194359494,'20070310095009',683,32);
INSERT INTO page VALUES (684,8,'Loginreqtitle','sysop',0,0,0,0.043878482622,'20070310095009',684,14);
INSERT INTO page VALUES (685,8,'Loginsuccess','sysop',0,0,0,0.122621039829,'20070310095009',685,52);
INSERT INTO page VALUES (686,8,'Loginsuccesstitle','sysop',0,0,0,0.842240248116,'20070310095009',686,16);
INSERT INTO page VALUES (687,8,'Logout','sysop',0,0,0,0.416705410296,'20070310095009',687,7);
INSERT INTO page VALUES (688,8,'Logouttext','sysop',0,0,0,0.785155994548,'20070310095009',688,274);
INSERT INTO page VALUES (689,8,'Logouttitle','sysop',0,0,0,0.382013128366,'20070310095009',689,11);
INSERT INTO page VALUES (690,8,'Lonelypages','sysop',0,0,0,0.0513566773,'20070310095009',690,14);
INSERT INTO page VALUES (691,8,'Longpageerror','sysop',0,0,0,0.180241911884,'20070310095009',691,144);
INSERT INTO page VALUES (692,8,'Longpages','sysop',0,0,0,0.586266482647,'20070310095009',692,10);
INSERT INTO page VALUES (693,8,'Longpagewarning','sysop',0,0,0,0.481779899818,'20070310095009',693,193);
INSERT INTO page VALUES (694,8,'Mailerror','sysop',0,0,0,0.720144145815,'20070310095009',694,22);
INSERT INTO page VALUES (695,8,'Mailmypassword','sysop',0,0,0,0.284286484852,'20070310095009',695,15);
INSERT INTO page VALUES (696,8,'Mailnologin','sysop',0,0,0,0.989217962117,'20070310095009',696,15);
INSERT INTO page VALUES (697,8,'Mailnologintext','sysop',0,0,0,0.037397126008,'20070310095009',697,150);
INSERT INTO page VALUES (698,8,'Mainpage','sysop',0,0,0,0.836886611394,'20070310095009',698,9);
INSERT INTO page VALUES (699,8,'Mainpagedocfooter','sysop',0,0,0,0.434335706924,'20070310095009',699,394);
INSERT INTO page VALUES (700,8,'Mainpagetext','sysop',0,0,0,0.848410007155,'20070310095009',700,59);
INSERT INTO page VALUES (701,8,'Makesysop','sysop',0,0,0,0.63289904509,'20070310095009',701,24);
INSERT INTO page VALUES (702,8,'Makesysopfail','sysop',0,0,0,0.021640380336,'20070310095009',702,84);
INSERT INTO page VALUES (703,8,'Makesysopname','sysop',0,0,0,0.55337188539,'20070310095009',703,17);
INSERT INTO page VALUES (704,8,'Makesysopok','sysop',0,0,0,0.392404892228,'20070310095009',704,31);
INSERT INTO page VALUES (705,8,'Makesysopsubmit','sysop',0,0,0,0.034425442842,'20070310095009',705,27);
INSERT INTO page VALUES (706,8,'Makesysoptext','sysop',0,0,0,0.083112005621,'20070310095009',706,168);
INSERT INTO page VALUES (707,8,'Makesysoptitle','sysop',0,0,0,0.175592459411,'20070310095009',707,24);
INSERT INTO page VALUES (708,8,'Mar','sysop',0,0,0,0.863088540373,'20070310095009',708,3);
INSERT INTO page VALUES (709,8,'March','sysop',0,0,0,0.470511270052,'20070310095009',709,5);
INSERT INTO page VALUES (710,8,'Markaspatrolleddiff','sysop',0,0,0,0.843765952903,'20070310095009',710,17);
INSERT INTO page VALUES (711,8,'Markaspatrolledlink','sysop',0,0,0,0.814155164675,'20070310095009',711,4);
INSERT INTO page VALUES (712,8,'Markaspatrolledtext','sysop',0,0,0,0.628754523964,'20070310095009',712,30);
INSERT INTO page VALUES (713,8,'Markedaspatrolled','sysop',0,0,0,0.270286747366,'20070310095009',713,19);
INSERT INTO page VALUES (714,8,'Markedaspatrollederror','sysop',0,0,0,0.386325666943,'20070310095009',714,24);
INSERT INTO page VALUES (715,8,'Markedaspatrollederrortext','sysop',0,0,0,0.24363146645,'20070310095009',715,52);
INSERT INTO page VALUES (716,8,'Markedaspatrolledtext','sysop',0,0,0,0.713046233342,'20070310095009',716,51);
INSERT INTO page VALUES (717,8,'Matchtotals','sysop',0,0,0,0.886836732968,'20070310095009',717,63);
INSERT INTO page VALUES (718,8,'Math','sysop',0,0,0,0.63550132739,'20070310095009',718,4);
INSERT INTO page VALUES (719,8,'Math_bad_output','sysop',0,0,0,0.848644971841,'20070310095009',719,46);
INSERT INTO page VALUES (720,8,'Math_bad_tmpdir','sysop',0,0,0,0.383560636715,'20070310095009',720,44);
INSERT INTO page VALUES (721,8,'Math_failure','sysop',0,0,0,0.438182589848,'20070310095009',721,15);
INSERT INTO page VALUES (722,8,'Math_image_error','sysop',0,0,0,0.683955313337,'20070310095009',722,86);
INSERT INTO page VALUES (723,8,'Math_lexing_error','sysop',0,0,0,0.13537545035,'20070310095009',723,12);
INSERT INTO page VALUES (724,8,'Math_notexvc','sysop',0,0,0,0.832996510894,'20070310095009',724,62);
INSERT INTO page VALUES (725,8,'Math_sample','sysop',0,0,0,0.555727735079,'20070310095009',725,19);
INSERT INTO page VALUES (726,8,'Math_syntax_error','sysop',0,0,0,0.485028163624,'20070310095009',726,12);
INSERT INTO page VALUES (727,8,'Math_tip','sysop',0,0,0,0.117431827454,'20070310095009',727,28);
INSERT INTO page VALUES (728,8,'Math_unknown_error','sysop',0,0,0,0.241766265152,'20070310095009',728,13);
INSERT INTO page VALUES (729,8,'Math_unknown_function','sysop',0,0,0,0.418436120943,'20070310095009',729,16);
INSERT INTO page VALUES (730,8,'May','sysop',0,0,0,0.641574526028,'20070310095009',730,3);
INSERT INTO page VALUES (731,8,'May_long','sysop',0,0,0,0.408371574497,'20070310095009',731,3);
INSERT INTO page VALUES (732,8,'Media_sample','sysop',0,0,0,0.460217732466,'20070310095009',732,11);
INSERT INTO page VALUES (733,8,'Media_tip','sysop',0,0,0,0.778101484171,'20070310095009',733,15);
INSERT INTO page VALUES (734,8,'Mediawarning','sysop',0,0,0,0.619993296787,'20070310095009',734,105);
INSERT INTO page VALUES (735,8,'Metadata','sysop',0,0,0,0.484757580481,'20070310095009',735,8);
INSERT INTO page VALUES (736,8,'Metadata-collapse','sysop',0,0,0,0.148711798426,'20070310095009',736,21);
INSERT INTO page VALUES (737,8,'Metadata-expand','sysop',0,0,0,0.170428569184,'20070310095009',737,21);
INSERT INTO page VALUES (738,8,'Metadata-fields','sysop',0,0,0,0.458108260845,'20070310095009',738,227);
INSERT INTO page VALUES (739,8,'Metadata-help','sysop',0,0,0,0.336386672249,'20070310095009',739,233);
INSERT INTO page VALUES (740,8,'Metadata_page','sysop',0,0,0,0.612230473656,'20070310095009',740,18);
INSERT INTO page VALUES (741,8,'Mimesearch','sysop',0,0,0,0.428202554778,'20070310095009',741,11);
INSERT INTO page VALUES (742,8,'Mimetype','sysop',0,0,0,0.015044693621,'20070310095009',742,10);
INSERT INTO page VALUES (743,8,'Minlength','sysop',0,0,0,0.546343897936,'20070310095009',743,42);
INSERT INTO page VALUES (744,8,'Minoredit','sysop',0,0,0,0.741099315482,'20070310095009',744,20);
INSERT INTO page VALUES (745,8,'Minoreditletter','sysop',0,0,0,0.884032275538,'20070310095009',745,1);
INSERT INTO page VALUES (746,8,'Missingarticle','sysop',0,0,0,0.268863419389,'20070310095009',746,318);
INSERT INTO page VALUES (747,8,'Missingcommenttext','sysop',0,0,0,0.822121157593,'20070310095009',747,29);
INSERT INTO page VALUES (748,8,'Missingimage','sysop',0,0,0,0.427797620393,'20070310095009',748,35);
INSERT INTO page VALUES (749,8,'Missingsummary','sysop',0,0,0,0.897524604493,'20070310095009',749,116);
INSERT INTO page VALUES (750,8,'Monday','sysop',0,0,0,0.523434130301,'20070310095009',750,6);
INSERT INTO page VALUES (751,8,'Moredotdotdot','sysop',0,0,0,0.526197970672,'20070310095009',751,7);
INSERT INTO page VALUES (752,8,'Mostcategories','sysop',0,0,0,0.606311926404,'20070310095009',752,33);
INSERT INTO page VALUES (753,8,'Mostimages','sysop',0,0,0,0.090346791667,'20070310095009',753,21);
INSERT INTO page VALUES (754,8,'Mostlinked','sysop',0,0,0,0.952707919132,'20070310095009',754,20);
INSERT INTO page VALUES (755,8,'Mostlinkedcategories','sysop',0,0,0,0.265522673734,'20070310095009',755,25);
INSERT INTO page VALUES (756,8,'Mostrevisions','sysop',0,0,0,0.455804644784,'20070310095009',756,32);
INSERT INTO page VALUES (757,8,'Move','sysop',0,0,0,0.309996311663,'20070310095009',757,4);
INSERT INTO page VALUES (758,8,'Movearticle','sysop',0,0,0,0.097151400025,'20070310095009',758,9);
INSERT INTO page VALUES (759,8,'Movedto','sysop',0,0,0,0.824414350074,'20070310095009',759,8);
INSERT INTO page VALUES (760,8,'Movelogpage','sysop',0,0,0,0.09858126744,'20070310095009',760,8);
INSERT INTO page VALUES (761,8,'Movelogpagetext','sysop',0,0,0,0.429122830877,'20070310095009',761,30);
INSERT INTO page VALUES (762,8,'Movenologin','sysop',0,0,0,0.981871287804,'20070310095009',762,13);
INSERT INTO page VALUES (763,8,'Movenologintext','sysop',0,0,0,0.044911499241,'20070310095009',763,81);
INSERT INTO page VALUES (764,8,'Movepage','sysop',0,0,0,0.957886007689,'20070310095009',764,9);
INSERT INTO page VALUES (765,8,'Movepagebtn','sysop',0,0,0,0.115668548541,'20070310095009',765,9);
INSERT INTO page VALUES (766,8,'Movepagetalktext','sysop',0,0,0,0.757900884104,'20070310095009',766,300);
INSERT INTO page VALUES (767,8,'Movepagetext','sysop',0,0,0,0.612161169611,'20070310095009',767,787);
INSERT INTO page VALUES (768,8,'Movereason','sysop',0,0,0,0.940158040875,'20070310095009',768,6);
INSERT INTO page VALUES (769,8,'Movetalk','sysop',0,0,0,0.167594751552,'20070310095009',769,25);
INSERT INTO page VALUES (770,8,'Movethispage','sysop',0,0,0,0.665018564548,'20070310095009',770,14);
INSERT INTO page VALUES (771,8,'math_html','sysop',0,0,0,0.799465847418,'20070310095009',771,28);
INSERT INTO page VALUES (772,8,'math_mathml','sysop',0,0,0,0.473629840877,'20070310095009',772,33);
INSERT INTO page VALUES (773,8,'math_modern','sysop',0,0,0,0.600501164259,'20070310095009',773,31);
INSERT INTO page VALUES (774,8,'math_png','sysop',0,0,0,0.518951469784,'20070310095009',774,17);
INSERT INTO page VALUES (775,8,'math_simple','sysop',0,0,0,0.136265149055,'20070310095009',775,31);
INSERT INTO page VALUES (776,8,'math_source','sysop',0,0,0,0.458055369906,'20070310095009',776,35);
INSERT INTO page VALUES (777,8,'Mycontris','sysop',0,0,0,0.800475748012,'20070310095009',777,16);
INSERT INTO page VALUES (778,8,'Mypage','sysop',0,0,0,0.771570843217,'20070310095009',778,7);
INSERT INTO page VALUES (779,8,'Mytalk','sysop',0,0,0,0.706258992202,'20070310095009',779,7);
INSERT INTO page VALUES (780,8,'Namespace','sysop',0,0,0,0.337019465581,'20070310095009',780,10);
INSERT INTO page VALUES (781,8,'Namespacesall','sysop',0,0,0,0.824660600842,'20070310095009',781,3);
INSERT INTO page VALUES (782,8,'Navigation','sysop',0,0,0,0.30441003432,'20070310095009',782,10);
INSERT INTO page VALUES (783,8,'Nbytes','sysop',0,0,0,0.832871713078,'20070310095009',783,8);
INSERT INTO page VALUES (784,8,'Ncategories','sysop',0,0,0,0.604485205018,'20070310095009',784,13);
INSERT INTO page VALUES (785,8,'Nchanges','sysop',0,0,0,0.637668921874,'20070310095009',785,10);
INSERT INTO page VALUES (786,8,'Newarticle','sysop',0,0,0,0.744417944965,'20070310095009',786,5);
INSERT INTO page VALUES (787,8,'Newarticletext','sysop',0,0,0,0.031752783149,'20070310095009',787,231);
INSERT INTO page VALUES (788,8,'Newarticletextanon','sysop',0,0,0,0.898820048316,'20070310095009',788,22);
INSERT INTO page VALUES (789,8,'Newbies','sysop',0,0,0,0.93240189811,'20070310095009',789,7);
INSERT INTO page VALUES (790,8,'Newimages','sysop',0,0,0,0.629517201859,'20070310095009',790,20);
INSERT INTO page VALUES (791,8,'Newmessagesdifflink','sysop',0,0,0,0.862133900727,'20070310095009',791,28);
INSERT INTO page VALUES (792,8,'Newmessageslink','sysop',0,0,0,0.39768001258,'20070310095009',792,12);
INSERT INTO page VALUES (793,8,'Newpage','sysop',0,0,0,0.103382974942,'20070310095009',793,8);
INSERT INTO page VALUES (794,8,'Newpageletter','sysop',0,0,0,0.648499028339,'20070310095009',794,1);
INSERT INTO page VALUES (795,8,'Newpages','sysop',0,0,0,0.63216821412,'20070310095009',795,9);
INSERT INTO page VALUES (796,8,'Newpassword','sysop',0,0,0,0.251890348268,'20070310095009',796,13);
INSERT INTO page VALUES (797,8,'Newtalkseperator','sysop',0,0,0,0.42905818797,'20070310095009',797,2);
INSERT INTO page VALUES (798,8,'Newtitle','sysop',0,0,0,0.889403038489,'20070310095009',798,12);
INSERT INTO page VALUES (799,8,'Newusersonly','sysop',0,0,0,0.692260650449,'20070310095009',799,17);
INSERT INTO page VALUES (800,8,'Newwindow','sysop',0,0,0,0.35417081823,'20070310095009',800,21);
INSERT INTO page VALUES (801,8,'Next','sysop',0,0,0,0.565188051714,'20070310095009',801,4);
INSERT INTO page VALUES (802,8,'Nextdiff','sysop',0,0,0,0.03368464786,'20070310095009',802,13);
INSERT INTO page VALUES (803,8,'Nextn','sysop',0,0,0,0.910064964885,'20070310095009',803,7);
INSERT INTO page VALUES (804,8,'Nextpage','sysop',0,0,0,0.997982147722,'20070310095009',804,14);
INSERT INTO page VALUES (805,8,'Nextrevision','sysop',0,0,0,0.471863610268,'20070310095009',805,17);
INSERT INTO page VALUES (806,8,'Nlinks','sysop',0,0,0,0.37287247859,'20070310095009',806,8);
INSERT INTO page VALUES (807,8,'Noarticletext','sysop',0,0,0,0.821942937141,'20070310095009',807,201);
INSERT INTO page VALUES (808,8,'Noarticletextanon','sysop',0,0,0,0.971551493589,'20070310095009',808,21);
INSERT INTO page VALUES (809,8,'Noconnect','sysop',0,0,0,0.557863335022,'20070310095009',809,110);
INSERT INTO page VALUES (810,8,'Nocontribs','sysop',0,0,0,0.223262701686,'20070310095009',810,46);
INSERT INTO page VALUES (811,8,'Nocookieslogin','sysop',0,0,0,0.010544888004,'20070310095009',811,103);
INSERT INTO page VALUES (812,8,'Nocookiesnew','sysop',0,0,0,0.449574881853,'20070310095009',812,195);
INSERT INTO page VALUES (813,8,'Nocreatetext','sysop',0,0,0,0.978017589141,'20070310095009',813,154);
INSERT INTO page VALUES (814,8,'Nocreatetitle','sysop',0,0,0,0.264101490347,'20070310095009',814,21);
INSERT INTO page VALUES (815,8,'Nocreativecommons','sysop',0,0,0,0.72470230465,'20070310095009',815,55);
INSERT INTO page VALUES (816,8,'Nocredits','sysop',0,0,0,0.28413740639,'20070310095009',816,49);
INSERT INTO page VALUES (817,8,'Nodb','sysop',0,0,0,0.173529145671,'20070310095009',817,28);
INSERT INTO page VALUES (818,8,'Nodublincore','sysop',0,0,0,0.756514462669,'20070310095009',818,50);
INSERT INTO page VALUES (819,8,'Noemail','sysop',0,0,0,0.574792964028,'20070310095009',819,50);
INSERT INTO page VALUES (820,8,'Noemailprefs','sysop',0,0,0,0.341934119211,'20070310095009',820,70);
INSERT INTO page VALUES (821,8,'Noemailtext','sysop',0,0,0,0.40338193937,'20070310095009',821,105);
INSERT INTO page VALUES (822,8,'Noemailtitle','sysop',0,0,0,0.160459146723,'20070310095009',822,17);
INSERT INTO page VALUES (823,8,'Nogomatch','sysop',0,0,0,0.721702948723,'20070310095009',823,68);
INSERT INTO page VALUES (824,8,'Nohistory','sysop',0,0,0,0.457972664209,'20070310095009',824,39);
INSERT INTO page VALUES (825,8,'Noimage','sysop',0,0,0,0.639296838662,'20070310095009',825,40);
INSERT INTO page VALUES (826,8,'Noimage-linktext','sysop',0,0,0,0.201312926729,'20070310095009',826,9);
INSERT INTO page VALUES (827,8,'Noimages','sysop',0,0,0,0.449278600549,'20070310095009',827,15);
INSERT INTO page VALUES (828,8,'Nolicense','sysop',0,0,0,0.375623610564,'20070310095009',828,13);
INSERT INTO page VALUES (829,8,'Nolinkshere','sysop',0,0,0,0.802788405056,'20070310095009',829,22);
INSERT INTO page VALUES (830,8,'Nolinkstoimage','sysop',0,0,0,0.168614494973,'20070310095009',830,42);
INSERT INTO page VALUES (831,8,'Nologin','sysop',0,0,0,0.019613631234,'20070310095009',831,23);
INSERT INTO page VALUES (832,8,'Nologinlink','sysop',0,0,0,0.13430289696,'20070310095009',832,17);
INSERT INTO page VALUES (833,8,'Noname','sysop',0,0,0,0.29435671004,'20070310095009',833,41);
INSERT INTO page VALUES (834,8,'Nonefound','sysop',0,0,0,0.572207646851,'20070310095009',834,245);
INSERT INTO page VALUES (835,8,'Nonunicodebrowser','sysop',0,0,0,0.790867359529,'20070310095009',835,198);
INSERT INTO page VALUES (836,8,'Nospecialpagetext','sysop',0,0,0,0.516987579717,'20070310095009',836,122);
INSERT INTO page VALUES (837,8,'Nosuchaction','sysop',0,0,0,0.139212869272,'20070310095009',837,14);
INSERT INTO page VALUES (838,8,'Nosuchactiontext','sysop',0,0,0,0.878209107969,'20070310095009',838,61);
INSERT INTO page VALUES (839,8,'Nosuchspecialpage','sysop',0,0,0,0.97899702523,'20070310095009',839,20);
INSERT INTO page VALUES (840,8,'Nosuchuser','sysop',0,0,0,0.559123592996,'20070310095009',840,80);
INSERT INTO page VALUES (841,8,'Nosuchusershort','sysop',0,0,0,0.071879995205,'20070310095009',841,55);
INSERT INTO page VALUES (842,8,'Notacceptable','sysop',0,0,0,0.218278203074,'20070310095009',842,68);
INSERT INTO page VALUES (843,8,'Notanarticle','sysop',0,0,0,0.681677719772,'20070310095009',843,18);
INSERT INTO page VALUES (844,8,'Notargettext','sysop',0,0,0,0.052721164894,'20070310095009',844,73);
INSERT INTO page VALUES (845,8,'Notargettitle','sysop',0,0,0,0.377492289378,'20070310095009',845,9);
INSERT INTO page VALUES (846,8,'Note','sysop',0,0,0,0.553201321955,'20070310095009',846,22);
INSERT INTO page VALUES (847,8,'Notextmatches','sysop',0,0,0,0.273971283758,'20070310095009',847,20);
INSERT INTO page VALUES (848,8,'Notitlematches','sysop',0,0,0,0.622635184765,'20070310095009',848,21);
INSERT INTO page VALUES (849,8,'Notloggedin','sysop',0,0,0,0.822886895534,'20070310095009',849,13);
INSERT INTO page VALUES (850,8,'Nouserspecified','sysop',0,0,0,0.095488276867,'20070310095009',850,31);
INSERT INTO page VALUES (851,8,'Nov','sysop',0,0,0,0.585024454752,'20070310095009',851,3);
INSERT INTO page VALUES (852,8,'November','sysop',0,0,0,0.354044205891,'20070310095009',852,8);
INSERT INTO page VALUES (853,8,'Nowatchlist','sysop',0,0,0,0.831702042298,'20070310095009',853,36);
INSERT INTO page VALUES (854,8,'Nowiki_sample','sysop',0,0,0,0.610566726107,'20070310095009',854,30);
INSERT INTO page VALUES (855,8,'Nowiki_tip','sysop',0,0,0,0.807166734477,'20070310095009',855,22);
INSERT INTO page VALUES (856,8,'Nrevisions','sysop',0,0,0,0.904336229144,'20070310095009',856,12);
INSERT INTO page VALUES (857,8,'Nstab-category','sysop',0,0,0,0.021534352779,'20070310095009',857,8);
INSERT INTO page VALUES (858,8,'Nstab-help','sysop',0,0,0,0.109555670513,'20070310095009',858,4);
INSERT INTO page VALUES (859,8,'Nstab-image','sysop',0,0,0,0.963193144883,'20070310095009',859,4);
INSERT INTO page VALUES (860,8,'Nstab-main','sysop',0,0,0,0.485843330978,'20070310095009',860,7);
INSERT INTO page VALUES (861,8,'Nstab-media','sysop',0,0,0,0.72856268184,'20070310095009',861,10);
INSERT INTO page VALUES (862,8,'Nstab-mediawiki','sysop',0,0,0,0.051207996508,'20070310095009',862,7);
INSERT INTO page VALUES (863,8,'Nstab-special','sysop',0,0,0,0.90137714279,'20070310095009',863,7);
INSERT INTO page VALUES (864,8,'Nstab-template','sysop',0,0,0,0.081768540759,'20070310095009',864,8);
INSERT INTO page VALUES (865,8,'Nstab-user','sysop',0,0,0,0.197697787413,'20070310095009',865,9);
INSERT INTO page VALUES (866,8,'Nstab-wp','sysop',0,0,0,0.137920786104,'20070310095009',866,12);
INSERT INTO page VALUES (867,8,'Numauthors','sysop',0,0,0,0.565978573573,'20070310095009',867,40);
INSERT INTO page VALUES (868,8,'Number_of_watching_users_RCview','sysop',0,0,0,0.956138273533,'20070310095009',868,4);
INSERT INTO page VALUES (869,8,'Number_of_watching_users_pageview','sysop',0,0,0,0.804230596946,'20070310095009',869,20);
INSERT INTO page VALUES (870,8,'Numedits','sysop',0,0,0,0.024551771968,'20070310095009',870,29);
INSERT INTO page VALUES (871,8,'Numtalkauthors','sysop',0,0,0,0.315088032512,'20070310095009',871,48);
INSERT INTO page VALUES (872,8,'Numtalkedits','sysop',0,0,0,0.294316474232,'20070310095009',872,37);
INSERT INTO page VALUES (873,8,'Numwatchers','sysop',0,0,0,0.501670923035,'20070310095009',873,22);
INSERT INTO page VALUES (874,8,'Nviews','sysop',0,0,0,0.391899086935,'20070310095009',874,8);
INSERT INTO page VALUES (875,8,'Oct','sysop',0,0,0,0.541230513041,'20070310095009',875,3);
INSERT INTO page VALUES (876,8,'October','sysop',0,0,0,0.347648470119,'20070310095009',876,7);
INSERT INTO page VALUES (877,8,'Ok','sysop',0,0,0,0.749687898889,'20070310095009',877,2);
INSERT INTO page VALUES (878,8,'Oldpassword','sysop',0,0,0,0.125515397048,'20070310095009',878,13);
INSERT INTO page VALUES (879,8,'Orig','sysop',0,0,0,0.768240488143,'20070310095009',879,4);
INSERT INTO page VALUES (880,8,'Orphans','sysop',0,0,0,0.052644363526,'20070310095009',880,14);
INSERT INTO page VALUES (881,8,'Othercontribs','sysop',0,0,0,0.533874444198,'20070310095009',881,20);
INSERT INTO page VALUES (882,8,'Otherlanguages','sysop',0,0,0,0.079695211504,'20070310095009',882,18);
INSERT INTO page VALUES (883,8,'Others','sysop',0,0,0,0.233583545787,'20070310095009',883,6);
INSERT INTO page VALUES (884,8,'Pagemovedsub','sysop',0,0,0,0.212066451093,'20070310095009',884,14);
INSERT INTO page VALUES (885,8,'Pagemovedtext','sysop',0,0,0,0.027103874982,'20070310095009',885,32);
INSERT INTO page VALUES (886,8,'Pagetitle','sysop',0,0,0,0.239766342275,'20070310095009',886,17);
INSERT INTO page VALUES (887,8,'Passwordremindertext','sysop',0,0,0,0.217566597083,'20070310095009',887,389);
INSERT INTO page VALUES (888,8,'Passwordremindertitle','sysop',0,0,0,0.643747805851,'20070310095009',888,35);
INSERT INTO page VALUES (889,8,'Passwordsent','sysop',0,0,0,0.895429993801,'20070310095009',889,113);
INSERT INTO page VALUES (890,8,'Passwordtooshort','sysop',0,0,0,0.042693107692,'20070310095009',890,64);
INSERT INTO page VALUES (891,8,'Perfcached','sysop',0,0,0,0.136356136354,'20070310095009',891,66);
INSERT INTO page VALUES (892,8,'Perfdisabled','sysop',0,0,0,0.487578280346,'20070310095009',892,127);
INSERT INTO page VALUES (893,8,'Perfdisabledsub','sysop',0,0,0,0.396086877466,'20070310095009',893,29);
INSERT INTO page VALUES (894,8,'Permalink','sysop',0,0,0,0.343886067892,'20070310095009',894,14);
INSERT INTO page VALUES (895,8,'Personaltools','sysop',0,0,0,0.49526539339,'20070310095009',895,14);
INSERT INTO page VALUES (896,8,'Popularpages','sysop',0,0,0,0.996980078833,'20070310095009',896,13);
INSERT INTO page VALUES (897,8,'Portal','sysop',0,0,0,0.503342854059,'20070310095009',897,16);
INSERT INTO page VALUES (898,8,'Portal-url','sysop',0,0,0,0.365329242316,'20070310095009',898,24);
INSERT INTO page VALUES (899,8,'Postcomment','sysop',0,0,0,0.924644254863,'20070310095009',899,14);
INSERT INTO page VALUES (900,8,'Poweredby','sysop',0,0,0,0.419523266947,'20070310095009',900,93);
INSERT INTO page VALUES (901,8,'Powersearch','sysop',0,0,0,0.391879029412,'20070310095009',901,6);
INSERT INTO page VALUES (902,8,'Powersearchtext','sysop',0,0,0,0.191356475792,'20070310095009',902,80);
INSERT INTO page VALUES (903,8,'Preferences','sysop',0,0,0,0.817259588349,'20070310095009',903,11);
INSERT INTO page VALUES (904,8,'Prefixindex','sysop',0,0,0,0.941630106974,'20070310095010',904,12);
INSERT INTO page VALUES (905,8,'Prefs-help-email','sysop',0,0,0,0.464489775593,'20070310095010',905,131);
INSERT INTO page VALUES (906,8,'Prefs-help-email-enotif','sysop',0,0,0,0.424395052363,'20070310095010',906,86);
INSERT INTO page VALUES (907,8,'Prefs-help-realname','sysop',0,0,0,0.387350632845,'20070310095010',907,111);
INSERT INTO page VALUES (908,8,'Prefs-misc','sysop',0,0,0,0.349036115727,'20070310095010',908,4);
INSERT INTO page VALUES (909,8,'Prefs-personal','sysop',0,0,0,0.364439015475,'20070310095010',909,12);
INSERT INTO page VALUES (910,8,'Prefs-rc','sysop',0,0,0,0.251136423922,'20070310095010',910,14);
INSERT INTO page VALUES (911,8,'Prefsnologin','sysop',0,0,0,0.550373616469,'20070310095010',911,13);
INSERT INTO page VALUES (912,8,'Prefsnologintext','sysop',0,0,0,0.977347301705,'20070310095010',912,68);
INSERT INTO page VALUES (913,8,'Prefsreset','sysop',0,0,0,0.784773653292,'20070310095010',913,41);
INSERT INTO page VALUES (914,8,'Preview','sysop',0,0,0,0.222508180663,'20070310095010',914,7);
INSERT INTO page VALUES (915,8,'Previewconflict','sysop',0,0,0,0.837760183081,'20070310095010',915,102);
INSERT INTO page VALUES (916,8,'Previewnote','sysop',0,0,0,0.653849744389,'20070310095010',916,73);
INSERT INTO page VALUES (917,8,'Previousdiff','sysop',0,0,0,0.070636244382,'20070310095010',917,17);
INSERT INTO page VALUES (918,8,'Previousrevision','sysop',0,0,0,0.297506562993,'20070310095010',918,17);
INSERT INTO page VALUES (919,8,'Prevn','sysop',0,0,0,0.208838414873,'20070310095010',919,11);
INSERT INTO page VALUES (920,8,'Print','sysop',0,0,0,0.967865772823,'20070310095010',920,5);
INSERT INTO page VALUES (921,8,'Printableversion','sysop',0,0,0,0.535928345144,'20070310095010',921,17);
INSERT INTO page VALUES (922,8,'Printsubtitle','sysop',0,0,0,0.77765180963,'20070310095010',922,17);
INSERT INTO page VALUES (923,8,'Privacy','sysop',0,0,0,0.086275134313,'20070310095010',923,14);
INSERT INTO page VALUES (924,8,'Privacypage','sysop',0,0,0,0.415706022689,'20070310095010',924,22);
INSERT INTO page VALUES (925,8,'Protect','sysop',0,0,0,0.453397104739,'20070310095010',925,7);
INSERT INTO page VALUES (926,8,'Protect-default','sysop',0,0,0,0.263920182234,'20070310095010',926,9);
INSERT INTO page VALUES (927,8,'Protect-level-autoconfirmed','sysop',0,0,0,0.309203676355,'20070310095010',927,24);
INSERT INTO page VALUES (928,8,'Protect-level-sysop','sysop',0,0,0,0.053528712937,'20070310095010',928,11);
INSERT INTO page VALUES (929,8,'Protect-text','sysop',0,0,0,0.485675177402,'20070310095010',929,167);
INSERT INTO page VALUES (930,8,'Protect-unchain','sysop',0,0,0,0.502285794367,'20070310095010',930,23);
INSERT INTO page VALUES (931,8,'Protect-viewtext','sysop',0,0,0,0.729804446638,'20070310095010',931,135);
INSERT INTO page VALUES (932,8,'Protectcomment','sysop',0,0,0,0.189976423342,'20070310095010',932,21);
INSERT INTO page VALUES (933,8,'Protectedarticle','sysop',0,0,0,0.461523213039,'20070310095010',933,18);
INSERT INTO page VALUES (934,8,'Protectedpage','sysop',0,0,0,0.896170565345,'20070310095010',934,14);
INSERT INTO page VALUES (935,8,'Protectedpagewarning','sysop',0,0,0,0.388768377498,'20070310095010',935,201);
INSERT INTO page VALUES (936,8,'Protectedtext','sysop',0,0,0,0.091333044181,'20070310095010',936,182);
INSERT INTO page VALUES (937,8,'Protectlogpage','sysop',0,0,0,0.38825180755,'20070310095010',937,14);
INSERT INTO page VALUES (938,8,'Protectlogtext','sysop',0,0,0,0.066874637913,'20070310095010',938,91);
INSERT INTO page VALUES (939,8,'Protectmoveonly','sysop',0,0,0,0.755384929188,'20070310095010',939,23);
INSERT INTO page VALUES (940,8,'Protectpage','sysop',0,0,0,0.430523624735,'20070310095010',940,12);
INSERT INTO page VALUES (941,8,'Protectsub','sysop',0,0,0,0.587630667688,'20070310095010',941,17);
INSERT INTO page VALUES (942,8,'Protectthispage','sysop',0,0,0,0.667645415394,'20070310095010',942,17);
INSERT INTO page VALUES (943,8,'Proxyblocker','sysop',0,0,0,0.471479034958,'20070310095010',943,13);
INSERT INTO page VALUES (944,8,'Proxyblockreason','sysop',0,0,0,0.231691462645,'20070310095010',944,173);
INSERT INTO page VALUES (945,8,'Proxyblocksuccess','sysop',0,0,0,0.578781840685,'20070310095010',945,5);
INSERT INTO page VALUES (946,8,'Pubmedurl','sysop',0,0,0,0.799878357285,'20070310095010',946,95);
INSERT INTO page VALUES (947,8,'Qbbrowse','sysop',0,0,0,0.092192464554,'20070310095010',947,6);
INSERT INTO page VALUES (948,8,'Qbedit','sysop',0,0,0,0.518952400549,'20070310095010',948,4);
INSERT INTO page VALUES (949,8,'Qbfind','sysop',0,0,0,0.033092174659,'20070310095010',949,4);
INSERT INTO page VALUES (950,8,'Qbmyoptions','sysop',0,0,0,0.096768720532,'20070310095010',950,8);
INSERT INTO page VALUES (951,8,'Qbpageinfo','sysop',0,0,0,0.196133816258,'20070310095010',951,7);
INSERT INTO page VALUES (952,8,'Qbpageoptions','sysop',0,0,0,0.994303811199,'20070310095010',952,9);
INSERT INTO page VALUES (953,8,'Qbsettings','sysop',0,0,0,0.998945655187,'20070310095010',953,8);
INSERT INTO page VALUES (954,8,'Qbspecialpages','sysop',0,0,0,0.699927123393,'20070310095010',954,13);
INSERT INTO page VALUES (955,8,'Randompage','sysop',0,0,0,0.0846743243,'20070310095010',955,11);
INSERT INTO page VALUES (956,8,'Randompage-url','sysop',0,0,0,0.869521690045,'20070310095010',956,14);
INSERT INTO page VALUES (957,8,'Range_block_disabled','sysop',0,0,0,0.421608602765,'20070310095010',957,53);
INSERT INTO page VALUES (958,8,'Rc_categories','sysop',0,0,0,0.871250462447,'20070310095010',958,39);
INSERT INTO page VALUES (959,8,'Rc_categories_any','sysop',0,0,0,0.871870705357,'20070310095010',959,3);
INSERT INTO page VALUES (960,8,'Rchide','sysop',0,0,0,0.863563924893,'20070310095010',960,71);
INSERT INTO page VALUES (961,8,'Rclinks','sysop',0,0,0,0.447740157783,'20070310095010',961,44);
INSERT INTO page VALUES (962,8,'Rclistfrom','sysop',0,0,0,0.432114345022,'20070310095010',962,33);
INSERT INTO page VALUES (963,8,'Rcliu','sysop',0,0,0,0.745085475332,'20070310095010',963,31);
INSERT INTO page VALUES (964,8,'Rcloaderr','sysop',0,0,0,0.904597060582,'20070310095010',964,22);
INSERT INTO page VALUES (965,8,'Rclsub','sysop',0,0,0,0.938808525844,'20070310095010',965,27);
INSERT INTO page VALUES (966,8,'Rcnote','sysop',0,0,0,0.515436031034,'20070310095010',966,80);
INSERT INTO page VALUES (967,8,'Rcnotefrom','sysop',0,0,0,0.289336146299,'20070310095010',967,62);
INSERT INTO page VALUES (968,8,'Rcpatroldisabled','sysop',0,0,0,0.276302150459,'20070310095010',968,30);
INSERT INTO page VALUES (969,8,'Rcpatroldisabledtext','sysop',0,0,0,0.025036436683,'20070310095010',969,56);
INSERT INTO page VALUES (970,8,'Rcshowhideanons','sysop',0,0,0,0.255185925803,'20070310095010',970,18);
INSERT INTO page VALUES (971,8,'Rcshowhidebots','sysop',0,0,0,0.403982682917,'20070310095010',971,7);
INSERT INTO page VALUES (972,8,'Rcshowhideliu','sysop',0,0,0,0.877774494198,'20070310095010',972,18);
INSERT INTO page VALUES (973,8,'Rcshowhidemine','sysop',0,0,0,0.569879545318,'20070310095010',973,11);
INSERT INTO page VALUES (974,8,'Rcshowhideminor','sysop',0,0,0,0.797389240277,'20070310095010',974,14);
INSERT INTO page VALUES (975,8,'Rcshowhidepatr','sysop',0,0,0,0.93275624461,'20070310095010',975,18);
INSERT INTO page VALUES (976,8,'Readonly','sysop',0,0,0,0.579467582544,'20070310095010',976,15);
INSERT INTO page VALUES (977,8,'Readonly_lag','sysop',0,0,0,0.36447268061,'20070310095010',977,98);
INSERT INTO page VALUES (978,8,'Readonlytext','sysop',0,0,0,0.275376804778,'20070310095010',978,216);
INSERT INTO page VALUES (979,8,'Readonlywarning','sysop',0,0,0,0.687548068064,'20070310095010',979,202);
INSERT INTO page VALUES (980,8,'Recentchanges','sysop',0,0,0,0.168927837284,'20070310095010',980,14);
INSERT INTO page VALUES (981,8,'Recentchanges-url','sysop',0,0,0,0.542700944031,'20070310095010',981,21);
INSERT INTO page VALUES (982,8,'Recentchangesall','sysop',0,0,0,0.868287039447,'20070310095010',982,3);
INSERT INTO page VALUES (983,8,'Recentchangescount','sysop',0,0,0,0.737798968996,'20070310095010',983,25);
INSERT INTO page VALUES (984,8,'Recentchangeslinked','sysop',0,0,0,0.288216456778,'20070310095010',984,15);
INSERT INTO page VALUES (985,8,'Recentchangestext','sysop',0,0,0,0.680159643315,'20070310095010',985,55);
INSERT INTO page VALUES (986,8,'Recreate','sysop',0,0,0,0.667862690343,'20070310095010',986,8);
INSERT INTO page VALUES (987,8,'Redirectedfrom','sysop',0,0,0,0.072949574125,'20070310095010',987,20);
INSERT INTO page VALUES (988,8,'Redirectingto','sysop',0,0,0,0.834085291471,'20070310095010',988,24);
INSERT INTO page VALUES (989,8,'Redirectpagesub','sysop',0,0,0,0.381757499083,'20070310095010',989,13);
INSERT INTO page VALUES (990,8,'Remembermypassword','sysop',0,0,0,0.2432911908,'20070310095010',990,11);
INSERT INTO page VALUES (991,8,'Removechecked','sysop',0,0,0,0.118584841572,'20070310095010',991,35);
INSERT INTO page VALUES (992,8,'Removedwatch','sysop',0,0,0,0.458159906508,'20070310095010',992,22);
INSERT INTO page VALUES (993,8,'Removedwatchtext','sysop',0,0,0,0.75614649558,'20070310095010',993,56);
INSERT INTO page VALUES (994,8,'Removingchecked','sysop',0,0,0,0.233610273622,'20070310095010',994,42);
INSERT INTO page VALUES (995,8,'Renamegrouplogentry','sysop',0,0,0,0.196622579653,'20070310095010',995,22);
INSERT INTO page VALUES (996,8,'Resetprefs','sysop',0,0,0,0.232273773826,'20070310095010',996,5);
INSERT INTO page VALUES (997,8,'Restorelink','sysop',0,0,0,0.577233786149,'20070310095010',997,16);
INSERT INTO page VALUES (998,8,'Restorelink1','sysop',0,0,0,0.861173496048,'20070310095010',998,16);
INSERT INTO page VALUES (999,8,'Restrictedpheading','sysop',0,0,0,0.069249444237,'20070310095010',999,24);
INSERT INTO page VALUES (1000,8,'Restriction-edit','sysop',0,0,0,0.669987810508,'20070310095010',1000,4);
INSERT INTO page VALUES (1001,8,'Restriction-move','sysop',0,0,0,0.314283005918,'20070310095010',1001,4);
INSERT INTO page VALUES (1002,8,'Resultsperpage','sysop',0,0,0,0.262663963599,'20070310095010',1002,14);
INSERT INTO page VALUES (1003,8,'Retrievedfrom','sysop',0,0,0,0.325002470512,'20070310095010',1003,19);
INSERT INTO page VALUES (1004,8,'Returnto','sysop',0,0,0,0.029516985258,'20070310095010',1004,13);
INSERT INTO page VALUES (1005,8,'Retypenew','sysop',0,0,0,0.198751028564,'20070310095010',1005,20);
INSERT INTO page VALUES (1006,8,'Reupload','sysop',0,0,0,0.492167641736,'20070310095010',1006,9);
INSERT INTO page VALUES (1007,8,'Reuploaddesc','sysop',0,0,0,0.511037755782,'20070310095010',1007,26);
INSERT INTO page VALUES (1008,8,'Rev-deleted-comment','sysop',0,0,0,0.085083587165,'20070310095010',1008,17);
INSERT INTO page VALUES (1009,8,'Rev-deleted-text-permission','sysop',0,0,0,0.749287407358,'20070310095010',1009,198);
INSERT INTO page VALUES (1010,8,'Rev-deleted-text-view','sysop',0,0,0,0.819051962593,'20070310095010',1010,248);
INSERT INTO page VALUES (1011,8,'Rev-deleted-user','sysop',0,0,0,0.940298660362,'20070310095010',1011,18);
INSERT INTO page VALUES (1012,8,'Rev-delundel','sysop',0,0,0,0.115803567786,'20070310095010',1012,9);
INSERT INTO page VALUES (1013,8,'Revdelete-hide-comment','sysop',0,0,0,0.320245737757,'20070310095010',1013,17);
INSERT INTO page VALUES (1014,8,'Revdelete-hide-restricted','sysop',0,0,0,0.87095785048,'20070310095010',1014,52);
INSERT INTO page VALUES (1015,8,'Revdelete-hide-text','sysop',0,0,0,0.730041058934,'20070310095010',1015,18);
INSERT INTO page VALUES (1016,8,'Revdelete-hide-user','sysop',0,0,0,0.041993837765,'20070310095010',1016,25);
INSERT INTO page VALUES (1017,8,'Revdelete-legend','sysop',0,0,0,0.182176946599,'20070310095010',1017,26);
INSERT INTO page VALUES (1018,8,'Revdelete-log','sysop',0,0,0,0.697894985435,'20070310095010',1018,12);
INSERT INTO page VALUES (1019,8,'Revdelete-logentry','sysop',0,0,0,0.0598141902,'20070310095010',1019,38);
INSERT INTO page VALUES (1020,8,'Revdelete-selected','sysop',0,0,0,0.617707493047,'20070310095010',1020,29);
INSERT INTO page VALUES (1021,8,'Revdelete-submit','sysop',0,0,0,0.189442004381,'20070310095010',1021,26);
INSERT INTO page VALUES (1022,8,'Revdelete-text','sysop',0,0,0,0.040006857881,'20070310095010',1022,312);
INSERT INTO page VALUES (1023,8,'Reverted','sysop',0,0,0,0.654456886764,'20070310095010',1023,28);
INSERT INTO page VALUES (1024,8,'Revertimg','sysop',0,0,0,0.152912252368,'20070310095010',1024,3);
INSERT INTO page VALUES (1025,8,'Revertmove','sysop',0,0,0,0.83866807839,'20070310095010',1025,6);
INSERT INTO page VALUES (1026,8,'Revertpage','sysop',0,0,0,0.594155721203,'20070310095010',1026,121);
INSERT INTO page VALUES (1027,8,'Revhistory','sysop',0,0,0,0.968734548525,'20070310095010',1027,16);
INSERT INTO page VALUES (1028,8,'Revisionasof','sysop',0,0,0,0.261056662465,'20070310095010',1028,17);
INSERT INTO page VALUES (1029,8,'Revisionasofwithlink','sysop',0,0,0,0.878608295517,'20070310095010',1029,34);
INSERT INTO page VALUES (1030,8,'Revisiondelete','sysop',0,0,0,0.289141521936,'20070310095010',1030,25);
INSERT INTO page VALUES (1031,8,'Revnotfound','sysop',0,0,0,0.364913160915,'20070310095010',1031,18);
INSERT INTO page VALUES (1032,8,'Revnotfoundtext','sysop',0,0,0,0.457830310778,'20070310095010',1032,113);
INSERT INTO page VALUES (1033,8,'Rfcurl','sysop',0,0,0,0.559942871775,'20070310095010',1033,33);
INSERT INTO page VALUES (1034,8,'Rights','sysop',0,0,0,0.15323030965,'20070310095010',1034,7);
INSERT INTO page VALUES (1035,8,'Rightslogtext','sysop',0,0,0,0.145740088917,'20070310095010',1035,40);
INSERT INTO page VALUES (1036,8,'Rollback','sysop',0,0,0,0.910857640613,'20070310095010',1036,15);
INSERT INTO page VALUES (1037,8,'Rollback_short','sysop',0,0,0,0.62493300285,'20070310095010',1037,8);
INSERT INTO page VALUES (1038,8,'Rollbackfailed','sysop',0,0,0,0.410899421816,'20070310095010',1038,15);
INSERT INTO page VALUES (1039,8,'Rollbacklink','sysop',0,0,0,0.04940351327,'20070310095010',1039,8);
INSERT INTO page VALUES (1040,8,'Rows','sysop',0,0,0,0.619578240752,'20070310095010',1040,5);
INSERT INTO page VALUES (1041,8,'Saturday','sysop',0,0,0,0.837300260039,'20070310095010',1041,8);
INSERT INTO page VALUES (1042,8,'Savearticle','sysop',0,0,0,0.476179407342,'20070310095010',1042,9);
INSERT INTO page VALUES (1043,8,'Savedprefs','sysop',0,0,0,0.683528253476,'20070310095010',1043,33);
INSERT INTO page VALUES (1044,8,'Savefile','sysop',0,0,0,0.254515384298,'20070310095010',1044,9);
INSERT INTO page VALUES (1045,8,'Savegroup','sysop',0,0,0,0.075170696729,'20070310095010',1045,10);
INSERT INTO page VALUES (1046,8,'Saveprefs','sysop',0,0,0,0.918997893293,'20070310095010',1046,4);
INSERT INTO page VALUES (1047,8,'Saveusergroups','sysop',0,0,0,0.514986978684,'20070310095010',1047,16);
INSERT INTO page VALUES (1048,8,'Scarytranscludedisabled','sysop',0,0,0,0.129118536887,'20070310095010',1048,36);
INSERT INTO page VALUES (1049,8,'Scarytranscludefailed','sysop',0,0,0,0.292071015452,'20070310095010',1049,37);
INSERT INTO page VALUES (1050,8,'Scarytranscludetoolong','sysop',0,0,0,0.065062493173,'20070310095010',1050,24);
INSERT INTO page VALUES (1051,8,'Search','sysop',0,0,0,0.457651735672,'20070310095010',1051,6);
INSERT INTO page VALUES (1052,8,'Searchcontaining','sysop',0,0,0,0.772605221382,'20070310095010',1052,38);
INSERT INTO page VALUES (1053,8,'Searchdisabled','sysop',0,0,0,0.507833685607,'20070310095010',1053,143);
INSERT INTO page VALUES (1054,8,'Searchfulltext','sysop',0,0,0,0.916714616155,'20070310095010',1054,16);
INSERT INTO page VALUES (1055,8,'Searchnamed','sysop',0,0,0,0.670198314765,'20070310095010',1055,33);
INSERT INTO page VALUES (1056,8,'Searchquery','sysop',0,0,0,0.344843020165,'20070310095010',1056,14);
INSERT INTO page VALUES (1057,8,'Searchresults','sysop',0,0,0,0.719472558962,'20070310095010',1057,14);
INSERT INTO page VALUES (1058,8,'Searchresultshead','sysop',0,0,0,0.074515975555,'20070310095010',1058,6);
INSERT INTO page VALUES (1059,8,'Searchresulttext','sysop',0,0,0,0.714324731123,'20070310095010',1059,100);
INSERT INTO page VALUES (1060,8,'Sectionlink','sysop',0,0,0,0.057500524052,'20070310095010',1060,3);
INSERT INTO page VALUES (1061,8,'Selectnewerversionfordiff','sysop',0,0,0,0.283106186349,'20070310095010',1061,37);
INSERT INTO page VALUES (1062,8,'Selectolderversionfordiff','sysop',0,0,0,0.285021260536,'20070310095010',1062,38);
INSERT INTO page VALUES (1063,8,'Selfmove','sysop',0,0,0,0.962089720906,'20070310095010',1063,74);
INSERT INTO page VALUES (1064,8,'Semiprotectedpagewarning','sysop',0,0,0,0.403607236258,'20070310095010',1064,80);
INSERT INTO page VALUES (1065,8,'Sep','sysop',0,0,0,0.836824742347,'20070310095010',1065,3);
INSERT INTO page VALUES (1066,8,'September','sysop',0,0,0,0.017416251554,'20070310095010',1066,9);
INSERT INTO page VALUES (1067,8,'Servertime','sysop',0,0,0,0.975392067424,'20070310095010',1067,11);
INSERT INTO page VALUES (1068,8,'Session_fail_preview','sysop',0,0,0,0.238491979378,'20070310095010',1068,166);
INSERT INTO page VALUES (1069,8,'Session_fail_preview_html','sysop',0,0,0,0.813898840651,'20070310095010',1069,333);
INSERT INTO page VALUES (1070,8,'Sessionfailure','sysop',0,0,0,0.802245200968,'20070310095010',1070,194);
INSERT INTO page VALUES (1071,8,'Set_rights_fail','sysop',0,0,0,0.187638124994,'20070310095010',1071,81);
INSERT INTO page VALUES (1072,8,'Set_user_rights','sysop',0,0,0,0.168941964475,'20070310095010',1072,15);
INSERT INTO page VALUES (1073,8,'Setbureaucratflag','sysop',0,0,0,0.79877243609,'20070310095010',1073,19);
INSERT INTO page VALUES (1074,8,'Setstewardflag','sysop',0,0,0,0.446467053977,'20070310095010',1074,16);
INSERT INTO page VALUES (1075,8,'Shareddescriptionfollows','sysop',0,0,0,0.017960799394,'20070310095010',1075,1);
INSERT INTO page VALUES (1076,8,'Sharedupload','sysop',0,0,0,0.77828765791,'20070310095010',1076,63);
INSERT INTO page VALUES (1077,8,'Shareduploadwiki','sysop',0,0,0,0.714593642998,'20070310095010',1077,42);
INSERT INTO page VALUES (1078,8,'Shareduploadwiki-linktext','sysop',0,0,0,0.322172555788,'20070310095010',1078,21);
INSERT INTO page VALUES (1079,8,'Shortpages','sysop',0,0,0,0.585090080276,'20070310095010',1079,11);
INSERT INTO page VALUES (1080,8,'Show','sysop',0,0,0,0.35975654658,'20070310095010',1080,4);
INSERT INTO page VALUES (1081,8,'Showbigimage','sysop',0,0,0,0.030280052943,'20070310095010',1081,47);
INSERT INTO page VALUES (1082,8,'Showdiff','sysop',0,0,0,0.099880129724,'20070310095010',1082,12);
INSERT INTO page VALUES (1083,8,'Showhidebots','sysop',0,0,0,0.423043026268,'20070310095010',1083,9);
INSERT INTO page VALUES (1084,8,'Showingresults','sysop',0,0,0,0.081944795017,'20070310095010',1084,63);
INSERT INTO page VALUES (1085,8,'Showingresultsnum','sysop',0,0,0,0.914324481121,'20070310095010',1085,57);
INSERT INTO page VALUES (1086,8,'Showlast','sysop',0,0,0,0.872749867285,'20070310095010',1086,29);
INSERT INTO page VALUES (1087,8,'Showlivepreview','sysop',0,0,0,0.216959101813,'20070310095010',1087,12);
INSERT INTO page VALUES (1088,8,'Showpreview','sysop',0,0,0,0.441154612423,'20070310095010',1088,12);
INSERT INTO page VALUES (1089,8,'Showtoc','sysop',0,0,0,0.367340179583,'20070310095010',1089,4);
INSERT INTO page VALUES (1090,8,'Sidebar','sysop',0,0,0,0.863870636297,'20070310095010',1090,202);
INSERT INTO page VALUES (1091,8,'Sig_tip','sysop',0,0,0,0.499425142477,'20070310095010',1091,29);
INSERT INTO page VALUES (1092,8,'Signupend','sysop',0,0,0,0.193146232232,'20070310095010',1092,16);
INSERT INTO page VALUES (1093,8,'Sitenotice','sysop',0,0,0,0.859699417302,'20070310095010',1093,1);
INSERT INTO page VALUES (1094,8,'Sitestats','sysop',0,0,0,0.58230328835,'20070310095010',1094,23);
INSERT INTO page VALUES (1095,8,'Sitestatstext','sysop',0,0,0,0.201079211208,'20070310095010',1095,572);
INSERT INTO page VALUES (1096,8,'Sitesubtitle','sysop',0,0,0,0.775332186179,'20070310095010',1096,0);
INSERT INTO page VALUES (1097,8,'Sitesupport','sysop',0,0,0,0.187904324569,'20070310095010',1097,9);
INSERT INTO page VALUES (1098,8,'Sitesupport-url','sysop',0,0,0,0.423289867941,'20070310095010',1098,20);
INSERT INTO page VALUES (1099,8,'Sitetitle','sysop',0,0,0,0.983142664708,'20070310095010',1099,12);
INSERT INTO page VALUES (1100,8,'Siteuser','sysop',0,0,0,0.288718559224,'20070310095010',1100,20);
INSERT INTO page VALUES (1101,8,'Siteusers','sysop',0,0,0,0.833255267043,'20070310095010',1101,23);
INSERT INTO page VALUES (1102,8,'Skin','sysop',0,0,0,0.809609796126,'20070310095010',1102,4);
INSERT INTO page VALUES (1103,8,'Skinpreview','sysop',0,0,0,0.994401683234,'20070310095010',1103,9);
INSERT INTO page VALUES (1104,8,'Sorbs','sysop',0,0,0,0.971177717921,'20070310095010',1104,11);
INSERT INTO page VALUES (1105,8,'Sorbs_create_account_reason','sysop',0,0,0,0.271688123395,'20070310095010',1105,114);
INSERT INTO page VALUES (1106,8,'Sorbsreason','sysop',0,0,0,0.647822551153,'20070310095010',1106,85);
INSERT INTO page VALUES (1107,8,'Sourcefilename','sysop',0,0,0,0.088156400661,'20070310095010',1107,15);
INSERT INTO page VALUES (1108,8,'Spam_blanking','sysop',0,0,0,0.811035868886,'20070310095010',1108,45);
INSERT INTO page VALUES (1109,8,'Spam_reverting','sysop',0,0,0,0.746272438725,'20070310095010',1109,52);
INSERT INTO page VALUES (1110,8,'Spambot_username','sysop',0,0,0,0.387443847367,'20070310095010',1110,22);
INSERT INTO page VALUES (1111,8,'Spamprotectionmatch','sysop',0,0,0,0.208290417403,'20070310095010',1111,56);
INSERT INTO page VALUES (1112,8,'Spamprotectiontext','sysop',0,0,0,0.473827819852,'20070310095010',1112,114);
INSERT INTO page VALUES (1113,8,'Spamprotectiontitle','sysop',0,0,0,0.408032047272,'20070310095010',1113,22);
INSERT INTO page VALUES (1114,8,'Speciallogtitlelabel','sysop',0,0,0,0.052738921599,'20070310095010',1114,6);
INSERT INTO page VALUES (1115,8,'Specialloguserlabel','sysop',0,0,0,0.158076288156,'20070310095010',1115,5);
INSERT INTO page VALUES (1116,8,'Specialpage','sysop',0,0,0,0.43818190134,'20070310095010',1116,12);
INSERT INTO page VALUES (1117,8,'Specialpages','sysop',0,0,0,0.850387871314,'20070310095010',1117,13);
INSERT INTO page VALUES (1118,8,'Spheading','sysop',0,0,0,0.78172249699,'20070310095010',1118,27);
INSERT INTO page VALUES (1119,8,'Sqlhidden','sysop',0,0,0,0.883278340809,'20070310095010',1119,18);
INSERT INTO page VALUES (1120,8,'Statistics','sysop',0,0,0,0.913751448732,'20070310095010',1120,10);
INSERT INTO page VALUES (1121,8,'Storedversion','sysop',0,0,0,0.436292866728,'20070310095010',1121,14);
INSERT INTO page VALUES (1122,8,'Stubthreshold','sysop',0,0,0,0.823453052266,'20070310095010',1122,27);
INSERT INTO page VALUES (1123,8,'Subcategories','sysop',0,0,0,0.441621153811,'20070310095010',1123,13);
INSERT INTO page VALUES (1124,8,'Subcategorycount','sysop',0,0,0,0.318997301132,'20070310095010',1124,44);
INSERT INTO page VALUES (1125,8,'Subcategorycount1','sysop',0,0,0,0.172448692048,'20070310095010',1125,41);
INSERT INTO page VALUES (1126,8,'Subject','sysop',0,0,0,0.523206487044,'20070310095010',1126,16);
INSERT INTO page VALUES (1127,8,'Subjectpage','sysop',0,0,0,0.930505954689,'20070310095010',1127,12);
INSERT INTO page VALUES (1128,8,'Successfulupload','sysop',0,0,0,0.002176740196,'20070310095010',1128,17);
INSERT INTO page VALUES (1129,8,'Summary','sysop',0,0,0,0.090940581745,'20070310095010',1129,7);
INSERT INTO page VALUES (1130,8,'Sunday','sysop',0,0,0,0.512147575184,'20070310095010',1130,6);
INSERT INTO page VALUES (1131,8,'Sysoptext','sysop',0,0,0,0.252089591542,'20070310095010',1131,93);
INSERT INTO page VALUES (1132,8,'Sysoptitle','sysop',0,0,0,0.540120476721,'20070310095010',1132,21);
INSERT INTO page VALUES (1133,8,'Tableform','sysop',0,0,0,0.437532716133,'20070310095010',1133,5);
INSERT INTO page VALUES (1134,8,'Tagline','sysop',0,0,0,0.83438380496,'20070310095010',1134,17);
INSERT INTO page VALUES (1135,8,'Talk','sysop',0,0,0,0.918903928959,'20070310095010',1135,10);
INSERT INTO page VALUES (1136,8,'Talkexists','sysop',0,0,0,0.457990678412,'20070310095010',1136,155);
INSERT INTO page VALUES (1137,8,'Talkpage','sysop',0,0,0,0.483264270647,'20070310095010',1137,17);
INSERT INTO page VALUES (1138,8,'Talkpagemoved','sysop',0,0,0,0.335414497998,'20070310095010',1138,43);
INSERT INTO page VALUES (1139,8,'Talkpagenotmoved','sysop',0,0,0,0.4444631397,'20070310095010',1139,59);
INSERT INTO page VALUES (1140,8,'Talkpagetext','sysop',0,0,0,0.111178942063,'20070310095010',1140,31);
INSERT INTO page VALUES (1141,8,'Templatesused','sysop',0,0,0,0.396769359381,'20070310095010',1141,28);
INSERT INTO page VALUES (1142,8,'Textboxsize','sysop',0,0,0,0.26945887708,'20070310095010',1142,7);
INSERT INTO page VALUES (1143,8,'Textmatches','sysop',0,0,0,0.675181770321,'20070310095010',1143,17);
INSERT INTO page VALUES (1144,8,'Thisisdeleted','sysop',0,0,0,0.18245327874,'20070310095010',1144,19);
INSERT INTO page VALUES (1145,8,'Thumbnail-more','sysop',0,0,0,0.896626381431,'20070310095010',1145,7);
INSERT INTO page VALUES (1146,8,'Thumbnail_error','sysop',0,0,0,0.256220458383,'20070310095010',1146,28);
INSERT INTO page VALUES (1147,8,'Thumbsize','sysop',0,0,0,0.741254856233,'20070310095010',1147,15);
INSERT INTO page VALUES (1148,8,'Thursday','sysop',0,0,0,0.704937079308,'20070310095010',1148,8);
INSERT INTO page VALUES (1149,8,'Timezonelegend','sysop',0,0,0,0.637690154976,'20070310095010',1149,9);
INSERT INTO page VALUES (1150,8,'Timezoneoffset','sysop',0,0,0,0.078875236214,'20070310095010',1150,8);
INSERT INTO page VALUES (1151,8,'Timezonetext','sysop',0,0,0,0.560490672034,'20070310095010',1151,67);
INSERT INTO page VALUES (1152,8,'Titlematches','sysop',0,0,0,0.892621404929,'20070310095010',1152,21);
INSERT INTO page VALUES (1153,8,'Toc','sysop',0,0,0,0.207818050839,'20070310095010',1153,8);
INSERT INTO page VALUES (1154,8,'Tog-autopatrol','sysop',0,0,0,0.931664343386,'20070310095010',1154,30);
INSERT INTO page VALUES (1155,8,'Tog-editondblclick','sysop',0,0,0,0.000293851599,'20070310095010',1155,39);
INSERT INTO page VALUES (1156,8,'Tog-editsection','sysop',0,0,0,0.413213999427,'20070310095010',1156,39);
INSERT INTO page VALUES (1157,8,'Tog-editsectiononrightclick','sysop',0,0,0,0.832317355657,'20070310095010',1157,77);
INSERT INTO page VALUES (1158,8,'Tog-editwidth','sysop',0,0,0,0.661723887839,'20070310095010',1158,23);
INSERT INTO page VALUES (1159,8,'Tog-enotifminoredits','sysop',0,0,0,0.182401072027,'20070310095010',1159,39);
INSERT INTO page VALUES (1160,8,'Tog-enotifrevealaddr','sysop',0,0,0,0.352843759674,'20070310095010',1160,46);
INSERT INTO page VALUES (1161,8,'Tog-enotifusertalkpages','sysop',0,0,0,0.790066408498,'20070310095010',1161,43);
INSERT INTO page VALUES (1162,8,'Tog-enotifwatchlistpages','sysop',0,0,0,0.323956605566,'20070310095010',1162,25);
INSERT INTO page VALUES (1163,8,'Tog-externaldiff','sysop',0,0,0,0.555362095223,'20070310095010',1163,28);
INSERT INTO page VALUES (1164,8,'Tog-externaleditor','sysop',0,0,0,0.27823813431,'20070310095010',1164,30);
INSERT INTO page VALUES (1165,8,'Tog-fancysig','sysop',0,0,0,0.64256310786,'20070310095010',1165,39);
INSERT INTO page VALUES (1166,8,'Tog-forceeditsummary','sysop',0,0,0,0.68666999695,'20070310095010',1166,44);
INSERT INTO page VALUES (1167,8,'Tog-hideminor','sysop',0,0,0,0.166073041077,'20070310095010',1167,34);
INSERT INTO page VALUES (1168,8,'Tog-highlightbroken','sysop',0,0,0,0.402705922493,'20070310095010',1168,115);
INSERT INTO page VALUES (1169,8,'Tog-justify','sysop',0,0,0,0.961708406909,'20070310095010',1169,18);
INSERT INTO page VALUES (1170,8,'Tog-minordefault','sysop',0,0,0,0.719401665846,'20070310095010',1170,31);
INSERT INTO page VALUES (1171,8,'Tog-nocache','sysop',0,0,0,0.624418294235,'20070310095010',1171,20);
INSERT INTO page VALUES (1172,8,'Tog-numberheadings','sysop',0,0,0,0.136577545197,'20070310095010',1172,20);
INSERT INTO page VALUES (1173,8,'Tog-previewonfirst','sysop',0,0,0,0.979326971476,'20070310095010',1173,26);
INSERT INTO page VALUES (1174,8,'Tog-previewontop','sysop',0,0,0,0.651263919723,'20070310095010',1174,28);
INSERT INTO page VALUES (1175,8,'Tog-rememberpassword','sysop',0,0,0,0.668879424265,'20070310095010',1175,24);
INSERT INTO page VALUES (1176,8,'Tog-showjumplinks','sysop',0,0,0,0.193423995431,'20070310095010',1176,36);
INSERT INTO page VALUES (1177,8,'Tog-shownumberswatching','sysop',0,0,0,0.929227433462,'20070310095010',1177,33);
INSERT INTO page VALUES (1178,8,'Tog-showtoc','sysop',0,0,0,0.490794763788,'20070310095010',1178,60);
INSERT INTO page VALUES (1179,8,'Tog-showtoolbar','sysop',0,0,0,0.905585583403,'20070310095010',1179,30);
INSERT INTO page VALUES (1180,8,'Tog-underline','sysop',0,0,0,0.571388833212,'20070310095010',1180,16);
INSERT INTO page VALUES (1181,8,'Tog-uselivepreview','sysop',0,0,0,0.193586816207,'20070310095010',1181,44);
INSERT INTO page VALUES (1182,8,'Tog-usenewrc','sysop',0,0,0,0.525294370388,'20070310095010',1182,36);
INSERT INTO page VALUES (1183,8,'Tog-watchcreations','sysop',0,0,0,0.224116948228,'20070310095010',1183,34);
INSERT INTO page VALUES (1184,8,'Tog-watchdefault','sysop',0,0,0,0.844166333604,'20070310095010',1184,32);
INSERT INTO page VALUES (1185,8,'Toolbox','sysop',0,0,0,0.476738964789,'20070310095010',1185,7);
INSERT INTO page VALUES (1186,8,'Tooltip-compareselectedversions','sysop',0,0,0,0.444935321302,'20070310095010',1186,75);
INSERT INTO page VALUES (1187,8,'Tooltip-diff','sysop',0,0,0,0.586131357615,'20070310095010',1187,48);
INSERT INTO page VALUES (1188,8,'Tooltip-minoredit','sysop',0,0,0,0.367797130901,'20070310095010',1188,33);
INSERT INTO page VALUES (1189,8,'Tooltip-preview','sysop',0,0,0,0.201754141511,'20070310095010',1189,60);
INSERT INTO page VALUES (1190,8,'Tooltip-recreate','sysop',0,0,0,0.747259335688,'20070310095010',1190,0);
INSERT INTO page VALUES (1191,8,'Tooltip-save','sysop',0,0,0,0.47766326207,'20070310095010',1191,25);
INSERT INTO page VALUES (1192,8,'Tooltip-search','sysop',0,0,0,0.489214327458,'20070310095010',1192,27);
INSERT INTO page VALUES (1193,8,'Tooltip-watch','sysop',0,0,0,0.18757807799,'20070310095010',1193,39);
INSERT INTO page VALUES (1194,8,'Trackback','sysop',0,0,0,0.446478809059,'20070310095010',1194,16);
INSERT INTO page VALUES (1195,8,'Trackbackbox','sysop',0,0,0,0.58215027058,'20070310095010',1195,69);
INSERT INTO page VALUES (1196,8,'Trackbackdeleteok','sysop',0,0,0,0.11798781985,'20070310095010',1196,39);
INSERT INTO page VALUES (1197,8,'Trackbackexcerpt','sysop',0,0,0,0.252243920962,'20070310095010',1197,37);
INSERT INTO page VALUES (1198,8,'Trackbacklink','sysop',0,0,0,0.619801742161,'20070310095010',1198,9);
INSERT INTO page VALUES (1199,8,'Trackbackremove','sysop',0,0,0,0.262056511952,'20070310095010',1199,14);
INSERT INTO page VALUES (1200,8,'Tryexact','sysop',0,0,0,0.8842591745,'20070310095010',1200,15);
INSERT INTO page VALUES (1201,8,'Tuesday','sysop',0,0,0,0.486303210732,'20070310095010',1201,7);
INSERT INTO page VALUES (1202,8,'Uclinks','sysop',0,0,0,0.742022735902,'20070310095010',1202,48);
INSERT INTO page VALUES (1203,8,'Ucnote','sysop',0,0,0,0.229234507323,'20070310095010',1203,72);
INSERT INTO page VALUES (1204,8,'Uctop','sysop',0,0,0,0.440697931907,'20070310095010',1204,6);
INSERT INTO page VALUES (1205,8,'Uid','sysop',0,0,0,0.35635133168,'20070310095010',1205,8);
INSERT INTO page VALUES (1206,8,'Unblockip','sysop',0,0,0,0.729425009333,'20070310095011',1206,12);
INSERT INTO page VALUES (1207,8,'Unblockiptext','sysop',0,0,0,0.233080816497,'20070310095011',1207,90);
INSERT INTO page VALUES (1208,8,'Unblocklink','sysop',0,0,0,0.068860463633,'20070310095011',1208,7);
INSERT INTO page VALUES (1209,8,'Unblocklogentry','sysop',0,0,0,0.690631419844,'20070310095011',1209,12);
INSERT INTO page VALUES (1210,8,'Uncategorizedcategories','sysop',0,0,0,0.375626177808,'20070310095011',1210,24);
INSERT INTO page VALUES (1211,8,'Uncategorizedpages','sysop',0,0,0,0.629387485631,'20070310095011',1211,19);
INSERT INTO page VALUES (1212,8,'Undelete','sysop',0,0,0,0.261977851895,'20070310095011',1212,18);
INSERT INTO page VALUES (1213,8,'Undelete_short','sysop',0,0,0,0.623014550631,'20070310095011',1213,17);
INSERT INTO page VALUES (1214,8,'Undelete_short1','sysop',0,0,0,0.856499717475,'20070310095011',1214,17);
INSERT INTO page VALUES (1215,8,'Undeletearticle','sysop',0,0,0,0.457739792879,'20070310095011',1215,20);
INSERT INTO page VALUES (1216,8,'Undeletebtn','sysop',0,0,0,0.714688417889,'20070310095011',1216,8);
INSERT INTO page VALUES (1217,8,'Undeletedarticle','sysop',0,0,0,0.914537432935,'20070310095011',1217,17);
INSERT INTO page VALUES (1218,8,'Undeletedrevisions','sysop',0,0,0,0.189485608019,'20070310095011',1218,21);
INSERT INTO page VALUES (1219,8,'Undeletedtext','sysop',0,0,0,0.426133357783,'20070310095011',1219,120);
INSERT INTO page VALUES (1220,8,'Undeletehistory','sysop',0,0,0,0.13151111081,'20070310095011',1220,276);
INSERT INTO page VALUES (1221,8,'Undeletehistorynoadmin','sysop',0,0,0,0.939176833174,'20070310095011',1221,239);
INSERT INTO page VALUES (1222,8,'Undeletepage','sysop',0,0,0,0.167313065896,'20070310095011',1222,30);
INSERT INTO page VALUES (1223,8,'Undeletepagetext','sysop',0,0,0,0.413502236559,'20070310095011',1223,132);
INSERT INTO page VALUES (1224,8,'Undeleterevision','sysop',0,0,0,0.964548904295,'20070310095011',1224,25);
INSERT INTO page VALUES (1225,8,'Undeleterevisions','sysop',0,0,0,0.648843795874,'20070310095011',1225,21);
INSERT INTO page VALUES (1226,8,'Underline-always','sysop',0,0,0,0.125744759281,'20070310095011',1226,6);
INSERT INTO page VALUES (1227,8,'Underline-default','sysop',0,0,0,0.511244674679,'20070310095011',1227,15);
INSERT INTO page VALUES (1228,8,'Underline-never','sysop',0,0,0,0.493673684098,'20070310095011',1228,5);
INSERT INTO page VALUES (1229,8,'Unexpected','sysop',0,0,0,0.794298680782,'20070310095011',1229,28);
INSERT INTO page VALUES (1230,8,'Unit-pixel','sysop',0,0,0,0.473110064854,'20070310095011',1230,2);
INSERT INTO page VALUES (1231,8,'Unlockbtn','sysop',0,0,0,0.910157341685,'20070310095011',1231,15);
INSERT INTO page VALUES (1232,8,'Unlockconfirm','sysop',0,0,0,0.048167630971,'20070310095011',1232,42);
INSERT INTO page VALUES (1233,8,'Unlockdb','sysop',0,0,0,0.101937904524,'20070310095011',1233,15);
INSERT INTO page VALUES (1234,8,'Unlockdbsuccesssub','sysop',0,0,0,0.538405957561,'20070310095011',1234,21);
INSERT INTO page VALUES (1235,8,'Unlockdbsuccesstext','sysop',0,0,0,0.625513668519,'20070310095011',1235,31);
INSERT INTO page VALUES (1236,8,'Unlockdbtext','sysop',0,0,0,0.998568924073,'20070310095011',1236,227);
INSERT INTO page VALUES (1237,8,'Unprotect','sysop',0,0,0,0.377042145182,'20070310095011',1237,9);
INSERT INTO page VALUES (1238,8,'Unprotectcomment','sysop',0,0,0,0.724766361255,'20070310095011',1238,23);
INSERT INTO page VALUES (1239,8,'Unprotectedarticle','sysop',0,0,0,0.845003594784,'20070310095011',1239,20);
INSERT INTO page VALUES (1240,8,'Unprotectsub','sysop',0,0,0,0.301976871827,'20070310095011',1240,19);
INSERT INTO page VALUES (1241,8,'Unprotectthispage','sysop',0,0,0,0.705902259093,'20070310095011',1241,19);
INSERT INTO page VALUES (1242,8,'Unusedcategories','sysop',0,0,0,0.578703202937,'20070310095011',1242,17);
INSERT INTO page VALUES (1243,8,'Unusedcategoriestext','sysop',0,0,0,0.302704525965,'20070310095011',1243,90);
INSERT INTO page VALUES (1244,8,'Unusedimages','sysop',0,0,0,0.174514930879,'20070310095011',1244,12);
INSERT INTO page VALUES (1245,8,'Unusedimagestext','sysop',0,0,0,0.996598773081,'20070310095011',1245,140);
INSERT INTO page VALUES (1246,8,'Unwatch','sysop',0,0,0,0.53000875327,'20070310095011',1246,7);
INSERT INTO page VALUES (1247,8,'Unwatchedpages','sysop',0,0,0,0.242472708429,'20070310095011',1247,15);
INSERT INTO page VALUES (1248,8,'Unwatchthispage','sysop',0,0,0,0.063756818552,'20070310095011',1248,13);
INSERT INTO page VALUES (1249,8,'Updated','sysop',0,0,0,0.082413498124,'20070310095011',1249,9);
INSERT INTO page VALUES (1250,8,'Updatedmarker','sysop',0,0,0,0.454005651184,'20070310095011',1250,27);
INSERT INTO page VALUES (1251,8,'Upload','sysop',0,0,0,0.511742514902,'20070310095011',1251,11);
INSERT INTO page VALUES (1252,8,'Upload_directory_read_only','sysop',0,0,0,0.777735662843,'20070310095011',1252,59);
INSERT INTO page VALUES (1253,8,'Uploadbtn','sysop',0,0,0,0.283214499269,'20070310095011',1253,11);
INSERT INTO page VALUES (1254,8,'Uploadcorrupt','sysop',0,0,0,0.087332314731,'20070310095011',1254,90);
INSERT INTO page VALUES (1255,8,'Uploaddisabled','sysop',0,0,0,0.459997575555,'20070310095011',1255,16);
INSERT INTO page VALUES (1256,8,'Uploaddisabledtext','sysop',0,0,0,0.721127750598,'20070310095011',1256,39);
INSERT INTO page VALUES (1257,8,'Uploadedfiles','sysop',0,0,0,0.63301151887,'20070310095011',1257,14);
INSERT INTO page VALUES (1258,8,'Uploadedimage','sysop',0,0,0,0.646626274085,'20070310095011',1258,17);
INSERT INTO page VALUES (1259,8,'Uploaderror','sysop',0,0,0,0.763424514412,'20070310095011',1259,12);
INSERT INTO page VALUES (1260,8,'Uploadlink','sysop',0,0,0,0.09616178246,'20070310095011',1260,13);
INSERT INTO page VALUES (1261,8,'Uploadlog','sysop',0,0,0,0.234703686293,'20070310095011',1261,10);
INSERT INTO page VALUES (1262,8,'Uploadlogpage','sysop',0,0,0,0.159256591804,'20070310095011',1262,10);
INSERT INTO page VALUES (1263,8,'Uploadlogpagetext','sysop',0,0,0,0.920858306845,'20070310095011',1263,48);
INSERT INTO page VALUES (1264,8,'Uploadnewversion','sysop',0,0,0,0.621062750877,'20070310095011',1264,38);
INSERT INTO page VALUES (1265,8,'Uploadnologin','sysop',0,0,0,0.37657587707,'20070310095011',1265,13);
INSERT INTO page VALUES (1266,8,'Uploadnologintext','sysop',0,0,0,0.713209344731,'20070310095011',1266,60);
INSERT INTO page VALUES (1267,8,'Uploadscripted','sysop',0,0,0,0.80410221245,'20070310095011',1267,95);
INSERT INTO page VALUES (1268,8,'Uploadtext','sysop',0,0,0,0.26684883393,'20070310095011',1268,455);
INSERT INTO page VALUES (1269,8,'Uploadvirus','sysop',0,0,0,0.958831994186,'20070310095011',1269,38);
INSERT INTO page VALUES (1270,8,'Uploadwarning','sysop',0,0,0,0.982091933579,'20070310095011',1270,14);
INSERT INTO page VALUES (1271,8,'Usenewcategorypage','sysop',0,0,0,0.716353857482,'20070310095011',1271,70);
INSERT INTO page VALUES (1272,8,'User_rights_set','sysop',0,0,0,0.04720147111,'20070310095011',1272,35);
INSERT INTO page VALUES (1273,8,'Usercssjsyoucanpreview','sysop',0,0,0,0.929442928169,'20070310095011',1273,90);
INSERT INTO page VALUES (1274,8,'Usercsspreview','sysop',0,0,0,0.2733147608,'20070310095011',1274,85);
INSERT INTO page VALUES (1275,8,'Userexists','sysop',0,0,0,0.104587594943,'20070310095011',1275,64);
INSERT INTO page VALUES (1276,8,'Userinvalidcssjstitle','sysop',0,0,0,0.034951297662,'20070310095011',1276,164);
INSERT INTO page VALUES (1277,8,'Userjspreview','sysop',0,0,0,0.580586520435,'20070310095011',1277,100);
INSERT INTO page VALUES (1278,8,'Userlogin','sysop',0,0,0,0.188218695044,'20070310095011',1278,23);
INSERT INTO page VALUES (1279,8,'Userlogout','sysop',0,0,0,0.925307369136,'20070310095011',1279,7);
INSERT INTO page VALUES (1280,8,'Usermailererror','sysop',0,0,0,0.147950255649,'20070310095011',1280,27);
INSERT INTO page VALUES (1281,8,'Username','sysop',0,0,0,0.9103905724,'20070310095011',1281,9);
INSERT INTO page VALUES (1282,8,'Userpage','sysop',0,0,0,0.21030371175,'20070310095011',1282,14);
INSERT INTO page VALUES (1283,8,'Userrights','sysop',0,0,0,0.997473311541,'20070310095011',1283,22);
INSERT INTO page VALUES (1284,8,'Userrights-editusergroup','sysop',0,0,0,0.628484154502,'20070310095011',1284,16);
INSERT INTO page VALUES (1285,8,'Userrights-groupsavailable','sysop',0,0,0,0.811927434404,'20070310095011',1285,17);
INSERT INTO page VALUES (1286,8,'Userrights-groupshelp','sysop',0,0,0,0.251302266485,'20070310095011',1286,150);
INSERT INTO page VALUES (1287,8,'Userrights-groupsmember','sysop',0,0,0,0.912170797468,'20070310095011',1287,10);
INSERT INTO page VALUES (1288,8,'Userrights-logcomment','sysop',0,0,0,0.315317954012,'20070310095011',1288,38);
INSERT INTO page VALUES (1289,8,'Userrights-lookup-user','sysop',0,0,0,0.351318190998,'20070310095011',1289,18);
INSERT INTO page VALUES (1290,8,'Userrights-user-editname','sysop',0,0,0,0.015140997821,'20070310095011',1290,17);
INSERT INTO page VALUES (1291,8,'Userstats','sysop',0,0,0,0.948035820361,'20070310095011',1291,15);
INSERT INTO page VALUES (1292,8,'Userstatstext','sysop',0,0,0,0.488914039477,'20070310095011',1292,98);
INSERT INTO page VALUES (1293,8,'Variantname-sr','sysop',0,0,0,0.017300900095,'20070310095011',1293,2);
INSERT INTO page VALUES (1294,8,'Variantname-sr-ec','sysop',0,0,0,0.951863122203,'20070310095011',1294,5);
INSERT INTO page VALUES (1295,8,'Variantname-sr-el','sysop',0,0,0,0.320827482321,'20070310095011',1295,5);
INSERT INTO page VALUES (1296,8,'Variantname-sr-jc','sysop',0,0,0,0.276424855969,'20070310095011',1296,5);
INSERT INTO page VALUES (1297,8,'Variantname-sr-jl','sysop',0,0,0,0.234801901119,'20070310095011',1297,5);
INSERT INTO page VALUES (1298,8,'Variantname-zh','sysop',0,0,0,0.381330776754,'20070310095011',1298,2);
INSERT INTO page VALUES (1299,8,'Variantname-zh-cn','sysop',0,0,0,0.792368411972,'20070310095011',1299,2);
INSERT INTO page VALUES (1300,8,'Variantname-zh-hk','sysop',0,0,0,0.775848612554,'20070310095011',1300,2);
INSERT INTO page VALUES (1301,8,'Variantname-zh-sg','sysop',0,0,0,0.41661351256,'20070310095011',1301,2);
INSERT INTO page VALUES (1302,8,'Variantname-zh-tw','sysop',0,0,0,0.956633274508,'20070310095011',1302,2);
INSERT INTO page VALUES (1303,8,'Version','sysop',0,0,0,0.344421940697,'20070310095011',1303,7);
INSERT INTO page VALUES (1304,8,'Versionrequired','sysop',0,0,0,0.512494686686,'20070310095011',1304,32);
INSERT INTO page VALUES (1305,8,'Versionrequiredtext','sysop',0,0,0,0.053767889778,'20070310095011',1305,77);
INSERT INTO page VALUES (1306,8,'Viewcount','sysop',0,0,0,0.905883203837,'20070310095011',1306,37);
INSERT INTO page VALUES (1307,8,'Viewdeleted','sysop',0,0,0,0.038549952164,'20070310095011',1307,8);
INSERT INTO page VALUES (1308,8,'Viewdeletedpage','sysop',0,0,0,0.841927147678,'20070310095011',1308,18);
INSERT INTO page VALUES (1309,8,'Viewprevnext','sysop',0,0,0,0.318587121616,'20070310095011',1309,20);
INSERT INTO page VALUES (1310,8,'Views','sysop',0,0,0,0.009862671287,'20070310095011',1310,5);
INSERT INTO page VALUES (1311,8,'Viewsource','sysop',0,0,0,0.445223168007,'20070310095011',1311,11);
INSERT INTO page VALUES (1312,8,'Viewsourcefor','sysop',0,0,0,0.053724579265,'20070310095011',1312,6);
INSERT INTO page VALUES (1313,8,'Viewtalkpage','sysop',0,0,0,0.511180859643,'20070310095011',1313,15);
INSERT INTO page VALUES (1314,8,'Wantedcategories','sysop',0,0,0,0.458315178171,'20070310095011',1314,17);
INSERT INTO page VALUES (1315,8,'Wantedpages','sysop',0,0,0,0.556454476113,'20070310095011',1315,12);
INSERT INTO page VALUES (1316,8,'Watch','sysop',0,0,0,0.469179253351,'20070310095011',1316,5);
INSERT INTO page VALUES (1317,8,'Watchdetails','sysop',0,0,0,0.247536282922,'20070310095011',1317,104);
INSERT INTO page VALUES (1318,8,'Watcheditlist','sysop',0,0,0,0.096114393762,'20070310095011',1318,270);
INSERT INTO page VALUES (1319,8,'Watchlist','sysop',0,0,0,0.287950266866,'20070310095011',1319,12);
INSERT INTO page VALUES (1320,8,'Watchlistall1','sysop',0,0,0,0.227857196107,'20070310095011',1320,3);
INSERT INTO page VALUES (1321,8,'Watchlistall2','sysop',0,0,0,0.439325348058,'20070310095011',1321,3);
INSERT INTO page VALUES (1322,8,'Watchlistcontains','sysop',0,0,0,0.731276350162,'20070310095011',1322,33);
INSERT INTO page VALUES (1323,8,'Watchlistsub','sysop',0,0,0,0.679816997688,'20070310095011',1323,15);
INSERT INTO page VALUES (1324,8,'Watchmethod-list','sysop',0,0,0,0.279504061375,'20070310095011',1324,39);
INSERT INTO page VALUES (1325,8,'Watchmethod-recent','sysop',0,0,0,0.012720222604,'20070310095011',1325,39);
INSERT INTO page VALUES (1326,8,'Watchnochange','sysop',0,0,0,0.203868337889,'20070310095011',1326,67);
INSERT INTO page VALUES (1327,8,'Watchnologin','sysop',0,0,0,0.010941603078,'20070310095011',1327,13);
INSERT INTO page VALUES (1328,8,'Watchnologintext','sysop',0,0,0,0.139997077762,'20070310095011',1328,69);
INSERT INTO page VALUES (1329,8,'Watchthis','sysop',0,0,0,0.472858430502,'20070310095011',1329,15);
INSERT INTO page VALUES (1330,8,'Watchthispage','sysop',0,0,0,0.640543356918,'20070310095011',1330,15);
INSERT INTO page VALUES (1331,8,'Wednesday','sysop',0,0,0,0.047354216594,'20070310095011',1331,9);
INSERT INTO page VALUES (1332,8,'Welcomecreation','sysop',0,0,0,0.358506524356,'20070310095011',1332,104);
INSERT INTO page VALUES (1333,8,'Whatlinkshere','sysop',0,0,0,0.955973052807,'20070310095011',1333,15);
INSERT INTO page VALUES (1334,8,'Whitelistacctext','sysop',0,0,0,0.359095149426,'20070310095011',1334,124);
INSERT INTO page VALUES (1335,8,'Whitelistacctitle','sysop',0,0,0,0.112112835535,'20070310095011',1335,40);
INSERT INTO page VALUES (1336,8,'Whitelistedittext','sysop',0,0,0,0.133630899991,'20070310095011',1336,54);
INSERT INTO page VALUES (1337,8,'Whitelistedittitle','sysop',0,0,0,0.771856805945,'20070310095011',1337,22);
INSERT INTO page VALUES (1338,8,'Whitelistreadtext','sysop',0,0,0,0.890676233509,'20070310095011',1338,54);
INSERT INTO page VALUES (1339,8,'Whitelistreadtitle','sysop',0,0,0,0.69494114127,'20070310095011',1339,22);
INSERT INTO page VALUES (1340,8,'Widthheight','sysop',0,0,0,0.277125771127,'20070310095011',1340,5);
INSERT INTO page VALUES (1341,8,'Wikipediapage','sysop',0,0,0,0.07869734108,'20070310095011',1341,17);
INSERT INTO page VALUES (1342,8,'Wlheader-enotif','sysop',0,0,0,0.854788953304,'20070310095011',1342,33);
INSERT INTO page VALUES (1343,8,'Wlheader-showupdated','sysop',0,0,0,0.374193650255,'20070310095011',1343,83);
INSERT INTO page VALUES (1344,8,'Wlhide','sysop',0,0,0,0.339269202938,'20070310095011',1344,4);
INSERT INTO page VALUES (1345,8,'Wlhideshowbots','sysop',0,0,0,0.324042821972,'20070310095011',1345,13);
INSERT INTO page VALUES (1346,8,'Wlhideshowown','sysop',0,0,0,0.589357696586,'20070310095011',1346,12);
INSERT INTO page VALUES (1347,8,'Wlnote','sysop',0,0,0,0.436683352682,'20070310095011',1347,58);
INSERT INTO page VALUES (1348,8,'Wlsaved','sysop',0,0,0,0.883798083259,'20070310095011',1348,42);
INSERT INTO page VALUES (1349,8,'Wlshow','sysop',0,0,0,0.962343353401,'20070310095011',1349,4);
INSERT INTO page VALUES (1350,8,'Wlshowlast','sysop',0,0,0,0.11268323835,'20070310095011',1350,29);
INSERT INTO page VALUES (1351,8,'Wrong_wfQuery_params','sysop',0,0,0,0.371277644348,'20070310095011',1351,68);
INSERT INTO page VALUES (1352,8,'Wrongpassword','sysop',0,0,0,0.025476987996,'20070310095011',1352,45);
INSERT INTO page VALUES (1353,8,'Wrongpasswordempty','sysop',0,0,0,0.646093268046,'20070310095011',1353,45);
INSERT INTO page VALUES (1354,8,'Youhavenewmessages','sysop',0,0,0,0.772227201106,'20070310095011',1354,17);
INSERT INTO page VALUES (1355,8,'Youhavenewmessagesmulti','sysop',0,0,0,0.237385553916,'20070310095011',1355,27);
INSERT INTO page VALUES (1356,8,'Yourdiff','sysop',0,0,0,0.36849217081,'20070310095011',1356,11);
INSERT INTO page VALUES (1357,8,'Yourdomainname','sysop',0,0,0,0.96040916929,'20070310095011',1357,11);
INSERT INTO page VALUES (1358,8,'Youremail','sysop',0,0,0,0.122111340245,'20070310095011',1358,8);
INSERT INTO page VALUES (1359,8,'Yourlanguage','sysop',0,0,0,0.556533798111,'20070310095011',1359,9);
INSERT INTO page VALUES (1360,8,'Yourname','sysop',0,0,0,0.454391426843,'20070310095011',1360,8);
INSERT INTO page VALUES (1361,8,'Yournick','sysop',0,0,0,0.417277623186,'20070310095011',1361,9);
INSERT INTO page VALUES (1362,8,'Yourpassword','sysop',0,0,0,0.639729705026,'20070310095011',1362,8);
INSERT INTO page VALUES (1363,8,'Yourpasswordagain','sysop',0,0,0,0.134199159944,'20070310095011',1363,15);
INSERT INTO page VALUES (1364,8,'Yourrealname','sysop',0,0,0,0.147435758492,'20070310095011',1364,11);
INSERT INTO page VALUES (1365,8,'Yourtext','sysop',0,0,0,0.163113425856,'20070310095011',1365,9);
INSERT INTO page VALUES (1366,8,'Yourvariant','sysop',0,0,0,0.889169883964,'20070310095011',1366,7);

--
-- Table structure for table `pagelinks`
--

DROP TABLE IF EXISTS pagelinks;
CREATE TABLE pagelinks (
  pl_from int(8) unsigned NOT NULL default '0',
  pl_namespace int(11) NOT NULL default '0',
  pl_title varchar(255) binary NOT NULL default '',
  UNIQUE KEY pl_from (pl_from,pl_namespace,pl_title),
  KEY pl_namespace (pl_namespace,pl_title)
) TYPE=InnoDB;

--
-- Dumping data for table `pagelinks`
--


--
-- Table structure for table `querycache`
--

DROP TABLE IF EXISTS querycache;
CREATE TABLE querycache (
  qc_type char(32) NOT NULL default '',
  qc_value int(5) unsigned NOT NULL default '0',
  qc_namespace int(11) NOT NULL default '0',
  qc_title char(255) binary NOT NULL default '',
  KEY qc_type (qc_type,qc_value)
) TYPE=InnoDB;

--
-- Dumping data for table `querycache`
--


--
-- Table structure for table `recentchanges`
--

DROP TABLE IF EXISTS recentchanges;
CREATE TABLE recentchanges (
  rc_id int(8) NOT NULL auto_increment,
  rc_timestamp varchar(14) binary NOT NULL default '',
  rc_cur_time varchar(14) binary NOT NULL default '',
  rc_user int(10) unsigned NOT NULL default '0',
  rc_user_text varchar(255) binary NOT NULL default '',
  rc_namespace int(11) NOT NULL default '0',
  rc_title varchar(255) binary NOT NULL default '',
  rc_comment varchar(255) binary NOT NULL default '',
  rc_minor tinyint(3) unsigned NOT NULL default '0',
  rc_bot tinyint(3) unsigned NOT NULL default '0',
  rc_new tinyint(3) unsigned NOT NULL default '0',
  rc_cur_id int(10) unsigned NOT NULL default '0',
  rc_this_oldid int(10) unsigned NOT NULL default '0',
  rc_last_oldid int(10) unsigned NOT NULL default '0',
  rc_type tinyint(3) unsigned NOT NULL default '0',
  rc_moved_to_ns tinyint(3) unsigned NOT NULL default '0',
  rc_moved_to_title varchar(255) binary NOT NULL default '',
  rc_patrolled tinyint(3) unsigned NOT NULL default '0',
  rc_ip varchar(15) NOT NULL default '',
  PRIMARY KEY  (rc_id),
  KEY rc_timestamp (rc_timestamp),
  KEY rc_namespace_title (rc_namespace,rc_title),
  KEY rc_cur_id (rc_cur_id),
  KEY new_name_timestamp (rc_new,rc_namespace,rc_timestamp),
  KEY rc_ip (rc_ip)
) TYPE=InnoDB;

--
-- Dumping data for table `recentchanges`
--


--
-- Table structure for table `revision`
--

DROP TABLE IF EXISTS revision;
CREATE TABLE revision (
  rev_id int(8) unsigned NOT NULL auto_increment,
  rev_page int(8) unsigned NOT NULL default '0',
  rev_text_id int(8) unsigned NOT NULL default '0',
  rev_comment tinyblob NOT NULL,
  rev_user int(5) unsigned NOT NULL default '0',
  rev_user_text varchar(255) binary NOT NULL default '',
  rev_timestamp varchar(14) binary NOT NULL default '',
  rev_minor_edit tinyint(1) unsigned NOT NULL default '0',
  rev_deleted tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (rev_page,rev_id),
  UNIQUE KEY rev_id (rev_id),
  KEY rev_timestamp (rev_timestamp),
  KEY page_timestamp (rev_page,rev_timestamp),
  KEY user_timestamp (rev_user,rev_timestamp),
  KEY usertext_timestamp (rev_user_text,rev_timestamp)
) TYPE=InnoDB;

--
-- Dumping data for table `revision`
--

INSERT INTO revision VALUES (1,1,1,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (2,2,2,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (3,3,3,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (4,4,4,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (5,5,5,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (6,6,6,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (7,7,7,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (8,8,8,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (9,9,9,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (10,10,10,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (11,11,11,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (12,12,12,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (13,13,13,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (14,14,14,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (15,15,15,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (16,16,16,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (17,17,17,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (18,18,18,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (19,19,19,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (20,20,20,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (21,21,21,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (22,22,22,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (23,23,23,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (24,24,24,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (25,25,25,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (26,26,26,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (27,27,27,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (28,28,28,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (29,29,29,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (30,30,30,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (31,31,31,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (32,32,32,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (33,33,33,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (34,34,34,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (35,35,35,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (36,36,36,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (37,37,37,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (38,38,38,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (39,39,39,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (40,40,40,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (41,41,41,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (42,42,42,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (43,43,43,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (44,44,44,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (45,45,45,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (46,46,46,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (47,47,47,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (48,48,48,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (49,49,49,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (50,50,50,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (51,51,51,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (52,52,52,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (53,53,53,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (54,54,54,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (55,55,55,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (56,56,56,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (57,57,57,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (58,58,58,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (59,59,59,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (60,60,60,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (61,61,61,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (62,62,62,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (63,63,63,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (64,64,64,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (65,65,65,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (66,66,66,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (67,67,67,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (68,68,68,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (69,69,69,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (70,70,70,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (71,71,71,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (72,72,72,'',0,'MediaWiki default','20070310095006',0,0);
INSERT INTO revision VALUES (73,73,73,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (74,74,74,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (75,75,75,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (76,76,76,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (77,77,77,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (78,78,78,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (79,79,79,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (80,80,80,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (81,81,81,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (82,82,82,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (83,83,83,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (84,84,84,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (85,85,85,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (86,86,86,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (87,87,87,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (88,88,88,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (89,89,89,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (90,90,90,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (91,91,91,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (92,92,92,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (93,93,93,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (94,94,94,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (95,95,95,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (96,96,96,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (97,97,97,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (98,98,98,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (99,99,99,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (100,100,100,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (101,101,101,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (102,102,102,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (103,103,103,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (104,104,104,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (105,105,105,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (106,106,106,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (107,107,107,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (108,108,108,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (109,109,109,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (110,110,110,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (111,111,111,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (112,112,112,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (113,113,113,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (114,114,114,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (115,115,115,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (116,116,116,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (117,117,117,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (118,118,118,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (119,119,119,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (120,120,120,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (121,121,121,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (122,122,122,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (123,123,123,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (124,124,124,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (125,125,125,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (126,126,126,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (127,127,127,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (128,128,128,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (129,129,129,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (130,130,130,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (131,131,131,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (132,132,132,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (133,133,133,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (134,134,134,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (135,135,135,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (136,136,136,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (137,137,137,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (138,138,138,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (139,139,139,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (140,140,140,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (141,141,141,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (142,142,142,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (143,143,143,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (144,144,144,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (145,145,145,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (146,146,146,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (147,147,147,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (148,148,148,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (149,149,149,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (150,150,150,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (151,151,151,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (152,152,152,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (153,153,153,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (154,154,154,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (155,155,155,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (156,156,156,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (157,157,157,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (158,158,158,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (159,159,159,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (160,160,160,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (161,161,161,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (162,162,162,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (163,163,163,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (164,164,164,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (165,165,165,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (166,166,166,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (167,167,167,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (168,168,168,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (169,169,169,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (170,170,170,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (171,171,171,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (172,172,172,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (173,173,173,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (174,174,174,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (175,175,175,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (176,176,176,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (177,177,177,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (178,178,178,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (179,179,179,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (180,180,180,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (181,181,181,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (182,182,182,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (183,183,183,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (184,184,184,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (185,185,185,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (186,186,186,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (187,187,187,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (188,188,188,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (189,189,189,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (190,190,190,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (191,191,191,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (192,192,192,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (193,193,193,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (194,194,194,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (195,195,195,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (196,196,196,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (197,197,197,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (198,198,198,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (199,199,199,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (200,200,200,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (201,201,201,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (202,202,202,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (203,203,203,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (204,204,204,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (205,205,205,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (206,206,206,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (207,207,207,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (208,208,208,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (209,209,209,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (210,210,210,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (211,211,211,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (212,212,212,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (213,213,213,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (214,214,214,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (215,215,215,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (216,216,216,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (217,217,217,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (218,218,218,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (219,219,219,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (220,220,220,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (221,221,221,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (222,222,222,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (223,223,223,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (224,224,224,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (225,225,225,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (226,226,226,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (227,227,227,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (228,228,228,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (229,229,229,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (230,230,230,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (231,231,231,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (232,232,232,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (233,233,233,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (234,234,234,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (235,235,235,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (236,236,236,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (237,237,237,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (238,238,238,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (239,239,239,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (240,240,240,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (241,241,241,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (242,242,242,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (243,243,243,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (244,244,244,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (245,245,245,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (246,246,246,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (247,247,247,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (248,248,248,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (249,249,249,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (250,250,250,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (251,251,251,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (252,252,252,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (253,253,253,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (254,254,254,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (255,255,255,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (256,256,256,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (257,257,257,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (258,258,258,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (259,259,259,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (260,260,260,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (261,261,261,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (262,262,262,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (263,263,263,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (264,264,264,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (265,265,265,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (266,266,266,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (267,267,267,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (268,268,268,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (269,269,269,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (270,270,270,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (271,271,271,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (272,272,272,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (273,273,273,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (274,274,274,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (275,275,275,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (276,276,276,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (277,277,277,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (278,278,278,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (279,279,279,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (280,280,280,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (281,281,281,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (282,282,282,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (283,283,283,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (284,284,284,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (285,285,285,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (286,286,286,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (287,287,287,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (288,288,288,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (289,289,289,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (290,290,290,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (291,291,291,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (292,292,292,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (293,293,293,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (294,294,294,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (295,295,295,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (296,296,296,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (297,297,297,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (298,298,298,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (299,299,299,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (300,300,300,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (301,301,301,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (302,302,302,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (303,303,303,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (304,304,304,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (305,305,305,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (306,306,306,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (307,307,307,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (308,308,308,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (309,309,309,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (310,310,310,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (311,311,311,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (312,312,312,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (313,313,313,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (314,314,314,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (315,315,315,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (316,316,316,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (317,317,317,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (318,318,318,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (319,319,319,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (320,320,320,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (321,321,321,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (322,322,322,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (323,323,323,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (324,324,324,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (325,325,325,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (326,326,326,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (327,327,327,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (328,328,328,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (329,329,329,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (330,330,330,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (331,331,331,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (332,332,332,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (333,333,333,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (334,334,334,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (335,335,335,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (336,336,336,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (337,337,337,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (338,338,338,'',0,'MediaWiki default','20070310095007',0,0);
INSERT INTO revision VALUES (339,339,339,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (340,340,340,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (341,341,341,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (342,342,342,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (343,343,343,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (344,344,344,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (345,345,345,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (346,346,346,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (347,347,347,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (348,348,348,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (349,349,349,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (350,350,350,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (351,351,351,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (352,352,352,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (353,353,353,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (354,354,354,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (355,355,355,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (356,356,356,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (357,357,357,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (358,358,358,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (359,359,359,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (360,360,360,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (361,361,361,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (362,362,362,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (363,363,363,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (364,364,364,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (365,365,365,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (366,366,366,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (367,367,367,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (368,368,368,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (369,369,369,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (370,370,370,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (371,371,371,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (372,372,372,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (373,373,373,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (374,374,374,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (375,375,375,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (376,376,376,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (377,377,377,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (378,378,378,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (379,379,379,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (380,380,380,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (381,381,381,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (382,382,382,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (383,383,383,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (384,384,384,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (385,385,385,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (386,386,386,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (387,387,387,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (388,388,388,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (389,389,389,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (390,390,390,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (391,391,391,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (392,392,392,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (393,393,393,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (394,394,394,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (395,395,395,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (396,396,396,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (397,397,397,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (398,398,398,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (399,399,399,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (400,400,400,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (401,401,401,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (402,402,402,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (403,403,403,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (404,404,404,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (405,405,405,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (406,406,406,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (407,407,407,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (408,408,408,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (409,409,409,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (410,410,410,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (411,411,411,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (412,412,412,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (413,413,413,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (414,414,414,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (415,415,415,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (416,416,416,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (417,417,417,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (418,418,418,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (419,419,419,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (420,420,420,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (421,421,421,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (422,422,422,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (423,423,423,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (424,424,424,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (425,425,425,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (426,426,426,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (427,427,427,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (428,428,428,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (429,429,429,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (430,430,430,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (431,431,431,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (432,432,432,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (433,433,433,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (434,434,434,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (435,435,435,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (436,436,436,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (437,437,437,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (438,438,438,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (439,439,439,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (440,440,440,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (441,441,441,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (442,442,442,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (443,443,443,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (444,444,444,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (445,445,445,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (446,446,446,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (447,447,447,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (448,448,448,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (449,449,449,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (450,450,450,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (451,451,451,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (452,452,452,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (453,453,453,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (454,454,454,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (455,455,455,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (456,456,456,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (457,457,457,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (458,458,458,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (459,459,459,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (460,460,460,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (461,461,461,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (462,462,462,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (463,463,463,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (464,464,464,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (465,465,465,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (466,466,466,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (467,467,467,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (468,468,468,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (469,469,469,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (470,470,470,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (471,471,471,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (472,472,472,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (473,473,473,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (474,474,474,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (475,475,475,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (476,476,476,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (477,477,477,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (478,478,478,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (479,479,479,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (480,480,480,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (481,481,481,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (482,482,482,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (483,483,483,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (484,484,484,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (485,485,485,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (486,486,486,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (487,487,487,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (488,488,488,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (489,489,489,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (490,490,490,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (491,491,491,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (492,492,492,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (493,493,493,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (494,494,494,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (495,495,495,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (496,496,496,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (497,497,497,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (498,498,498,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (499,499,499,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (500,500,500,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (501,501,501,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (502,502,502,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (503,503,503,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (504,504,504,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (505,505,505,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (506,506,506,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (507,507,507,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (508,508,508,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (509,509,509,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (510,510,510,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (511,511,511,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (512,512,512,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (513,513,513,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (514,514,514,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (515,515,515,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (516,516,516,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (517,517,517,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (518,518,518,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (519,519,519,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (520,520,520,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (521,521,521,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (522,522,522,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (523,523,523,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (524,524,524,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (525,525,525,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (526,526,526,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (527,527,527,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (528,528,528,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (529,529,529,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (530,530,530,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (531,531,531,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (532,532,532,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (533,533,533,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (534,534,534,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (535,535,535,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (536,536,536,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (537,537,537,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (538,538,538,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (539,539,539,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (540,540,540,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (541,541,541,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (542,542,542,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (543,543,543,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (544,544,544,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (545,545,545,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (546,546,546,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (547,547,547,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (548,548,548,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (549,549,549,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (550,550,550,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (551,551,551,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (552,552,552,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (553,553,553,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (554,554,554,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (555,555,555,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (556,556,556,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (557,557,557,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (558,558,558,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (559,559,559,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (560,560,560,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (561,561,561,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (562,562,562,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (563,563,563,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (564,564,564,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (565,565,565,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (566,566,566,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (567,567,567,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (568,568,568,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (569,569,569,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (570,570,570,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (571,571,571,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (572,572,572,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (573,573,573,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (574,574,574,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (575,575,575,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (576,576,576,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (577,577,577,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (578,578,578,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (579,579,579,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (580,580,580,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (581,581,581,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (582,582,582,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (583,583,583,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (584,584,584,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (585,585,585,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (586,586,586,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (587,587,587,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (588,588,588,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (589,589,589,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (590,590,590,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (591,591,591,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (592,592,592,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (593,593,593,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (594,594,594,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (595,595,595,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (596,596,596,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (597,597,597,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (598,598,598,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (599,599,599,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (600,600,600,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (601,601,601,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (602,602,602,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (603,603,603,'',0,'MediaWiki default','20070310095008',0,0);
INSERT INTO revision VALUES (604,604,604,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (605,605,605,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (606,606,606,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (607,607,607,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (608,608,608,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (609,609,609,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (610,610,610,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (611,611,611,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (612,612,612,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (613,613,613,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (614,614,614,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (615,615,615,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (616,616,616,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (617,617,617,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (618,618,618,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (619,619,619,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (620,620,620,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (621,621,621,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (622,622,622,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (623,623,623,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (624,624,624,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (625,625,625,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (626,626,626,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (627,627,627,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (628,628,628,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (629,629,629,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (630,630,630,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (631,631,631,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (632,632,632,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (633,633,633,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (634,634,634,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (635,635,635,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (636,636,636,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (637,637,637,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (638,638,638,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (639,639,639,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (640,640,640,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (641,641,641,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (642,642,642,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (643,643,643,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (644,644,644,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (645,645,645,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (646,646,646,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (647,647,647,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (648,648,648,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (649,649,649,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (650,650,650,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (651,651,651,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (652,652,652,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (653,653,653,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (654,654,654,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (655,655,655,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (656,656,656,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (657,657,657,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (658,658,658,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (659,659,659,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (660,660,660,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (661,661,661,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (662,662,662,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (663,663,663,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (664,664,664,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (665,665,665,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (666,666,666,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (667,667,667,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (668,668,668,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (669,669,669,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (670,670,670,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (671,671,671,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (672,672,672,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (673,673,673,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (674,674,674,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (675,675,675,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (676,676,676,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (677,677,677,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (678,678,678,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (679,679,679,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (680,680,680,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (681,681,681,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (682,682,682,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (683,683,683,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (684,684,684,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (685,685,685,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (686,686,686,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (687,687,687,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (688,688,688,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (689,689,689,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (690,690,690,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (691,691,691,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (692,692,692,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (693,693,693,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (694,694,694,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (695,695,695,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (696,696,696,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (697,697,697,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (698,698,698,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (699,699,699,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (700,700,700,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (701,701,701,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (702,702,702,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (703,703,703,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (704,704,704,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (705,705,705,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (706,706,706,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (707,707,707,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (708,708,708,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (709,709,709,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (710,710,710,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (711,711,711,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (712,712,712,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (713,713,713,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (714,714,714,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (715,715,715,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (716,716,716,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (717,717,717,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (718,718,718,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (719,719,719,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (720,720,720,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (721,721,721,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (722,722,722,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (723,723,723,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (724,724,724,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (725,725,725,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (726,726,726,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (727,727,727,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (728,728,728,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (729,729,729,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (730,730,730,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (731,731,731,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (732,732,732,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (733,733,733,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (734,734,734,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (735,735,735,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (736,736,736,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (737,737,737,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (738,738,738,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (739,739,739,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (740,740,740,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (741,741,741,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (742,742,742,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (743,743,743,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (744,744,744,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (745,745,745,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (746,746,746,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (747,747,747,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (748,748,748,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (749,749,749,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (750,750,750,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (751,751,751,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (752,752,752,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (753,753,753,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (754,754,754,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (755,755,755,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (756,756,756,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (757,757,757,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (758,758,758,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (759,759,759,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (760,760,760,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (761,761,761,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (762,762,762,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (763,763,763,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (764,764,764,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (765,765,765,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (766,766,766,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (767,767,767,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (768,768,768,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (769,769,769,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (770,770,770,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (771,771,771,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (772,772,772,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (773,773,773,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (774,774,774,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (775,775,775,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (776,776,776,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (777,777,777,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (778,778,778,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (779,779,779,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (780,780,780,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (781,781,781,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (782,782,782,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (783,783,783,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (784,784,784,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (785,785,785,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (786,786,786,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (787,787,787,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (788,788,788,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (789,789,789,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (790,790,790,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (791,791,791,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (792,792,792,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (793,793,793,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (794,794,794,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (795,795,795,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (796,796,796,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (797,797,797,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (798,798,798,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (799,799,799,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (800,800,800,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (801,801,801,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (802,802,802,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (803,803,803,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (804,804,804,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (805,805,805,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (806,806,806,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (807,807,807,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (808,808,808,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (809,809,809,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (810,810,810,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (811,811,811,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (812,812,812,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (813,813,813,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (814,814,814,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (815,815,815,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (816,816,816,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (817,817,817,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (818,818,818,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (819,819,819,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (820,820,820,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (821,821,821,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (822,822,822,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (823,823,823,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (824,824,824,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (825,825,825,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (826,826,826,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (827,827,827,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (828,828,828,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (829,829,829,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (830,830,830,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (831,831,831,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (832,832,832,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (833,833,833,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (834,834,834,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (835,835,835,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (836,836,836,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (837,837,837,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (838,838,838,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (839,839,839,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (840,840,840,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (841,841,841,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (842,842,842,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (843,843,843,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (844,844,844,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (845,845,845,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (846,846,846,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (847,847,847,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (848,848,848,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (849,849,849,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (850,850,850,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (851,851,851,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (852,852,852,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (853,853,853,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (854,854,854,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (855,855,855,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (856,856,856,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (857,857,857,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (858,858,858,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (859,859,859,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (860,860,860,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (861,861,861,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (862,862,862,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (863,863,863,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (864,864,864,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (865,865,865,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (866,866,866,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (867,867,867,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (868,868,868,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (869,869,869,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (870,870,870,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (871,871,871,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (872,872,872,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (873,873,873,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (874,874,874,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (875,875,875,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (876,876,876,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (877,877,877,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (878,878,878,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (879,879,879,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (880,880,880,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (881,881,881,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (882,882,882,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (883,883,883,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (884,884,884,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (885,885,885,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (886,886,886,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (887,887,887,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (888,888,888,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (889,889,889,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (890,890,890,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (891,891,891,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (892,892,892,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (893,893,893,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (894,894,894,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (895,895,895,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (896,896,896,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (897,897,897,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (898,898,898,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (899,899,899,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (900,900,900,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (901,901,901,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (902,902,902,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (903,903,903,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (904,904,904,'',0,'MediaWiki default','20070310095009',0,0);
INSERT INTO revision VALUES (905,905,905,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (906,906,906,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (907,907,907,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (908,908,908,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (909,909,909,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (910,910,910,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (911,911,911,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (912,912,912,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (913,913,913,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (914,914,914,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (915,915,915,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (916,916,916,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (917,917,917,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (918,918,918,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (919,919,919,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (920,920,920,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (921,921,921,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (922,922,922,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (923,923,923,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (924,924,924,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (925,925,925,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (926,926,926,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (927,927,927,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (928,928,928,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (929,929,929,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (930,930,930,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (931,931,931,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (932,932,932,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (933,933,933,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (934,934,934,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (935,935,935,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (936,936,936,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (937,937,937,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (938,938,938,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (939,939,939,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (940,940,940,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (941,941,941,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (942,942,942,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (943,943,943,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (944,944,944,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (945,945,945,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (946,946,946,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (947,947,947,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (948,948,948,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (949,949,949,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (950,950,950,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (951,951,951,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (952,952,952,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (953,953,953,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (954,954,954,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (955,955,955,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (956,956,956,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (957,957,957,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (958,958,958,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (959,959,959,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (960,960,960,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (961,961,961,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (962,962,962,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (963,963,963,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (964,964,964,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (965,965,965,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (966,966,966,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (967,967,967,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (968,968,968,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (969,969,969,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (970,970,970,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (971,971,971,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (972,972,972,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (973,973,973,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (974,974,974,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (975,975,975,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (976,976,976,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (977,977,977,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (978,978,978,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (979,979,979,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (980,980,980,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (981,981,981,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (982,982,982,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (983,983,983,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (984,984,984,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (985,985,985,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (986,986,986,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (987,987,987,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (988,988,988,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (989,989,989,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (990,990,990,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (991,991,991,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (992,992,992,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (993,993,993,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (994,994,994,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (995,995,995,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (996,996,996,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (997,997,997,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (998,998,998,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (999,999,999,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1000,1000,1000,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1001,1001,1001,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1002,1002,1002,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1003,1003,1003,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1004,1004,1004,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1005,1005,1005,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1006,1006,1006,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1007,1007,1007,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1008,1008,1008,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1009,1009,1009,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1010,1010,1010,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1011,1011,1011,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1012,1012,1012,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1013,1013,1013,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1014,1014,1014,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1015,1015,1015,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1016,1016,1016,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1017,1017,1017,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1018,1018,1018,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1019,1019,1019,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1020,1020,1020,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1021,1021,1021,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1022,1022,1022,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1023,1023,1023,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1024,1024,1024,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1025,1025,1025,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1026,1026,1026,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1027,1027,1027,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1028,1028,1028,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1029,1029,1029,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1030,1030,1030,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1031,1031,1031,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1032,1032,1032,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1033,1033,1033,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1034,1034,1034,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1035,1035,1035,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1036,1036,1036,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1037,1037,1037,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1038,1038,1038,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1039,1039,1039,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1040,1040,1040,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1041,1041,1041,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1042,1042,1042,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1043,1043,1043,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1044,1044,1044,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1045,1045,1045,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1046,1046,1046,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1047,1047,1047,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1048,1048,1048,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1049,1049,1049,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1050,1050,1050,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1051,1051,1051,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1052,1052,1052,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1053,1053,1053,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1054,1054,1054,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1055,1055,1055,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1056,1056,1056,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1057,1057,1057,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1058,1058,1058,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1059,1059,1059,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1060,1060,1060,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1061,1061,1061,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1062,1062,1062,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1063,1063,1063,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1064,1064,1064,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1065,1065,1065,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1066,1066,1066,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1067,1067,1067,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1068,1068,1068,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1069,1069,1069,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1070,1070,1070,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1071,1071,1071,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1072,1072,1072,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1073,1073,1073,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1074,1074,1074,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1075,1075,1075,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1076,1076,1076,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1077,1077,1077,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1078,1078,1078,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1079,1079,1079,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1080,1080,1080,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1081,1081,1081,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1082,1082,1082,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1083,1083,1083,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1084,1084,1084,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1085,1085,1085,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1086,1086,1086,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1087,1087,1087,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1088,1088,1088,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1089,1089,1089,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1090,1090,1090,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1091,1091,1091,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1092,1092,1092,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1093,1093,1093,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1094,1094,1094,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1095,1095,1095,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1096,1096,1096,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1097,1097,1097,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1098,1098,1098,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1099,1099,1099,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1100,1100,1100,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1101,1101,1101,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1102,1102,1102,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1103,1103,1103,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1104,1104,1104,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1105,1105,1105,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1106,1106,1106,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1107,1107,1107,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1108,1108,1108,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1109,1109,1109,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1110,1110,1110,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1111,1111,1111,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1112,1112,1112,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1113,1113,1113,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1114,1114,1114,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1115,1115,1115,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1116,1116,1116,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1117,1117,1117,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1118,1118,1118,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1119,1119,1119,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1120,1120,1120,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1121,1121,1121,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1122,1122,1122,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1123,1123,1123,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1124,1124,1124,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1125,1125,1125,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1126,1126,1126,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1127,1127,1127,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1128,1128,1128,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1129,1129,1129,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1130,1130,1130,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1131,1131,1131,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1132,1132,1132,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1133,1133,1133,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1134,1134,1134,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1135,1135,1135,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1136,1136,1136,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1137,1137,1137,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1138,1138,1138,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1139,1139,1139,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1140,1140,1140,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1141,1141,1141,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1142,1142,1142,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1143,1143,1143,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1144,1144,1144,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1145,1145,1145,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1146,1146,1146,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1147,1147,1147,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1148,1148,1148,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1149,1149,1149,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1150,1150,1150,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1151,1151,1151,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1152,1152,1152,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1153,1153,1153,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1154,1154,1154,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1155,1155,1155,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1156,1156,1156,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1157,1157,1157,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1158,1158,1158,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1159,1159,1159,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1160,1160,1160,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1161,1161,1161,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1162,1162,1162,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1163,1163,1163,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1164,1164,1164,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1165,1165,1165,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1166,1166,1166,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1167,1167,1167,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1168,1168,1168,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1169,1169,1169,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1170,1170,1170,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1171,1171,1171,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1172,1172,1172,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1173,1173,1173,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1174,1174,1174,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1175,1175,1175,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1176,1176,1176,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1177,1177,1177,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1178,1178,1178,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1179,1179,1179,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1180,1180,1180,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1181,1181,1181,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1182,1182,1182,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1183,1183,1183,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1184,1184,1184,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1185,1185,1185,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1186,1186,1186,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1187,1187,1187,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1188,1188,1188,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1189,1189,1189,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1190,1190,1190,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1191,1191,1191,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1192,1192,1192,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1193,1193,1193,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1194,1194,1194,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1195,1195,1195,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1196,1196,1196,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1197,1197,1197,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1198,1198,1198,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1199,1199,1199,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1200,1200,1200,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1201,1201,1201,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1202,1202,1202,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1203,1203,1203,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1204,1204,1204,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1205,1205,1205,'',0,'MediaWiki default','20070310095010',0,0);
INSERT INTO revision VALUES (1206,1206,1206,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1207,1207,1207,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1208,1208,1208,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1209,1209,1209,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1210,1210,1210,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1211,1211,1211,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1212,1212,1212,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1213,1213,1213,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1214,1214,1214,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1215,1215,1215,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1216,1216,1216,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1217,1217,1217,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1218,1218,1218,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1219,1219,1219,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1220,1220,1220,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1221,1221,1221,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1222,1222,1222,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1223,1223,1223,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1224,1224,1224,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1225,1225,1225,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1226,1226,1226,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1227,1227,1227,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1228,1228,1228,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1229,1229,1229,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1230,1230,1230,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1231,1231,1231,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1232,1232,1232,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1233,1233,1233,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1234,1234,1234,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1235,1235,1235,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1236,1236,1236,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1237,1237,1237,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1238,1238,1238,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1239,1239,1239,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1240,1240,1240,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1241,1241,1241,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1242,1242,1242,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1243,1243,1243,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1244,1244,1244,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1245,1245,1245,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1246,1246,1246,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1247,1247,1247,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1248,1248,1248,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1249,1249,1249,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1250,1250,1250,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1251,1251,1251,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1252,1252,1252,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1253,1253,1253,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1254,1254,1254,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1255,1255,1255,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1256,1256,1256,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1257,1257,1257,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1258,1258,1258,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1259,1259,1259,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1260,1260,1260,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1261,1261,1261,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1262,1262,1262,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1263,1263,1263,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1264,1264,1264,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1265,1265,1265,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1266,1266,1266,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1267,1267,1267,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1268,1268,1268,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1269,1269,1269,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1270,1270,1270,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1271,1271,1271,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1272,1272,1272,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1273,1273,1273,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1274,1274,1274,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1275,1275,1275,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1276,1276,1276,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1277,1277,1277,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1278,1278,1278,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1279,1279,1279,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1280,1280,1280,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1281,1281,1281,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1282,1282,1282,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1283,1283,1283,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1284,1284,1284,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1285,1285,1285,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1286,1286,1286,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1287,1287,1287,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1288,1288,1288,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1289,1289,1289,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1290,1290,1290,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1291,1291,1291,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1292,1292,1292,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1293,1293,1293,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1294,1294,1294,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1295,1295,1295,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1296,1296,1296,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1297,1297,1297,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1298,1298,1298,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1299,1299,1299,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1300,1300,1300,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1301,1301,1301,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1302,1302,1302,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1303,1303,1303,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1304,1304,1304,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1305,1305,1305,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1306,1306,1306,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1307,1307,1307,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1308,1308,1308,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1309,1309,1309,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1310,1310,1310,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1311,1311,1311,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1312,1312,1312,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1313,1313,1313,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1314,1314,1314,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1315,1315,1315,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1316,1316,1316,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1317,1317,1317,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1318,1318,1318,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1319,1319,1319,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1320,1320,1320,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1321,1321,1321,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1322,1322,1322,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1323,1323,1323,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1324,1324,1324,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1325,1325,1325,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1326,1326,1326,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1327,1327,1327,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1328,1328,1328,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1329,1329,1329,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1330,1330,1330,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1331,1331,1331,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1332,1332,1332,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1333,1333,1333,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1334,1334,1334,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1335,1335,1335,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1336,1336,1336,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1337,1337,1337,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1338,1338,1338,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1339,1339,1339,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1340,1340,1340,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1341,1341,1341,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1342,1342,1342,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1343,1343,1343,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1344,1344,1344,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1345,1345,1345,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1346,1346,1346,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1347,1347,1347,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1348,1348,1348,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1349,1349,1349,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1350,1350,1350,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1351,1351,1351,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1352,1352,1352,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1353,1353,1353,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1354,1354,1354,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1355,1355,1355,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1356,1356,1356,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1357,1357,1357,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1358,1358,1358,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1359,1359,1359,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1360,1360,1360,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1361,1361,1361,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1362,1362,1362,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1363,1363,1363,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1364,1364,1364,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1365,1365,1365,'',0,'MediaWiki default','20070310095011',0,0);
INSERT INTO revision VALUES (1366,1366,1366,'',0,'MediaWiki default','20070310095011',0,0);

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS searchindex;
CREATE TABLE searchindex (
  si_page int(8) unsigned NOT NULL default '0',
  si_title varchar(255) NOT NULL default '',
  si_text mediumtext NOT NULL,
  UNIQUE KEY si_page (si_page),
  FULLTEXT KEY si_title (si_title),
  FULLTEXT KEY si_text (si_text)
) TYPE=MyISAM;

--
-- Dumping data for table `searchindex`
--


--
-- Table structure for table `site_stats`
--

DROP TABLE IF EXISTS site_stats;
CREATE TABLE site_stats (
  ss_row_id int(8) unsigned NOT NULL default '0',
  ss_total_views bigint(20) unsigned default '0',
  ss_total_edits bigint(20) unsigned default '0',
  ss_good_articles bigint(20) unsigned default '0',
  ss_total_pages bigint(20) default '-1',
  ss_users bigint(20) default '-1',
  ss_admins int(10) default '-1',
  ss_images int(10) default '0',
  UNIQUE KEY ss_row_id (ss_row_id)
) TYPE=InnoDB;

--
-- Dumping data for table `site_stats`
--

INSERT INTO site_stats VALUES (1,1,0,0,-1,-1,-1,0);

--
-- Table structure for table `templatelinks`
--

DROP TABLE IF EXISTS templatelinks;
CREATE TABLE templatelinks (
  tl_from int(8) unsigned NOT NULL default '0',
  tl_namespace int(11) NOT NULL default '0',
  tl_title varchar(255) binary NOT NULL default '',
  UNIQUE KEY tl_from (tl_from,tl_namespace,tl_title),
  KEY tl_namespace (tl_namespace,tl_title)
) TYPE=InnoDB;

--
-- Dumping data for table `templatelinks`
--


--
-- Table structure for table `text`
--

DROP TABLE IF EXISTS text;
CREATE TABLE text (
  old_id int(8) unsigned NOT NULL auto_increment,
  old_text mediumblob NOT NULL,
  old_flags tinyblob NOT NULL,
  PRIMARY KEY  (old_id)
) TYPE=InnoDB;

--
-- Dumping data for table `text`
--

INSERT INTO text VALUES (1,'<big>\'\'\'MediaWiki has been successfully installed.\'\'\'</big>\n\nConsult the [http://meta.wikipedia.org/wiki/MediaWiki_User%27s_Guide User\'s Guide] for information on using the wiki software.\n\n== Getting started ==\n\n* [http://www.mediawiki.org/wiki/Help:Configuration_settings Configuration settings list]\n* [http://www.mediawiki.org/wiki/Help:FAQ MediaWiki FAQ]\n* [http://mail.wikipedia.org/mailman/listinfo/mediawiki-announce MediaWiki release mailing list]','utf-8');
INSERT INTO text VALUES (2,'[[$1]] moved to [[$2]]','utf-8');
INSERT INTO text VALUES (3,'[[$1]] moved to [[$2]] over redirect','utf-8');
INSERT INTO text VALUES (4,'/* edit this file to customize the monobook skin for the entire site */','utf-8');
INSERT INTO text VALUES (5,'/* tooltips and access keys */\nta = new Object();\nta[\'pt-userpage\'] = new Array(\'.\',\'My user page\');\nta[\'pt-anonuserpage\'] = new Array(\'.\',\'The user page for the ip you\\\'re editing as\');\nta[\'pt-mytalk\'] = new Array(\'n\',\'My talk page\');\nta[\'pt-anontalk\'] = new Array(\'n\',\'Discussion about edits from this ip address\');\nta[\'pt-preferences\'] = new Array(\'\',\'My preferences\');\nta[\'pt-watchlist\'] = new Array(\'l\',\'The list of pages you\\\'re monitoring for changes.\');\nta[\'pt-mycontris\'] = new Array(\'y\',\'List of my contributions\');\nta[\'pt-login\'] = new Array(\'o\',\'You are encouraged to log in, it is not mandatory however.\');\nta[\'pt-anonlogin\'] = new Array(\'o\',\'You are encouraged to log in, it is not mandatory however.\');\nta[\'pt-logout\'] = new Array(\'o\',\'Log out\');\nta[\'ca-talk\'] = new Array(\'t\',\'Discussion about the content page\');\nta[\'ca-edit\'] = new Array(\'e\',\'You can edit this page. Please use the preview button before saving.\');\nta[\'ca-addsection\'] = new Array(\'+\',\'Add a comment to this discussion.\');\nta[\'ca-viewsource\'] = new Array(\'e\',\'This page is protected. You can view its source.\');\nta[\'ca-history\'] = new Array(\'h\',\'Past versions of this page.\');\nta[\'ca-protect\'] = new Array(\'=\',\'Protect this page\');\nta[\'ca-delete\'] = new Array(\'d\',\'Delete this page\');\nta[\'ca-undelete\'] = new Array(\'d\',\'Restore the edits done to this page before it was deleted\');\nta[\'ca-move\'] = new Array(\'m\',\'Move this page\');\nta[\'ca-watch\'] = new Array(\'w\',\'Add this page to your watchlist\');\nta[\'ca-unwatch\'] = new Array(\'w\',\'Remove this page from your watchlist\');\nta[\'search\'] = new Array(\'f\',\'Search this wiki\');\nta[\'p-logo\'] = new Array(\'\',\'Main Page\');\nta[\'n-mainpage\'] = new Array(\'z\',\'Visit the Main Page\');\nta[\'n-portal\'] = new Array(\'\',\'About the project, what you can do, where to find things\');\nta[\'n-currentevents\'] = new Array(\'\',\'Find background information on current events\');\nta[\'n-recentchanges\'] = new Array(\'r\',\'The list of recent changes in the wiki.\');\nta[\'n-randompage\'] = new Array(\'x\',\'Load a random page\');\nta[\'n-help\'] = new Array(\'\',\'The place to find out.\');\nta[\'n-sitesupport\'] = new Array(\'\',\'Support us\');\nta[\'t-whatlinkshere\'] = new Array(\'j\',\'List of all wiki pages that link here\');\nta[\'t-recentchangeslinked\'] = new Array(\'k\',\'Recent changes in pages linked from this page\');\nta[\'feed-rss\'] = new Array(\'\',\'RSS feed for this page\');\nta[\'feed-atom\'] = new Array(\'\',\'Atom feed for this page\');\nta[\'t-contributions\'] = new Array(\'\',\'View the list of contributions of this user\');\nta[\'t-emailuser\'] = new Array(\'\',\'Send a mail to this user\');\nta[\'t-upload\'] = new Array(\'u\',\'Upload images or media files\');\nta[\'t-specialpages\'] = new Array(\'q\',\'List of all special pages\');\nta[\'ca-nstab-main\'] = new Array(\'c\',\'View the content page\');\nta[\'ca-nstab-user\'] = new Array(\'c\',\'View the user page\');\nta[\'ca-nstab-media\'] = new Array(\'c\',\'View the media page\');\nta[\'ca-nstab-special\'] = new Array(\'\',\'This is a special page, you can\\\'t edit the page itself.\');\nta[\'ca-nstab-wp\'] = new Array(\'a\',\'View the project page\');\nta[\'ca-nstab-image\'] = new Array(\'c\',\'View the image page\');\nta[\'ca-nstab-mediawiki\'] = new Array(\'c\',\'View the system message\');\nta[\'ca-nstab-template\'] = new Array(\'c\',\'View the template\');\nta[\'ca-nstab-help\'] = new Array(\'c\',\'View the help page\');\nta[\'ca-nstab-category\'] = new Array(\'c\',\'View the category page\');','utf-8');
INSERT INTO text VALUES (6,'About','utf-8');
INSERT INTO text VALUES (7,'Project:About','utf-8');
INSERT INTO text VALUES (8,'About {{SITENAME}}','utf-8');
INSERT INTO text VALUES (9,'v','utf-8');
INSERT INTO text VALUES (10,'v','utf-8');
INSERT INTO text VALUES (11,'i','utf-8');
INSERT INTO text VALUES (12,'p','utf-8');
INSERT INTO text VALUES (13,'s','utf-8');
INSERT INTO text VALUES (14,'f','utf-8');
INSERT INTO text VALUES (15,'The password for \"$1\" has been sent to $2.','utf-8');
INSERT INTO text VALUES (16,'Password sent.','utf-8');
INSERT INTO text VALUES (17,'Sorry, you have already created $1 accounts. You can\'t make any more.','utf-8');
INSERT INTO text VALUES (18,'Action complete','utf-8');
INSERT INTO text VALUES (19,'Added to watchlist','utf-8');
INSERT INTO text VALUES (20,'The page \"[[:$1]]\" has been added to your [[Special:Watchlist|watchlist]].\nFuture changes to this page and its associated Talk page will be listed there,\nand the page will appear \'\'\'bolded\'\'\' in the [[Special:Recentchanges|list of recent changes]] to\nmake it easier to pick out.\n\n<p>If you want to remove the page from your watchlist later, click \"Unwatch\" in the sidebar.','utf-8');
INSERT INTO text VALUES (21,'Add Group','utf-8');
INSERT INTO text VALUES (22,'Added group $2','utf-8');
INSERT INTO text VALUES (23,'+','utf-8');
INSERT INTO text VALUES (24,'Project:Administrators','utf-8');
INSERT INTO text VALUES (25,'All articles','utf-8');
INSERT INTO text VALUES (26,'All pages ($1 namespace)','utf-8');
INSERT INTO text VALUES (27,'Combined display of upload, deletion, protection, blocking, and sysop logs.\nYou can narrow down the view by selecting a log type, the user name, or the affected page.','utf-8');
INSERT INTO text VALUES (28,'System messages','utf-8');
INSERT INTO text VALUES (29,'Current text','utf-8');
INSERT INTO text VALUES (30,'Default text','utf-8');
INSERT INTO text VALUES (31,'Message name filter:','utf-8');
INSERT INTO text VALUES (32,'Show only modified','utf-8');
INSERT INTO text VALUES (33,'Name','utf-8');
INSERT INTO text VALUES (34,'Special:Allmessages cannot be used because wgUseDatabaseMessages is off.','utf-8');
INSERT INTO text VALUES (35,'Your current interface language <b>$1</b> is not supported by Special:Allmessages at this site.','utf-8');
INSERT INTO text VALUES (36,'This is a list of system messages available in the MediaWiki: namespace.','utf-8');
INSERT INTO text VALUES (37,'All non-articles','utf-8');
INSERT INTO text VALUES (38,'All pages (not in $1 namespace)','utf-8');
INSERT INTO text VALUES (39,'Enable e-mail from other users','utf-8');
INSERT INTO text VALUES (40,'All pages','utf-8');
INSERT INTO text VALUES (41,'Display pages starting at:','utf-8');
INSERT INTO text VALUES (42,'Next','utf-8');
INSERT INTO text VALUES (43,'Display pages with prefix:','utf-8');
INSERT INTO text VALUES (44,'Previous','utf-8');
INSERT INTO text VALUES (45,'Go','utf-8');
INSERT INTO text VALUES (46,'$1 to $2','utf-8');
INSERT INTO text VALUES (47,'This user is already a bureaucrat','utf-8');
INSERT INTO text VALUES (48,'This user is already a steward','utf-8');
INSERT INTO text VALUES (49,'This user is already an administrator','utf-8');
INSERT INTO text VALUES (50,'<strong>User $1, you are already logged in!</strong><br />','utf-8');
INSERT INTO text VALUES (51,'Cannot rollback last edit of [[$1]]\nby [[User:$2|$2]] ([[User talk:$2|Talk]]); someone else has edited or rolled back the page already.\n\nLast edit was by [[User:$3|$3]] ([[User talk:$3|Talk]]).','utf-8');
INSERT INTO text VALUES (52,'Oldest pages','utf-8');
INSERT INTO text VALUES (53,'and','utf-8');
INSERT INTO text VALUES (54,'You are not logged in. Your IP address will be recorded in this page\'s edit history.','utf-8');
INSERT INTO text VALUES (55,'-','utf-8');
INSERT INTO text VALUES (56,'Talk for this IP','utf-8');
INSERT INTO text VALUES (57,'----\'\'This is the discussion page for an anonymous user who has not created an account yet or who does not use it. We therefore have to use the numerical [[IP address]] to identify him/her. Such an IP address can be shared by several users. If you are an anonymous user and feel that irrelevant comments have been directed at you, please [[Special:Userlogin|create an account or log in]] to avoid future confusion with other anonymous users.\'\'','utf-8');
INSERT INTO text VALUES (58,'Anonymous user(s) of {{SITENAME}}','utf-8');
INSERT INTO text VALUES (59,'Apr','utf-8');
INSERT INTO text VALUES (60,'April','utf-8');
INSERT INTO text VALUES (61,'Content page','utf-8');
INSERT INTO text VALUES (62,'A page of that name already exists, or the\nname you have chosen is not valid.\nPlease choose another name.','utf-8');
INSERT INTO text VALUES (63,'View content page','utf-8');
INSERT INTO text VALUES (64,'Articles starting with \'\'$1\'\'','utf-8');
INSERT INTO text VALUES (65,'Aug','utf-8');
INSERT INTO text VALUES (66,'August','utf-8');
INSERT INTO text VALUES (67,'Autoblocked because your IP address has been recently used by \"[[User:$1|$1]]\". The reason given for $1\'s block is: \"\'\'\'$2\'\'\'\"','utf-8');
INSERT INTO text VALUES (68,'Permission error','utf-8');
INSERT INTO text VALUES (69,'The action you have requested is limited\nto users with the \"$2\" permission assigned.\nSee $1.','utf-8');
INSERT INTO text VALUES (70,'This action cannot be performed on this page.','utf-8');
INSERT INTO text VALUES (71,'File name has been changed to \"$1\".','utf-8');
INSERT INTO text VALUES (72,'\".$1\" is not a recommended image file format.','utf-8');
INSERT INTO text VALUES (73,'Invalid IP address','utf-8');
INSERT INTO text VALUES (74,'Badly formed search query','utf-8');
INSERT INTO text VALUES (75,'We could not process your query.\nThis is probably because you have attempted to search for a\nword fewer than three letters long, which is not yet supported.\nIt could also be that you have mistyped the expression, for\nexample \"fish and and scales\".\nPlease try another query.','utf-8');
INSERT INTO text VALUES (76,'The passwords you entered do not match.','utf-8');
INSERT INTO text VALUES (77,'Invalid raw signature; check HTML tags.','utf-8');
INSERT INTO text VALUES (78,'Bad title','utf-8');
INSERT INTO text VALUES (79,'The requested page title was invalid, empty, or an incorrectly linked inter-language or inter-wiki title. It may contain one more characters which cannot be used in titles.','utf-8');
INSERT INTO text VALUES (80,'(Main)','utf-8');
INSERT INTO text VALUES (81,'Your user name or IP address has been blocked by $1.\nThe reason given is this:<br />\'\'$2\'\'<p>You may contact $1 or one of the other\n[[Project:Administrators|administrators]] to discuss the block.\n\nNote that you may not use the \"e-mail this user\" feature unless you have a valid e-mail address registered in your [[Special:Preferences|user preferences]].\n\nYour IP address is $3. Please include this address in any queries you make.','utf-8');
INSERT INTO text VALUES (82,'User is blocked','utf-8');
INSERT INTO text VALUES (83,'Block user','utf-8');
INSERT INTO text VALUES (84,'Block succeeded','utf-8');
INSERT INTO text VALUES (85,'[[{{ns:Special}}:Contributions/$1|$1]] has been blocked.\n<br />See [[{{ns:Special}}:Ipblocklist|IP block list]] to review blocks.','utf-8');
INSERT INTO text VALUES (86,'Use the form below to block write access\nfrom a specific IP address or username.\nThis should be done only only to prevent vandalism, and in\naccordance with [[Project:Policy|policy]].\nFill in a specific reason below (for example, citing particular\npages that were vandalized).','utf-8');
INSERT INTO text VALUES (87,'block','utf-8');
INSERT INTO text VALUES (88,'$1, $2 blocked $3 ($4)','utf-8');
INSERT INTO text VALUES (89,'blocked \"[[$1]]\" with an expiry time of $2','utf-8');
INSERT INTO text VALUES (90,'Block_log','utf-8');
INSERT INTO text VALUES (91,'This is a log of user blocking and unblocking actions. Automatically\nblocked IP addresses are not listed. See the [[Special:Ipblocklist|IP block list]] for\nthe list of currently operational bans and blocks.','utf-8');
INSERT INTO text VALUES (92,'Bold text','utf-8');
INSERT INTO text VALUES (93,'Bold text','utf-8');
INSERT INTO text VALUES (94,'Book sources','utf-8');
INSERT INTO text VALUES (95,'Below is a list of links to other sites that\nsell new and used books, and may also have further information\nabout books you are looking for.','utf-8');
INSERT INTO text VALUES (96,'Broken redirects','utf-8');
INSERT INTO text VALUES (97,'The following redirects link to non-existent pages:','utf-8');
INSERT INTO text VALUES (98,'Bug reports','utf-8');
INSERT INTO text VALUES (99,'Project:Bug_reports','utf-8');
INSERT INTO text VALUES (100,'Bureaucrat_log','utf-8');
INSERT INTO text VALUES (101,'Changed group membership for $1 from $2 to $3','utf-8');
INSERT INTO text VALUES (102,'by date','utf-8');
INSERT INTO text VALUES (103,'by name','utf-8');
INSERT INTO text VALUES (104,'by size','utf-8');
INSERT INTO text VALUES (105,'The following is a cached copy of the requested page, and may not be up to date.','utf-8');
INSERT INTO text VALUES (106,'Cancel','utf-8');
INSERT INTO text VALUES (107,'Could not delete the page or file specified. (It may have already been deleted by someone else.)','utf-8');
INSERT INTO text VALUES (108,'Cannot revert edit; last contributor is only author of this page.','utf-8');
INSERT INTO text VALUES (109,'Categories','utf-8');
INSERT INTO text VALUES (110,'Category','utf-8');
INSERT INTO text VALUES (111,'The following categories exist in the wiki.','utf-8');
INSERT INTO text VALUES (112,'category','utf-8');
INSERT INTO text VALUES (113,'Articles in category \"$1\"','utf-8');
INSERT INTO text VALUES (114,'There are $1 articles in this category.','utf-8');
INSERT INTO text VALUES (115,'There is $1 article in this category.','utf-8');
INSERT INTO text VALUES (116,'|','utf-8');
INSERT INTO text VALUES (117,'changed','utf-8');
INSERT INTO text VALUES (118,'Changed group $2','utf-8');
INSERT INTO text VALUES (119,'Change password','utf-8');
INSERT INTO text VALUES (120,'changes','utf-8');
INSERT INTO text VALUES (121,'\'\'\'Note:\'\'\' After saving, you may have to bypass your browser\'s cache to see the changes. \'\'\'Mozilla / Firefox / Safari:\'\'\' hold down \'\'Shift\'\' while clicking \'\'Reload\'\', or press \'\'Ctrl-Shift-R\'\' (\'\'Cmd-Shift-R\'\' on Apple Mac); \'\'\'IE:\'\'\' hold \'\'Ctrl\'\' while clicking \'\'Refresh\'\', or press \'\'Ctrl-F5\'\'; \'\'\'Konqueror:\'\'\': simply click the \'\'Reload\'\' button, or press \'\'F5\'\'; \'\'\'Opera\'\'\' users may need to completely clear their cache in \'\'Tools&rarr;Preferences\'\'.','utf-8');
INSERT INTO text VALUES (122,'Columns:','utf-8');
INSERT INTO text VALUES (123,'Compare selected versions','utf-8');
INSERT INTO text VALUES (124,'Confirm','utf-8');
INSERT INTO text VALUES (125,'Clear the cache of this page?\n\n$1','utf-8');
INSERT INTO text VALUES (126,'OK','utf-8');
INSERT INTO text VALUES (127,'Confirm delete','utf-8');
INSERT INTO text VALUES (128,'You are about to permanently delete a page\nor image along with all of its history from the database.\nPlease confirm that you intend to do this, that you understand the\nconsequences, and that you are doing this in accordance with\n[[Project:Policy]].','utf-8');
INSERT INTO text VALUES (129,'You must confirm your e-mail address before editing pages. Please set and validate your e-mail address through your [[Special:Preferences|user preferences]].','utf-8');
INSERT INTO text VALUES (130,'E-mail confirmation required to edit','utf-8');
INSERT INTO text VALUES (131,'Confirm E-mail address','utf-8');
INSERT INTO text VALUES (132,'Someone, probably you from IP address $1, has registered an\naccount \"$2\" with this e-mail address on {{SITENAME}}.\n\nTo confirm that this account really does belong to you and activate\ne-mail features on {{SITENAME}}, open this link in your browser:\n\n$3\n\nIf this is *not* you, don\'t follow the link. This confirmation code\nwill expire at $4.','utf-8');
INSERT INTO text VALUES (133,'Something went wrong saving your confirmation.','utf-8');
INSERT INTO text VALUES (134,'Invalid confirmation code. The code may have expired.','utf-8');
INSERT INTO text VALUES (135,'Your e-mail address has now been confirmed.','utf-8');
INSERT INTO text VALUES (136,'Mail a confirmation code','utf-8');
INSERT INTO text VALUES (137,'Could not send confirmation mail. Check address for invalid characters.','utf-8');
INSERT INTO text VALUES (138,'Confirmation e-mail sent.','utf-8');
INSERT INTO text VALUES (139,'{{SITENAME}} e-mail address confirmation','utf-8');
INSERT INTO text VALUES (140,'Your e-mail address has been confirmed. You may now log in and enjoy the wiki.','utf-8');
INSERT INTO text VALUES (141,'This wiki requires that you validate your e-mail address\nbefore using e-mail features. Activate the button below to send a confirmation\nmail to your address. The mail will include a link containing a code; load the\nlink in your browser to confirm that your e-mail address is valid.','utf-8');
INSERT INTO text VALUES (142,'Confirm protection','utf-8');
INSERT INTO text VALUES (143,'Do you really want to protect this page?','utf-8');
INSERT INTO text VALUES (144,'User [[User:$1|$1]] ([[User talk:$1|talk]]) deleted this article after you started editing with reason:\n: \'\'$2\'\'\nPlease confirm that really want to recreate this article.','utf-8');
INSERT INTO text VALUES (145,'Confirm unprotection','utf-8');
INSERT INTO text VALUES (146,'Do you really want to unprotect this page?','utf-8');
INSERT INTO text VALUES (147,'Context per line:','utf-8');
INSERT INTO text VALUES (148,'Lines per hit:','utf-8');
INSERT INTO text VALUES (149,'$1 minor edits','utf-8');
INSERT INTO text VALUES (150,'contribs','utf-8');
INSERT INTO text VALUES (151,'For $1','utf-8');
INSERT INTO text VALUES (152,'User contributions','utf-8');
INSERT INTO text VALUES (153,'Content is available under $1.','utf-8');
INSERT INTO text VALUES (154,'Project:Copyrights','utf-8');
INSERT INTO text VALUES (155,'{{SITENAME}} copyright','utf-8');
INSERT INTO text VALUES (156,'Please note that all contributions to {{SITENAME}} are considered to be released under the $2 (see $1 for details). If you don\'t want your writing to be edited mercilessly and redistributed at will, then don\'t submit it here.<br />\nYou are also promising us that you wrote this yourself, or copied it from a public domain or similar free resource.\n<strong>DO NOT SUBMIT COPYRIGHTED WORK WITHOUT PERMISSION!</strong>','utf-8');
INSERT INTO text VALUES (157,'Please note that all contributions to {{SITENAME}} may be edited, altered, or removed by other contributors. If you don\'t want your writing to be edited mercilessly, then don\'t submit it here.<br />\nYou are also promising us that you wrote this yourself, or copied it from a\npublic domain or similar free resource (see $1 for details).\n<strong>DO NOT SUBMIT COPYRIGHTED WORK WITHOUT PERMISSION!</strong>','utf-8');
INSERT INTO text VALUES (158,'Couldn\'t remove item \'$1\'...','utf-8');
INSERT INTO text VALUES (159,'Create account','utf-8');
INSERT INTO text VALUES (160,'by e-mail','utf-8');
INSERT INTO text VALUES (161,'Create article','utf-8');
INSERT INTO text VALUES (162,'created','utf-8');
INSERT INTO text VALUES (163,'Page credits','utf-8');
INSERT INTO text VALUES (164,'cur','utf-8');
INSERT INTO text VALUES (165,'Current events','utf-8');
INSERT INTO text VALUES (166,'Current events','utf-8');
INSERT INTO text VALUES (167,'Current revision','utf-8');
INSERT INTO text VALUES (168,'view current revision','utf-8');
INSERT INTO text VALUES (169,'Data','utf-8');
INSERT INTO text VALUES (170,'Database error','utf-8');
INSERT INTO text VALUES (171,'No preference','utf-8');
INSERT INTO text VALUES (172,'Date format','utf-8');
INSERT INTO text VALUES (173,'Date and time','utf-8');
INSERT INTO text VALUES (174,'A database query syntax error has occurred.\nThis may indicate a bug in the software.\nThe last attempted database query was:\n<blockquote><tt>$1</tt></blockquote>\nfrom within function \"<tt>$2</tt>\".\nMySQL returned error \"<tt>$3: $4</tt>\".','utf-8');
INSERT INTO text VALUES (175,'A database query syntax error has occurred.\nThe last attempted database query was:\n\"$1\"\nfrom within function \"$2\".\nMySQL returned error \"$3: $4\"','utf-8');
INSERT INTO text VALUES (176,'Dead-end pages','utf-8');
INSERT INTO text VALUES (177,'Debug','utf-8');
INSERT INTO text VALUES (178,'Dec','utf-8');
INSERT INTO text VALUES (179,'December','utf-8');
INSERT INTO text VALUES (180,'default','utf-8');
INSERT INTO text VALUES (181,'Search in these namespaces by default:','utf-8');
INSERT INTO text VALUES (182,'{{SITENAME}} e-mail','utf-8');
INSERT INTO text VALUES (183,'Delete','utf-8');
INSERT INTO text VALUES (184,'Delete and move','utf-8');
INSERT INTO text VALUES (185,'Yes, delete the page','utf-8');
INSERT INTO text VALUES (186,'Deleted to make way for move','utf-8');
INSERT INTO text VALUES (187,'==Deletion required==\n\nThe destination article \"[[$1]]\" already exists. Do you want to delete it to make way for the move?','utf-8');
INSERT INTO text VALUES (188,'Reason for deletion','utf-8');
INSERT INTO text VALUES (189,'deleted \"[[$1]]\"','utf-8');
INSERT INTO text VALUES (190,'[deleted]','utf-8');
INSERT INTO text VALUES (191,'Deleted old revision $1.','utf-8');
INSERT INTO text VALUES (192,'\"$1\" has been deleted.\nSee $2 for a record of recent deletions.','utf-8');
INSERT INTO text VALUES (193,'Warning: This page has been deleted after you started editing!','utf-8');
INSERT INTO text VALUES (194,'del','utf-8');
INSERT INTO text VALUES (195,'Delete all revisions of this file','utf-8');
INSERT INTO text VALUES (196,'Delete page','utf-8');
INSERT INTO text VALUES (197,'(Deleting \"$1\")','utf-8');
INSERT INTO text VALUES (198,'Delete this page','utf-8');
INSERT INTO text VALUES (199,'deletion log','utf-8');
INSERT INTO text VALUES (200,'Deletion_log','utf-8');
INSERT INTO text VALUES (201,'Below is a list of the most recent deletions.','utf-8');
INSERT INTO text VALUES (202,'Destination filename','utf-8');
INSERT INTO text VALUES (203,'The action you have requested can only be\nperformed by users with \"developer\" capability.\nSee $1.','utf-8');
INSERT INTO text VALUES (204,'Developer access required','utf-8');
INSERT INTO text VALUES (205,'diff','utf-8');
INSERT INTO text VALUES (206,'(Difference between revisions)','utf-8');
INSERT INTO text VALUES (207,'Disambiguation pages','utf-8');
INSERT INTO text VALUES (208,'Template:disambig','utf-8');
INSERT INTO text VALUES (209,'The following pages link to a <i>disambiguation page</i>. They should link to the appropriate topic instead.<br />A page is treated as disambiguation if it is linked from $1.<br />Links from other namespaces are <i>not</i> listed here.','utf-8');
INSERT INTO text VALUES (210,'Project:General_disclaimer','utf-8');
INSERT INTO text VALUES (211,'Disclaimers','utf-8');
INSERT INTO text VALUES (212,'Double redirects','utf-8');
INSERT INTO text VALUES (213,'Each row contains links to the first and second redirect, as well as the first line of the second redirect text, usually giving the \"real\" target page, which the first redirect should point to.','utf-8');
INSERT INTO text VALUES (214,'download','utf-8');
INSERT INTO text VALUES (215,'A confirmation e-mail has been sent to the nominated e-mail address.\nBefore any other mail is sent to the account, you will have to follow the instructions in the e-mail,\nto confirm that the account is actually yours.','utf-8');
INSERT INTO text VALUES (216,'Edit','utf-8');
INSERT INTO text VALUES (217,'Edit this file using an external application','utf-8');
INSERT INTO text VALUES (218,'See the [http://meta.wikimedia.org/wiki/Help:External_editors setup instructions] for more information.','utf-8');
INSERT INTO text VALUES (219,'The edit comment was: \"<i>$1</i>\".','utf-8');
INSERT INTO text VALUES (220,'Edit conflict: $1','utf-8');
INSERT INTO text VALUES (221,'Edit the current version of this page','utf-8');
INSERT INTO text VALUES (222,'Edit Group','utf-8');
INSERT INTO text VALUES (223,'Editing help','utf-8');
INSERT INTO text VALUES (224,'Help:Editing','utf-8');
INSERT INTO text VALUES (225,'Editing $1','utf-8');
INSERT INTO text VALUES (226,'Editing $1 (comment)','utf-8');
INSERT INTO text VALUES (227,'<strong>WARNING: You are editing an out-of-date\nrevision of this page.\nIf you save it, any changes made since this revision will be lost.</strong>','utf-8');
INSERT INTO text VALUES (228,'Editing $1 (section)','utf-8');
INSERT INTO text VALUES (229,'edit','utf-8');
INSERT INTO text VALUES (230,'Edit section: $1','utf-8');
INSERT INTO text VALUES (231,'Edit this page','utf-8');
INSERT INTO text VALUES (232,'<!-- Text here will be shown below edit and upload forms. -->','utf-8');
INSERT INTO text VALUES (233,'Edit User Groups','utf-8');
INSERT INTO text VALUES (234,'E-mail','utf-8');
INSERT INTO text VALUES (235,'Your e-mail address was authenticated on $1.','utf-8');
INSERT INTO text VALUES (236,'Confirm your e-mail address','utf-8');
INSERT INTO text VALUES (237,'<div style=\"width:30em\">* Optional. An e-mail lets others contact you on this site without revealing your address, and lets us send you a new password if you forget it.<br /><br />Your real name will be used to give you attribution for your work.</div>','utf-8');
INSERT INTO text VALUES (238,'From','utf-8');
INSERT INTO text VALUES (239,'Message','utf-8');
INSERT INTO text VALUES (240,'Your e-mail address is <strong>not yet authenticated</strong>. No e-mail\nwill be sent for any of the following features.','utf-8');
INSERT INTO text VALUES (241,'E-mail user','utf-8');
INSERT INTO text VALUES (242,'If this user has entered a valid e-mail address in\nhis or her user preferences, the form below will send a single message.\nThe e-mail address you entered in your user preferences will appear\nas the \"From\" address of the mail, so the recipient will be able\nto reply.','utf-8');
INSERT INTO text VALUES (243,'Send','utf-8');
INSERT INTO text VALUES (244,'E-mail sent','utf-8');
INSERT INTO text VALUES (245,'Your e-mail message has been sent.','utf-8');
INSERT INTO text VALUES (246,'Subject','utf-8');
INSERT INTO text VALUES (247,'To','utf-8');
INSERT INTO text VALUES (248,'E-mail this user','utf-8');
INSERT INTO text VALUES (249,'The file you uploaded seems to be empty. This might be due to a typo in the file name. Please check whether you really want to upload this file.','utf-8');
INSERT INTO text VALUES (250,'Dear $WATCHINGUSERNAME,\n\nthe {{SITENAME}} page $PAGETITLE has been $CHANGEDORCREATED on $PAGEEDITDATE by $PAGEEDITOR, see $PAGETITLE_URL for the current version.\n\n$NEWPAGE\n\nEditor\'s summary: $PAGESUMMARY $PAGEMINOREDIT\n\nContact the editor:\nmail: $PAGEEDITOR_EMAIL\nwiki: $PAGEEDITOR_WIKI\n\nThere will be no other notifications in case of further changes unless you visit this page. You could also reset the notification flags for all your watched pages on your watchlist.\n\n             Your friendly {{SITENAME}} notification system\n\n--\nTo change your watchlist settings, visit\n{{SERVER}}{{localurl:Special:Watchlist/edit}}\n\nFeedback and further assistance:\n{{SERVER}}{{localurl:Help:Contents}}','utf-8');
INSERT INTO text VALUES (251,'See $1 for all changes since your last visit.','utf-8');
INSERT INTO text VALUES (252,'{{SITENAME}} Notification Mailer','utf-8');
INSERT INTO text VALUES (253,'This is a new page.','utf-8');
INSERT INTO text VALUES (254,'Mark all pages visited','utf-8');
INSERT INTO text VALUES (255,'{{SITENAME}} page $PAGETITLE has been $CHANGEDORCREATED by $PAGEEDITOR','utf-8');
INSERT INTO text VALUES (256,'Enter a reason for the lock, including an estimate\nof when the lock will be released','utf-8');
INSERT INTO text VALUES (257,'Error','utf-8');
INSERT INTO text VALUES (258,'Error','utf-8');
INSERT INTO text VALUES (259,'content before blanking was: \'$1\'','utf-8');
INSERT INTO text VALUES (260,'page was empty','utf-8');
INSERT INTO text VALUES (261,'content was: \'$1\'','utf-8');
INSERT INTO text VALUES (262,'content was: \'$1\' (and the only contributor was \'$2\')','utf-8');
INSERT INTO text VALUES (263,'Aperture','utf-8');
INSERT INTO text VALUES (264,'Author','utf-8');
INSERT INTO text VALUES (265,'Bits per component','utf-8');
INSERT INTO text VALUES (266,'Brightness','utf-8');
INSERT INTO text VALUES (267,'CFA pattern','utf-8');
INSERT INTO text VALUES (268,'Color space','utf-8');
INSERT INTO text VALUES (269,'sRGB','utf-8');
INSERT INTO text VALUES (270,'FFFF.H','utf-8');
INSERT INTO text VALUES (271,'Meaning of each component','utf-8');
INSERT INTO text VALUES (272,'does not exist','utf-8');
INSERT INTO text VALUES (273,'Y','utf-8');
INSERT INTO text VALUES (274,'Cb','utf-8');
INSERT INTO text VALUES (275,'Cr','utf-8');
INSERT INTO text VALUES (276,'R','utf-8');
INSERT INTO text VALUES (277,'G','utf-8');
INSERT INTO text VALUES (278,'B','utf-8');
INSERT INTO text VALUES (279,'Image compression mode','utf-8');
INSERT INTO text VALUES (280,'Compression scheme','utf-8');
INSERT INTO text VALUES (281,'Uncompressed','utf-8');
INSERT INTO text VALUES (282,'JPEG','utf-8');
INSERT INTO text VALUES (283,'Contrast','utf-8');
INSERT INTO text VALUES (284,'Normal','utf-8');
INSERT INTO text VALUES (285,'Soft','utf-8');
INSERT INTO text VALUES (286,'Hard','utf-8');
INSERT INTO text VALUES (287,'Copyright holder','utf-8');
INSERT INTO text VALUES (288,'Custom image processing','utf-8');
INSERT INTO text VALUES (289,'Normal process','utf-8');
INSERT INTO text VALUES (290,'Custom process','utf-8');
INSERT INTO text VALUES (291,'File change date and time','utf-8');
INSERT INTO text VALUES (292,'Date and time of digitizing','utf-8');
INSERT INTO text VALUES (293,'Date and time of data generation','utf-8');
INSERT INTO text VALUES (294,'Device settings description','utf-8');
INSERT INTO text VALUES (295,'Digital zoom ratio','utf-8');
INSERT INTO text VALUES (296,'Exif version','utf-8');
INSERT INTO text VALUES (297,'Exposure bias','utf-8');
INSERT INTO text VALUES (298,'Exposure index','utf-8');
INSERT INTO text VALUES (299,'Exposure mode','utf-8');
INSERT INTO text VALUES (300,'Auto exposure','utf-8');
INSERT INTO text VALUES (301,'Manual exposure','utf-8');
INSERT INTO text VALUES (302,'Auto bracket','utf-8');
INSERT INTO text VALUES (303,'Exposure Program','utf-8');
INSERT INTO text VALUES (304,'Not defined','utf-8');
INSERT INTO text VALUES (305,'Manual','utf-8');
INSERT INTO text VALUES (306,'Normal program','utf-8');
INSERT INTO text VALUES (307,'Aperture priority','utf-8');
INSERT INTO text VALUES (308,'Shutter priority','utf-8');
INSERT INTO text VALUES (309,'Creative program (biased toward depth of field)','utf-8');
INSERT INTO text VALUES (310,'Action program (biased toward fast shutter speed)','utf-8');
INSERT INTO text VALUES (311,'Portrait mode (for closeup photos with the background out of focus)','utf-8');
INSERT INTO text VALUES (312,'Landscape mode (for landscape photos with the background in focus)','utf-8');
INSERT INTO text VALUES (313,'Exposure time','utf-8');
INSERT INTO text VALUES (314,'$1 sec ($2)','utf-8');
INSERT INTO text VALUES (315,'File source','utf-8');
INSERT INTO text VALUES (316,'DSC','utf-8');
INSERT INTO text VALUES (317,'Flash','utf-8');
INSERT INTO text VALUES (318,'Flash energy','utf-8');
INSERT INTO text VALUES (319,'Supported Flashpix version','utf-8');
INSERT INTO text VALUES (320,'F Number','utf-8');
INSERT INTO text VALUES (321,'f/$1','utf-8');
INSERT INTO text VALUES (322,'Lens focal length','utf-8');
INSERT INTO text VALUES (323,'$1 mm','utf-8');
INSERT INTO text VALUES (324,'Focal length in 35 mm film','utf-8');
INSERT INTO text VALUES (325,'Focal plane resolution unit','utf-8');
INSERT INTO text VALUES (326,'inches','utf-8');
INSERT INTO text VALUES (327,'Focal plane X resolution','utf-8');
INSERT INTO text VALUES (328,'Focal plane Y resolution','utf-8');
INSERT INTO text VALUES (329,'Scene control','utf-8');
INSERT INTO text VALUES (330,'None','utf-8');
INSERT INTO text VALUES (331,'Low gain up','utf-8');
INSERT INTO text VALUES (332,'High gain up','utf-8');
INSERT INTO text VALUES (333,'Low gain down','utf-8');
INSERT INTO text VALUES (334,'High gain down','utf-8');
INSERT INTO text VALUES (335,'Altitude','utf-8');
INSERT INTO text VALUES (336,'Altitude reference','utf-8');
INSERT INTO text VALUES (337,'Name of GPS area','utf-8');
INSERT INTO text VALUES (338,'GPS date','utf-8');
INSERT INTO text VALUES (339,'Bearing of destination','utf-8');
INSERT INTO text VALUES (340,'Reference for bearing of destination','utf-8');
INSERT INTO text VALUES (341,'Distance to destination','utf-8');
INSERT INTO text VALUES (342,'Reference for distance to destination','utf-8');
INSERT INTO text VALUES (343,'Latitude destination','utf-8');
INSERT INTO text VALUES (344,'Reference for latitude of destination','utf-8');
INSERT INTO text VALUES (345,'Longitude of destination','utf-8');
INSERT INTO text VALUES (346,'Reference for longitude of destination','utf-8');
INSERT INTO text VALUES (347,'GPS differential correction','utf-8');
INSERT INTO text VALUES (348,'Magnetic direction','utf-8');
INSERT INTO text VALUES (349,'True direction','utf-8');
INSERT INTO text VALUES (350,'Measurement precision','utf-8');
INSERT INTO text VALUES (351,'Direction of image','utf-8');
INSERT INTO text VALUES (352,'Reference for direction of image','utf-8');
INSERT INTO text VALUES (353,'Latitude','utf-8');
INSERT INTO text VALUES (354,'North latitude','utf-8');
INSERT INTO text VALUES (355,'South latitude','utf-8');
INSERT INTO text VALUES (356,'North or South Latitude','utf-8');
INSERT INTO text VALUES (357,'Longitude','utf-8');
INSERT INTO text VALUES (358,'East longitude','utf-8');
INSERT INTO text VALUES (359,'West longitude','utf-8');
INSERT INTO text VALUES (360,'East or West Longitude','utf-8');
INSERT INTO text VALUES (361,'Geodetic survey data used','utf-8');
INSERT INTO text VALUES (362,'Measurement mode','utf-8');
INSERT INTO text VALUES (363,'2-dimensional measurement','utf-8');
INSERT INTO text VALUES (364,'3-dimensional measurement','utf-8');
INSERT INTO text VALUES (365,'Name of GPS processing method','utf-8');
INSERT INTO text VALUES (366,'Satellites used for measurement','utf-8');
INSERT INTO text VALUES (367,'Speed of GPS receiver','utf-8');
INSERT INTO text VALUES (368,'Kilometres per hour','utf-8');
INSERT INTO text VALUES (369,'Miles per hour','utf-8');
INSERT INTO text VALUES (370,'Knots','utf-8');
INSERT INTO text VALUES (371,'Speed unit','utf-8');
INSERT INTO text VALUES (372,'Receiver status','utf-8');
INSERT INTO text VALUES (373,'Measurement in progress','utf-8');
INSERT INTO text VALUES (374,'Measurement interoperability','utf-8');
INSERT INTO text VALUES (375,'GPS time (atomic clock)','utf-8');
INSERT INTO text VALUES (376,'Direction of movement','utf-8');
INSERT INTO text VALUES (377,'Reference for direction of movement','utf-8');
INSERT INTO text VALUES (378,'GPS tag version','utf-8');
INSERT INTO text VALUES (379,'Image title','utf-8');
INSERT INTO text VALUES (380,'Height','utf-8');
INSERT INTO text VALUES (381,'Unique image ID','utf-8');
INSERT INTO text VALUES (382,'Width','utf-8');
INSERT INTO text VALUES (383,'ISO speed rating','utf-8');
INSERT INTO text VALUES (384,'Offset to JPEG SOI','utf-8');
INSERT INTO text VALUES (385,'Bytes of JPEG data','utf-8');
INSERT INTO text VALUES (386,'Light source','utf-8');
INSERT INTO text VALUES (387,'Unknown','utf-8');
INSERT INTO text VALUES (388,'Daylight','utf-8');
INSERT INTO text VALUES (389,'Cloudy weather','utf-8');
INSERT INTO text VALUES (390,'Shade','utf-8');
INSERT INTO text VALUES (391,'Daylight fluorescent (D 5700 – 7100K)','utf-8');
INSERT INTO text VALUES (392,'Day white fluorescent (N 4600 – 5400K)','utf-8');
INSERT INTO text VALUES (393,'Cool white fluorescent (W 3900 – 4500K)','utf-8');
INSERT INTO text VALUES (394,'White fluorescent (WW 3200 – 3700K)','utf-8');
INSERT INTO text VALUES (395,'Standard light A','utf-8');
INSERT INTO text VALUES (396,'Standard light B','utf-8');
INSERT INTO text VALUES (397,'Standard light C','utf-8');
INSERT INTO text VALUES (398,'Fluorescent','utf-8');
INSERT INTO text VALUES (399,'D55','utf-8');
INSERT INTO text VALUES (400,'D65','utf-8');
INSERT INTO text VALUES (401,'D75','utf-8');
INSERT INTO text VALUES (402,'D50','utf-8');
INSERT INTO text VALUES (403,'ISO studio tungsten','utf-8');
INSERT INTO text VALUES (404,'Other light source','utf-8');
INSERT INTO text VALUES (405,'Tungsten (incandescent light)','utf-8');
INSERT INTO text VALUES (406,'Flash','utf-8');
INSERT INTO text VALUES (407,'Fine weather','utf-8');
INSERT INTO text VALUES (408,'Camera manufacturer','utf-8');
INSERT INTO text VALUES (409,'$1','utf-8');
INSERT INTO text VALUES (410,'Manufacturer notes','utf-8');
INSERT INTO text VALUES (411,'Maximum land aperture','utf-8');
INSERT INTO text VALUES (412,'Metering mode','utf-8');
INSERT INTO text VALUES (413,'Unknown','utf-8');
INSERT INTO text VALUES (414,'Average','utf-8');
INSERT INTO text VALUES (415,'CenterWeightedAverage','utf-8');
INSERT INTO text VALUES (416,'Other','utf-8');
INSERT INTO text VALUES (417,'Spot','utf-8');
INSERT INTO text VALUES (418,'MultiSpot','utf-8');
INSERT INTO text VALUES (419,'Pattern','utf-8');
INSERT INTO text VALUES (420,'Partial','utf-8');
INSERT INTO text VALUES (421,'Camera model','utf-8');
INSERT INTO text VALUES (422,'$1','utf-8');
INSERT INTO text VALUES (423,'Optoelectronic conversion factor','utf-8');
INSERT INTO text VALUES (424,'Orientation','utf-8');
INSERT INTO text VALUES (425,'Normal','utf-8');
INSERT INTO text VALUES (426,'Flipped horizontally','utf-8');
INSERT INTO text VALUES (427,'Rotated 180°','utf-8');
INSERT INTO text VALUES (428,'Flipped vertically','utf-8');
INSERT INTO text VALUES (429,'Rotated 90° CCW and flipped vertically','utf-8');
INSERT INTO text VALUES (430,'Rotated 90° CW','utf-8');
INSERT INTO text VALUES (431,'Rotated 90° CW and flipped vertically','utf-8');
INSERT INTO text VALUES (432,'Rotated 90° CCW','utf-8');
INSERT INTO text VALUES (433,'Pixel composition','utf-8');
INSERT INTO text VALUES (434,'RGB','utf-8');
INSERT INTO text VALUES (435,'YCbCr','utf-8');
INSERT INTO text VALUES (436,'Valind image height','utf-8');
INSERT INTO text VALUES (437,'Valid image width','utf-8');
INSERT INTO text VALUES (438,'Data arrangement','utf-8');
INSERT INTO text VALUES (439,'chunky format','utf-8');
INSERT INTO text VALUES (440,'planar format','utf-8');
INSERT INTO text VALUES (441,'Chromaticities of primarities','utf-8');
INSERT INTO text VALUES (442,'Pair of black and white reference values','utf-8');
INSERT INTO text VALUES (443,'Related audio file','utf-8');
INSERT INTO text VALUES (444,'Unit of X and Y resolution','utf-8');
INSERT INTO text VALUES (445,'Number of rows per strip','utf-8');
INSERT INTO text VALUES (446,'Number of components','utf-8');
INSERT INTO text VALUES (447,'Saturation','utf-8');
INSERT INTO text VALUES (448,'Normal','utf-8');
INSERT INTO text VALUES (449,'Low saturation','utf-8');
INSERT INTO text VALUES (450,'High saturation','utf-8');
INSERT INTO text VALUES (451,'Scene capture type','utf-8');
INSERT INTO text VALUES (452,'Standard','utf-8');
INSERT INTO text VALUES (453,'Landscape','utf-8');
INSERT INTO text VALUES (454,'Portrait','utf-8');
INSERT INTO text VALUES (455,'Night scene','utf-8');
INSERT INTO text VALUES (456,'Scene type','utf-8');
INSERT INTO text VALUES (457,'A directly photographed image','utf-8');
INSERT INTO text VALUES (458,'Sensing method','utf-8');
INSERT INTO text VALUES (459,'Undefined','utf-8');
INSERT INTO text VALUES (460,'One-chip color area sensor','utf-8');
INSERT INTO text VALUES (461,'Two-chip color area sensor','utf-8');
INSERT INTO text VALUES (462,'Three-chip color area sensor','utf-8');
INSERT INTO text VALUES (463,'Color sequential area sensor','utf-8');
INSERT INTO text VALUES (464,'Trilinear sensor','utf-8');
INSERT INTO text VALUES (465,'Color sequential linear sensor','utf-8');
INSERT INTO text VALUES (466,'Sharpness','utf-8');
INSERT INTO text VALUES (467,'Normal','utf-8');
INSERT INTO text VALUES (468,'Soft','utf-8');
INSERT INTO text VALUES (469,'Hard','utf-8');
INSERT INTO text VALUES (470,'Shutter speed','utf-8');
INSERT INTO text VALUES (471,'Software used','utf-8');
INSERT INTO text VALUES (472,'$1','utf-8');
INSERT INTO text VALUES (473,'Spatial frequency response','utf-8');
INSERT INTO text VALUES (474,'Spectral sensitivity','utf-8');
INSERT INTO text VALUES (475,'Bytes per compressed strip','utf-8');
INSERT INTO text VALUES (476,'Image data location','utf-8');
INSERT INTO text VALUES (477,'Subject area','utf-8');
INSERT INTO text VALUES (478,'Subject distance','utf-8');
INSERT INTO text VALUES (479,'$1 metres','utf-8');
INSERT INTO text VALUES (480,'Subject distance range','utf-8');
INSERT INTO text VALUES (481,'Unknown','utf-8');
INSERT INTO text VALUES (482,'Macro','utf-8');
INSERT INTO text VALUES (483,'Close view','utf-8');
INSERT INTO text VALUES (484,'Distant view','utf-8');
INSERT INTO text VALUES (485,'Subject location','utf-8');
INSERT INTO text VALUES (486,'DateTime subseconds','utf-8');
INSERT INTO text VALUES (487,'DateTimeDigitized subseconds','utf-8');
INSERT INTO text VALUES (488,'DateTimeOriginal subseconds','utf-8');
INSERT INTO text VALUES (489,'Transfer function','utf-8');
INSERT INTO text VALUES (490,'User comments','utf-8');
INSERT INTO text VALUES (491,'White Balance','utf-8');
INSERT INTO text VALUES (492,'Auto white balance','utf-8');
INSERT INTO text VALUES (493,'Manual white balance','utf-8');
INSERT INTO text VALUES (494,'White point chromaticity','utf-8');
INSERT INTO text VALUES (495,'Horizontal resolution','utf-8');
INSERT INTO text VALUES (496,'$1 dpc','utf-8');
INSERT INTO text VALUES (497,'$1 dpi','utf-8');
INSERT INTO text VALUES (498,'Color space transformation matrix coefficients','utf-8');
INSERT INTO text VALUES (499,'Y and C positioning','utf-8');
INSERT INTO text VALUES (500,'Subsampling ratio of Y to C','utf-8');
INSERT INTO text VALUES (501,'Vertical resolution','utf-8');
INSERT INTO text VALUES (502,'expires $1','utf-8');
INSERT INTO text VALUES (503,'Someone else has changed this page since you started editing it.\nThe upper text area contains the page text as it currently exists.\nYour changes are shown in the lower text area.\nYou will have to merge your changes into the existing text.\n<b>Only</b> the text in the upper text area will be saved when you\npress \"Save page\".<br />','utf-8');
INSERT INTO text VALUES (504,'Export pages','utf-8');
INSERT INTO text VALUES (505,'Include only the current revision, not the full history','utf-8');
INSERT INTO text VALUES (506,'----\n\'\'\'Note:\'\'\' exporting the full history of pages through this form has been disabled due to performance reasons.','utf-8');
INSERT INTO text VALUES (507,'You can export the text and editing history of a particular page or\nset of pages wrapped in some XML. This can be imported into another wiki using MediaWiki\nvia the Special:Import page.\n\nTo export pages, enter the titles in the text box below, one title per line, and\nselect whether you want the current version as well as all old versions, with the page\nhistory lines, or just the current version with the info about the last edit.\n\nIn the latter case you can also use a link, e.g. [[{{ns:Special}}:Export/{{Mediawiki:mainpage}}]] for the page {{Mediawiki:mainpage}}.','utf-8');
INSERT INTO text VALUES (508,'There was either an external authentication database error or you are not allowed to update your external account.','utf-8');
INSERT INTO text VALUES (509,'http://www.example.com link title','utf-8');
INSERT INTO text VALUES (510,'External link (remember http:// prefix)','utf-8');
INSERT INTO text VALUES (511,'FAQ','utf-8');
INSERT INTO text VALUES (512,'Project:FAQ','utf-8');
INSERT INTO text VALUES (513,'Feb','utf-8');
INSERT INTO text VALUES (514,'February','utf-8');
INSERT INTO text VALUES (515,'Feed:','utf-8');
INSERT INTO text VALUES (516,'Could not copy file \"$1\" to \"$2\".','utf-8');
INSERT INTO text VALUES (517,'Could not delete file \"$1\".','utf-8');
INSERT INTO text VALUES (518,'Summary','utf-8');
INSERT INTO text VALUES (519,'A file with this name exists already, please check $1 if you are not sure if you want to change it.','utf-8');
INSERT INTO text VALUES (520,'A file with this name exists already; please go back and upload this file under a new name. [[Image:$1|thumb|center|$1]]','utf-8');
INSERT INTO text VALUES (521,'A file with this name exists already in the shared file repository; please go back and upload this file under a new name. [[Image:$1|thumb|center|$1]]','utf-8');
INSERT INTO text VALUES (522,'$1KB, MIME type: <code>$2</code>','utf-8');
INSERT INTO text VALUES (523,'File missing','utf-8');
INSERT INTO text VALUES (524,'Filename','utf-8');
INSERT INTO text VALUES (525,'Could not find file \"$1\".','utf-8');
INSERT INTO text VALUES (526,'Could not rename file \"$1\" to \"$2\".','utf-8');
INSERT INTO text VALUES (527,'Files','utf-8');
INSERT INTO text VALUES (528,'Source','utf-8');
INSERT INTO text VALUES (529,'Copyright status','utf-8');
INSERT INTO text VALUES (530,'File $1 uploaded successfully.\nPlease follow this link: $2 to the description page and fill\nin information about the file, such as where it came from, when it was\ncreated and by whom, and anything else you may know about it. If this is an image, you can insert it like this: <tt><nowiki>[[Image:$1|thumb|Description]]</nowiki></tt>','utf-8');
INSERT INTO text VALUES (531,'Summary:','utf-8');
INSERT INTO text VALUES (532,'Error: could not submit form','utf-8');
INSERT INTO text VALUES (533,'Friday','utf-8');
INSERT INTO text VALUES (534,'fetching file list','utf-8');
INSERT INTO text VALUES (535,'Go','utf-8');
INSERT INTO text VALUES (536,'\n<form method=\"get\" action=\"http://www.google.com/search\" id=\"googlesearch\">\n    <input type=\"hidden\" name=\"domains\" value=\"{{SERVER}}\" />\n    <input type=\"hidden\" name=\"num\" value=\"50\" />\n    <input type=\"hidden\" name=\"ie\" value=\"$2\" />\n    <input type=\"hidden\" name=\"oe\" value=\"$2\" />\n\n    <input type=\"text\" name=\"q\" size=\"31\" maxlength=\"255\" value=\"$1\" />\n    <input type=\"submit\" name=\"btnG\" value=\"$3\" />\n  <div>\n    <input type=\"radio\" name=\"sitesearch\" id=\"gwiki\" value=\"{{SERVER}}\" checked=\"checked\" /><label for=\"gwiki\">{{SITENAME}}</label>\n    <input type=\"radio\" name=\"sitesearch\" id=\"gWWW\" value=\"\" /><label for=\"gWWW\">WWW</label>\n  </div>\n</form>','utf-8');
INSERT INTO text VALUES (537,'Already got an account? $1.','utf-8');
INSERT INTO text VALUES (538,'Log in','utf-8');
INSERT INTO text VALUES (539,'Trusted users able to block users and delete articles','utf-8');
INSERT INTO text VALUES (540,'Administrator','utf-8');
INSERT INTO text VALUES (541,'Anonymous users','utf-8');
INSERT INTO text VALUES (542,'Anonymous','utf-8');
INSERT INTO text VALUES (543,'The bureaucrat group is able to make sysops','utf-8');
INSERT INTO text VALUES (544,'Bureaucrat','utf-8');
INSERT INTO text VALUES (545,'General logged in users','utf-8');
INSERT INTO text VALUES (546,'User','utf-8');
INSERT INTO text VALUES (547,'Full access','utf-8');
INSERT INTO text VALUES (548,'Steward','utf-8');
INSERT INTO text VALUES (549,'User groups','utf-8');
INSERT INTO text VALUES (550,'Add group','utf-8');
INSERT INTO text VALUES (551,'A group of that name already exists','utf-8');
INSERT INTO text VALUES (552,'Edit group','utf-8');
INSERT INTO text VALUES (553,'Group description (max 255 characters):<br />','utf-8');
INSERT INTO text VALUES (554,'Group name:','utf-8');
INSERT INTO text VALUES (555,'If the name or description starts with a colon, the\nremainder will be treated as a message name, and hence the text will be localised\nusing the MediaWiki namespace','utf-8');
INSERT INTO text VALUES (556,'Existing groups','utf-8');
INSERT INTO text VALUES (557,'Existing groups:','utf-8');
INSERT INTO text VALUES (558,'Manage group rights','utf-8');
INSERT INTO text VALUES (559,'Please specify a valid group name','utf-8');
INSERT INTO text VALUES (560,'ID || Name || Description || Rights','utf-8');
INSERT INTO text VALUES (561,'Fill in from browser','utf-8');
INSERT INTO text VALUES (562,'Headline text','utf-8');
INSERT INTO text VALUES (563,'Level 2 headline','utf-8');
INSERT INTO text VALUES (564,'Help','utf-8');
INSERT INTO text VALUES (565,'Help:Contents','utf-8');
INSERT INTO text VALUES (566,'Hide','utf-8');
INSERT INTO text VALUES (567,'Hide results','utf-8');
INSERT INTO text VALUES (568,'hide','utf-8');
INSERT INTO text VALUES (569,'hist','utf-8');
INSERT INTO text VALUES (570,'Earliest','utf-8');
INSERT INTO text VALUES (571,'Latest','utf-8');
INSERT INTO text VALUES (572,'Diff selection: mark the radio boxes of the versions to compare and hit enter or the button at the bottom.<br />\nLegend: (cur) = difference with current version,\n(last) = difference with preceding version, M = minor edit.','utf-8');
INSERT INTO text VALUES (573,'Page history','utf-8');
INSERT INTO text VALUES (574,'-','utf-8');
INSERT INTO text VALUES (575,'History','utf-8');
INSERT INTO text VALUES (576,'Warning: The page you are about to delete has a history:','utf-8');
INSERT INTO text VALUES (577,'Horizontal line (use sparingly)','utf-8');
INSERT INTO text VALUES (578,'Ignore warning and save file anyway.','utf-8');
INSERT INTO text VALUES (579,'Ignore any warnings','utf-8');
INSERT INTO text VALUES (580,'The filename \"$1\" contains characters that are not allowed in page titles. Please rename the file and try uploading it again.','utf-8');
INSERT INTO text VALUES (581,'Search','utf-8');
INSERT INTO text VALUES (582,'Example.jpg','utf-8');
INSERT INTO text VALUES (583,'Embedded image','utf-8');
INSERT INTO text VALUES (584,'Links','utf-8');
INSERT INTO text VALUES (585,'File list','utf-8');
INSERT INTO text VALUES (586,'all','utf-8');
INSERT INTO text VALUES (587,'This shows only images uploaded by $1.','utf-8');
INSERT INTO text VALUES (588,'Below is a list of $1 files sorted $2.','utf-8');
INSERT INTO text VALUES (589,'Limit images on image description pages to:','utf-8');
INSERT INTO text VALUES (590,'View image page','utf-8');
INSERT INTO text VALUES (591,'Revert to earlier version was successful.','utf-8');
INSERT INTO text VALUES (592,'del','utf-8');
INSERT INTO text VALUES (593,'desc','utf-8');
INSERT INTO text VALUES (594,'Legend: (cur) = this is the current file, (del) = delete\nthis old version, (rev) = revert to this old version.\n<br /><i>Click on date to see the file uploaded on that date</i>.','utf-8');
INSERT INTO text VALUES (595,'File history','utf-8');
INSERT INTO text VALUES (596,'Legend: (desc) = show/edit file description.','utf-8');
INSERT INTO text VALUES (597,'Destination title is of a special type; cannot move pages into that namespace.','utf-8');
INSERT INTO text VALUES (598,'Import pages','utf-8');
INSERT INTO text VALUES (599,'Import failed: $1','utf-8');
INSERT INTO text VALUES (600,'Conflicting history revision exists (may have imported this page before)','utf-8');
INSERT INTO text VALUES (601,'Importing $1','utf-8');
INSERT INTO text VALUES (602,'Transwiki import','utf-8');
INSERT INTO text VALUES (603,'No import file was uploaded.','utf-8');
INSERT INTO text VALUES (604,'No transwiki import sources have been defined and direct history uploads are disabled.','utf-8');
INSERT INTO text VALUES (605,'Empty or no text','utf-8');
INSERT INTO text VALUES (606,'Import succeeded!','utf-8');
INSERT INTO text VALUES (607,'Please export the file from the source wiki using the Special:Export utility, save it to your disk and upload it here.','utf-8');
INSERT INTO text VALUES (608,'Upload of import file failed; perhaps the file is bigger than the allowed upload size.','utf-8');
INSERT INTO text VALUES (609,'infinite','utf-8');
INSERT INTO text VALUES (610,'Information','utf-8');
INSERT INTO text VALUES (611,'Information for page','utf-8');
INSERT INTO text VALUES (612,'Internal error','utf-8');
INSERT INTO text VALUES (613,'Interlanguage links','utf-8');
INSERT INTO text VALUES (614,'The e-mail address cannot be accepted as it appears to have an invalid\nformat. Please enter a well-formatted address or empty that field.','utf-8');
INSERT INTO text VALUES (615,'Invert selection','utf-8');
INSERT INTO text VALUES (616,'Invalid IP range.','utf-8');
INSERT INTO text VALUES (617,'IP Address','utf-8');
INSERT INTO text VALUES (618,'IP Address or username','utf-8');
INSERT INTO text VALUES (619,'Expiry time invalid.','utf-8');
INSERT INTO text VALUES (620,'Expiry','utf-8');
INSERT INTO text VALUES (621,'List of blocked IP addresses and usernames','utf-8');
INSERT INTO text VALUES (622,'The blocklist is empty.','utf-8');
INSERT INTO text VALUES (623,'2 hours:2 hours,1 day:1 day,3 days:3 days,1 week:1 week,2 weeks:2 weeks,1 month:1 month,3 months:3 months,6 months:6 months,1 year:1 year,infinite:infinite','utf-8');
INSERT INTO text VALUES (624,'Other time','utf-8');
INSERT INTO text VALUES (625,'other','utf-8');
INSERT INTO text VALUES (626,'Reason','utf-8');
INSERT INTO text VALUES (627,'Block this user','utf-8');
INSERT INTO text VALUES (628,'Unblock this address','utf-8');
INSERT INTO text VALUES (629,'\"[[$1]]\" unblocked','utf-8');
INSERT INTO text VALUES (630,'ISBN','utf-8');
INSERT INTO text VALUES (631,'redirect page','utf-8');
INSERT INTO text VALUES (632,'inclusion','utf-8');
INSERT INTO text VALUES (633,'Italic text','utf-8');
INSERT INTO text VALUES (634,'Italic text','utf-8');
INSERT INTO text VALUES (635,'Problem with item \'$1\', invalid name...','utf-8');
INSERT INTO text VALUES (636,'Jan','utf-8');
INSERT INTO text VALUES (637,'January','utf-8');
INSERT INTO text VALUES (638,'Jul','utf-8');
INSERT INTO text VALUES (639,'July','utf-8');
INSERT INTO text VALUES (640,'Jump to:','utf-8');
INSERT INTO text VALUES (641,'navigation','utf-8');
INSERT INTO text VALUES (642,'search','utf-8');
INSERT INTO text VALUES (643,'Jun','utf-8');
INSERT INTO text VALUES (644,'June','utf-8');
INSERT INTO text VALUES (645,'Warning: Page may not contain recent updates.','utf-8');
INSERT INTO text VALUES (646,'It is recommended that images not exceed $1 bytes in size, this file is $2 bytes','utf-8');
INSERT INTO text VALUES (647,'This file is bigger than the server is configured to allow.','utf-8');
INSERT INTO text VALUES (648,'last','utf-8');
INSERT INTO text VALUES (649,'This page was last modified $1.','utf-8');
INSERT INTO text VALUES (650,'This page was last modified $1 by $2.','utf-8');
INSERT INTO text VALUES (651,'Licensing','utf-8');
INSERT INTO text VALUES (652,'Line $1:','utf-8');
INSERT INTO text VALUES (653,'Link title','utf-8');
INSERT INTO text VALUES (654,'Internal link','utf-8');
INSERT INTO text VALUES (655,'(List of links)','utf-8');
INSERT INTO text VALUES (656,'/^(.*?)([a-zA-Z\\x80-\\xff]+)$/sD','utf-8');
INSERT INTO text VALUES (657,'The following pages link to here:','utf-8');
INSERT INTO text VALUES (658,'The following pages link to this file:','utf-8');
INSERT INTO text VALUES (659,'/^([a-z]+)(.*)$/sD','utf-8');
INSERT INTO text VALUES (660,'list','utf-8');
INSERT INTO text VALUES (661,' cont.','utf-8');
INSERT INTO text VALUES (662,'List redirects','utf-8');
INSERT INTO text VALUES (663,'User list','utf-8');
INSERT INTO text VALUES (664,'Loading page history','utf-8');
INSERT INTO text VALUES (665,'loading revision for diff','utf-8');
INSERT INTO text VALUES (666,'Local time','utf-8');
INSERT INTO text VALUES (667,'Lock database','utf-8');
INSERT INTO text VALUES (668,'Yes, I really want to lock the database.','utf-8');
INSERT INTO text VALUES (669,'Lock database','utf-8');
INSERT INTO text VALUES (670,'Database lock succeeded','utf-8');
INSERT INTO text VALUES (671,'The database has been locked.\n<br />Remember to remove the lock after your maintenance is complete.','utf-8');
INSERT INTO text VALUES (672,'Locking the database will suspend the ability of all\nusers to edit pages, change their preferences, edit their watchlists, and\nother things requiring changes in the database.\nPlease confirm that this is what you intend to do, and that you will\nunlock the database when your maintenance is done.','utf-8');
INSERT INTO text VALUES (673,'You did not check the confirmation box.','utf-8');
INSERT INTO text VALUES (674,'Logs','utf-8');
INSERT INTO text VALUES (675,'No matching items in log.','utf-8');
INSERT INTO text VALUES (676,'Log in','utf-8');
INSERT INTO text VALUES (677,'','utf-8');
INSERT INTO text VALUES (678,'Login error','utf-8');
INSERT INTO text VALUES (679,'User login','utf-8');
INSERT INTO text VALUES (680,'<b>There has been a problem with your login.</b><br />Try again!','utf-8');
INSERT INTO text VALUES (681,'You must have cookies enabled to log in to {{SITENAME}}.','utf-8');
INSERT INTO text VALUES (682,'log in','utf-8');
INSERT INTO text VALUES (683,'You must $1 to view other pages.','utf-8');
INSERT INTO text VALUES (684,'Login Required','utf-8');
INSERT INTO text VALUES (685,'\'\'\'You are now logged in to {{SITENAME}} as \"$1\".\'\'\'','utf-8');
INSERT INTO text VALUES (686,'Login successful','utf-8');
INSERT INTO text VALUES (687,'Log out','utf-8');
INSERT INTO text VALUES (688,'<strong>You are now logged out.</strong><br />\nYou can continue to use {{SITENAME}} anonymously, or you can log in\nagain as the same or as a different user. Note that some pages may\ncontinue to be displayed as if you were still logged in, until you clear\nyour browser cache.','utf-8');
INSERT INTO text VALUES (689,'User logout','utf-8');
INSERT INTO text VALUES (690,'Orphaned pages','utf-8');
INSERT INTO text VALUES (691,'<strong>ERROR: The text you have submitted is $1 kilobytes \nlong, which is longer than the maximum of $2 kilobytes. It cannot be saved.</strong>','utf-8');
INSERT INTO text VALUES (692,'Long pages','utf-8');
INSERT INTO text VALUES (693,'<strong>WARNING: This page is $1 kilobytes long; some\nbrowsers may have problems editing pages approaching or longer than 32kb.\nPlease consider breaking the page into smaller sections.</strong>','utf-8');
INSERT INTO text VALUES (694,'Error sending mail: $1','utf-8');
INSERT INTO text VALUES (695,'E-mail password','utf-8');
INSERT INTO text VALUES (696,'No send address','utf-8');
INSERT INTO text VALUES (697,'You must be [[Special:Userlogin|logged in]]\nand have a valid e-mail address in your [[Special:Preferences|preferences]]\nto send e-mail to other users.','utf-8');
INSERT INTO text VALUES (698,'Main Page','utf-8');
INSERT INTO text VALUES (699,'Consult the [http://meta.wikipedia.org/wiki/MediaWiki_User%27s_Guide User\'s Guide] for information on using the wiki software.\n\n== Getting started ==\n\n* [http://www.mediawiki.org/wiki/Help:Configuration_settings Configuration settings list]\n* [http://www.mediawiki.org/wiki/Help:FAQ MediaWiki FAQ]\n* [http://mail.wikipedia.org/mailman/listinfo/mediawiki-announce MediaWiki release mailing list]','utf-8');
INSERT INTO text VALUES (700,'<big>\'\'\'MediaWiki has been successfully installed.\'\'\'</big>','utf-8');
INSERT INTO text VALUES (701,'Make a user into a sysop','utf-8');
INSERT INTO text VALUES (702,'<b>User \"$1\" could not be made into a sysop. (Did you enter the name correctly?)</b>','utf-8');
INSERT INTO text VALUES (703,'Name of the user:','utf-8');
INSERT INTO text VALUES (704,'<b>User \"$1\" is now a sysop</b>','utf-8');
INSERT INTO text VALUES (705,'Make this user into a sysop','utf-8');
INSERT INTO text VALUES (706,'This form is used by bureaucrats to turn ordinary users into administrators.\nType the name of the user in the box and press the button to make the user an administrator','utf-8');
INSERT INTO text VALUES (707,'Make a user into a sysop','utf-8');
INSERT INTO text VALUES (708,'Mar','utf-8');
INSERT INTO text VALUES (709,'March','utf-8');
INSERT INTO text VALUES (710,'Mark as patrolled','utf-8');
INSERT INTO text VALUES (711,'[$1]','utf-8');
INSERT INTO text VALUES (712,'Mark this article as patrolled','utf-8');
INSERT INTO text VALUES (713,'Marked as patrolled','utf-8');
INSERT INTO text VALUES (714,'Cannot mark as patrolled','utf-8');
INSERT INTO text VALUES (715,'You need to specify a revision to mark as patrolled.','utf-8');
INSERT INTO text VALUES (716,'The selected revision has been marked as patrolled.','utf-8');
INSERT INTO text VALUES (717,'The query \"$1\" matched $2 page titles\nand the text of $3 pages.','utf-8');
INSERT INTO text VALUES (718,'Math','utf-8');
INSERT INTO text VALUES (719,'Can\'t write to or create math output directory','utf-8');
INSERT INTO text VALUES (720,'Can\'t write to or create math temp directory','utf-8');
INSERT INTO text VALUES (721,'Failed to parse','utf-8');
INSERT INTO text VALUES (722,'PNG conversion failed; check for correct installation of latex, dvips, gs, and convert','utf-8');
INSERT INTO text VALUES (723,'lexing error','utf-8');
INSERT INTO text VALUES (724,'Missing texvc executable; please see math/README to configure.','utf-8');
INSERT INTO text VALUES (725,'Insert formula here','utf-8');
INSERT INTO text VALUES (726,'syntax error','utf-8');
INSERT INTO text VALUES (727,'Mathematical formula (LaTeX)','utf-8');
INSERT INTO text VALUES (728,'unknown error','utf-8');
INSERT INTO text VALUES (729,'unknown function','utf-8');
INSERT INTO text VALUES (730,'May','utf-8');
INSERT INTO text VALUES (731,'May','utf-8');
INSERT INTO text VALUES (732,'Example.ogg','utf-8');
INSERT INTO text VALUES (733,'Media file link','utf-8');
INSERT INTO text VALUES (734,'\'\'\'Warning\'\'\': This file may contain malicious code, by executing it your system may be compromised.\n<hr>','utf-8');
INSERT INTO text VALUES (735,'Metadata','utf-8');
INSERT INTO text VALUES (736,'Hide extended details','utf-8');
INSERT INTO text VALUES (737,'Show extended details','utf-8');
INSERT INTO text VALUES (738,'EXIF metadata fields listed in this message will\nbe included on image page display when the metadata table\nis collapsed. Others will be hidden by default.\n* make\n* model\n* datetimeoriginal\n* exposuretime\n* fnumber\n* focallength','utf-8');
INSERT INTO text VALUES (739,'This file contains additional information, probably added from the digital camera or scanner used to create or digitize it. If the file has been modified from its original state, some details may not fully reflect the modified image.','utf-8');
INSERT INTO text VALUES (740,'Wikipedia:Metadata','utf-8');
INSERT INTO text VALUES (741,'MIME search','utf-8');
INSERT INTO text VALUES (742,'MIME type:','utf-8');
INSERT INTO text VALUES (743,'File names must be at least three letters.','utf-8');
INSERT INTO text VALUES (744,'This is a minor edit','utf-8');
INSERT INTO text VALUES (745,'m','utf-8');
INSERT INTO text VALUES (746,'The database did not find the text of a page that it should have found, named \"$1\".\n\nThis is usually caused by following an outdated diff or history link to a\npage that has been deleted.\n\nIf this is not the case, you may have found a bug in the software.\nPlease report this to an administrator, making note of the URL.','utf-8');
INSERT INTO text VALUES (747,'Please enter a comment below.','utf-8');
INSERT INTO text VALUES (748,'<b>Missing image</b><br /><i>$1</i>','utf-8');
INSERT INTO text VALUES (749,'\'\'\'Reminder:\'\'\' You have not provided an edit summary. If you click Save again, your edit will be saved without one.','utf-8');
INSERT INTO text VALUES (750,'Monday','utf-8');
INSERT INTO text VALUES (751,'More...','utf-8');
INSERT INTO text VALUES (752,'Articles with the most categories','utf-8');
INSERT INTO text VALUES (753,'Most linked to images','utf-8');
INSERT INTO text VALUES (754,'Most linked to pages','utf-8');
INSERT INTO text VALUES (755,'Most linked to categories','utf-8');
INSERT INTO text VALUES (756,'Articles with the most revisions','utf-8');
INSERT INTO text VALUES (757,'Move','utf-8');
INSERT INTO text VALUES (758,'Move page','utf-8');
INSERT INTO text VALUES (759,'moved to','utf-8');
INSERT INTO text VALUES (760,'Move log','utf-8');
INSERT INTO text VALUES (761,'Below is a list of page moved.','utf-8');
INSERT INTO text VALUES (762,'Not logged in','utf-8');
INSERT INTO text VALUES (763,'You must be a registered user and [[Special:Userlogin|logged in]]\nto move a page.','utf-8');
INSERT INTO text VALUES (764,'Move page','utf-8');
INSERT INTO text VALUES (765,'Move page','utf-8');
INSERT INTO text VALUES (766,'The associated talk page, if any, will be automatically moved along with it \'\'\'unless:\'\'\'\n*You are moving the page across namespaces,\n*A non-empty talk page already exists under the new name, or\n*You uncheck the box below.\n\nIn those cases, you will have to move or merge the page manually if desired.','utf-8');
INSERT INTO text VALUES (767,'Using the form below will rename a page, moving all\nof its history to the new name.\nThe old title will become a redirect page to the new title.\nLinks to the old page title will not be changed; be sure to\ncheck for double or broken redirects.\nYou are responsible for making sure that links continue to\npoint where they are supposed to go.\n\nNote that the page will \'\'\'not\'\'\' be moved if there is already\na page at the new title, unless it is empty or a redirect and has no\npast edit history. This means that you can rename a page back to where\nit was just renamed from if you make a mistake, and you cannot overwrite\nan existing page.\n\n<b>WARNING!</b>\nThis can be a drastic and unexpected change for a popular page;\nplease be sure you understand the consequences of this before\nproceeding.','utf-8');
INSERT INTO text VALUES (768,'Reason','utf-8');
INSERT INTO text VALUES (769,'Move associated talk page','utf-8');
INSERT INTO text VALUES (770,'Move this page','utf-8');
INSERT INTO text VALUES (771,'HTML if possible or else PNG','utf-8');
INSERT INTO text VALUES (772,'MathML if possible (experimental)','utf-8');
INSERT INTO text VALUES (773,'Recommended for modern browsers','utf-8');
INSERT INTO text VALUES (774,'Always render PNG','utf-8');
INSERT INTO text VALUES (775,'HTML if very simple or else PNG','utf-8');
INSERT INTO text VALUES (776,'Leave it as TeX (for text browsers)','utf-8');
INSERT INTO text VALUES (777,'My contributions','utf-8');
INSERT INTO text VALUES (778,'My page','utf-8');
INSERT INTO text VALUES (779,'My talk','utf-8');
INSERT INTO text VALUES (780,'Namespace:','utf-8');
INSERT INTO text VALUES (781,'all','utf-8');
INSERT INTO text VALUES (782,'Navigation','utf-8');
INSERT INTO text VALUES (783,'$1 bytes','utf-8');
INSERT INTO text VALUES (784,'$1 categories','utf-8');
INSERT INTO text VALUES (785,'$1 changes','utf-8');
INSERT INTO text VALUES (786,'(New)','utf-8');
INSERT INTO text VALUES (787,'You\'ve followed a link to a page that doesn\'t exist yet.\nTo create the page, start typing in the box below\n(see the [[Project:Help|help page]] for more info).\nIf you are here by mistake, just click your browser\'s \'\'\'back\'\'\' button.','utf-8');
INSERT INTO text VALUES (788,'{{int:newarticletext}}','utf-8');
INSERT INTO text VALUES (789,'newbies','utf-8');
INSERT INTO text VALUES (790,'Gallery of new files','utf-8');
INSERT INTO text VALUES (791,'diff to penultimate revision','utf-8');
INSERT INTO text VALUES (792,'new messages','utf-8');
INSERT INTO text VALUES (793,'New page','utf-8');
INSERT INTO text VALUES (794,'N','utf-8');
INSERT INTO text VALUES (795,'New pages','utf-8');
INSERT INTO text VALUES (796,'New password:','utf-8');
INSERT INTO text VALUES (797,',_','utf-8');
INSERT INTO text VALUES (798,'To new title','utf-8');
INSERT INTO text VALUES (799,' (new users only)','utf-8');
INSERT INTO text VALUES (800,'(opens in new window)','utf-8');
INSERT INTO text VALUES (801,'next','utf-8');
INSERT INTO text VALUES (802,'Next diff →','utf-8');
INSERT INTO text VALUES (803,'next $1','utf-8');
INSERT INTO text VALUES (804,'Next page ($1)','utf-8');
INSERT INTO text VALUES (805,'Newer revision→','utf-8');
INSERT INTO text VALUES (806,'$1 links','utf-8');
INSERT INTO text VALUES (807,'There is currently no text in this page, you can [[{{ns:special}}:Search/{{PAGENAME}}|search for this page title]] in other pages or [{{fullurl:{{NAMESPACE}}:{{PAGENAME}}|action=edit}} edit this page].','utf-8');
INSERT INTO text VALUES (808,'{{int:noarticletext}}','utf-8');
INSERT INTO text VALUES (809,'Sorry! The wiki is experiencing some technical difficulties, and cannot contact the database server. <br />\n$1','utf-8');
INSERT INTO text VALUES (810,'No changes were found matching these criteria.','utf-8');
INSERT INTO text VALUES (811,'{{SITENAME}} uses cookies to log in users. You have cookies disabled. Please enable them and try again.','utf-8');
INSERT INTO text VALUES (812,'The user account was created, but you are not logged in. {{SITENAME}} uses cookies to log in users. You have cookies disabled. Please enable them, then log in with your new username and password.','utf-8');
INSERT INTO text VALUES (813,'This site has restricted the ability to create new pages.\nYou can go back and edit an existing page, or [[Special:Userlogin|log in or create an account]].','utf-8');
INSERT INTO text VALUES (814,'Page creation limited','utf-8');
INSERT INTO text VALUES (815,'Creative Commons RDF metadata disabled for this server.','utf-8');
INSERT INTO text VALUES (816,'There is no credits info available for this page.','utf-8');
INSERT INTO text VALUES (817,'Could not select database $1','utf-8');
INSERT INTO text VALUES (818,'Dublin Core RDF metadata disabled for this server.','utf-8');
INSERT INTO text VALUES (819,'There is no e-mail address recorded for user \"$1\".','utf-8');
INSERT INTO text VALUES (820,'<strong>Specify an e-mail address for these features to work.</strong>','utf-8');
INSERT INTO text VALUES (821,'This user has not specified a valid e-mail address,\nor has chosen not to receive e-mail from other users.','utf-8');
INSERT INTO text VALUES (822,'No e-mail address','utf-8');
INSERT INTO text VALUES (823,'\'\'\'There is no page titled \"$1\".\'\'\' You can [[$1|create this page]].','utf-8');
INSERT INTO text VALUES (824,'There is no edit history for this page.','utf-8');
INSERT INTO text VALUES (825,'No file by this name exists, you can $1.','utf-8');
INSERT INTO text VALUES (826,'upload it','utf-8');
INSERT INTO text VALUES (827,'Nothing to see.','utf-8');
INSERT INTO text VALUES (828,'None selected','utf-8');
INSERT INTO text VALUES (829,'No pages link to here.','utf-8');
INSERT INTO text VALUES (830,'There are no pages that link to this file.','utf-8');
INSERT INTO text VALUES (831,'Don\'t have a login? $1.','utf-8');
INSERT INTO text VALUES (832,'Create an account','utf-8');
INSERT INTO text VALUES (833,'You have not specified a valid user name.','utf-8');
INSERT INTO text VALUES (834,'\'\'\'Note\'\'\': unsuccessful searches are\noften caused by searching for common words like \"have\" and \"from\",\nwhich are not indexed, or by specifying more than one search term (only pages\ncontaining all of the search terms will appear in the result).','utf-8');
INSERT INTO text VALUES (835,'<strong>WARNING: Your browser is not unicode compliant. A workaround is in place to allow you to safely edit articles: non-ASCII characters will appear in the edit box as hexadecimal codes.</strong>','utf-8');
INSERT INTO text VALUES (836,'You have requested an invalid special page, a list of valid special pages may be found at [[{{ns:special}}:Specialpages]].','utf-8');
INSERT INTO text VALUES (837,'No such action','utf-8');
INSERT INTO text VALUES (838,'The action specified by the URL is not\nrecognized by the wiki','utf-8');
INSERT INTO text VALUES (839,'No such special page','utf-8');
INSERT INTO text VALUES (840,'There is no user by the name \"$1\". Check your spelling, or create a new account.','utf-8');
INSERT INTO text VALUES (841,'There is no user by the name \"$1\". Check your spelling.','utf-8');
INSERT INTO text VALUES (842,'The wiki server can\'t provide data in a format your client can read.','utf-8');
INSERT INTO text VALUES (843,'Not a content page','utf-8');
INSERT INTO text VALUES (844,'You have not specified a target page or user\nto perform this function on.','utf-8');
INSERT INTO text VALUES (845,'No target','utf-8');
INSERT INTO text VALUES (846,'<strong>Note:</strong>','utf-8');
INSERT INTO text VALUES (847,'No page text matches','utf-8');
INSERT INTO text VALUES (848,'No page title matches','utf-8');
INSERT INTO text VALUES (849,'Not logged in','utf-8');
INSERT INTO text VALUES (850,'You have to specify a username.','utf-8');
INSERT INTO text VALUES (851,'Nov','utf-8');
INSERT INTO text VALUES (852,'November','utf-8');
INSERT INTO text VALUES (853,'You have no items on your watchlist.','utf-8');
INSERT INTO text VALUES (854,'Insert non-formatted text here','utf-8');
INSERT INTO text VALUES (855,'Ignore wiki formatting','utf-8');
INSERT INTO text VALUES (856,'$1 revisions','utf-8');
INSERT INTO text VALUES (857,'Category','utf-8');
INSERT INTO text VALUES (858,'Help','utf-8');
INSERT INTO text VALUES (859,'File','utf-8');
INSERT INTO text VALUES (860,'Article','utf-8');
INSERT INTO text VALUES (861,'Media page','utf-8');
INSERT INTO text VALUES (862,'Message','utf-8');
INSERT INTO text VALUES (863,'Special','utf-8');
INSERT INTO text VALUES (864,'Template','utf-8');
INSERT INTO text VALUES (865,'User page','utf-8');
INSERT INTO text VALUES (866,'Project page','utf-8');
INSERT INTO text VALUES (867,'Number of distinct authors (article): $1','utf-8');
INSERT INTO text VALUES (868,'[$1]','utf-8');
INSERT INTO text VALUES (869,'[$1 watching user/s]','utf-8');
INSERT INTO text VALUES (870,'Number of edits (article): $1','utf-8');
INSERT INTO text VALUES (871,'Number of distinct authors (discussion page): $1','utf-8');
INSERT INTO text VALUES (872,'Number of edits (discussion page): $1','utf-8');
INSERT INTO text VALUES (873,'Number of watchers: $1','utf-8');
INSERT INTO text VALUES (874,'$1 views','utf-8');
INSERT INTO text VALUES (875,'Oct','utf-8');
INSERT INTO text VALUES (876,'October','utf-8');
INSERT INTO text VALUES (877,'OK','utf-8');
INSERT INTO text VALUES (878,'Old password:','utf-8');
INSERT INTO text VALUES (879,'orig','utf-8');
INSERT INTO text VALUES (880,'Orphaned pages','utf-8');
INSERT INTO text VALUES (881,'Based on work by $1.','utf-8');
INSERT INTO text VALUES (882,'In other languages','utf-8');
INSERT INTO text VALUES (883,'others','utf-8');
INSERT INTO text VALUES (884,'Move succeeded','utf-8');
INSERT INTO text VALUES (885,'Page \"[[$1]]\" moved to \"[[$2]]\".','utf-8');
INSERT INTO text VALUES (886,'$1 - {{SITENAME}}','utf-8');
INSERT INTO text VALUES (887,'Someone (probably you, from IP address $1)\nrequested that we send you a new {{SITENAME}} login password for {{SERVERNAME}}.\nThe password for user \"$2\" is now \"$3\".\nYou should log in and change your password now.\n\nIf someone else made this request or if you have remembered your password and\nyou no longer wish to change it, you may ignore this message and continue using\nyour old password.','utf-8');
INSERT INTO text VALUES (888,'Password reminder from {{SITENAME}}','utf-8');
INSERT INTO text VALUES (889,'A new password has been sent to the e-mail address\nregistered for \"$1\".\nPlease log in again after you receive it.','utf-8');
INSERT INTO text VALUES (890,'Your password is too short. It must have at least $1 characters.','utf-8');
INSERT INTO text VALUES (891,'The following data is cached and may not be completely up to date:','utf-8');
INSERT INTO text VALUES (892,'Sorry! This feature has been temporarily disabled because it slows the database down to the point that no one can use the wiki.','utf-8');
INSERT INTO text VALUES (893,'Here is a saved copy from $1:','utf-8');
INSERT INTO text VALUES (894,'Permanent link','utf-8');
INSERT INTO text VALUES (895,'Personal tools','utf-8');
INSERT INTO text VALUES (896,'Popular pages','utf-8');
INSERT INTO text VALUES (897,'Community portal','utf-8');
INSERT INTO text VALUES (898,'Project:Community Portal','utf-8');
INSERT INTO text VALUES (899,'Post a comment','utf-8');
INSERT INTO text VALUES (900,'{{SITENAME}} is powered by [http://www.mediawiki.org/ MediaWiki], an open source wiki engine.','utf-8');
INSERT INTO text VALUES (901,'Search','utf-8');
INSERT INTO text VALUES (902,'\nSearch in namespaces :<br />\n$1<br />\n$2 List redirects &nbsp; Search for $3 $9','utf-8');
INSERT INTO text VALUES (903,'Preferences','utf-8');
INSERT INTO text VALUES (904,'Prefix index','utf-8');
INSERT INTO text VALUES (905,'* E-mail (optional): Enables others to contact you through your user or user_talk page without the need of revealing your identity.','utf-8');
INSERT INTO text VALUES (906,'This address is also used to send you e-mail notifications if you enabled the options.','utf-8');
INSERT INTO text VALUES (907,'* Real name (optional): if you choose to provide it this will be used for giving you attribution for your work.','utf-8');
INSERT INTO text VALUES (908,'Misc','utf-8');
INSERT INTO text VALUES (909,'User profile','utf-8');
INSERT INTO text VALUES (910,'Recent changes','utf-8');
INSERT INTO text VALUES (911,'Not logged in','utf-8');
INSERT INTO text VALUES (912,'You must be [[Special:Userlogin|logged in]] to set user preferences.','utf-8');
INSERT INTO text VALUES (913,'Preferences have been reset from storage.','utf-8');
INSERT INTO text VALUES (914,'Preview','utf-8');
INSERT INTO text VALUES (915,'This preview reflects the text in the upper\ntext editing area as it will appear if you choose to save.','utf-8');
INSERT INTO text VALUES (916,'<strong>This is only a preview; changes have not yet been saved!</strong>','utf-8');
INSERT INTO text VALUES (917,'← Previous diff','utf-8');
INSERT INTO text VALUES (918,'←Older revision','utf-8');
INSERT INTO text VALUES (919,'previous $1','utf-8');
INSERT INTO text VALUES (920,'Print','utf-8');
INSERT INTO text VALUES (921,'Printable version','utf-8');
INSERT INTO text VALUES (922,'(From {{SERVER}})','utf-8');
INSERT INTO text VALUES (923,'Privacy policy','utf-8');
INSERT INTO text VALUES (924,'Project:Privacy_policy','utf-8');
INSERT INTO text VALUES (925,'Protect','utf-8');
INSERT INTO text VALUES (926,'(default)','utf-8');
INSERT INTO text VALUES (927,'Block unregistered users','utf-8');
INSERT INTO text VALUES (928,'Sysops only','utf-8');
INSERT INTO text VALUES (929,'You may view and change the protection level here for the page <strong>$1</strong>.\nPlease be sure you are following the [[Project:Protected page|project guidelines]].','utf-8');
INSERT INTO text VALUES (930,'Unlock move permissions','utf-8');
INSERT INTO text VALUES (931,'Your account does not have permission to change\npage protection levels. Here are the current settings for the page <strong>$1</strong>:','utf-8');
INSERT INTO text VALUES (932,'Reason for protecting','utf-8');
INSERT INTO text VALUES (933,'protected \"[[$1]]\"','utf-8');
INSERT INTO text VALUES (934,'Protected page','utf-8');
INSERT INTO text VALUES (935,'<strong>WARNING:  This page has been locked so that only users with sysop privileges can edit it. Be sure you are following the [[Project:Protected_page_guidelines|protected page guidelines]].</strong>','utf-8');
INSERT INTO text VALUES (936,'This page has been locked to prevent editing; there are\na number of reasons why this may be so, please see\n[[Project:Protected page]].\n\nYou can view and copy the source of this page:','utf-8');
INSERT INTO text VALUES (937,'Protection_log','utf-8');
INSERT INTO text VALUES (938,'Below is a list of page locks/unlocks.\nSee [[Project:Protected page]] for more information.','utf-8');
INSERT INTO text VALUES (939,'Protect from moves only','utf-8');
INSERT INTO text VALUES (940,'Protect page','utf-8');
INSERT INTO text VALUES (941,'(Protecting \"$1\")','utf-8');
INSERT INTO text VALUES (942,'Protect this page','utf-8');
INSERT INTO text VALUES (943,'Proxy blocker','utf-8');
INSERT INTO text VALUES (944,'Your IP address has been blocked because it is an open proxy. Please contact your Internet service provider or tech support and inform them of this serious security problem.','utf-8');
INSERT INTO text VALUES (945,'Done.','utf-8');
INSERT INTO text VALUES (946,'http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?cmd=Retrieve&db=pubmed&dopt=Abstract&list_uids=$1','utf-8');
INSERT INTO text VALUES (947,'Browse','utf-8');
INSERT INTO text VALUES (948,'Edit','utf-8');
INSERT INTO text VALUES (949,'Find','utf-8');
INSERT INTO text VALUES (950,'My pages','utf-8');
INSERT INTO text VALUES (951,'Context','utf-8');
INSERT INTO text VALUES (952,'This page','utf-8');
INSERT INTO text VALUES (953,'Quickbar','utf-8');
INSERT INTO text VALUES (954,'Special pages','utf-8');
INSERT INTO text VALUES (955,'Random page','utf-8');
INSERT INTO text VALUES (956,'Special:Random','utf-8');
INSERT INTO text VALUES (957,'The sysop ability to create range blocks is disabled.','utf-8');
INSERT INTO text VALUES (958,'Limit to categories (separate with \"|\")','utf-8');
INSERT INTO text VALUES (959,'Any','utf-8');
INSERT INTO text VALUES (960,'in $4 form; $1 minor edits; $2 secondary namespaces; $3 multiple edits.','utf-8');
INSERT INTO text VALUES (961,'Show last $1 changes in last $2 days<br />$3','utf-8');
INSERT INTO text VALUES (962,'Show new changes starting from $1','utf-8');
INSERT INTO text VALUES (963,'; $1 edits from logged in users','utf-8');
INSERT INTO text VALUES (964,'Loading recent changes','utf-8');
INSERT INTO text VALUES (965,'(to pages linked from \"$1\")','utf-8');
INSERT INTO text VALUES (966,'Below are the last <strong>$1</strong> changes in last <strong>$2</strong> days.','utf-8');
INSERT INTO text VALUES (967,'Below are the changes since <b>$2</b> (up to <b>$1</b> shown).','utf-8');
INSERT INTO text VALUES (968,'Recent Changes Patrol disabled','utf-8');
INSERT INTO text VALUES (969,'The Recent Changes Patrol feature is currently disabled.','utf-8');
INSERT INTO text VALUES (970,'$1 anonymous users','utf-8');
INSERT INTO text VALUES (971,'$1 bots','utf-8');
INSERT INTO text VALUES (972,'$1 logged-in users','utf-8');
INSERT INTO text VALUES (973,'$1 my edits','utf-8');
INSERT INTO text VALUES (974,'$1 minor edits','utf-8');
INSERT INTO text VALUES (975,'$1 patrolled edits','utf-8');
INSERT INTO text VALUES (976,'Database locked','utf-8');
INSERT INTO text VALUES (977,'The database has been automatically locked while the slave database servers catch up to the master','utf-8');
INSERT INTO text VALUES (978,'The database is currently locked to new entries and other modifications, probably for routine database maintenance, after which it will be back to normal.\n\nThe administrator who locked it offered this explanation: $1','utf-8');
INSERT INTO text VALUES (979,'<strong>WARNING: The database has been locked for maintenance,\nso you will not be able to save your edits right now. You may wish to cut-n-paste\nthe text into a text file and save it for later.</strong>','utf-8');
INSERT INTO text VALUES (980,'Recent changes','utf-8');
INSERT INTO text VALUES (981,'Special:Recentchanges','utf-8');
INSERT INTO text VALUES (982,'all','utf-8');
INSERT INTO text VALUES (983,'Titles in recent changes:','utf-8');
INSERT INTO text VALUES (984,'Related changes','utf-8');
INSERT INTO text VALUES (985,'Track the most recent changes to the wiki on this page.','utf-8');
INSERT INTO text VALUES (986,'Recreate','utf-8');
INSERT INTO text VALUES (987,'(Redirected from $1)','utf-8');
INSERT INTO text VALUES (988,'Redirecting to [[$1]]...','utf-8');
INSERT INTO text VALUES (989,'Redirect page','utf-8');
INSERT INTO text VALUES (990,'Remember me','utf-8');
INSERT INTO text VALUES (991,'Remove checked items from watchlist','utf-8');
INSERT INTO text VALUES (992,'Removed from watchlist','utf-8');
INSERT INTO text VALUES (993,'The page \"[[:$1]]\" has been removed from your watchlist.','utf-8');
INSERT INTO text VALUES (994,'Removing requested items from watchlist...','utf-8');
INSERT INTO text VALUES (995,'Renamed group $2 to $3','utf-8');
INSERT INTO text VALUES (996,'Reset','utf-8');
INSERT INTO text VALUES (997,'$1 deleted edits','utf-8');
INSERT INTO text VALUES (998,'one deleted edit','utf-8');
INSERT INTO text VALUES (999,'Restricted special pages','utf-8');
INSERT INTO text VALUES (1000,'Edit','utf-8');
INSERT INTO text VALUES (1001,'Move','utf-8');
INSERT INTO text VALUES (1002,'Hits per page:','utf-8');
INSERT INTO text VALUES (1003,'Retrieved from \"$1\"','utf-8');
INSERT INTO text VALUES (1004,'Return to $1.','utf-8');
INSERT INTO text VALUES (1005,'Retype new password:','utf-8');
INSERT INTO text VALUES (1006,'Re-upload','utf-8');
INSERT INTO text VALUES (1007,'Return to the upload form.','utf-8');
INSERT INTO text VALUES (1008,'(comment removed)','utf-8');
INSERT INTO text VALUES (1009,'<div class=\"mw-warning plainlinks\">\nThis page revision has been removed from the public archives.\nThere may be details in the [{{fullurl:Special:Log/delete|page={{PAGENAMEE}}}} deletion log].\n</div>','utf-8');
INSERT INTO text VALUES (1010,'<div class=\"mw-warning plainlinks\">\nThis page revision has been removed from the public archives.\nAs an administrator on this site you can view it;\nthere may be details in the [{{fullurl:Special:Log/delete|page={{PAGENAMEE}}}} deletion log].\n</div>','utf-8');
INSERT INTO text VALUES (1011,'(username removed)','utf-8');
INSERT INTO text VALUES (1012,'show/hide','utf-8');
INSERT INTO text VALUES (1013,'Hide edit comment','utf-8');
INSERT INTO text VALUES (1014,'Apply these restrictions to sysops as well as others','utf-8');
INSERT INTO text VALUES (1015,'Hide revision text','utf-8');
INSERT INTO text VALUES (1016,'Hide editor\'s username/IP','utf-8');
INSERT INTO text VALUES (1017,'Set revision restrictions:','utf-8');
INSERT INTO text VALUES (1018,'Log comment:','utf-8');
INSERT INTO text VALUES (1019,'changed revision visibility for [[$1]]','utf-8');
INSERT INTO text VALUES (1020,'Selected revision of [[:$1]]:','utf-8');
INSERT INTO text VALUES (1021,'Apply to selected revision','utf-8');
INSERT INTO text VALUES (1022,'Deleted revisions will still appear in the page history,\nbut their text contents will be inaccessible to the public.\n\nOther admins on this wiki will still be able to access the hidden content and can\nundelete it again through this same interface, unless an additional restriction\nis placed by the site operators.','utf-8');
INSERT INTO text VALUES (1023,'Reverted to earlier revision','utf-8');
INSERT INTO text VALUES (1024,'rev','utf-8');
INSERT INTO text VALUES (1025,'revert','utf-8');
INSERT INTO text VALUES (1026,'Reverted edits by [[Special:Contributions/$2|$2]] ([[User_talk:$2|Talk]]); changed back to last version by [[User:$1|$1]]','utf-8');
INSERT INTO text VALUES (1027,'Revision history','utf-8');
INSERT INTO text VALUES (1028,'Revision as of $1','utf-8');
INSERT INTO text VALUES (1029,'Revision as of $1; $2<br />$3 | $4','utf-8');
INSERT INTO text VALUES (1030,'Delete/undelete revisions','utf-8');
INSERT INTO text VALUES (1031,'Revision not found','utf-8');
INSERT INTO text VALUES (1032,'The old revision of the page you asked for could not be found.\nPlease check the URL you used to access this page.','utf-8');
INSERT INTO text VALUES (1033,'http://www.ietf.org/rfc/rfc$1.txt','utf-8');
INSERT INTO text VALUES (1034,'Rights:','utf-8');
INSERT INTO text VALUES (1035,'This is a log of changes to user rights.','utf-8');
INSERT INTO text VALUES (1036,'Roll back edits','utf-8');
INSERT INTO text VALUES (1037,'Rollback','utf-8');
INSERT INTO text VALUES (1038,'Rollback failed','utf-8');
INSERT INTO text VALUES (1039,'rollback','utf-8');
INSERT INTO text VALUES (1040,'Rows:','utf-8');
INSERT INTO text VALUES (1041,'Saturday','utf-8');
INSERT INTO text VALUES (1042,'Save page','utf-8');
INSERT INTO text VALUES (1043,'Your preferences have been saved.','utf-8');
INSERT INTO text VALUES (1044,'Save file','utf-8');
INSERT INTO text VALUES (1045,'Save Group','utf-8');
INSERT INTO text VALUES (1046,'Save','utf-8');
INSERT INTO text VALUES (1047,'Save User Groups','utf-8');
INSERT INTO text VALUES (1048,'[Interwiki transcluding is disabled]','utf-8');
INSERT INTO text VALUES (1049,'[Template fetch failed for $1; sorry]','utf-8');
INSERT INTO text VALUES (1050,'[URL is too long; sorry]','utf-8');
INSERT INTO text VALUES (1051,'Search','utf-8');
INSERT INTO text VALUES (1052,'Search for articles containing \'\'$1\'\'.','utf-8');
INSERT INTO text VALUES (1053,'{{SITENAME}} search is disabled. You can search via Google in the meantime. Note that their indexes of {{SITENAME}} content may be out of date.','utf-8');
INSERT INTO text VALUES (1054,'Search full text','utf-8');
INSERT INTO text VALUES (1055,'Search for articles named \'\'$1\'\'.','utf-8');
INSERT INTO text VALUES (1056,'For query \"$1\"','utf-8');
INSERT INTO text VALUES (1057,'Search results','utf-8');
INSERT INTO text VALUES (1058,'Search','utf-8');
INSERT INTO text VALUES (1059,'For more information about searching {{SITENAME}}, see [[Project:Searching|Searching {{SITENAME}}]].','utf-8');
INSERT INTO text VALUES (1060,'→','utf-8');
INSERT INTO text VALUES (1061,'Select a newer version for comparison','utf-8');
INSERT INTO text VALUES (1062,'Select an older version for comparison','utf-8');
INSERT INTO text VALUES (1063,'Source and destination titles are the same; can\'t move a page over itself.','utf-8');
INSERT INTO text VALUES (1064,'\'\'\'Note:\'\'\' This page has been locked so that only registered users can edit it.','utf-8');
INSERT INTO text VALUES (1065,'Sep','utf-8');
INSERT INTO text VALUES (1066,'September','utf-8');
INSERT INTO text VALUES (1067,'Server time','utf-8');
INSERT INTO text VALUES (1068,'<strong>Sorry! We could not process your edit due to a loss of session data.\nPlease try again. If it still doesn\'t work, try logging out and logging back in.</strong>','utf-8');
INSERT INTO text VALUES (1069,'<strong>Sorry! We could not process your edit due to a loss of session data.</strong>\n\n\'\'Because this wiki has raw HTML enabled, the preview is hidden as a precaution against JavaScript attacks.\'\'\n\n<strong>If this is a legitimate edit attempt, please try again. If it still doesn\'t work, try logging out and logging back in.</strong>','utf-8');
INSERT INTO text VALUES (1070,'There seems to be a problem with your login session;\nthis action has been canceled as a precaution against session hijacking.\nPlease hit \"back\" and reload the page you came from, then try again.','utf-8');
INSERT INTO text VALUES (1071,'<b>User rights for \"$1\" could not be set. (Did you enter the name correctly?)</b>','utf-8');
INSERT INTO text VALUES (1072,'Set user rights','utf-8');
INSERT INTO text VALUES (1073,'Set bureaucrat flag','utf-8');
INSERT INTO text VALUES (1074,'Set steward flag','utf-8');
INSERT INTO text VALUES (1075,'-','utf-8');
INSERT INTO text VALUES (1076,'This file is a shared upload and may be used by other projects.','utf-8');
INSERT INTO text VALUES (1077,'Please see the $1 for further information.','utf-8');
INSERT INTO text VALUES (1078,'file description page','utf-8');
INSERT INTO text VALUES (1079,'Short pages','utf-8');
INSERT INTO text VALUES (1080,'Show','utf-8');
INSERT INTO text VALUES (1081,'Download high resolution version ($1x$2, $3 KB)','utf-8');
INSERT INTO text VALUES (1082,'Show changes','utf-8');
INSERT INTO text VALUES (1083,'($1 bots)','utf-8');
INSERT INTO text VALUES (1084,'Showing below up to <b>$1</b> results starting with #<b>$2</b>.','utf-8');
INSERT INTO text VALUES (1085,'Showing below <b>$3</b> results starting with #<b>$2</b>.','utf-8');
INSERT INTO text VALUES (1086,'Show last $1 files sorted $2.','utf-8');
INSERT INTO text VALUES (1087,'Live preview','utf-8');
INSERT INTO text VALUES (1088,'Show preview','utf-8');
INSERT INTO text VALUES (1089,'show','utf-8');
INSERT INTO text VALUES (1090,'\n* navigation\n** mainpage|mainpage\n** portal-url|portal\n** currentevents-url|currentevents\n** recentchanges-url|recentchanges\n** randompage-url|randompage\n** helppage|help\n** sitesupport-url|sitesupport','utf-8');
INSERT INTO text VALUES (1091,'Your signature with timestamp','utf-8');
INSERT INTO text VALUES (1092,'{{int:loginend}}','utf-8');
INSERT INTO text VALUES (1093,'-','utf-8');
INSERT INTO text VALUES (1094,'{{SITENAME}} statistics','utf-8');
INSERT INTO text VALUES (1095,'There are \'\'\'$1\'\'\' total pages in the database.\nThis includes \"talk\" pages, pages about {{SITENAME}}, minimal \"stub\"\npages, redirects, and others that probably don\'t qualify as content pages.\nExcluding those, there are \'\'\'$2\'\'\' pages that are probably legitimate\ncontent pages. \n\n\'\'\'$8\'\'\' files have been uploaded.\n\nThere have been a total of \'\'\'$3\'\'\' page views, and \'\'\'$4\'\'\' page edits\nsince the wiki was setup.\nThat comes to \'\'\'$5\'\'\' average edits per page, and \'\'\'$6\'\'\' views per edit.\n\nThe [http://meta.wikimedia.org/wiki/Help:Job_queue job queue] length is \'\'\'$7\'\'\'.','utf-8');
INSERT INTO text VALUES (1096,'','utf-8');
INSERT INTO text VALUES (1097,'Donations','utf-8');
INSERT INTO text VALUES (1098,'Project:Site support','utf-8');
INSERT INTO text VALUES (1099,'{{SITENAME}}','utf-8');
INSERT INTO text VALUES (1100,'{{SITENAME}} user $1','utf-8');
INSERT INTO text VALUES (1101,'{{SITENAME}} user(s) $1','utf-8');
INSERT INTO text VALUES (1102,'Skin','utf-8');
INSERT INTO text VALUES (1103,'(Preview)','utf-8');
INSERT INTO text VALUES (1104,'SORBS DNSBL','utf-8');
INSERT INTO text VALUES (1105,'Your IP address is listed as an open proxy in the [http://www.sorbs.net SORBS] DNSBL. You cannot create an account','utf-8');
INSERT INTO text VALUES (1106,'Your IP address is listed as an open proxy in the [http://www.sorbs.net SORBS] DNSBL.','utf-8');
INSERT INTO text VALUES (1107,'Source filename','utf-8');
INSERT INTO text VALUES (1108,'All revisions contained links to $1, blanking','utf-8');
INSERT INTO text VALUES (1109,'Reverting to last version not containing links to $1','utf-8');
INSERT INTO text VALUES (1110,'MediaWiki spam cleanup','utf-8');
INSERT INTO text VALUES (1111,'The following text is what triggered our spam filter: $1','utf-8');
INSERT INTO text VALUES (1112,'The page you wanted to save was blocked by the spam filter. This is probably caused by a link to an external site.','utf-8');
INSERT INTO text VALUES (1113,'Spam protection filter','utf-8');
INSERT INTO text VALUES (1114,'Title:','utf-8');
INSERT INTO text VALUES (1115,'User:','utf-8');
INSERT INTO text VALUES (1116,'Special Page','utf-8');
INSERT INTO text VALUES (1117,'Special pages','utf-8');
INSERT INTO text VALUES (1118,'Special pages for all users','utf-8');
INSERT INTO text VALUES (1119,'(SQL query hidden)','utf-8');
INSERT INTO text VALUES (1120,'Statistics','utf-8');
INSERT INTO text VALUES (1121,'Stored version','utf-8');
INSERT INTO text VALUES (1122,'Threshold for stub display:','utf-8');
INSERT INTO text VALUES (1123,'Subcategories','utf-8');
INSERT INTO text VALUES (1124,'There are $1 subcategories to this category.','utf-8');
INSERT INTO text VALUES (1125,'There is $1 subcategory to this category.','utf-8');
INSERT INTO text VALUES (1126,'Subject/headline','utf-8');
INSERT INTO text VALUES (1127,'View subject','utf-8');
INSERT INTO text VALUES (1128,'Successful upload','utf-8');
INSERT INTO text VALUES (1129,'Summary','utf-8');
INSERT INTO text VALUES (1130,'Sunday','utf-8');
INSERT INTO text VALUES (1131,'The action you have requested can only be\nperformed by users with \"sysop\" capability.\nSee $1.','utf-8');
INSERT INTO text VALUES (1132,'Sysop access required','utf-8');
INSERT INTO text VALUES (1133,'table','utf-8');
INSERT INTO text VALUES (1134,'From {{SITENAME}}','utf-8');
INSERT INTO text VALUES (1135,'Discussion','utf-8');
INSERT INTO text VALUES (1136,'\'\'\'The page itself was moved successfully, but the talk page could not be moved because one already exists at the new title. Please merge them manually.\'\'\'','utf-8');
INSERT INTO text VALUES (1137,'Discuss this page','utf-8');
INSERT INTO text VALUES (1138,'The corresponding talk page was also moved.','utf-8');
INSERT INTO text VALUES (1139,'The corresponding talk page was <strong>not</strong> moved.','utf-8');
INSERT INTO text VALUES (1140,'<!-- MediaWiki:talkpagetext -->','utf-8');
INSERT INTO text VALUES (1141,'Templates used on this page:','utf-8');
INSERT INTO text VALUES (1142,'Editing','utf-8');
INSERT INTO text VALUES (1143,'Page text matches','utf-8');
INSERT INTO text VALUES (1144,'View or restore $1?','utf-8');
INSERT INTO text VALUES (1145,'Enlarge','utf-8');
INSERT INTO text VALUES (1146,'Error creating thumbnail: $1','utf-8');
INSERT INTO text VALUES (1147,'Thumbnail size:','utf-8');
INSERT INTO text VALUES (1148,'Thursday','utf-8');
INSERT INTO text VALUES (1149,'Time zone','utf-8');
INSERT INTO text VALUES (1150,'Offset¹','utf-8');
INSERT INTO text VALUES (1151,'The number of hours your local time differs from server time (UTC).','utf-8');
INSERT INTO text VALUES (1152,'Article title matches','utf-8');
INSERT INTO text VALUES (1153,'Contents','utf-8');
INSERT INTO text VALUES (1154,'Mark edits I make as patrolled','utf-8');
INSERT INTO text VALUES (1155,'Edit pages on double click (JavaScript)','utf-8');
INSERT INTO text VALUES (1156,'Enable section editing via [edit] links','utf-8');
INSERT INTO text VALUES (1157,'Enable section editing by right clicking<br /> on section titles (JavaScript)','utf-8');
INSERT INTO text VALUES (1158,'Edit box has full width','utf-8');
INSERT INTO text VALUES (1159,'E-mail me also for minor edits of pages','utf-8');
INSERT INTO text VALUES (1160,'Reveal my e-mail address in notification mails','utf-8');
INSERT INTO text VALUES (1161,'E-mail me when my user talk page is changed','utf-8');
INSERT INTO text VALUES (1162,'E-mail me on page changes','utf-8');
INSERT INTO text VALUES (1163,'Use external diff by default','utf-8');
INSERT INTO text VALUES (1164,'Use external editor by default','utf-8');
INSERT INTO text VALUES (1165,'Raw signatures (without automatic link)','utf-8');
INSERT INTO text VALUES (1166,'Prompt me when entering a blank edit summary','utf-8');
INSERT INTO text VALUES (1167,'Hide minor edits in recent changes','utf-8');
INSERT INTO text VALUES (1168,'Format broken links <a href=\"\" class=\"new\">like this</a> (alternative: like this<a href=\"\" class=\"internal\">?</a>).','utf-8');
INSERT INTO text VALUES (1169,'Justify paragraphs','utf-8');
INSERT INTO text VALUES (1170,'Mark all edits minor by default','utf-8');
INSERT INTO text VALUES (1171,'Disable page caching','utf-8');
INSERT INTO text VALUES (1172,'Auto-number headings','utf-8');
INSERT INTO text VALUES (1173,'Show preview on first edit','utf-8');
INSERT INTO text VALUES (1174,'Show preview before edit box','utf-8');
INSERT INTO text VALUES (1175,'Remember across sessions','utf-8');
INSERT INTO text VALUES (1176,'Enable \"jump to\" accessibility links','utf-8');
INSERT INTO text VALUES (1177,'Show the number of watching users','utf-8');
INSERT INTO text VALUES (1178,'Show table of contents (for pages with more than 3 headings)','utf-8');
INSERT INTO text VALUES (1179,'Show edit toolbar (JavaScript)','utf-8');
INSERT INTO text VALUES (1180,'Underline links:','utf-8');
INSERT INTO text VALUES (1181,'Use live preview (JavaScript) (Experimental)','utf-8');
INSERT INTO text VALUES (1182,'Enhanced recent changes (JavaScript)','utf-8');
INSERT INTO text VALUES (1183,'Add pages I create to my watchlist','utf-8');
INSERT INTO text VALUES (1184,'Add pages I edit to my watchlist','utf-8');
INSERT INTO text VALUES (1185,'Toolbox','utf-8');
INSERT INTO text VALUES (1186,'See the differences between the two selected versions of this page. [alt-v]','utf-8');
INSERT INTO text VALUES (1187,'Show which changes you made to the text. [alt-d]','utf-8');
INSERT INTO text VALUES (1188,'Mark this as a minor edit [alt-i]','utf-8');
INSERT INTO text VALUES (1189,'Preview your changes, please use this before saving! [alt-p]','utf-8');
INSERT INTO text VALUES (1190,'','utf-8');
INSERT INTO text VALUES (1191,'Save your changes [alt-s]','utf-8');
INSERT INTO text VALUES (1192,'Search {{SITENAME}} [alt-f]','utf-8');
INSERT INTO text VALUES (1193,'Add this page to your watchlist [alt-w]','utf-8');
INSERT INTO text VALUES (1194,'; $4$5 : [$2 $1]','utf-8');
INSERT INTO text VALUES (1195,'<div id=\"trackbacks\">\nTrackbacks for this article:<br />\n$1\n</div>','utf-8');
INSERT INTO text VALUES (1196,'The trackback was successfully deleted.','utf-8');
INSERT INTO text VALUES (1197,'; $4$5 : [$2 $1]: <nowiki>$3</nowiki>','utf-8');
INSERT INTO text VALUES (1198,'Trackback','utf-8');
INSERT INTO text VALUES (1199,' ([$1 Delete])','utf-8');
INSERT INTO text VALUES (1200,'Try exact match','utf-8');
INSERT INTO text VALUES (1201,'Tuesday','utf-8');
INSERT INTO text VALUES (1202,'View the last $1 changes; view the last $2 days.','utf-8');
INSERT INTO text VALUES (1203,'Below are this user\'s last <b>$1</b> changes in the last <b>$2</b> days.','utf-8');
INSERT INTO text VALUES (1204,' (top)','utf-8');
INSERT INTO text VALUES (1205,'User ID:','utf-8');
INSERT INTO text VALUES (1206,'Unblock user','utf-8');
INSERT INTO text VALUES (1207,'Use the form below to restore write access\nto a previously blocked IP address or username.','utf-8');
INSERT INTO text VALUES (1208,'unblock','utf-8');
INSERT INTO text VALUES (1209,'unblocked $1','utf-8');
INSERT INTO text VALUES (1210,'Uncategorized categories','utf-8');
INSERT INTO text VALUES (1211,'Uncategorized pages','utf-8');
INSERT INTO text VALUES (1212,'View deleted pages','utf-8');
INSERT INTO text VALUES (1213,'Undelete $1 edits','utf-8');
INSERT INTO text VALUES (1214,'Undelete one edit','utf-8');
INSERT INTO text VALUES (1215,'Restore deleted page','utf-8');
INSERT INTO text VALUES (1216,'Restore!','utf-8');
INSERT INTO text VALUES (1217,'restored \"[[$1]]\"','utf-8');
INSERT INTO text VALUES (1218,'$1 revisions restored','utf-8');
INSERT INTO text VALUES (1219,'[[:$1|$1]] has been successfully restored.\nSee [[Special:Log/delete]] for a record of recent deletions and restorations.','utf-8');
INSERT INTO text VALUES (1220,'If you restore the page, all revisions will be restored to the history.\nIf a new page with the same name has been created since the deletion, the restored\nrevisions will appear in the prior history, and the current revision of the live page\nwill not be automatically replaced.','utf-8');
INSERT INTO text VALUES (1221,'This article has been deleted. The reason for deletion is\nshown in the summary below, along with details of the users who had edited this page\nbefore deletion. The actual text of these deleted revisions is only available to administrators.','utf-8');
INSERT INTO text VALUES (1222,'View and restore deleted pages','utf-8');
INSERT INTO text VALUES (1223,'The following pages have been deleted but are still in the archive and\ncan be restored. The archive may be periodically cleaned out.','utf-8');
INSERT INTO text VALUES (1224,'Deleted revision as of $1','utf-8');
INSERT INTO text VALUES (1225,'$1 revisions archived','utf-8');
INSERT INTO text VALUES (1226,'Always','utf-8');
INSERT INTO text VALUES (1227,'Browser default','utf-8');
INSERT INTO text VALUES (1228,'Never','utf-8');
INSERT INTO text VALUES (1229,'Unexpected value: \"$1\"=\"$2\".','utf-8');
INSERT INTO text VALUES (1230,'px','utf-8');
INSERT INTO text VALUES (1231,'Unlock database','utf-8');
INSERT INTO text VALUES (1232,'Yes, I really want to unlock the database.','utf-8');
INSERT INTO text VALUES (1233,'Unlock database','utf-8');
INSERT INTO text VALUES (1234,'Database lock removed','utf-8');
INSERT INTO text VALUES (1235,'The database has been unlocked.','utf-8');
INSERT INTO text VALUES (1236,'Unlocking the database will restore the ability of all\nusers to edit pages, change their preferences, edit their watchlists, and\nother things requiring changes in the database.\nPlease confirm that this is what you intend to do.','utf-8');
INSERT INTO text VALUES (1237,'unprotect','utf-8');
INSERT INTO text VALUES (1238,'Reason for unprotecting','utf-8');
INSERT INTO text VALUES (1239,'unprotected \"[[$1]]\"','utf-8');
INSERT INTO text VALUES (1240,'(Unprotecting \"$1\")','utf-8');
INSERT INTO text VALUES (1241,'Unprotect this page','utf-8');
INSERT INTO text VALUES (1242,'Unused categories','utf-8');
INSERT INTO text VALUES (1243,'The following category pages exist although no other article or category make use of them.','utf-8');
INSERT INTO text VALUES (1244,'Unused files','utf-8');
INSERT INTO text VALUES (1245,'<p>Please note that other web sites may link to an image with\na direct URL, and so may still be listed here despite being\nin active use.</p>','utf-8');
INSERT INTO text VALUES (1246,'Unwatch','utf-8');
INSERT INTO text VALUES (1247,'Unwatched pages','utf-8');
INSERT INTO text VALUES (1248,'Stop watching','utf-8');
INSERT INTO text VALUES (1249,'(Updated)','utf-8');
INSERT INTO text VALUES (1250,'updated since my last visit','utf-8');
INSERT INTO text VALUES (1251,'Upload file','utf-8');
INSERT INTO text VALUES (1252,'The upload directory ($1) is not writable by the webserver.','utf-8');
INSERT INTO text VALUES (1253,'Upload file','utf-8');
INSERT INTO text VALUES (1254,'The file is corrupt or has an incorrect extension. Please check the file and upload again.','utf-8');
INSERT INTO text VALUES (1255,'Uploads disabled','utf-8');
INSERT INTO text VALUES (1256,'File uploads are disabled on this wiki.','utf-8');
INSERT INTO text VALUES (1257,'Uploaded files','utf-8');
INSERT INTO text VALUES (1258,'uploaded \"[[$1]]\"','utf-8');
INSERT INTO text VALUES (1259,'Upload error','utf-8');
INSERT INTO text VALUES (1260,'Upload images','utf-8');
INSERT INTO text VALUES (1261,'upload log','utf-8');
INSERT INTO text VALUES (1262,'Upload_log','utf-8');
INSERT INTO text VALUES (1263,'Below is a list of the most recent file uploads.','utf-8');
INSERT INTO text VALUES (1264,'[$1 Upload a new version of this file]','utf-8');
INSERT INTO text VALUES (1265,'Not logged in','utf-8');
INSERT INTO text VALUES (1266,'You must be [[Special:Userlogin|logged in]]\nto upload files.','utf-8');
INSERT INTO text VALUES (1267,'This file contains HTML or script code that may be erroneously be interpreted by a web browser.','utf-8');
INSERT INTO text VALUES (1268,'Use the form below to upload files, to view or search previously uploaded images go to the [[Special:Imagelist|list of uploaded files]], uploads and deletions are also logged in the [[Special:Log/upload|upload log]].\n\nTo include the image in a page, use a link in the form\n\'\'\'<nowiki>[[{{ns:6}}:file.jpg]]</nowiki>\'\'\',\n\'\'\'<nowiki>[[{{ns:6}}:file.png|alt text]]</nowiki>\'\'\' or\n\'\'\'<nowiki>[[{{ns:-2}}:file.ogg]]</nowiki>\'\'\' for directly linking to the file.','utf-8');
INSERT INTO text VALUES (1269,'The file contains a virus! Details: $1','utf-8');
INSERT INTO text VALUES (1270,'Upload warning','utf-8');
INSERT INTO text VALUES (1271,'1\n\nSet first character to \"0\" to disable the new category page layout.','utf-8');
INSERT INTO text VALUES (1272,'<b>User rights for \"$1\" updated</b>','utf-8');
INSERT INTO text VALUES (1273,'<strong>Tip:</strong> Use the \'Show preview\' button to test your new CSS/JS before saving.','utf-8');
INSERT INTO text VALUES (1274,'\'\'\'Remember that you are only previewing your user CSS, it has not yet been saved!\'\'\'','utf-8');
INSERT INTO text VALUES (1275,'Username entered already in use. Please choose a different name.','utf-8');
INSERT INTO text VALUES (1276,'\'\'\'Warning:\'\'\' There is no skin \"$1\". Remember that custom .css and .js pages use a lowercase title, e.g. User:Foo/monobook.css as opposed to User:Foo/Monobook.css.','utf-8');
INSERT INTO text VALUES (1277,'\'\'\'Remember that you are only testing/previewing your user JavaScript, it has not yet been saved!\'\'\'','utf-8');
INSERT INTO text VALUES (1278,'Log in / create account','utf-8');
INSERT INTO text VALUES (1279,'Log out','utf-8');
INSERT INTO text VALUES (1280,'Mail object returned error:','utf-8');
INSERT INTO text VALUES (1281,'Username:','utf-8');
INSERT INTO text VALUES (1282,'View user page','utf-8');
INSERT INTO text VALUES (1283,'User rights management','utf-8');
INSERT INTO text VALUES (1284,'Edit user groups','utf-8');
INSERT INTO text VALUES (1285,'Available groups:','utf-8');
INSERT INTO text VALUES (1286,'Select groups you want the user to be removed from or added to.\nUnselected groups will not be changed. You can deselect a group with CTRL + Left Click','utf-8');
INSERT INTO text VALUES (1287,'Member of:','utf-8');
INSERT INTO text VALUES (1288,'Changed group membership from $1 to $2','utf-8');
INSERT INTO text VALUES (1289,'Manage user groups','utf-8');
INSERT INTO text VALUES (1290,'Enter a username:','utf-8');
INSERT INTO text VALUES (1291,'User statistics','utf-8');
INSERT INTO text VALUES (1292,'There are \'\'\'$1\'\'\' registered users, of which\n\'\'\'$2\'\'\' (or \'\'\'$4%\'\'\') are administrators (see $3).','utf-8');
INSERT INTO text VALUES (1293,'sr','utf-8');
INSERT INTO text VALUES (1294,'sr-ec','utf-8');
INSERT INTO text VALUES (1295,'sr-el','utf-8');
INSERT INTO text VALUES (1296,'sr-jc','utf-8');
INSERT INTO text VALUES (1297,'sr-jl','utf-8');
INSERT INTO text VALUES (1298,'zh','utf-8');
INSERT INTO text VALUES (1299,'cn','utf-8');
INSERT INTO text VALUES (1300,'hk','utf-8');
INSERT INTO text VALUES (1301,'sg','utf-8');
INSERT INTO text VALUES (1302,'tw','utf-8');
INSERT INTO text VALUES (1303,'Version','utf-8');
INSERT INTO text VALUES (1304,'Version $1 of MediaWiki required','utf-8');
INSERT INTO text VALUES (1305,'Version $1 of MediaWiki is required to use this page. See [[Special:Version]]','utf-8');
INSERT INTO text VALUES (1306,'This page has been accessed $1 times.','utf-8');
INSERT INTO text VALUES (1307,'View $1?','utf-8');
INSERT INTO text VALUES (1308,'View deleted pages','utf-8');
INSERT INTO text VALUES (1309,'View ($1) ($2) ($3).','utf-8');
INSERT INTO text VALUES (1310,'Views','utf-8');
INSERT INTO text VALUES (1311,'View source','utf-8');
INSERT INTO text VALUES (1312,'for $1','utf-8');
INSERT INTO text VALUES (1313,'View discussion','utf-8');
INSERT INTO text VALUES (1314,'Wanted categories','utf-8');
INSERT INTO text VALUES (1315,'Wanted pages','utf-8');
INSERT INTO text VALUES (1316,'Watch','utf-8');
INSERT INTO text VALUES (1317,'* $1 pages watched not counting talk pages\n* [[Special:Watchlist/edit|Show and edit complete watchlist]]','utf-8');
INSERT INTO text VALUES (1318,'Here\'s an alphabetical list of your\nwatched content pages. Check the boxes of pages you want to remove from your watchlist and click the \'remove checked\' button\nat the bottom of the screen (deleting a content page also deletes the accompanying talk page and vice versa).','utf-8');
INSERT INTO text VALUES (1319,'My watchlist','utf-8');
INSERT INTO text VALUES (1320,'all','utf-8');
INSERT INTO text VALUES (1321,'all','utf-8');
INSERT INTO text VALUES (1322,'Your watchlist contains $1 pages.','utf-8');
INSERT INTO text VALUES (1323,'(for user \"$1\")','utf-8');
INSERT INTO text VALUES (1324,'checking watched pages for recent edits','utf-8');
INSERT INTO text VALUES (1325,'checking recent edits for watched pages','utf-8');
INSERT INTO text VALUES (1326,'None of your watched items was edited in the time period displayed.','utf-8');
INSERT INTO text VALUES (1327,'Not logged in','utf-8');
INSERT INTO text VALUES (1328,'You must be [[Special:Userlogin|logged in]] to modify your watchlist.','utf-8');
INSERT INTO text VALUES (1329,'Watch this page','utf-8');
INSERT INTO text VALUES (1330,'Watch this page','utf-8');
INSERT INTO text VALUES (1331,'Wednesday','utf-8');
INSERT INTO text VALUES (1332,'== Welcome, $1! ==\n\nYour account has been created. Don\'t forget to change your {{SITENAME}} preferences.','utf-8');
INSERT INTO text VALUES (1333,'What links here','utf-8');
INSERT INTO text VALUES (1334,'To be allowed to create accounts in this Wiki you have to [[Special:Userlogin|log]] in and have the appropriate permissions.','utf-8');
INSERT INTO text VALUES (1335,'You are not allowed to create an account','utf-8');
INSERT INTO text VALUES (1336,'You have to [[Special:Userlogin|login]] to edit pages.','utf-8');
INSERT INTO text VALUES (1337,'Login required to edit','utf-8');
INSERT INTO text VALUES (1338,'You have to [[Special:Userlogin|login]] to read pages.','utf-8');
INSERT INTO text VALUES (1339,'Login required to read','utf-8');
INSERT INTO text VALUES (1340,'$1x$2','utf-8');
INSERT INTO text VALUES (1341,'View project page','utf-8');
INSERT INTO text VALUES (1342,'* E-mail notification is enabled.','utf-8');
INSERT INTO text VALUES (1343,'* Pages which have been changed since you last visited them are shown in \'\'\'bold\'\'\'','utf-8');
INSERT INTO text VALUES (1344,'Hide','utf-8');
INSERT INTO text VALUES (1345,'$1 bot edits.','utf-8');
INSERT INTO text VALUES (1346,'$1 my edits.','utf-8');
INSERT INTO text VALUES (1347,'Below are the last $1 changes in the last <b>$2</b> hours.','utf-8');
INSERT INTO text VALUES (1348,'This is a saved version of your watchlist.','utf-8');
INSERT INTO text VALUES (1349,'Show','utf-8');
INSERT INTO text VALUES (1350,'Show last $1 hours $2 days $3','utf-8');
INSERT INTO text VALUES (1351,'Incorrect parameters to wfQuery()<br />\nFunction: $1<br />\nQuery: $2','utf-8');
INSERT INTO text VALUES (1352,'Incorrect password entered. Please try again.','utf-8');
INSERT INTO text VALUES (1353,'Password entered was blank. Please try again.','utf-8');
INSERT INTO text VALUES (1354,'You have $1 ($2).','utf-8');
INSERT INTO text VALUES (1355,'You have new messages on $1','utf-8');
INSERT INTO text VALUES (1356,'Differences','utf-8');
INSERT INTO text VALUES (1357,'Your domain','utf-8');
INSERT INTO text VALUES (1358,'E-mail *','utf-8');
INSERT INTO text VALUES (1359,'Language:','utf-8');
INSERT INTO text VALUES (1360,'Username','utf-8');
INSERT INTO text VALUES (1361,'Nickname:','utf-8');
INSERT INTO text VALUES (1362,'Password','utf-8');
INSERT INTO text VALUES (1363,'Retype password','utf-8');
INSERT INTO text VALUES (1364,'Real name *','utf-8');
INSERT INTO text VALUES (1365,'Your text','utf-8');
INSERT INTO text VALUES (1366,'Variant','utf-8');

--
-- Table structure for table `trackbacks`
--

DROP TABLE IF EXISTS trackbacks;
CREATE TABLE trackbacks (
  tb_id int(11) NOT NULL auto_increment,
  tb_page int(11) default NULL,
  tb_title varchar(255) NOT NULL default '',
  tb_url varchar(255) NOT NULL default '',
  tb_ex text,
  tb_name varchar(255) default NULL,
  PRIMARY KEY  (tb_id),
  KEY tb_page (tb_page)
) TYPE=InnoDB;

--
-- Dumping data for table `trackbacks`
--


--
-- Table structure for table `transcache`
--

DROP TABLE IF EXISTS transcache;
CREATE TABLE transcache (
  tc_url varchar(255) NOT NULL default '',
  tc_contents text,
  tc_time int(11) NOT NULL default '0',
  UNIQUE KEY tc_url_idx (tc_url)
) TYPE=InnoDB;

--
-- Dumping data for table `transcache`
--


--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS user;
CREATE TABLE user (
  user_id int(5) unsigned NOT NULL auto_increment,
  user_name varchar(255) binary NOT NULL default '',
  user_real_name varchar(255) binary NOT NULL default '',
  user_password tinyblob NOT NULL,
  user_newpassword tinyblob NOT NULL,
  user_email tinytext NOT NULL,
  user_options blob NOT NULL,
  user_touched varchar(14) binary NOT NULL default '',
  user_token varchar(32) binary NOT NULL default '',
  user_email_authenticated varchar(14) binary default NULL,
  user_email_token varchar(32) binary default NULL,
  user_email_token_expires varchar(14) binary default NULL,
  user_registration varchar(14) binary default NULL,
  PRIMARY KEY  (user_id),
  UNIQUE KEY user_name (user_name),
  KEY user_email_token (user_email_token)
) TYPE=InnoDB;

--
-- Dumping data for table `user`
--

INSERT INTO user VALUES (1,'Wdr1','','9b4ddca485e24bd37f522927be118d71','','','quickbar=1\nunderline=2\ncols=80\nrows=25\nsearchlimit=20\ncontextlines=5\ncontextchars=50\nskin=monobook\nmath=1\nrcdays=7\nrclimit=50\nhighlightbroken=1\nstubthreshold=0\npreviewontop=1\neditsection=1\neditsectiononrightclick=0\nshowtoc=1\nshowtoolbar=1\ndate=0\nimagesize=2\nthumbsize=2\nrememberpassword=0\nenotifwatchlistpages=0\nenotifusertalkpages=1\nenotifminoredits=0\nenotifrevealaddr=0\nshownumberswatching=1\nfancysig=0\nexternaleditor=0\nexternaldiff=0\nshowjumplinks=1\nnumberheadings=0\nuselivepreview=0\nvariant=en\nlanguage=en\nsearchNs0=1','20070310095011','83aea58ddf054120d9fac77b0c0af2e8',NULL,NULL,NULL,'20070310095005');

--
-- Table structure for table `user_groups`
--

DROP TABLE IF EXISTS user_groups;
CREATE TABLE user_groups (
  ug_user int(5) unsigned NOT NULL default '0',
  ug_group char(16) NOT NULL default '',
  PRIMARY KEY  (ug_user,ug_group),
  KEY ug_group (ug_group)
) TYPE=InnoDB;

--
-- Dumping data for table `user_groups`
--

INSERT INTO user_groups VALUES (1,'bureaucrat');
INSERT INTO user_groups VALUES (1,'sysop');

--
-- Table structure for table `user_newtalk`
--

DROP TABLE IF EXISTS user_newtalk;
CREATE TABLE user_newtalk (
  user_id int(5) NOT NULL default '0',
  user_ip varchar(40) NOT NULL default '',
  KEY user_id (user_id),
  KEY user_ip (user_ip)
) TYPE=MyISAM;

--
-- Dumping data for table `user_newtalk`
--


--
-- Table structure for table `validate`
--

DROP TABLE IF EXISTS validate;
CREATE TABLE validate (
  val_user int(11) NOT NULL default '0',
  val_page int(11) unsigned NOT NULL default '0',
  val_revision int(11) unsigned NOT NULL default '0',
  val_type int(11) unsigned NOT NULL default '0',
  val_value int(11) default '0',
  val_comment varchar(255) NOT NULL default '',
  val_ip varchar(20) NOT NULL default '',
  KEY val_user (val_user,val_revision)
) TYPE=InnoDB;

--
-- Dumping data for table `validate`
--


--
-- Table structure for table `watchlist`
--

DROP TABLE IF EXISTS watchlist;
CREATE TABLE watchlist (
  wl_user int(5) unsigned NOT NULL default '0',
  wl_namespace int(11) NOT NULL default '0',
  wl_title varchar(255) binary NOT NULL default '',
  wl_notificationtimestamp varchar(14) binary default NULL,
  UNIQUE KEY wl_user (wl_user,wl_namespace,wl_title),
  KEY namespace_title (wl_namespace,wl_title)
) TYPE=InnoDB;

--
-- Dumping data for table `watchlist`
--


