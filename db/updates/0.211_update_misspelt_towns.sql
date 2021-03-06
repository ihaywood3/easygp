--
-- PostgreSQL database dump
--

-- Started on 2012-08-15 07:55:13 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = contacts, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 3472 (class 1259 OID 68743)
-- Dependencies: 40
-- Name: lu_misspelt_towns; Type: TABLE; Schema: contacts; Owner: -; Tablespace: 
--

CREATE TABLE lu_misspelt_towns (
    pk integer NOT NULL,
    fk_town integer NOT NULL,
    town text NOT NULL,
    town_misspelt text NOT NULL
);


--
-- TOC entry 3865 (class 0 OID 0)
-- Dependencies: 3472
-- Name: TABLE lu_misspelt_towns; Type: COMMENT; Schema: contacts; Owner: -
--

COMMENT ON TABLE lu_misspelt_towns IS 'When patient demographics is imported, the quality is usually appalling
 this table keeps matches to real towns/suburbs from the AU postcode database';


--
-- TOC entry 3473 (class 1259 OID 68749)
-- Dependencies: 3472 40
-- Name: lu_mismatched_towns_pk_seq; Type: SEQUENCE; Schema: contacts; Owner: -
--

CREATE SEQUENCE lu_mismatched_towns_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- TOC entry 3867 (class 0 OID 0)
-- Dependencies: 3473
-- Name: lu_mismatched_towns_pk_seq; Type: SEQUENCE OWNED BY; Schema: contacts; Owner: -
--

ALTER SEQUENCE lu_mismatched_towns_pk_seq OWNED BY lu_misspelt_towns.pk;


--
-- TOC entry 3868 (class 0 OID 0)
-- Dependencies: 3473
-- Name: lu_mismatched_towns_pk_seq; Type: SEQUENCE SET; Schema: contacts; Owner: -
--

SELECT pg_catalog.setval('lu_mismatched_towns_pk_seq', 344, true);


--
-- TOC entry 3859 (class 2604 OID 68751)
-- Dependencies: 3473 3472
-- Name: pk; Type: DEFAULT; Schema: contacts; Owner: -
--

ALTER TABLE lu_misspelt_towns ALTER COLUMN pk SET DEFAULT nextval('lu_mismatched_towns_pk_seq'::regclass);


--
-- TOC entry 3862 (class 0 OID 68743)
-- Dependencies: 3472
-- Data for Name: lu_misspelt_towns; Type: TABLE DATA; Schema: contacts; Owner: -
--

INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (104, 10686, 'RIVERSIDE', 'RIVESIDE WEST');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (105, 4985, 'BURLEIGH HEADS', 'BULEIGH HEADS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (106, 1611, 'LISMORE', 'LISMORE HEIGHTS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (107, 245, 'TAMARAMA', 'TAMARAMA BEACH');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (5, 290, 'ABBOTSFORD', 'ABBOTTSFORD');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (6, 1931, 'AMBARVALE', 'AMBERVALE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (7, 577, 'ASHCROFT', 'ASCHROFT');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (8, 535, 'BAULKHAM HILLS', 'BAULKAM HILLS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (9, 535, 'BAULKHAM HILLS', 'BAULKHAM HILL');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (10, 617, 'BOSSLEY PARK', 'BOSSLEY PK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (11, 1934, 'BRADBURY', 'BRADBURRY');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (12, 1967, 'CAMDEN', 'CAMDEN SOUTH');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (13, 1935, 'CAMPBELLTOWN', 'CAMPBELTOWN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (14, 572, 'CABRAMATTA', 'CANBRAMATTA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (15, 601, 'CATHERINE FIELD', 'CATHERING FIELD');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (16, 1958, 'CURRANS HILL', 'CURRAN HILL');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (17, 4994, 'CURRUMBIN WATERS', 'CURRUMBIN WATER');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (18, 1950, 'DENHAM COURT', 'DENHAM  COURT');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (19, 1950, 'DENHAM COURT', 'DENHAM CRT');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (20, 1586, 'BALLINA', 'EAST BALLINA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (21, 618, 'EDENSOR PARK', 'ENDENSOR PARK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (22, 1345, 'FORSTER', 'FORSTER KEYS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (23, 1939, 'GLEN ALPINE', 'GLEN ALP[INE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (24, 1939, 'GLEN ALPINE', 'GLEN APLINE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (25, 1939, 'GLEN ALPINE', 'GLENN ALPINE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (26, 556, 'GUILDFORD', 'GUILFORD');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (27, 632, 'HURLSTONE PARK', 'HURLSTONE PK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (28, 192, 'INGLEBURN', 'INLEBURN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (29, 7213, 'KALAMUNDA', 'KALAMUNDA  W.A');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (30, 1002, 'LARGS', 'LARG''S');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (31, 1941, 'LEUMEAH', 'LEAMUEAH');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (32, 996, 'LEMON TREE PASSAGE', 'LEMONTREE PASSAGE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (33, 2463, 'LONDONDERRY', 'LONDONDERY');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (34, 1949, 'MACQUARIE FIELDS', 'MACQAURIE  FIELDS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (35, 1949, 'MACQUARIE FIELDS', 'MACQUATIE FIELDS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (36, 2634, 'MILLTHORPE', 'MILLTHORP');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (37, 1954, 'MINTO', 'MIN TO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (38, 1954, 'MINTO', 'MINTO HEIGHTS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (39, 1954, 'MINTO', 'MINTOI');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (40, 1973, 'MOUNT HUNTER', 'MT. HUNTER');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (41, 1963, 'NARELLAN VALE', 'NARRELLAN VALE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (42, 9256, 'NORTH EPPING', 'NTH EPPING');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (43, 2466, 'NORTH RICHMOND', 'NTH RICHMOND');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (44, 676, 'PANANIA', 'PANAIA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (45, 513, 'PENDLE HILL', 'PENDLE HILLS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (46, 2513, 'ROOTY HILL', 'ROOTYHILL');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (47, 1942, 'ROSEMEADOW', 'ROSEMEDOW');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (48, 706, 'SYLVANIA', 'SILVANIA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (49, 2478, 'MAROOTA', 'SOUTH MAROOTA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (50, 2453, 'PENRITH', 'SOUTH PENRITH');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (51, 245, 'TAMARAMA', 'TAMMARRA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (52, 1987, 'TAHMOOR', 'TARMORE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (53, 517, 'TOONGABBIE', 'TOONGABIE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (54, 2281, 'WAGGA WAGGA', 'WAGGA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (55, 734, 'WORONORA', 'WOROMORA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (56, 1338, 'GIRVAN', 'GIRVEN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (57, 922, 'CHARLESTOWN', 'CHARESTOWN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (58, 821, 'BATEAU BAY', 'BATEUA BAY');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (59, 653, 'ARNCLIFFE', 'ARNCLIFF');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (60, 821, 'BATEAU BAY', 'BATAEU BAY');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (61, 1476, 'DORRIGO', 'NORTH DORRIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (62, 1480, 'MEGAN', 'MEGAN VIA DORRIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (63, 1500, 'BRUSHGROVE', 'BRUSH GROVE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (64, 1476, 'DORRIGO', 'VIA DORRIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (65, 1476, 'DORRIGO', 'EASTERN DORRIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (66, 1476, 'DORRIGO', 'DORRGIO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (67, 1476, 'DORRIGO', 'DORRGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (68, 1473, 'BOSTOBRICK', 'BOSTORBRICK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (69, 1430, 'PORT MACQUARIE', 'PORT MCACQURIE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (70, 1476, 'DORRIGO', 'NORTH DORIIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (71, 1476, 'DORRIGO', 'DOIRRIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (72, 1478, 'EBOR', 'GUY FAWKES  EBOR');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (73, 1458, 'COFFS HARBOUR', 'COFFS HBR');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (74, 1476, 'DORRIGO', 'DORRIGO NORTH');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (75, 8382, 'BROOME', 'BROOM');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (76, 1497, 'WOOLGOOLGA', 'WOOLGOOLA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (77, 1477, 'DUNDURRABIN', 'DUNDUARRABIN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (78, 1665, 'BILAMBIL', 'BILAMBIL HEIGHTS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (79, 1489, 'THORA', 'BRINERVILLE VIA THORA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (80, 1476, 'DORRIGO', 'NOTH DORRIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (81, 1482, 'BELLINGEN', 'NORTH BELLINGEN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (82, 1479, 'HERNANI', 'VIA HERNANI');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (83, 10681, 'BROOKLANA', 'BROOKLANA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (84, 1597, 'FERNLEIGH', 'GLENFERNEIGH');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (85, 1477, 'DUNDURRABIN', 'DUNDARRABIN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (86, 10682, 'FERNBROOK', 'FERNBROOK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (87, 4692, 'TARINGA', 'TARINGA,  BRISBANE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (88, 10683, 'WOOMBAH', 'WOOMBAH');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (89, 1481, 'TYRINGHAM', 'TYRINGHAM RD');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (90, 1476, 'DORRIGO', 'NTH DORRIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (91, 1476, 'DORRIGO', 'VIA  DORRIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (92, 1476, 'DORRIGO', 'DORRRIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (93, 1473, 'BOSTOBRICK', 'BOSTOBRI CK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (94, 1481, 'TYRINGHAM', 'TYRINGHAM  PO BOX 488 DOR');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (95, 554, 'MERRYLANDS', 'MERRYLAND');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (96, 1384, 'SOUTH WEST ROCKS', 'SOUTH WEST ROCKS, NS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (97, 1476, 'DORRIGO', 'NORTTH DORRIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (98, 1476, 'DORRIGO', 'DORRIOG');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (99, 3186, 'ST KILDA', 'ST. KILDA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (100, 1446, 'WAUCHOPE', 'WAUHOPE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (101, 1253, 'MULLALEY', 'MULLAWAY');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (102, 1461, 'GLENREAGH', 'GLENREIGH');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (103, 1667, 'TERRANORA', 'TERRANORRA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (108, 4569, 'PETRIE TERRACE', 'PETRIE TERACE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (109, 10687, 'DONDINGALONG', 'DONDINGALONG');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (110, 10688, 'KULGUN', 'KULGUN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (111, 10696, 'DEER VALE', 'DEERVALE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (112, 1477, 'DUNDURRABIN', 'DUDURRABIN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (113, 4915, 'GUANABA', 'GUANAVA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (114, 1478, 'EBOR', 'VIA EBOR');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (115, 2, 'DARWIN', 'DARWIN RIVER');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (116, 1458, 'COFFS HARBOUR', 'COFFS HAVRBOUR');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (117, 1476, 'DORRIGO', 'EASTERN DORRRIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (118, 10682, 'FERNBROOK', 'FERNBROOD');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (119, 1473, 'BOSTOBRICK', 'BOSTABRICK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (120, 2964, 'CARLTON NORTH', 'NORTH CARTLTON');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (121, 6434, 'ATHELSTONE', 'ATHELSTINE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (122, 1150, 'GOWRIE', 'GOWRIE JUNCTION');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (123, 5448, 'MORAYFIELD', 'MORAY FIELD');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (124, 1479, 'HERNANI', 'HERNANI VIA DORRIGO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (125, 5356, 'GOONDIWINDI', 'GOONDIWINDA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (126, 1473, 'BOSTOBRICK', 'BOSTORICK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (127, 161, 'ST LEONARDS', 'ST. LEONARDS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (128, 613, 'WEST HOXTON', 'WEST HOXTIN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (129, 10696, 'DEER VALE', 'DEERVALE LOOP RD');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (131, 1687, 'WOLLONGONG', 'WALLALONG');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (132, 4840, 'WELLINGTON POINT', 'WELLINFTON POINT');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (133, 1422, 'HERONS CREEK', 'HERRONS CREEK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (134, 1113, 'MUSWELLBROOK', 'MUSSELLBROOK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (135, 2542, 'FAULCONBRIDGE', 'FAULCON BRIDGE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (136, 10696, 'DEER VALE', 'DEEFVALE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (137, 238, 'BELLEVUE HILL', 'BELLVIEW HILL');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (138, 1027, 'WOODBERRY', 'WOODVBERRY');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (139, 1283, 'MOREE', 'MOOREE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (140, 1480, 'MEGAN', 'MEGAN`');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (141, 1226, 'BEN LOMOND', 'BEL LOMOND');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (142, 1476, 'DORRIGO', 'DORRIGO`');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (143, 1302, 'DUNGOG', 'MARTINS CREEK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (144, 773, 'GREEN POINT', 'GREENPOINT');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (145, 3171, 'DINGLEY VILLAGE', 'DINGLEY');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (146, 1481, 'TYRINGHAM', 'TYRNGHAM');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (147, 1481, 'TYRINGHAM', 'TYRINGAHM');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (148, 10696, 'DEER VALE', 'DEERVALEQ');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (149, 1482, 'BELLINGEN', 'BELLINGENT');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (150, 584, 'SADLEIR', 'SADLIER');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (151, 711, 'COMO', 'COMO WEST');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (152, 5827, 'WOORABINDA', 'WONGWIBINDA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (153, 1290, 'BINGARA', 'BINGARRA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (154, 415, 'NARRABEEN', 'NARABEEN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (155, 5501, 'GOLDEN BEACH', 'SOUTH GOLDEN  BEACH');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (156, 1478, 'EBOR', 'EBOR`');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (157, 1473, 'BOSTOBRICK', 'BOSTOBRCIK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (158, 5749, 'BOYNE ISLAND', 'BOYNE INSLAND');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (159, 10696, 'DEER VALE', 'DEERVALKE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (160, 7332, 'SPEARWOOD', 'SPEARWOODQ');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (161, 1476, 'DORRIGO', 'DORRIGO1');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (162, 1479, 'HERNANI', 'HERNANIE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (163, 1464, 'LOWANNA', 'LOWANA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (164, 7253, 'GOSNELLS', 'GOSNELL');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (165, 7310, 'WILLETTON', 'WILLETTTON');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (166, 1479, 'HERNANI', 'HERNIA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (167, 1655, 'MURWILLUMBAH', 'MURWILLIMBAH');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (168, 864, 'FLORAVILLE', 'FLORAVILLA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (170, 5170, 'GATTON', 'GATTOL');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (171, 1617, 'NUMULGI', 'MUMULGI');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (172, 450, 'DENISTONE', 'DENISTON');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (173, 1179, 'ARMIDALE', 'VIA ARMIDALE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (174, 1477, 'DUNDURRABIN', 'DUNNDURRABIN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (175, 10893, 'BELIMBLA PARK', 'BELIMBA PARK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (176, 2519, 'BIDWILL', 'BIDWELL');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (177, 617, 'BOSSLEY PARK', 'BOSSLEY PRK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (178, 681, 'BRIGHTON-LE-SANDS', 'BRIGHTON LE SANDS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (179, 937, 'CARRINGTON', 'CARRINGBAH');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (180, 1958, 'CURRANS HILL', 'CURRAN HILLS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (181, 1724, 'FARMBOROUGH HEIGHTS', 'FARMBOROUGH HGTS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (182, 9201, 'GOLD COAST MC', 'GOLD COAST');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (183, 1697, 'HELENSBURGH', 'HELENSBURG');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (184, 192, 'INGLEBURN', 'INGLEBURN  ZZ');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (185, 4219, 'KINGLAKE', 'KINGSLAKE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (186, 10896, 'KIRKHAM', 'KIRKHAM MEADOWS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (187, 1941, 'LEUMEAH', 'LEUMEAH HEIGHTS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (188, 2442, 'LLANDILO', 'LIANDILO');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (189, 1949, 'MACQUARIE FIELDS', 'MACQUARIE FIELD');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (190, 1949, 'MACQUARIE FIELDS', 'MACQUIARIE FIELDS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (191, 554, 'MERRYLANDS', 'MERRLANDS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (193, 1961, 'NARELLAN', 'NARELLEN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (194, 9358, 'POTTSVILLE', 'NTH POTTSVILLE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (195, 1855, 'OLD EROWAL BAY', 'OLDERROWAL BAY');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (196, 1976, 'ORANGEVILLE', 'ORANGVILLE');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (197, 637, 'PUNCHBOWL', 'PUNCH BOWL');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (198, 10895, 'CAMDEN SOUTH', 'SOUTH CAMDEN');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (199, 1944, 'ST HELENS PARK', 'ST HELEN''S PARK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (200, 3684, 'SUNBURY', 'SUNBURY VIC');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (201, 245, 'TAMARAMA', 'TARRAMARRA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (202, 459, 'TELOPEA', 'TELOPIA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (203, 10315, 'CROSS ROADS', 'THE CROSS ROADS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (204, 1727, 'UNANDERRA', 'VANDERRA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (205, 540, 'WINSTON HILLS', 'WINSTON HILL');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (206, 1001, 'GATESHEAD', 'GATESHEAD DC');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (207, 1001, 'GATESHEAD', 'GATESHEAD WEST');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (208, 11990, 'BILLYS CREEK', 'Billys Ck');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (209, 1736, 'DUNDURRABIN', 'Dunduuabin');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (210, 10131, 'NORTHAM', 'Northam WA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (211, 1736, 'DUNDURRABIN', 'Dundurrabbin');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (212, 1733, 'DEER VALE', 'Deervale, Nsw,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (213, 938, 'JEWELLS', 'Jewels');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (214, 1734, 'DORRIGO', 'Dorrigo, Nsw,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (215, 12734, 'FERNANCES', 'Glenfernaigh');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (216, 11990, 'BILLYS CREEK', 'Billy''s Creek');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (217, 1732, 'BOSTOBRICK', 'Bostbrick');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (218, 3464, 'FORBES', 'Forbes');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (219, 1734, 'DORRIGO', 'Dorrigo, Nsw');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (220, 1734, 'DORRIGO', 'Dorriigo');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (221, 1713, 'COFFS HARBOUR', 'Coffs Harbour, Nsw,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (222, 1729, 'SAWTELL', 'Sawtell, Nsw,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (223, 6461, 'GOONDIWINDI', 'Goodiwindi');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (224, 1712, 'BUCCA', 'Central Bucca');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (225, 1389, 'ROCKY CREEK', 'Rocky Creek Road');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (226, 6461, 'GOONDIWINDI', 'Goondawindi');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (227, 1753, 'VALERY', 'Velery');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (228, 7961, 'WHITFIELD', 'Whitield');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (229, 3751, 'HAWTHORN', ' ');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (230, 5646, 'WONTHAGGI', 'Woothaggi');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (231, 1736, 'DUNDURRABIN', 'Dunburrabin');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (232, 171, 'CAMPERDOWN', 'Camperdown');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (233, 392, 'BEROWRA HEIGHTS', 'Berowra Hts');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (234, 1747, 'GLENIFFER', 'Glenifer');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (235, 302, 'ANNANDALE', 'Annandale');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (236, 916, 'BRIGHTWATERS', 'Brightwaters, Nsw,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (237, 6666, 'MORAYFIELD', 'Morayfield Rd');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (238, 5767, 'SINNAMON PARK', 'Sinnamon');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (239, 1717, 'GLENREAGH', 'Genreagh');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (240, 6416, 'WARWICK', 'Warwick 4370');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (241, 1711, 'BROOKLANA', 'Upper Boba');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (242, 1907, 'MEERSCHAUM VALE', 'Meershaum Vale');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (243, 3637, 'CARLTON NORTH', 'Nort Carlton');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (244, 1732, 'BOSTOBRICK', 'BOSTOBRICK VIA Dorrigo ');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (245, 1720, 'LOWANNA', 'Lowann');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (246, 1747, 'GLENIFFER', 'Glennifer');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (247, 1734, 'DORRIGO', 'Dorrigoq');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (248, 3514, 'GORDON', 'Gordon ACT');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (249, 2483, 'BUNDANOON', 'Bundanoon');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (250, 1738, 'FERNBROOK', 'Frenbrook');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (251, 587, 'DURAL', 'Dural');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (252, 7846, 'BURKETOWN', 'Bourketown');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (253, 10904, 'ROSETTA', 'Rosetta TAS');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (254, 1301, 'ARMIDALE', 'Armidale, Nsw,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (255, 9511, 'ERSKINE', 'Erskine WA');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (256, 14559, 'POONA', ' Poona Bay');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (257, 5942, 'MOUNT WARREN PARK', 'Mt Warren');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (258, 2631, 'HAWKER', 'Hawker');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (259, 1832, 'ILUKA', 'Iluka');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (260, 3817, 'MALVERN', 'Malvern');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (261, 68, 'DRIVER', 'Driver Palmerston');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (262, 844, 'OURIMBAH', 'Ourimbah, Nsw,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (263, 1734, 'DORRIGO', 'Hernani Dorrigo');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (264, 1734, 'DORRIGO', 'Leigh');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (265, 506, 'NEWINGTON', 'Newington');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (266, 5743, 'THE GAP', 'The Gap');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (267, 5995, 'SOUTHPORT', 'Southport');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (268, 1734, 'DORRIGO', 'Dorrigo,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (269, 1734, 'DORRIGO', 'Dorigo');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (270, 2275, 'SANCTUARY POINT', 'Sanctuary Point NSW');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (271, 1728, 'BOAMBEE EAST', 'East Boambee');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (272, 1736, 'DUNDURRABIN', 'Old Grafton Rd Dundurrabin');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (273, 5942, 'MOUNT WARREN PARK', 'Mt Warren Park');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (274, 5708, 'KEDRON', '115 Turner Rd Kedron ');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (275, 5252, 'NARRE WARREN SOUTH', 'Narrewarren South');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (276, 2059, 'TWEED HEADS SOUTH', 'Twed Heads South');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (277, 482, 'WEST RYDE', 'West Ride');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (278, 1734, 'DORRIGO', 'P O Box 282  Dorrigo');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (279, 1711, 'BROOKLANA', 'Brooklanan');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (280, 1752, 'THORA', 'Thora 2454');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (281, 559, 'KINGS LANGLEY', 'Kings Langley, Nsw,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (282, 1734, 'DORRIGO', 'Meldrum');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (283, 3166, 'MAYFIELD', 'Mayfield');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (284, 7109, 'HERVEY BAY', 'Hervey Bay');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (285, 1373, 'TINGHA', 'Tinghga');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (286, 1989, 'MULLUMBIMBY', 'Mullimbimby');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (287, 2614, 'DUFFY', 'Doffy');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (288, 3345, 'DUBBO', 'Dobbo');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (289, 1724, 'SAPPHIRE BEACH', 'Sapphire ');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (290, 5710, 'CHERMSIDE WEST', 'Chernside West');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (291, 1605, 'GLADSTONE', 'Gladstone');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (292, 1739, 'HERNANI', 'Hernie');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (293, 1754, 'URUNGA', 'Urnga');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (294, 2623, 'WESTON', 'Western   ACT');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (295, 3127, 'MOUNT RIVERVIEW', 'Riverview');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (296, 8331, 'PROSPECT', 'Prospect');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (297, 1734, 'DORRIGO', 'Dorrigp');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (298, 1702, 'NAMBUCCA HEADS', 'Nambuca Heads');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (299, 11990, 'BILLYS CREEK', 'Billys Creel');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (300, 1742, 'TYRINGHAM', '1829 Tyringham Rd');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (301, 1737, 'EBOR', 'Ebor, Nsw,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (302, 840, 'UMINA BEACH', 'Umina');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (303, 1741, 'NORTH DORRIGO', 'Nrth Dorrigo');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (304, 1150, 'RAYMOND TERRACE', 'Raymond Terraceq');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (305, 1702, 'NAMBUCCA HEADS', 'Nambucca');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (306, 3522, 'PALMERSTON', 'Palmerston');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (307, 5999, 'PARADISE POINT', 'Paradise Waters');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (308, 1625, 'BONVILLE', 'Bonville');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (309, 1742, 'TYRINGHAM', 'Tyringham, Nsw,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (310, 3910, 'BRIGHTON', 'Brighton');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (311, 1715, 'COFFS HARBOUR PLAZA', 'Coffs Harbour Plaza');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (312, 1737, 'EBOR', 'Guy Fawkes');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (313, 11990, 'BILLYS CREEK', 'Billys Creeks');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (314, 3104, 'DOONSIDE', 'Huntington Heights');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (315, 1761, 'SAFETY BEACH', 'Safety Beach');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (316, 1743, 'BELLINGEN', 'Bellingen, Nsw,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (317, 6213, 'UPPER TENTHILL', 'Upper Tent Hill');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (318, 1102, 'CLARENCE TOWN', 'Clarencetown');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (319, 1734, 'DORRIGO', 'Dorriogo');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (320, 5780, 'SHERWOOD', 'Sherwood');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (321, 1711, 'BROOKLANA', 'Lower Bobo');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (322, 1726, 'ULONG', 'Eulong');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (323, 5717, 'BRIDGEMAN DOWNS', 'Bridgenan');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (324, 15493, 'PERTH', 'Perth');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (325, 1737, 'EBOR', 'Ebor, Nsw');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (326, 1734, 'DORRIGO', 'EVES CREEK');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (327, 996, 'KOTARA', 'Kottara');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (328, 1736, 'DUNDURRABIN', 'Dundurrabin, Nsw');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (329, 1727, 'UPPER ORARA', 'Dairyville');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (330, 1170, 'MILLFIELD', 'Mullfield, Nsw,');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (331, 811, 'WYOMING', 'Wyoming');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (332, 348, 'ST LEONARDS', 'St Leonards');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (333, 1734, 'DORRIGO', 'Cascade Via Dorrigo');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (334, 6050, 'BIRNAM', 'Birnam');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (335, 1742, 'TYRINGHAM', 'Tryingham');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (336, 1742, 'TYRINGHAM', 'Tyringham  Po Box 488 Dorrigo');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (337, 1635, 'TELEGRAPH POINT', 'Telegraph Rd');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (338, 8150, 'WEST BEACH', 'West Beach South Australia');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (339, 1747, 'GLENIFFER', 'Gordonville');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (340, 1734, 'DORRIGO', 'West Dorrigo');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (341, 1742, 'TYRINGHAM', 'Tyrigham');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (342, 1734, 'DORRIGO', 'Deerville');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (343, 1830, 'YAMBA', 'Yamba');
INSERT INTO lu_misspelt_towns (pk, fk_town, town, town_misspelt) VALUES (344, 1734, 'DORRIGO', 'Dorrio');


--
-- TOC entry 3861 (class 2606 OID 68753)
-- Dependencies: 3472 3472
-- Name: lu_mismatched_towns_pkey; Type: CONSTRAINT; Schema: contacts; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_misspelt_towns
    ADD CONSTRAINT lu_mismatched_towns_pkey PRIMARY KEY (pk);


--
-- TOC entry 3866 (class 0 OID 0)
-- Dependencies: 3472
-- Name: lu_misspelt_towns; Type: ACL; Schema: contacts; Owner: -
--

REVOKE ALL ON TABLE lu_misspelt_towns FROM PUBLIC;
ALTER TABLE OWNER lu_misspelt_towns to easygp;
GRANT ALL ON TABLE lu_misspelt_towns TO easygp;
GRANT ALL ON TABLE lu_misspelt_towns TO staff;


-- Completed on 2012-08-15 07:55:13 EST
-- PostgreSQL database dump complete
--

