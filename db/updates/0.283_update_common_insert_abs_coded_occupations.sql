--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: common; Type: SCHEMA; Schema: -; Owner: easygp
--



SET search_path = common, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: lu_occupations_abs_coded; Type: TABLE; Schema: common; Owner: easygp; Tablespace: 
--

CREATE TABLE lu_occupations_abs_coded (
    pk integer NOT NULL,
    abs_code text,
    occupation text NOT NULL
);


ALTER TABLE common.lu_occupations_abs_coded OWNER TO easygp;

--
-- Name: lu_occupations_abs_coded_pk_seq; Type: SEQUENCE; Schema: common; Owner: easygp
--

CREATE SEQUENCE lu_occupations_abs_coded_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE common.lu_occupations_abs_coded_pk_seq OWNER TO easygp;

--
-- Name: lu_occupations_abs_coded_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: easygp
--

ALTER SEQUENCE lu_occupations_abs_coded_pk_seq OWNED BY lu_occupations_abs_coded.pk;


--
-- Name: lu_occupations_abs_coded_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: easygp
--

SELECT pg_catalog.setval('lu_occupations_abs_coded_pk_seq', 1419, true);


--
-- Name: pk; Type: DEFAULT; Schema: common; Owner: easygp
--

ALTER TABLE ONLY lu_occupations_abs_coded ALTER COLUMN pk SET DEFAULT nextval('lu_occupations_abs_coded_pk_seq'::regclass);


--
-- Data for Name: lu_occupations_abs_coded; Type: TABLE DATA; Schema: common; Owner: easygp
--

COPY lu_occupations_abs_coded (pk, abs_code, occupation) FROM stdin;
1	100000	Managers nfd
2	111000	Chief Executives, General Managers and Legislators nfd
3	111111	Chief Executive or Managing Director
4	111200	General Managers nfd
5	111211	Corporate General Manager
6	111212	Defence Force Senior Officer
7	111300	Legislators nfd
8	111311	Local Government Legislator
9	111312	Member of Parliament
10	111399	Legislators nec
11	121000	Farmers and Farm Managers nfd
12	121111	Aquaculture Farmer
13	121200	Crop Farmers nfd
14	121211	Cotton Grower
15	121212	Flower Grower
16	121213	Fruit or Nut Grower
17	121214	Grain, Oilseed or Pasture Grower
18	121215	Grape Grower
19	121216	Mixed Crop Farmer
20	121217	Sugar Cane Grower
21	121218	Turf Grower
22	121221	Vegetable Grower
23	121299	Crop Farmers nec
24	121300	Livestock Farmers nfd
25	121311	Apiarist
26	121312	Beef Cattle Farmer
27	121313	Dairy Cattle Farmer
28	121314	Deer Farmer
29	121315	Goat Farmer
30	121316	Horse Breeder
31	121317	Mixed Livestock Farmer
32	121318	Pig Farmer
33	121321	Poultry Farmer
34	121322	Sheep Farmer
35	121399	Livestock Farmers nec
36	121411	Mixed Crop and Livestock Farmer
37	130000	Specialist Managers nfd
38	131100	Advertising, Public Relations and Sales Managers nfd
39	131112	Sales and Marketing Manager
40	131113	Advertising Manager
41	131114	Public Relations Manager
42	132000	Business Administration Managers nfd
43	132111	Corporate Services Manager
44	132211	Finance Manager
45	132311	Human Resource Manager
46	132411	Policy and Planning Manager
47	132511	Research and Development Manager
48	133000	Construction, Distribution and Production Managers nfd
49	133100	Construction Managers nfd
50	133111	Construction Project Manager
51	133112	Project Builder
52	133211	Engineering Manager
53	133300	Importers, Exporters and Wholesalers nfd
54	133311	Importer or Exporter
55	133312	Wholesaler
56	133411	Manufacturer
57	133500	Production Managers nfd
58	133511	Production Manager (Forestry)
59	133512	Production Manager (Manufacturing)
60	133513	Production Manager (Mining)
61	133611	Supply and Distribution Manager
62	134000	Education, Health and Welfare Services Managers nfd
63	134111	Child Care Centre Manager
64	134200	Health and Welfare Services Managers nfd
65	134211	Medical Administrator
66	134212	Nursing Clinical Director
67	134213	Primary Health Organisation Manager
68	134214	Welfare Centre Manager
69	134299	Health and Welfare Services Managers nec
70	134311	School Principal
71	134400	Other Education Managers nfd
72	134411	Faculty Head
73	134412	Regional Education Manager
74	134499	Education Managers nec
75	135100	ICT Managers nfd
76	135111	Chief Information Officer
77	135112	ICT Project Manager
78	135199	ICT Managers nec
79	139000	Miscellaneous Specialist Managers nfd
80	139100	Commissioned Officers (Management) nfd
81	139111	Commissioned Defence Force Officer
82	139112	Commissioned Fire Officer
83	139113	Commissioned Police Officer
84	139211	Senior Non-commissioned Defence Force Member
85	139900	Other Specialist Managers nfd
86	139911	Arts Administrator or Manager
87	139912	Environmental Manager
88	139913	Laboratory Manager
89	139914	Quality Assurance Manager
90	139915	Sports Administrator
91	139999	Specialist Managers nec
92	140000	Hospitality, Retail and Service Managers nfd
93	141000	Accommodation and Hospitality Managers nfd
94	141111	Cafe or Restaurant Manager
95	141211	Caravan Park and Camping Ground Manager
96	141311	Hotel or Motel Manager
97	141411	Licensed Club Manager
98	141900	Other Accommodation and Hospitality Managers nfd
99	141911	Bed and Breakfast Operator
100	141912	Retirement Village Manager
101	141999	Accommodation and Hospitality Managers nec
102	142100	Retail Managers nfd
103	142111	Retail Manager (General)
104	142112	Antique Dealer
105	142113	Betting Agency Manager
106	142114	Hair or Beauty Salon Manager
107	142115	Post Office Manager
108	142116	Travel Agency Manager
109	149000	Miscellaneous Hospitality, Retail and Service Managers nfd
110	149100	Amusement, Fitness and Sports Centre Managers nfd
111	149111	Amusement Centre Manager
112	149112	Fitness Centre Manager
113	149113	Sports Centre Manager
114	149200	Call or Contact Centre and Customer Service Managers nfd
115	149211	Call or Contact Centre Manager
116	149212	Customer Service Manager
117	149311	Conference and Event Organiser
118	149400	Transport Services Managers nfd
119	149411	Fleet Manager
120	149412	Railway Station Manager
121	149413	Transport Company Manager
122	149900	Other Hospitality, Retail and Service Managers nfd
123	149911	Boarding Kennel or Cattery Operator
124	149912	Cinema or Theatre Manager
125	149913	Facilities Manager
126	149914	Financial Institution Branch Manager
127	149915	Equipment Hire Manager
128	149999	Hospitality, Retail and Service Managers nec
129	200000	Professionals nfd
130	210000	Arts and Media Professionals nfd
131	211000	Arts Professionals nfd
132	211100	Actors, Dancers and Other Entertainers nfd
133	211111	Actor
134	211112	Dancer or Choreographer
135	211113	Entertainer or Variety Artist
136	211199	Actors, Dancers and Other Entertainers nec
137	211200	Music Professionals nfd
138	211211	Composer
139	211212	Music Director
140	211213	Musician (Instrumental)
141	211214	Singer
142	211299	Music Professionals nec
143	211311	Photographer
144	211400	Visual Arts and Crafts Professionals nfd
145	211411	Painter (Visual Arts)
146	211412	Potter or Ceramic Artist
147	211413	Sculptor
148	211499	Visual Arts and Crafts Professionals nec
149	212000	Media Professionals nfd
150	212100	Artistic Directors, and Media Producers and Presenters nfd
151	212111	Artistic Director
152	212112	Media Producer (excluding Video)
153	212113	Radio Presenter
154	212114	Television Presenter
155	212200	Authors, and Book and Script Editors nfd
156	212211	Author
157	212212	Book or Script Editor
158	212300	Film, Television, Radio and Stage Directors nfd
159	212311	Art Director (Film, Television or Stage)
160	212312	Director (Film, Television, Radio or Stage)
161	212313	Director of Photography
162	212314	Film and Video Editor
163	212315	Program Director (Television or Radio)
164	212316	Stage Manager
165	212317	Technical Director
166	212318	Video Producer
167	212399	Film, Television, Radio and Stage Directors nec
168	212400	Journalists and Other Writers nfd
169	212411	Copywriter
170	212412	Newspaper or Periodical Editor
171	212413	Print Journalist
172	212414	Radio Journalist
173	212415	Technical Writer
174	212416	Television Journalist
175	212499	Journalists and Other Writers nec
176	220000	Business, Human Resource and Marketing Professionals nfd
177	221000	Accountants, Auditors and Company Secretaries nfd
178	221100	Accountants nfd
179	221111	Accountant (General)
180	221112	Management Accountant
181	221113	Taxation Accountant
182	221200	Auditors, Company Secretaries and Corporate Treasurers nfd
183	221211	Company Secretary
184	221212	Corporate Treasurer
185	221213	External Auditor
186	221214	Internal Auditor
187	222000	Financial Brokers and Dealers, and Investment Advisers nfd
188	222100	Financial Brokers nfd
189	222111	Commodities Trader
190	222112	Finance Broker
191	222113	Insurance Broker
192	222199	Financial Brokers nec
193	222200	Financial Dealers nfd
194	222211	Financial Market Dealer
195	222212	Futures Trader
196	222213	Stockbroking Dealer
197	222299	Financial Dealers nec
198	222300	Financial Investment Advisers and Managers nfd
199	222311	Financial Investment Adviser
200	222312	Financial Investment Manager
201	223000	Human Resource and Training Professionals nfd
202	223100	Human Resource Professionals nfd
203	223111	Human Resource Adviser
204	223112	Recruitment Consultant
205	223113	Workplace Relations Adviser
206	223211	ICT Trainer
207	223311	Training and Development Professional
208	224000	Information and Organisation Professionals nfd
209	224100	Actuaries, Mathematicians and Statisticians nfd
210	224111	Actuary
211	224112	Mathematician
212	224113	Statistician
213	224200	Archivists, Curators and Records Managers nfd
214	224211	Archivist
215	224212	Gallery or Museum Curator
216	224213	Health Information Manager
217	224214	Records Manager
218	224311	Economist
219	224400	Intelligence and Policy Analysts nfd
220	224411	Intelligence Officer
221	224412	Policy Analyst
222	224500	Land Economists and Valuers nfd
223	224511	Land Economist
224	224512	Valuer
225	224611	Librarian
226	224700	Management and Organisation Analysts nfd
227	224711	Management Consultant
228	224712	Organisation and Methods Analyst
229	224900	Other Information and Organisation Professionals nfd
230	224911	Electorate Officer
231	224912	Liaison Officer
232	224913	Migration Agent
233	224914	Patents Examiner
234	224999	Information and Organisation Professionals nec
235	225000	Sales, Marketing and Public Relations Professionals nfd
236	225100	Advertising and Marketing Professionals nfd
237	225111	Advertising Specialist
238	225112	Market Research Analyst
239	225113	Marketing Specialist
240	225200	ICT Sales Professionals nfd
241	225211	ICT Account Manager
242	225212	ICT Business Development Manager
243	225213	ICT Sales Representative
244	225311	Public Relations Professional
245	225400	Technical Sales Representatives nfd
246	225411	Sales Representative (Industrial Products)
247	225412	Sales Representative (Medical and Pharmaceutical Products)
248	225499	Technical Sales Representatives nec
249	230000	Design, Engineering, Science and Transport Professionals nfd
250	231000	Air and Marine Transport Professionals nfd
251	231100	Air Transport Professionals nfd
252	231111	Aeroplane Pilot
253	231112	Air Traffic Controller
254	231113	Flying Instructor
255	231114	Helicopter Pilot
256	231199	Air Transport Professionals nec
257	231200	Marine Transport Professionals nfd
258	231211	Master Fisher
259	231212	Ship's Engineer
260	231213	Ship's Master
261	231214	Ship's Officer
262	231215	Ship's Surveyor
263	231299	Marine Transport Professionals nec
264	232000	Architects, Designers, Planners and Surveyors nfd
265	232100	Architects and Landscape Architects nfd
266	232111	Architect
267	232112	Landscape Architect
268	232200	Surveyors and Spatial Scientists nfd
269	232212	Surveyor
270	232213	Cartographer
271	232214	Other Spatial Scientist
272	232300	Fashion, Industrial and Jewellery Designers nfd
273	232311	Fashion Designer
274	232312	Industrial Designer
275	232313	Jewellery Designer
276	232400	Graphic and Web Designers, and Illustrators nfd
277	232411	Graphic Designer
278	232412	Illustrator
279	232413	Multimedia Designer
280	232414	Web Designer
281	232511	Interior Designer
282	232611	Urban and Regional Planner
283	233000	Engineering Professionals nfd
284	233100	Chemical and Materials Engineers nfd
285	233111	Chemical Engineer
286	233112	Materials Engineer
287	233200	Civil Engineering Professionals nfd
288	233211	Civil Engineer
289	233212	Geotechnical Engineer
290	233213	Quantity Surveyor
291	233214	Structural Engineer
292	233215	Transport Engineer
293	233311	Electrical Engineer
294	233411	Electronics Engineer
295	233500	Industrial, Mechanical and Production Engineers nfd
296	233511	Industrial Engineer
297	233512	Mechanical Engineer
298	233513	Production or Plant Engineer
299	233600	Mining Engineers nfd
300	233611	Mining Engineer (excluding Petroleum)
301	233612	Petroleum Engineer
302	233900	Other Engineering Professionals nfd
303	233911	Aeronautical Engineer
304	233912	Agricultural Engineer
305	233913	Biomedical Engineer
306	233914	Engineering Technologist
307	233915	Environmental Engineer
308	233916	Naval Architect
309	233999	Engineering Professionals nec
310	234000	Natural and Physical Science Professionals nfd
311	234100	Agricultural and Forestry Scientists nfd
312	234111	Agricultural Consultant
313	234112	Agricultural Scientist
314	234113	Forester
315	234200	Chemists, and Food and Wine Scientists nfd
316	234211	Chemist
317	234212	Food Technologist
318	234213	Wine Maker
319	234300	Environmental Scientists nfd
320	234311	Conservation Officer
321	234312	Environmental Consultant
322	234313	Environmental Research Scientist
323	234314	Park Ranger
324	234399	Environmental Scientists nec
325	234400	Geologists and Geophysicists nfd
326	234411	Geologist
327	234412	Geophysicist
328	234500	Life Scientists nfd
329	234511	Life Scientist (General)
330	234512	Anatomist or Physiologist
331	234513	Biochemist
332	234514	Biotechnologist
333	234515	Botanist
334	234516	Marine Biologist
335	234517	Microbiologist
336	234518	Zoologist
337	234599	Life Scientists nec
338	234611	Medical Laboratory Scientist
339	234711	Veterinarian
340	234900	Other Natural and Physical Science Professionals nfd
341	234911	Conservator
342	234912	Metallurgist
343	234913	Meteorologist
344	234914	Physicist
345	234999	Natural and Physical Science Professionals nec
346	240000	Education Professionals nfd
347	241000	School Teachers nfd
348	241111	Early Childhood (Pre-primary School) Teacher
349	241213	Primary School Teacher
350	241311	Middle School Teacher
351	241411	Secondary School Teacher
352	241500	Special Education Teachers nfd
353	241511	Special Needs Teacher
354	241512	Teacher of the Hearing Impaired
355	241513	Teacher of the Sight Impaired
356	241599	Special Education Teachers nec
357	242000	Tertiary Education Teachers nfd
358	242100	University Lecturers and Tutors nfd
359	242111	University Lecturer
360	242112	University Tutor
361	242211	Vocational Education Teacher
362	249000	Miscellaneous Education Professionals nfd
363	249100	Education Advisers and Reviewers nfd
364	249111	Education Adviser
365	249112	Education Reviewer
366	249200	Private Tutors and Teachers nfd
367	249211	Art Teacher (Private Tuition)
368	249212	Dance Teacher (Private Tuition)
369	249213	Drama Teacher (Private Tuition)
370	249214	Music Teacher (Private Tuition)
371	249299	Private Tutors and Teachers nec
372	249311	Teacher of English to Speakers of Other Languages
373	250000	Health Professionals nfd
374	251000	Health Diagnostic and Promotion Professionals nfd
375	251111	Dietitian
376	251200	Medical Imaging Professionals nfd
377	251211	Medical Diagnostic Radiographer
378	251212	Medical Radiation Therapist
379	251213	Nuclear Medicine Technologist
380	251214	Sonographer
381	251300	Occupational and Environmental Health Professionals nfd
382	251311	Environmental Health Officer
383	251312	Occupational Health and Safety Adviser
384	251400	Optometrists and Orthoptists nfd
385	251411	Optometrist
386	251412	Orthoptist
387	251500	Pharmacists nfd
388	251511	Hospital Pharmacist
389	251512	Industrial Pharmacist
390	251513	Retail Pharmacist
391	251900	Other Health Diagnostic and Promotion Professionals nfd
392	251911	Health Promotion Officer
393	251912	Orthotist or Prosthetist
394	251999	Health Diagnostic and Promotion Professionals nec
395	252000	Health Therapy Professionals nfd
396	252100	Chiropractors and Osteopaths nfd
397	252111	Chiropractor
398	252112	Osteopath
399	252200	Complementary Health Therapists nfd
400	252211	Acupuncturist
401	252212	Homoeopath
402	252213	Naturopath
403	252214	Traditional Chinese Medicine Practitioner
404	252299	Complementary Health Therapists nec
405	252300	Dental Practitioners nfd
406	252311	Dental Specialist
407	252311	Maxillo-facial surgeon
408	252312	Dentist
409	252411	Occupational Therapist
410	252511	Physiotherapist
411	252611	Podiatrist
412	252700	Speech Professionals and Audiologists nfd
413	252711	Audiologist
414	252712	Speech Pathologist
415	253000	Medical Practitioners nfd
416	253100	Generalist Medical Practitioners nfd
417	253111	General Medical Practitioner
418	253112	Resident Medical Officer
419	253100	Psychiatry registrar
420	253100	Medical registrar
421	253100	Obstetrics/Gynaecology registrar
422	253100	Surgical Registrar
423	253100	Orthopaedic Registrar
424	253100	Anaesthetic Registrar
425	253100	Emergency Registrar
426	253100	Paediatric Registrar
427	253100	Dermatology Registrar
428	253100	Pathology Registrar
429	253100	Opthalmology Registrar
430	253100	Radiology Registrar
431	253100	Sports Physician
432	253100	Cosmetic Surgeon
433	253100	Sexual Health Physician
434	253100	Addiction Specialist
435	253100	Addiction Medicine Registrar
436	253100	GP Registrar
437	253211	Anaesthetist
438	253211	Pain specialist
439	253300	Specialist Physicians nfd
440	253300	Rehabilitation Physician
441	253300	Clinical geneticist
442	253300	Clinical pharmacologist
443	253300	ID physician
444	253300	Palliative care physician
445	253300	Geriatrician
446	253311	Specialist Physician (General Medicine)
447	253312	Cardiologist
448	253312	Cardiologist - interventional
449	253312	Echocardiologist
450	253312	Cardiologist - Electrophysiologist
451	253313	Clinical Haematologist
452	253314	Medical Oncologist
453	253315	Endocrinologist
454	253315	Diabetologist
455	253316	Gastroenterologist
456	253317	Intensive Care Specialist
457	253318	Neurologist
458	253321	Paediatrician
459	253321	Paediatric Gastroenterologist
460	253321	Paediatric Neurologist
461	253321	Paediatric Endocrinologist
462	253321	Paediatric Allergist
463	253321	Paediatrician - behaviour
464	253321	Paediatric Oncologist
465	253321	Rehabilitation Paediatrician
466	253321	Neonatologist
467	253321	Paediatric Nephrologist
468	253321	Paediatric ID physician
469	253321	Paediatric Cardiologist
470	253322	Renal Medicine Specialist
471	253323	Rheumatologist
472	253324	Respiratory Physician
473	253324	Respiratory Physician - sleep
474	253399	Specialist Physicians nec
475	253411	Psychiatrist
476	253411	Psychiatrist - child and adolescent
477	253411	Psychiatrist - old-age
478	253411	Psychiatrist - forensic
479	253411	Psychiatrist - psychotherapist
480	253500	Surgeons nfd
481	253511	Surgeon (General)
482	253500	Transplant Surgeon
483	253511	Colorectal Surgeon
484	253511	Breast Surgeon
485	253511	Hepatopancreatobilliary & upper gi surgeon
486	253511	Surgeon - Thyroid
487	253511	Neck and General Surgeon
488	253512	Cardiothoracic Surgeon
489	253513	Neurosurgeon
490	253514	Orthopaedic Surgeon
491	253514	Orthopaedic Surgeon - hip and knee
492	253514	Orthopaedic Surgeon - hand
493	253514	Orthopaedic Surgeon - shoulder
494	253514	Orthopaedic Surgeon - spine
495	253514	Orthopaedic Surgeon - foot and ankle
496	253515	Otorhinolaryngologist
497	253516	Paediatric Surgeon
498	253517	Plastic and Reconstructive Surgeon
499	253518	Urologist
500	253521	Vascular Surgeon
501	253900	Other Medical Practitioners nfd
502	253900	Public health physician
503	253900	Medical administrator
504	253911	Dermatologist
505	253912	Emergency Medicine Specialist
506	253913	Obstetrician and Gynaecologist
507	253913	Obstetrician and Gynaecologist - maternal-foetal medicine
508	253913	Obstetrician and Gynaecologist - IVF
509	253913	Gynaecologist - no obstetrics
510	253913	Urogynaecologist
511	253913	Gynaecological oncologist
512	253914	Ophthalmologist
513	253915	Pathologist
514	253915	Medical Microbiologist
515	253915	Chemical Pathologist
516	253915	Forensic Pathologist
517	253915	Genetic Pathologist
518	253915	Anatomical Pathologist
519	253917	Diagnostic and Interventional Radiologist
520	253918	Radiation Oncologist
521	253300	Nuclear Medicine physician
522	253999	Medical Practitioners nec
523	254000	Midwifery and Nursing Professionals nfd
524	254111	Midwife
525	254200	Nurse Educators and Researchers nfd
526	254211	Nurse Educator
527	254212	Nurse Researcher
528	254311	Nurse Manager
529	254400	Registered Nurses nfd
530	254411	Nurse Practitioner
531	254412	Registered Nurse (Aged Care)
532	254413	Registered Nurse (Child and Family Health)
533	254414	Registered Nurse (Community Health)
534	254415	Registered Nurse (Critical Care and Emergency)
535	254416	Registered Nurse (Developmental Disability)
536	254417	Registered Nurse (Disability and Rehabilitation)
537	254418	Registered Nurse (Medical)
538	254421	Registered Nurse (Medical Practice)
539	254422	Registered Nurse (Mental Health)
540	254423	Registered Nurse (Perioperative)
541	254424	Registered Nurse (Surgical)
542	254499	Registered Nurses nec
543	260000	ICT Professionals nfd
544	261000	Business and Systems Analysts, and Programmers nfd
545	261100	ICT Business and Systems Analysts nfd
546	261111	ICT Business Analyst
547	261112	Systems Analyst
548	261200	Multimedia Specialists and Web Developers nfd
549	261211	Multimedia Specialist
550	261212	Web Developer
551	261300	Software and Applications Programmers nfd
552	261311	Analyst Programmer
553	261312	Developer Programmer
554	261313	Software Engineer
555	261314	Software Tester
556	261399	Software and Applications Programmers nec
557	262100	Database and Systems Administrators, and ICT Security Specialists nfd
558	262111	Database Administrator
559	262112	ICT Security Specialist
560	262113	Systems Administrator
561	263000	ICT Network and Support Professionals nfd
562	263100	Computer Network Professionals nfd
563	263111	Computer Network and Systems Engineer
564	263112	Network Administrator
565	263113	Network Analyst
566	263200	ICT Support and Test Engineers nfd
567	263211	ICT Quality Assurance Engineer
568	263212	ICT Support Engineer
569	263213	ICT Systems Test Engineer
570	263299	ICT Support and Test Engineers nec
571	263300	Telecommunications Engineering Professionals nfd
572	263311	Telecommunications Engineer
573	263312	Telecommunications Network Engineer
574	270000	Legal, Social and Welfare Professionals nfd
575	271000	Legal Professionals nfd
576	271111	Barrister
577	271200	Judicial and Other Legal Professionals nfd
578	271211	Judge
579	271212	Magistrate
580	271213	Tribunal Member
581	271299	Judicial and Other Legal Professionals nec
582	271311	Solicitor
583	272000	Social and Welfare Professionals nfd
584	272100	Counsellors nfd
585	272111	Careers Counsellor
586	272112	Drug and Alcohol Counsellor
587	272113	Family and Marriage Counsellor
588	272114	Rehabilitation Counsellor
589	272115	Student Counsellor
590	272199	Counsellors nec
591	272211	Minister of Religion
592	272300	Psychologists nfd
593	272311	Clinical Psychologist
594	272312	Educational Psychologist
595	272313	Organisational Psychologist
596	272314	Psychotherapist
597	272399	Psychologists nec
598	272400	Social Professionals nfd
599	272411	Historian
600	272412	Interpreter
601	272413	Translator
602	272499	Social Professionals nec
603	272511	Social Worker
604	272600	Welfare, Recreation and Community Arts Workers nfd
605	272611	Community Arts Worker
606	272612	Recreation Officer
607	272613	Welfare Worker
608	300000	Technicians and Trades Workers nfd
609	310000	Engineering, ICT and Science Technicians nfd
610	311000	Agricultural, Medical and Science Technicians nfd
611	311111	Agricultural Technician
612	311200	Medical Technicians nfd
613	311211	Anaesthetic Technician
614	311212	Cardiac Technician
615	311213	Medical Laboratory Technician
616	311214	Operating Theatre Technician
617	311215	Pharmacy Technician
618	311216	Pathology Collector
619	311299	Medical Technicians nec
620	311300	Primary Products Inspectors nfd
621	311311	Fisheries Officer
622	311312	Meat Inspector
623	311313	Quarantine Officer
624	311399	Primary Products Inspectors nec
625	311400	Science Technicians nfd
626	311411	Chemistry Technician
627	311412	Earth Science Technician
628	311413	Life Science Technician
629	311414	School Laboratory Technician
630	311499	Science Technicians nec
631	312000	Building and Engineering Technicians nfd
632	312100	Architectural, Building and Surveying Technicians nfd
633	312111	Architectural Draftsperson
634	312112	Building Associate
635	312113	Building Inspector
636	312114	Construction Estimator
637	312115	Plumbing Inspector
638	312116	Surveying or Spatial Science Technician
639	312199	Architectural, Building and Surveying Technicians nec
640	312200	Civil Engineering Draftspersons and Technicians nfd
641	312211	Civil Engineering Draftsperson
642	312212	Civil Engineering Technician
643	312300	Electrical Engineering Draftspersons and Technicians nfd
644	312311	Electrical Engineering Draftsperson
645	312312	Electrical Engineering Technician
646	312400	Electronic Engineering Draftspersons and Technicians nfd
647	312411	Electronic Engineering Draftsperson
648	312412	Electronic Engineering Technician
649	312500	Mechanical Engineering Draftspersons and Technicians nfd
650	312511	Mechanical Engineering Draftsperson
651	312512	Mechanical Engineering Technician
652	312611	Safety Inspector
653	312900	Other Building and Engineering Technicians nfd
654	312911	Maintenance Planner
655	312912	Metallurgical or Materials Technician
656	312913	Mine Deputy
657	312999	Building and Engineering Technicians nec
658	313000	ICT and Telecommunications Technicians nfd
659	313100	ICT Support Technicians nfd
660	313111	Hardware Technician
661	313112	ICT Customer Support Officer
662	313113	Web Administrator
663	313199	ICT Support Technicians nec
664	313200	Telecommunications Technical Specialists nfd
665	313211	Radiocommunications Technician
666	313212	Telecommunications Field Engineer
667	313213	Telecommunications Network Planner
668	313214	Telecommunications Technical Officer or Technologist
669	320000	Automotive and Engineering Trades Workers nfd
670	321000	Automotive Electricians and Mechanics nfd
671	321111	Automotive Electrician
672	321200	Motor Mechanics nfd
673	321211	Motor Mechanic (General)
674	321212	Diesel Motor Mechanic
675	321213	Motorcycle Mechanic
676	321214	Small Engine Mechanic
677	322000	Fabrication Engineering Trades Workers nfd
678	322100	Metal Casting, Forging and Finishing Trades Workers nfd
679	322111	Blacksmith
680	322112	Electroplater
681	322113	Farrier
682	322114	Metal Casting Trades Worker
683	322115	Metal Polisher
684	322211	Sheetmetal Trades Worker
685	322300	Structural Steel and Welding Trades Workers nfd
686	322311	Metal Fabricator
687	322312	Pressure Welder
688	322313	Welder (First Class)
689	323000	Mechanical Engineering Trades Workers nfd
690	323100	Aircraft Maintenance Engineers nfd
691	323111	Aircraft Maintenance Engineer (Avionics)
692	323112	Aircraft Maintenance Engineer (Mechanical)
693	323113	Aircraft Maintenance Engineer (Structures)
694	323200	Metal Fitters and Machinists nfd
695	323211	Fitter (General)
696	323212	Fitter and Turner
697	323213	Fitter-Welder
698	323214	Metal Machinist (First Class)
699	323215	Textile, Clothing and Footwear Mechanic
700	323299	Metal Fitters and Machinists nec
701	323300	Precision Metal Trades Workers nfd
702	323311	Engraver
703	323312	Gunsmith
704	323313	Locksmith
705	323314	Precision Instrument Maker and Repairer
706	323315	Saw Maker and Repairer
707	323316	Watch and Clock Maker and Repairer
708	323400	Toolmakers and Engineering Patternmakers nfd
709	323411	Engineering Patternmaker
710	323412	Toolmaker
711	324000	Panelbeaters, and Vehicle Body Builders, Trimmers and Painters nfd
712	324111	Panelbeater
713	324200	Vehicle Body Builders and Trimmers nfd
714	324211	Vehicle Body Builder
715	324212	Vehicle Trimmer
716	324311	Vehicle Painter
717	330000	Construction Trades Workers nfd
718	331000	Bricklayers, and Carpenters and Joiners nfd
719	331100	Bricklayers and Stonemasons nfd
720	331111	Bricklayer
721	331112	Stonemason
722	331211	Carpenter and Joiner
723	331212	Carpenter
724	331213	Joiner
725	332000	Floor Finishers and Painting Trades Workers nfd
726	332111	Floor Finisher
727	332211	Painting Trades Worker
728	333000	Glaziers, Plasterers and Tilers nfd
729	333111	Glazier
730	333200	Plasterers nfd
731	333211	Fibrous Plasterer
732	333212	Solid Plasterer
733	333311	Roof Tiler
734	333411	Wall and Floor Tiler
735	334100	Plumbers nfd
736	334111	Plumber (General)
737	334112	Airconditioning and Mechanical Services Plumber
738	334113	Drainer
739	334114	Gasfitter
740	334115	Roof Plumber
741	340000	Electrotechnology and Telecommunications Trades Workers nfd
742	341100	Electricians nfd
743	341111	Electrician (General)
744	341112	Electrician (Special Class)
745	341113	Lift Mechanic
746	342000	Electronics and Telecommunications Trades Workers nfd
747	342111	Airconditioning and Refrigeration Mechanic
748	342200	Electrical Distribution Trades Workers nfd
749	342211	Electrical Linesworker
750	342212	Technical Cable Jointer
751	342300	Electronics Trades Workers nfd
752	342311	Business Machine Mechanic
753	342312	Communications Operator
754	342313	Electronic Equipment Trades Worker
755	342314	Electronic Instrument Trades Worker (General)
756	342315	Electronic Instrument Trades Worker (Special Class)
757	342400	Telecommunications Trades Workers nfd
758	342411	Cabler (Data and Telecommunications)
759	342412	Telecommunications Cable Jointer
760	342413	Telecommunications Linesworker
761	342414	Telecommunications Technician
762	351000	Food Trades Workers nfd
763	351100	Bakers and Pastrycooks nfd
764	351111	Baker
765	351112	Pastrycook
766	351211	Butcher or Smallgoods Maker
767	351311	Chef
768	351411	Cook
769	360000	Skilled Animal and Horticultural Workers nfd
770	361000	Animal Attendants and Trainers, and Shearers nfd
771	361100	Animal Attendants and Trainers nfd
772	361111	Dog Handler or Trainer
773	361112	Horse Trainer
774	361113	Pet Groomer
775	361114	Zookeeper
776	361199	Animal Attendants and Trainers nec
777	361211	Shearer
778	361311	Veterinary Nurse
779	362000	Horticultural Trades Workers nfd
780	362111	Florist
781	362200	Gardeners nfd
782	362211	Gardener (General)
783	362212	Arborist
784	362213	Landscape Gardener
785	362311	Greenkeeper
786	362411	Nurseryperson
787	390000	Other Technicians and Trades Workers nfd
788	391111	Hairdresser
789	392000	Printing Trades Workers nfd
790	392100	Print Finishers and Screen Printers nfd
791	392111	Print Finisher
792	392112	Screen Printer
793	392211	Graphic Pre-press Trades Worker
794	392300	Printers nfd
795	392311	Printing Machinist
796	392312	Small Offset Printer
797	393000	Textile, Clothing and Footwear Trades Workers nfd
798	393100	Canvas and Leather Goods Makers nfd
799	393111	Canvas Goods Fabricator
800	393112	Leather Goods Maker
801	393113	Sail Maker
802	393114	Shoemaker
803	393200	Clothing Trades Workers nfd
804	393211	Apparel Cutter
805	393212	Clothing Patternmaker
806	393213	Dressmaker or Tailor
807	393299	Clothing Trades Workers nec
808	393311	Upholsterer
809	394000	Wood Trades Workers nfd
810	394111	Cabinetmaker
811	394200	Wood Machinists and Other Wood Trades Workers nfd
812	394211	Furniture Finisher
813	394212	Picture Framer
814	394213	Wood Machinist
815	394214	Wood Turner
816	394299	Wood Machinists and Other Wood Trades Workers nec
817	399000	Miscellaneous Technicians and Trades Workers nfd
818	399100	Boat Builders and Shipwrights nfd
819	399111	Boat Builder and Repairer
820	399112	Shipwright
821	399200	Chemical, Gas, Petroleum and Power Generation Plant Operators nfd
822	399211	Chemical Plant Operator
823	399212	Gas or Petroleum Operator
824	399213	Power Generation Plant Operator
825	399300	Gallery, Library and Museum Technicians nfd
826	399311	Gallery or Museum Technician
827	399312	Library Technician
828	399411	Jeweller
829	399500	Performing Arts Technicians nfd
830	399511	Broadcast Transmitter Operator
831	399512	Camera Operator (Film, Television or Video)
832	399513	Light Technician
833	399514	Make Up Artist
834	399515	Musical Instrument Maker or Repairer
835	399516	Sound Technician
836	399517	Television Equipment Operator
837	399599	Performing Arts Technicians nec
838	399611	Signwriter
839	399900	Other Miscellaneous Technicians and Trades Workers nfd
840	399911	Diver
841	399912	Interior Decorator
842	399913	Optical Dispenser
843	399914	Optical Mechanic
844	399915	Photographer's Assistant
845	399916	Plastics Technician
846	399917	Wool Classer
847	399918	Fire Protection Equipment Technician
848	399999	Technicians and Trades Workers nec
849	400000	Community and Personal Service Workers nfd
850	411000	Health and Welfare Support Workers nfd
851	411100	Ambulance Officers and Paramedics nfd
852	411111	Ambulance Officer
853	411112	Intensive Care Ambulance Paramedic
854	411200	Dental Hygienists, Technicians and Therapists nfd
855	411211	Dental Hygienist
856	411212	Dental Prosthetist
857	411213	Dental Technician
858	411214	Dental Therapist
859	411311	Diversional Therapist
860	411400	Enrolled and Mothercraft Nurses nfd
861	411411	Enrolled Nurse
862	411412	Mothercraft Nurse
863	411511	Aboriginal and Torres Strait Islander Health Worker
864	411611	Massage Therapist
865	411700	Welfare Support Workers nfd
866	411711	Community Worker
867	411712	Disabilities Services Officer
868	411713	Family Support Worker
869	411714	Parole or Probation Officer
870	411715	Residential Care Officer
871	411716	Youth Worker
872	420000	Carers and Aides nfd
873	421100	Child Carers nfd
874	421111	Child Care Worker
875	421112	Family Day Care Worker
876	421113	Nanny
877	421114	Out of School Hours Care Worker
878	422100	Education Aides nfd
879	422111	Aboriginal and Torres Strait Islander Education Worker
880	422112	Integration Aide
881	422115	Preschool Aide
882	422116	Teachers' Aide
883	423000	Personal Carers and Assistants nfd
884	423111	Aged or Disabled Carer
885	423211	Dental Assistant
886	423300	Nursing Support and Personal Care Workers nfd
887	423311	Hospital Orderly
888	423312	Nursing Support Worker
889	423313	Personal Care Assistant
890	423314	Therapy Aide
891	423400	Special Care Workers nfd
892	423411	Child or Youth Residential Care Assistant
893	423412	Hostel Parent
894	423413	Refuge Worker
895	431000	Hospitality Workers nfd
896	431100	Bar Attendants and Baristas nfd
897	431111	Bar Attendant
898	431112	Barista
899	431211	Cafe Worker
900	431311	Gaming Worker
901	431411	Hotel Service Manager
902	431511	Waiter
903	431900	Other Hospitality Workers nfd
904	431911	Bar Useful or Busser
905	431912	Doorperson or Luggage Porter
906	431999	Hospitality Workers nec
907	440000	Protective Service Workers nfd
908	441000	Defence Force Members, Fire Fighters and Police nfd
909	441111	Defence Force Member - Other Ranks
910	441200	Fire and Emergency Workers nfd
911	441211	Emergency Service Worker
912	441212	Fire Fighter
913	441300	Police nfd
914	441311	Detective
915	441312	Police Officer
916	442000	Prison and Security Officers nfd
917	442111	Prison Officer
918	442200	Security Officers and Guards nfd
919	442211	Alarm, Security or Surveillance Monitor
920	442212	Armoured Car Escort
921	442213	Crowd Controller
922	442214	Private Investigator
923	442215	Retail Loss Prevention Officer
924	442216	Security Consultant
925	442217	Security Officer
926	442299	Security Officers and Guards nec
927	450000	Sports and Personal Service Workers nfd
928	451000	Personal Service and Travel Workers nfd
929	451111	Beauty Therapist
930	451211	Driving Instructor
931	451300	Funeral Workers nfd
932	451311	Funeral Director
933	451399	Funeral Workers nec
934	451400	Gallery, Museum and Tour Guides nfd
935	451411	Gallery or Museum Guide
936	451412	Tour Guide
937	451500	Personal Care Consultants nfd
938	451511	Natural Remedy Consultant
939	451512	Weight Loss Consultant
940	451600	Tourism and Travel Advisers nfd
941	451611	Tourist Information Officer
942	451612	Travel Consultant
943	451700	Travel Attendants nfd
944	451711	Flight Attendant
945	451799	Travel Attendants nec
946	451800	Other Personal Service Workers nfd
947	451811	Civil Celebrant
948	451812	Hair or Beauty Salon Assistant
949	451813	Sex Worker or Escort
950	451814	Body Artist
951	451815	First Aid Trainer
952	451816	Religious Assistant
953	451899	Personal Service Workers nec
954	452000	Sports and Fitness Workers nfd
955	452111	Fitness Instructor
956	452200	Outdoor Adventure Guides nfd
957	452211	Bungy Jump Master
958	452212	Fishing Guide
959	452213	Hunting Guide
960	452214	Mountain or Glacier Guide
961	452215	Outdoor Adventure Instructor
962	452216	Trekking Guide
963	452217	Whitewater Rafting Guide
964	452299	Outdoor Adventure Guides nec
965	452300	Sports Coaches, Instructors and Officials nfd
966	452311	Diving Instructor (Open Water)
967	452312	Gymnastics Coach or Instructor
968	452313	Horse Riding Coach or Instructor
969	452314	Snowsport Instructor
970	452315	Swimming Coach or Instructor
971	452316	Tennis Coach
972	452317	Other Sports Coach or Instructor
973	452318	Dog or Horse Racing Official
974	452321	Sports Development Officer
975	452322	Sports Umpire
976	452323	Other Sports Official
977	452400	Sportspersons nfd
978	452411	Footballer
979	452412	Golfer
980	452413	Jockey
981	452414	Lifeguard
982	452499	Sportspersons nec
983	500000	Clerical and Administrative Workers nfd
984	510000	Office Managers and Program Administrators nfd
985	511100	Contract, Program and Project Administrators nfd
986	511111	Contract Administrator
987	511112	Program or Project Administrator
988	512000	Office and Practice Managers nfd
989	512111	Office Manager
990	512200	Practice Managers nfd
991	512211	Health Practice Manager
992	512299	Practice Managers nec
993	521000	Personal Assistants and Secretaries nfd
994	521111	Personal Assistant
995	521200	Secretaries nfd
996	521211	Secretary (General)
997	521212	Legal Secretary
998	530000	General Clerical Workers nfd
999	531111	General Clerk
1000	532100	Keyboard Operators nfd
1001	532111	Data Entry Operator
1002	532112	Machine Shorthand Reporter
1003	532113	Word Processing Operator
1004	540000	Inquiry Clerks and Receptionists nfd
1005	541000	Call or Contact Centre Information Clerks nfd
1006	541100	Call or Contact Centre Workers nfd
1007	541111	Call or Contact Centre Team Leader
1008	541112	Call or Contact Centre Operator
1009	541211	Inquiry Clerk
1010	542100	Receptionists nfd
1011	542111	Receptionist (General)
1012	542112	Admissions Clerk
1013	542113	Hotel or Motel Receptionist
1014	542114	Medical Receptionist
1015	550000	Numerical Clerks nfd
1016	551000	Accounting Clerks and Bookkeepers nfd
1017	551100	Accounting Clerks nfd
1018	551111	Accounts Clerk
1019	551112	Cost Clerk
1020	551211	Bookkeeper
1021	551311	Payroll Clerk
1022	552000	Financial and Insurance Clerks nfd
1023	552111	Bank Worker
1024	552211	Credit or Loans Officer
1025	552300	Insurance, Money Market and Statistical Clerks nfd
1026	552311	Bookmaker
1027	552312	Insurance Consultant
1028	552313	Money Market Clerk
1029	552314	Statistical Clerk
1030	561000	Clerical and Office Support Workers nfd
1031	561100	Betting Clerks nfd
1032	561111	Betting Agency Counter Clerk
1033	561112	Bookmaker's Clerk
1034	561113	Telephone Betting Clerk
1035	561199	Betting Clerks nec
1036	561200	Couriers and Postal Deliverers nfd
1037	561211	Courier
1038	561212	Postal Delivery Officer
1039	561311	Filing or Registry Clerk
1040	561400	Mail Sorters nfd
1041	561411	Mail Clerk
1042	561412	Postal Sorting Officer
1043	561511	Survey Interviewer
1044	561611	Switchboard Operator
1045	561900	Other Clerical and Office Support Workers nfd
1046	561911	Classified Advertising Clerk
1047	561912	Meter Reader
1048	561913	Parking Inspector
1049	561999	Clerical and Office Support Workers nec
1050	590000	Other Clerical and Administrative Workers nfd
1051	591000	Logistics Clerks nfd
1052	591100	Purchasing and Supply Logistics Clerks nfd
1053	591112	Production Clerk
1054	591113	Purchasing Officer
1055	591115	Stock Clerk
1056	591116	Warehouse Administrator
1057	591117	Order Clerk
1058	591200	Transport and Despatch Clerks nfd
1059	591211	Despatching and Receiving Clerk
1060	591212	Import-Export Clerk
1061	599000	Miscellaneous Clerical and Administrative Workers nfd
1062	599100	Conveyancers and Legal Executives nfd
1063	599111	Conveyancer
1064	599112	Legal Executive
1065	599200	Court and Legal Clerks nfd
1066	599211	Clerk of Court
1067	599212	Court Bailiff or Sheriff
1068	599213	Court Orderly
1069	599214	Law Clerk
1070	599215	Trust Officer
1071	599311	Debt Collector
1072	599411	Human Resource Clerk
1073	599500	Inspectors and Regulatory Officers nfd
1074	599511	Customs Officer
1075	599512	Immigration Officer
1076	599513	Motor Vehicle Licence Examiner
1077	599514	Noxious Weeds and Pest Inspector
1078	599515	Social Security Assessor
1079	599516	Taxation Inspector
1080	599517	Train Examiner
1081	599518	Transport Operations Inspector
1082	599521	Water Inspector
1083	599599	Inspectors and Regulatory Officers nec
1084	599600	Insurance Investigators, Loss Adjusters and Risk Surveyors nfd
1085	599611	Insurance Investigator
1086	599612	Insurance Loss Adjuster
1087	599613	Insurance Risk Surveyor
1088	599711	Library Assistant
1089	599900	Other Miscellaneous Clerical and Administrative Workers nfd
1090	599912	Production Assistant (Film, Television, Radio or Stage)
1091	599913	Proof Reader
1092	599914	Radio Despatcher
1093	599915	Clinical Coder
1094	599916	Facilities Administrator
1095	599999	Clerical and Administrative Workers nec
1096	600000	Sales Workers nfd
1097	610000	Sales Representatives and Agents nfd
1098	611000	Insurance Agents and Sales Representatives nfd
1099	611100	Auctioneers, and Stock and Station Agents nfd
1100	611111	Auctioneer
1101	611112	Stock and Station Agent
1102	611211	Insurance Agent
1103	611300	Sales Representatives nfd
1104	611311	Sales Representative (Building and Plumbing Supplies)
1105	611312	Sales Representative (Business Services)
1106	611313	Sales Representative (Motor Vehicle Parts and Accessories)
1107	611314	Sales Representative (Personal and Household Goods)
1108	611399	Sales Representatives nec
1109	612100	Real Estate Sales Agents nfd
1110	612111	Business Broker
1111	612112	Property Manager
1112	612113	Real Estate Agency Principal
1113	612114	Real Estate Agent
1114	612115	Real Estate Representative
1115	621000	Sales Assistants and Salespersons nfd
1116	621111	Sales Assistant (General)
1117	621211	ICT Sales Assistant
1118	621300	Motor Vehicle and Vehicle Parts Salespersons nfd
1119	621311	Motor Vehicle or Caravan Salesperson
1120	621312	Motor Vehicle Parts Interpreter
1121	621411	Pharmacy Sales Assistant
1122	621511	Retail Supervisor
1123	621611	Service Station Attendant
1124	621700	Street Vendors and Related Salespersons nfd
1125	621711	Cash Van Salesperson
1126	621712	Door-to-door Salesperson
1127	621713	Street Vendor
1128	621900	Other Sales Assistants and Salespersons nfd
1129	621911	Materials Recycler
1130	621912	Rental Salesperson
1131	621999	Sales Assistants and Salespersons nec
1132	630000	Sales Support Workers nfd
1133	631100	Checkout Operators and Office Cashiers nfd
1134	631111	Checkout Operator
1135	631112	Office Cashier
1136	639000	Miscellaneous Sales Support Workers nfd
1137	639100	Models and Sales Demonstrators nfd
1138	639111	Model
1139	639112	Sales Demonstrator
1140	639200	Retail and Wool Buyers nfd
1141	639211	Retail Buyer
1142	639212	Wool Buyer
1143	639311	Telemarketer
1144	639400	Ticket Salespersons nfd
1145	639411	Ticket Seller
1146	639412	Transport Conductor
1147	639511	Visual Merchandiser
1148	639911	Other Sales Support Worker
1149	700000	Machinery Operators and Drivers nfd
1150	710000	Machine and Stationary Plant Operators nfd
1151	711000	Machine Operators nfd
1152	711100	Clay, Concrete, Glass and Stone Processing Machine Operators nfd
1153	711111	Clay Products Machine Operator
1154	711112	Concrete Products Machine Operator
1155	711113	Glass Production Machine Operator
1156	711114	Stone Processing Machine Operator
1157	711199	Clay, Concrete, Glass and Stone Processing Machine Operators nec
1158	711211	Industrial Spraypainter
1159	711300	Paper and Wood Processing Machine Operators nfd
1160	711311	Paper Products Machine Operator
1161	711313	Sawmilling Operator
1162	711314	Other Wood Processing Machine Operator
1163	711411	Photographic Developer and Printer
1164	711500	Plastics and Rubber Production Machine Operators nfd
1165	711511	Plastic Cablemaking Machine Operator
1166	711512	Plastic Compounding and Reclamation Machine Operator
1167	711513	Plastics Fabricator or Welder
1168	711514	Plastics Production Machine Operator (General)
1169	711515	Reinforced Plastic and Composite Production Worker
1170	711516	Rubber Production Machine Operator
1171	711599	Plastics and Rubber Production Machine Operators nec
1172	711611	Sewing Machinist
1173	711700	Textile and Footwear Production Machine Operators nfd
1174	711711	Footwear Production Machine Operator
1175	711712	Hide and Skin Processing Machine Operator
1176	711713	Knitting Machine Operator
1177	711714	Textile Dyeing and Finishing Machine Operator
1178	711715	Weaving Machine Operator
1179	711716	Yarn Carding and Spinning Machine Operator
1180	711799	Textile and Footwear Production Machine Operators nec
1181	711900	Other Machine Operators nfd
1182	711911	Chemical Production Machine Operator
1183	711912	Motion Picture Projectionist
1184	711913	Sand Blaster
1185	711914	Sterilisation Technician
1186	711999	Machine Operators nec
1187	712000	Stationary Plant Operators nfd
1188	712111	Crane, Hoist or Lift Operator
1189	712200	Drillers, Miners and Shot Firers nfd
1190	712211	Driller
1191	712212	Miner
1192	712213	Shot Firer
1193	712311	Engineering Production Worker
1194	712900	Other Stationary Plant Operators nfd
1195	712911	Boiler or Engine Operator
1196	712912	Bulk Materials Handling Plant Operator
1197	712913	Cement Production Plant Operator
1198	712914	Concrete Batching Plant Operator
1199	712915	Concrete Pump Operator
1200	712916	Paper and Pulp Mill Operator
1201	712917	Railway Signal Operator
1202	712918	Train Controller
1203	712921	Waste Water or Water Plant Operator
1204	712922	Weighbridge Operator
1205	712999	Stationary Plant Operators nec
1206	721000	Mobile Plant Operators nfd
1207	721100	Agricultural, Forestry and Horticultural Plant Operators nfd
1208	721111	Agricultural and Horticultural Mobile Plant Operator
1209	721112	Logging Plant Operator
1210	721200	Earthmoving Plant Operators nfd
1211	721211	Earthmoving Plant Operator (General)
1212	721212	Backhoe Operator
1213	721213	Bulldozer Operator
1214	721214	Excavator Operator
1215	721215	Grader Operator
1216	721216	Loader Operator
1217	721311	Forklift Driver
1218	721900	Other Mobile Plant Operators nfd
1219	721911	Aircraft Baggage Handler and Airline Ground Crew
1220	721912	Linemarker
1221	721913	Paving Plant Operator
1222	721914	Railway Track Plant Operator
1223	721915	Road Roller Operator
1224	721916	Streetsweeper Operator
1225	721999	Mobile Plant Operators nec
1226	730000	Road and Rail Drivers nfd
1227	731000	Automobile, Bus and Rail Drivers nfd
1228	731100	Automobile Drivers nfd
1229	731111	Chauffeur
1230	731112	Taxi Driver
1231	731199	Automobile Drivers nec
1232	731200	Bus and Coach Drivers nfd
1233	731211	Bus Driver
1234	731212	Charter and Tour Bus Driver
1235	731213	Passenger Coach Driver
1236	731300	Train and Tram Drivers nfd
1237	731311	Train Driver
1238	731312	Tram Driver
1239	732111	Delivery Driver
1240	733100	Truck Drivers nfd
1241	733111	Truck Driver (General)
1242	733112	Aircraft Refueller
1243	733113	Furniture Removalist
1244	733114	Tanker Driver
1245	733115	Tow Truck Driver
1246	741111	Storeperson
1247	800000	Labourers nfd
1248	811000	Cleaners and Laundry Workers nfd
1249	811111	Car Detailer
1250	811211	Commercial Cleaner
1251	811311	Domestic Cleaner
1252	811400	Housekeepers nfd
1253	811411	Commercial Housekeeper
1254	811412	Domestic Housekeeper
1255	811500	Laundry Workers nfd
1256	811511	Laundry Worker (General)
1257	811512	Drycleaner
1258	811513	Ironer or Presser
1259	811600	Other Cleaners nfd
1260	811611	Carpet Cleaner
1261	811612	Window Cleaner
1262	811699	Cleaners nec
1263	821000	Construction and Mining Labourers nfd
1264	821100	Building and Plumbing Labourers nfd
1265	821111	Builder's Labourer
1266	821112	Drainage, Sewerage and Stormwater Labourer
1267	821113	Earthmoving Labourer
1268	821114	Plumber's Assistant
1269	821211	Concreter
1270	821311	Fencer
1271	821400	Insulation and Home Improvement Installers nfd
1272	821411	Building Insulation Installer
1273	821412	Home Improvement Installer
1274	821511	Paving and Surfacing Labourer
1275	821611	Railway Track Worker
1276	821700	Structural Steel Construction Workers nfd
1277	821711	Construction Rigger
1278	821712	Scaffolder
1279	821713	Steel Fixer
1280	821714	Structural Steel Erector
1281	821900	Other Construction and Mining Labourers nfd
1282	821911	Crane Chaser
1283	821912	Driller's Assistant
1284	821913	Lagger
1285	821914	Mining Support Worker
1286	821915	Surveyor's Assistant
1287	830000	Factory Process Workers nfd
1288	831000	Food Process Workers nfd
1289	831100	Food and Drink Factory Workers nfd
1290	831111	Baking Factory Worker
1291	831112	Brewery Worker
1292	831113	Confectionery Maker
1293	831114	Dairy Products Maker
1294	831115	Fruit and Vegetable Factory Worker
1295	831116	Grain Mill Worker
1296	831117	Sugar Mill Worker
1297	831118	Winery Cellar Hand
1298	831199	Food and Drink Factory Workers nec
1299	831200	Meat Boners and Slicers, and Slaughterers nfd
1300	831211	Meat Boner and Slicer
1301	831212	Slaughterer
1302	831300	Meat, Poultry and Seafood Process Workers nfd
1303	831311	Meat Process Worker
1304	831312	Poultry Process Worker
1305	831313	Seafood Process Worker
1306	832000	Packers and Product Assemblers nfd
1307	832100	Packers nfd
1308	832111	Chocolate Packer
1309	832112	Container Filler
1310	832113	Fruit and Vegetable Packer
1311	832114	Meat Packer
1312	832115	Seafood Packer
1313	832199	Packers nec
1314	832211	Product Assembler
1315	839000	Miscellaneous Factory Process Workers nfd
1316	839111	Metal Engineering Process Worker
1317	839200	Plastics and Rubber Factory Workers nfd
1318	839211	Plastics Factory Worker
1319	839212	Rubber Factory Worker
1320	839300	Product Quality Controllers nfd
1321	839311	Product Examiner
1322	839312	Product Grader
1323	839313	Product Tester
1324	839400	Timber and Wood Process Workers nfd
1325	839411	Paper and Pulp Mill Worker
1326	839412	Sawmill or Timber Yard Worker
1327	839413	Wood and Wood Products Factory Worker
1328	839900	Other Factory Process Workers nfd
1329	839911	Cement and Concrete Plant Worker
1330	839912	Chemical Plant Worker
1331	839913	Clay Processing Factory Worker
1332	839914	Fabric and Textile Factory Worker
1333	839915	Footwear Factory Worker
1334	839916	Glass Processing Worker
1335	839917	Hide and Skin Processing Worker
1336	839918	Recycling Worker
1337	839999	Factory Process Workers nec
1338	841000	Farm, Forestry and Garden Workers nfd
1339	841111	Aquaculture Worker
1340	841200	Crop Farm Workers nfd
1341	841211	Fruit or Nut Farm Worker
1342	841212	Fruit or Nut Picker
1343	841213	Grain, Oilseed or Pasture Farm Worker
1344	841214	Vegetable Farm Worker
1345	841215	Vegetable Picker
1346	841216	Vineyard Worker
1347	841217	Mushroom Picker
1348	841299	Crop Farm Workers nec
1349	841300	Forestry and Logging Workers nfd
1350	841311	Forestry Worker
1351	841312	Logging Assistant
1352	841313	Tree Faller
1353	841400	Garden and Nursery Labourers nfd
1354	841411	Garden Labourer
1355	841412	Horticultural Nursery Assistant
1356	841500	Livestock Farm Workers nfd
1357	841511	Beef Cattle Farm Worker
1358	841512	Dairy Cattle Farm Worker
1359	841513	Mixed Livestock Farm Worker
1360	841514	Poultry Farm Worker
1361	841515	Sheep Farm Worker
1362	841516	Stablehand
1363	841517	Wool Handler
1364	841599	Livestock Farm Workers nec
1365	841611	Mixed Crop and Livestock Farm Worker
1366	841900	Other Farm, Forestry and Garden Workers nfd
1367	841911	Hunter-Trapper
1368	841913	Pest Controller
1369	841999	Farm, Forestry and Garden Workers nec
1370	851000	Food Preparation Assistants nfd
1371	851111	Fast Food Cook
1372	851200	Food Trades Assistants nfd
1373	851211	Pastrycook's Assistant
1374	851299	Food Trades Assistants nec
1375	851311	Kitchenhand
1376	890000	Other Labourers nfd
1377	891000	Freight Handlers and Shelf Fillers nfd
1378	891100	Freight and Furniture Handlers nfd
1379	891111	Freight Handler (Rail or Road)
1380	891112	Truck Driver's Offsider
1381	891113	Waterside Worker
1382	891211	Shelf Filler
1383	899000	Miscellaneous Labourers nfd
1384	899111	Caretaker
1385	899200	Deck and Fishing Hands nfd
1386	899211	Deck Hand
1387	899212	Fishing Hand
1388	899311	Handyperson
1389	899400	Motor Vehicle Parts and Accessories Fitters nfd
1390	899411	Motor Vehicle Parts and Accessories Fitter (General)
1391	899412	Autoglazier
1392	899413	Exhaust and Muffler Repairer
1393	899414	Radiator Repairer
1394	899415	Tyre Fitter
1395	899500	Printing Assistants and Table Workers nfd
1396	899511	Printer's Assistant
1397	899512	Printing Table Worker
1398	899611	Recycling or Rubbish Collector
1399	899711	Vending Machine Attendant
1400	899900	Other Miscellaneous Labourers nfd
1401	899911	Bicycle Mechanic
1402	899912	Car Park Attendant
1403	899913	Crossing Supervisor
1404	899914	Electrical or Telecommunications Trades Assistant
1405	899915	Leaflet or Newspaper Deliverer
1406	899916	Mechanic's Assistant
1407	899917	Railways Assistant
1408	899918	Sign Erector
1409	899921	Ticket Collector or Usher
1410	899922	Trolley Collector
1411	899923	Road Traffic Controller
1412	899999	Labourers nec
1413	0999-10	Student
1414	0999-20	Child/baby
1415	0999-30	Invalid pensioner
1416	0999-40	Other pensioner
1417	0999-50	House wife/husband
1418	0999-60	Retired
1419	0999-70	Unemployed
\.


--
-- Name: lu_occupations_abs_coded_pkey; Type: CONSTRAINT; Schema: common; Owner: easygp; Tablespace: 
--

ALTER TABLE ONLY lu_occupations_abs_coded
    ADD CONSTRAINT lu_occupations_abs_coded_pkey PRIMARY KEY (pk);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
alter table common.lu_occupations_abs_coded owner to easygp;
Grant all on table common.lu_occupations_abs_coded to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 283);