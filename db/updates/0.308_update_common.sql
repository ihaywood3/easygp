--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.1.9
-- Started on 2013-07-29 20:44:29 EST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = common, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 979 (class 1259 OID 1287089)
-- Dependencies: 4407 4408 21
-- Name: lu_occupations_temp; Type: TABLE; Schema: common; Owner: -; Tablespace: 
--
DROP TABLE lu_occupations_temp;

CREATE TABLE lu_occupations_temp (
    pk integer NOT NULL,
    occupation text NOT NULL,
    referrer_type character(1) DEFAULT 'o'::bpchar,
    CONSTRAINT lu_occupations_referrer_type_check CHECK ((referrer_type = ANY (ARRAY['o'::bpchar, 'g'::bpchar, 's'::bpchar])))
);


--
-- TOC entry 978 (class 1259 OID 1287087)
-- Dependencies: 979 21
-- Name: lu_occupations_temp_pk_seq; Type: SEQUENCE; Schema: common; Owner: -
--

CREATE SEQUENCE lu_occupations_temp_pk_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4417 (class 0 OID 0)
-- Dependencies: 978
-- Name: lu_occupations_temp_pk_seq; Type: SEQUENCE OWNED BY; Schema: common; Owner: -
--

ALTER SEQUENCE lu_occupations_temp_pk_seq OWNED BY lu_occupations_temp.pk;


--
-- TOC entry 4406 (class 2604 OID 1287092)
-- Dependencies: 978 979 979
-- Name: pk; Type: DEFAULT; Schema: common; Owner: -
--

ALTER TABLE ONLY lu_occupations_temp ALTER COLUMN pk SET DEFAULT nextval('lu_occupations_temp_pk_seq'::regclass);


--
-- TOC entry 4412 (class 0 OID 1287089)
-- Dependencies: 979 4413
-- Data for Name: lu_occupations_temp; Type: TABLE DATA; Schema: common; Owner: -
--

COPY lu_occupations_temp (pk, occupation, referrer_type) FROM stdin;
1	accountant	o
2	account manager	o
3	acute case manager	o
4	addiction medicine registrar	g
5	addiction medicine specialist	s
6	admin assistant	o
7	administration manager	o
8	administration officer	o
9	administrator	o
10	admin officer	o
11	aged care ain	o
12	air conditioning mechanic	o
13	airframe fitter	o
14	airline pilot	o
15	allergist & immunologist	s
16	aluminium fabricator	o
17	ambulance officer	o
18	anaesthesic registrar	g
19	anaesthetist	s
20	anaesthetist & intensivist	s
21	anatomical pathologist	s
22	apprentice boilermaker	o
23	apprentice carpenter	o
24	apprentice joiner	o
25	apprentice welder	o
26	arial and satellite installation	o
27	artist	o
28	asphalt contractor	o
29	asphalter	o
30	assistant director	o
31	assistant in nursing	o
32	associate professor	o
33	audiologist	o
34	audiometrist	o
35	auto electrician	o
36	baby	o
37	baker	o
38	bakery manager	o
39	bank clerk	o
40	banker	o
41	bank manager	o
42	bank officer	o
43	bar and gaming attendant	o
44	bar attendant	o
45	barman	o
46	bar manager	o
47	bar work	o
48	beauty therapist	o
49	bereavement counsellor - adult	o
50	bistro assistant	o
51	boilermaker	o
52	book binder	o
53	booking officer	o
54	book keeper	o
55	bowel surgeon	s
56	bread carter	o
57	brickies labourer	o
58	bricklayer	o
59	builder	o
60	building contracter	o
61	building supervisor	o
62	building surveyor	o
63	bus driver	o
64	business coach	o
65	business equipment technician	o
66	businessman	o
67	business manager	o
68	business owner	o
69	business person	o
70	butcher	o
71	cabinet maker	o
72	cake decorator	o
73	call centre consultant	o
74	cane cutter	o
75	canteen assistant	o
76	car detailer	o
77	cardiologist	s
78	cardiologist - electrophysiologist	s
79	cardiologist - interventional	s
80	cardiology registrar	g
81	cardiothoracic registrar	g
82	cardiothoracic surgeon	s
83	career medical officer	g
84	carer	o
85	care service employee	o
86	caretaker shopping centre	o
87	care worker	o
88	carpenter	o
89	carpenter site supervisor	o
90	carpet layer	o
91	carpet salesman	o
92	cartoon character	o
93	car wagon fitter	o
94	case manager	o
95	cashier	o
96	casual receptionist	o
97	casual shop assistant	o
98	catchment officer	o
99	cement renderer	o
100	ceo cardio clinic	o
101	chartered accountant	o
102	chef	o
103	chemical pathologist	s
104	chemist	o
105	chemist assistant	o
106	chicken farmer	o
107	chief executive officer	o
108	child care assistant	o
109	child carer - casual	o
110	child care worker	o
111	child minder	o
112	child psychiatrist	s
113	child psychiatry registrar	g
114	chiropractor	o
115	cinema owner	o
116	civil construction supervisor	o
117	civil engineer	o
118	claims manager	o
119	cleaner	o
120	cleaning business	o
121	clerical	o
122	clerical support staff	o
123	clerical work	o
124	clerk	o
125	clinical geneticist	s
126	clinical genetics registrar	g
127	clinical nurse consultant	o
128	clinical pharmacologist	s
129	clinical pharmacology registrar	g
130	clinical psychologist	o
131	clinic research data manager	o
132	club manager	o
133	coal miner	o
134	coal miner fitter	o
135	colorectal and general surgeon	s
136	colorectal surgeon	s
137	commission agent	o
138	community worker	o
139	company director	o
140	company manager	o
141	company owner	o
142	computer aided draftsman	o
143	computer consultant	o
144	computer programmer	o
145	computer technician	o
146	concretor	o
147	construction manager	o
148	construction supervisor	o
149	consultant	o
150	consultant physician/geriatrician	o
151	contract cleaner	o
152	conveyor maintenance	o
153	cook	o
154	corporate consultant	o
155	cosmetic plastic surgeon	s
156	counselling psychologist	o
157	counsellor	o
158	courier	o
159	court registrar	o
160	crane chaser	o
161	crane driver	o
162	crane truck driver	o
163	crew manager	o
164	crew member	o
165	customer contact officer (fines)	o
166	customer service assistant	o
167	customer service consultant	o
168	customer service officer	o
169	dancer	o
170	database manager	o
171	deli assistant	o
172	delivery driver	o
173	dental lab manager	o
174	dental nurse	o
175	dental prosthetist	o
176	dental technician	o
177	dentist	o
178	dermatologist	s
179	dermatology registrar	g
180	design engineer	o
181	developer	o
182	diabetes educator	o
183	diabetologist	s
184	diesel mechanic	o
185	dietitian	o
186	directional driller	o
187	disability pensioner	o
188	distribution manager	o
189	district officer	o
190	doctor	g
191	dog groomer	o
192	dogman	o
193	domestic	o
194	domestic supervisor	o
195	doorman	o
196	draftsman	o
197	draughtsman	o
198	dress maker	o
199	driver	o
200	driver examiner	o
201	driving instructor	o
202	drover	o
203	drug and alcohol counsellor	o
204	drug representative	o
205	dry cleaner	o
206	educational consultant	o
207	electrical consultant	o
208	electrical contractor	o
209	electrical engineer	o
210	electrical fitter	o
211	electrical maintenance service	o
212	electrical trades assistant	o
213	electrical wholesaler	o
214	electrician	o
215	electrician's labourer	o
216	electronics technician	o
217	emergency physician	s
218	emergency registrar	g
219	employment consultant	o
220	endocrinologist	s
221	endocrinology registrar	g
222	engine driver	o
223	engineer	o
224	engineering surveyor	o
225	engineer - mechanical	o
226	ent - head & neck surgeon	s
227	ent registrar	g
228	ent surgeon	s
229	ent surgeon - paediatric	s
230	environmental consultant	o
231	environmental economist	o
232	epidemiologist	s
233	estimator	o
234	exercise physiologist	s
235	exercise therapist	o
236	factory worker	o
237	falls intake coordinator	o
238	family day care worker	o
239	farmer	o
240	farm hand	o
241	fencing contractor	o
242	finance broker	o
243	finance company	o
244	finance officer	o
245	financial adviser	o
246	financial planner	o
247	fire fighter	o
248	fireman	o
249	fish monger	o
250	fitter	o
251	fitter and machinist	o
252	fitter and turner	o
253	food services coordinator	o
254	foreman	o
255	forensic pathologist	s
256	forensic psychiatrist	s
257	forensic psychologist	o
258	forest ranger	o
259	forklift driver	o
260	forklift driver- booking officer	o
261	forklift mechanic	o
262	free lance stylist	o
263	fruit and vegetable packer	o
264	fruit supplier	o
265	full time student	o
266	furniture removalist	o
267	garbage contractor	o
268	gardener	o
269	gas controller	o
270	gastroenterologist	s
271	gastroenterologist and hepatologist	s
272	gastroenterologist and hepatologist - paediatric	s
273	gastroenterology registrar	g
274	general and abdominal surgeon	s
275	general and oncological surgeon	s
276	general assistant	o
277	general hand	o
278	general & laparoscopic surgeon	s
279	general manager	o
280	general practice registrar	g
281	general practitioner	g
282	general surgeon	s
283	general work	o
284	genetic counsellor	o
285	geologist	o
286	geotechnician	o
287	geriatrician	s
288	geriatric registrar	g
289	gis data acquisition officer	o
290	glass worker	o
291	glazier	o
292	graphic artist	o
293	graphic designer	o
294	gynaecological oncologist	s
295	gynaecologist	s
296	gynaecology registrar	g
297	haematologist	s
298	haematology registrar	g
299	hairdresser	o
300	hand therapist	o
301	head teacher	o
302	health and safety manager	o
303	health information manager	o
304	hepatopancreatobilliary & upper gi surgeon	s
305	high school teacher	o
306	home care worker	o
307	home duties	o
308	horse trainer	o
309	horticulturalist	o
310	horticulturalist supervisor	o
311	hospital assistant	o
312	hospital cleaner	o
313	hospitality	o
314	hospitality teacher	o
315	house cleaner	o
316	house duties	o
317	house keeper	o
318	house wife	o
319	human resources manager	o
320	human resources officer	o
321	hydrographer	o
322	icu registrar	g
323	immunologist	s
324	immunology registrar	g
325	industrial economist	o
326	infant teacher	o
327	infectious diseases registrar	g
328	information technology manager	o
329	injury management advisor	o
330	installer	o
331	instrument maker	o
332	instrument technician	o
333	insurance broker	o
334	insurance officer	o
335	insurance operator	o
336	insurance underwriter	o
337	intern	g
338	invalid pensioner	o
339	investor	o
340	iron worker	o
341	it consultant	o
342	it infrastructure manager	o
343	it manager	o
344	it project manager	o
345	ivf specialist	s
346	jockey	o
347	joiner	o
348	laboratory analyst	o
349	labourer	o
350	landscaper	o
351	laundry worker	o
352	lawn mowing	o
353	lecturer	o
354	legal manager	o
355	legal secretary	o
356	legal support officer	o
357	liaison officer	o
358	librarian	o
359	library technician	o
360	lifeguard	o
361	linesman	o
362	locum cardiologist	s
363	loss adjuster	o
364	lubrication fitter	o
365	machine operator	o
366	machinist	o
367	magistrate	o
368	mail courier	o
369	maintenance carpenter	o
370	maintenance planner	o
371	maintenance worker	o
372	maintenence supervisor	o
373	make up artist	o
374	manager	o
375	manufacturer	o
376	manufacturers agent	o
377	manufacturing	o
378	marine engineer	o
379	marketing	o
380	marketing manager	o
381	massage therapist	o
382	maxillofacial registrar	g
383	meat inspector	o
384	meat salesman	o
385	mechanic	o
386	mechanical engineer	o
387	medical administration registrar	g
388	medical administrator	s
389	medical oncologist	s
390	medical oncology registrar	g
391	medical practitioner	g
392	medical receptionist	o
393	medical registrar	g
394	medical representative	o
395	medical scientist	o
396	medical secretary	o
397	medical student	o
398	merchandiser	o
399	merchant seaman	o
400	metallurgist	o
401	meter reader	o
402	microbiologist	s
403	migration agent	o
404	milk vendor	o
405	mine deputy	o
406	mine manager	o
407	mine worker	o
408	mining	o
409	mining engineer	o
410	minister of religion	o
411	motor body trimmer	o
412	motor car dealer	o
413	motor mechanic	o
414	musician	o
415	music teacher	o
416	nail technican	o
417	natural resource project officer	o
418	neck and general surgeon	s
419	neonatal paediatrician	s
420	neonatologist	s
421	nephrologist	s
422	neurologist - adult	s
423	neurology registrar	g
424	neuropsychologist	o
425	neurosurgeon	s
426	night watchman	o
427	nrma patrolman	o
428	nuclear medicine physician	s
429	nuclear medicine registrar	g
430	nurse	o
431	nurse - ain	o
432	nurse - disability	o
433	nurse - psychiatric	o
434	nurse - psychiatry	o
435	nurses aid	o
436	nursing sister	o
437	obstetrician and gynaecologist	s
438	obstetric registrar	g
439	occupational medicine registrar	g
440	occupational nursing	o
441	occupational physician	s
442	occupational therapist	o
443	office administrator	o
444	office clerk	o
445	office duties	o
446	office duties and retail	o
447	office equipment engineer	o
448	office manager	o
449	office worker	o
450	operations assistant	o
451	ophthalmic surgeon	s
452	ophthalmologist	o
453	ophthalmologist & plastic surgeon	s
454	ophthalmology registrar	g
455	optometrist	o
456	oral & maxillofacial surgeon	s
457	oral surgeon	s
458	orthodontist	o
459	orthopaedic registrar	g
460	orthopaedic surgeon	s
461	orthopaedic surgeon - foot & ankle	o
462	orthopaedic surgeon - general	s
463	orthopaedic surgeon - hand	s
464	orthopaedic surgeon - hip & knee	s
465	orthopaedic surgeon -  paediatric	s
466	orthopaedic surgeon - upper limb	s
467	packing team leader	o
468	paediatric allergist and immunologist	s
469	paediatric cardiologist	s
470	paediatric emergency physician	s
471	paediatric endocrinologist	s
472	paediatric haematologist	s
473	paediatrician	s
474	paediatrician - behaviour	o
475	paediatrician - general	o
476	paediatric infectious diseases physician	s
477	paediatric nephrologist	s
478	paediatric neurologist	s
479	paediatric nuclear medicine physician	s
480	paediatric oncologist	s
481	paediatric palliative care physician	s
482	paediatric physiotherapist	o
483	paediatric registrar	g
484	paediatric respiratory physician	s
485	paediatric rheumatologist	s
486	paediatric surgeon	s
487	paediatric surgical registrar	g
488	paediatric urologist	s
489	pain medicine registrar	g
490	pain physician	s
491	painter	o
492	paint tinter	o
493	palliative care physician	s
494	palliative care registrar	g
495	panel beater	o
496	pantry maid	o
497	paramedic	o
498	part time careers advisor	o
499	part time cleaner	o
500	part time clerical assistant	o
501	part time office worker	o
502	part time teacher	o
503	pastoral carer	o
504	pastry cook	o
505	pathologist	s
506	pathology registrar	g
507	pathology technician	o
508	pensioner	o
509	personal assistant	o
510	personal trainer	o
511	personel officer	o
512	pest controller	o
513	pharmaceutical representative	o
514	pharmacist	o
515	pharmacy assistant	o
516	phlebolgist	o
517	phone system installation	o
518	photographer	o
519	photo shop assistant	o
520	photo studio manager	o
521	physical education teacher	o
522	physician	s
523	physician & allergist	s
524	physician - breast	s
525	physician - general	s
526	physician - infectious disease	s
527	physician - musculoskeletal	s
528	physician - renal	s
529	physicians aide	o
530	physiotherapist	o
531	physiotherapy aid	o
532	plant fitter	o
533	plant mechanic	o
534	plant operator	o
535	plasterer	o
536	plastic, reconstructive & hand surgeon	s
537	plastics registrar	g
538	plastic surgeon	s
539	plumber	o
540	podiatrist	o
541	poker machine clerk	o
542	police officer	o
543	pool builder	o
544	pool inspector	o
545	postal delivery officer	o
546	postal worker	o
547	post office	o
548	post office licensee	o
549	poultry farmer	o
550	practice manager	o
551	pre-school teacher	o
552	pricing clerk	o
553	primary school teacher	o
554	prime minister	o
555	principal research engineer	o
556	printer	o
557	printing machinist	o
558	prison officer	o
559	private secretary	o
560	process worker	o
561	production operator	o
562	production shift foreman	o
563	product manager	o
564	professional fisherman	o
565	professor engineering	o
566	project manager	o
567	project officer	o
568	property manager	o
569	prospector	o
570	psychiatric nurse	o
571	psychiatrist	s
572	psychiatry registrar	g
573	psychogeriatrician	s
574	psychogeriatric registrar	g
575	psychologist	o
576	public health physician	s
577	public health registrar	g
578	public servant	o
579	purchasing officer	o
580	radiation oncologist	s
581	radiation oncology registrar	g
582	radiologist	s
583	radiology registrar	g
584	radio operator	o
585	rail worker	o
586	real estate agent	o
587	real estate valuer	o
588	receptionist	o
589	recycler	o
590	regional manager	o
591	registered nurse	o
592	registered psychologist	o
593	registrar	g
594	registrar - neurosurgery	g
595	rehabilitation consultant	o
596	rehabilitation medicine physician	s
597	rehabilitation paediatrician	s
598	rehabilitation registrar	g
599	rehabilitation specialist	o
600	renal registrar	g
601	representative	o
602	research co-ordinator	o
603	residential home worker	o
604	resident medical officer	g
605	respiratory physician	s
606	respiratory registrar	g
607	respiratory & sleep physician	s
608	restaurant worker	o
609	retail	o
610	retail sales	o
611	retired	o
612	return to work co-ordinator	o
613	rheumatologist	s
614	rheumatology clinical nurse specialist	o
615	rheumatology registrar	g
616	rigger	o
617	risk management consultant	o
618	road builder	o
619	rocket scientist	o
620	roofer	o
621	roof plumber	o
622	roof tiler	o
623	safety trainer	o
624	sailor	o
625	sales and service co-ordinator	o
626	sales assistant	o
627	sales consultant	o
628	salesman	o
629	sales manager	o
630	salesperson	o
631	sales representative	o
632	sandblaster	o
633	scaffolder	o
634	school administrator	o
635	school assistant	o
636	school cleaner	o
637	school counsellor	o
638	school crossing supervisor	o
639	school learning support officer	o
640	school principal	o
641	school teacher	o
642	seamstress	o
643	secretarial	o
644	secretary	o
645	secretary - legal	o
646	section manageress	o
647	security consultant	o
648	security guard	o
649	security technician	o
650	self employed	o
651	self employed consultant	o
652	self empoyed wholesaler	o
653	senior firefighter	o
654	sergeant of police	o
655	service assistant	o
656	service supervisor	o
657	service technician	o
658	sex therapist	o
659	sexual health physician	s
660	sexual health registrar	g
661	sex worker	o
662	shearer	o
663	sheep drover	o
664	sheet metal worker	o
665	sherriff's officer	o
666	shift co-ordinator	o
667	shift manager	o
668	shipping clerk	o
669	shop assistant	o
670	shop manager	o
671	shop owner	o
672	shop security	o
673	shorthand typist	o
674	shoulder physician	s
675	sign writer	o
676	singer	o
677	site coordinator	o
678	small business	o
679	social welfare	o
680	software systems engineer	o
681	soldier	o
682	sole parent pensioner	o
683	solicitor	o
684	solicitor's clerk	o
685	sound technician	o
686	spare parts supervisor	o
687	special education teacher	o
688	spectum manager	o
689	speech pathologist	o
690	speech therapist	o
691	spinal & orthopaedic surgeon	s
692	sports medicine registrar	g
693	sports physician	s
694	staff manager	o
695	staff specialist diabetic clinic	s
696	stage manager	o
697	steel bending	o
698	steel fixer	o
699	steel worker	o
700	stevadore	o
701	storeman	o
702	store manager	o
703	storeman - driver	o
704	storeperson	o
705	strip club dancer	o
706	student	o
707	student actor	o
708	student - ain	o
709	student - high school	o
710	supermarket manager	o
711	supervisor	o
712	support learning officer	o
713	support services officer	o
714	support worker	o
715	surgeon	s
716	surgeon - breast	s
717	surgeon - thoracic	s
718	surgical registrar	g
719	surveyor	o
720	swimming instructor	o
721	systems trainer	o
722	tab agent	o
723	tafe teacher	o
724	tafe teacher - science	o
725	tailor	o
726	talley clerk	o
727	tanker driver	o
728	taxation office investigator	o
729	taxi driver	o
730	taxi operator	o
731	teacher	o
732	teacher - adult education	o
733	teacher - headmaster	o
734	teacher - high school	o
735	teacher - high school special ed	o
736	teacher - kindergarten	o
737	teacher - librarian	o
738	teacher - mathematics	o
739	teacher - nursing	o
740	teacher - pre-school	o
741	teacher - primary school	o
742	teacher - principal	o
743	teacher - tafe	o
744	teacher - trades	o
745	technical assistant	o
746	technical officer	o
747	telemarketing	o
748	telephonist	o
749	telstra fault operator	o
750	telstra - technician	o
751	tennis coach	o
752	territory manager	o
753	testing technician	o
754	tiler	o
755	tool maker	o
756	town planner	o
757	tow truck driver	o
758	toy maker	o
759	trade assistant	o
760	traffic facilitator	o
761	train controller	o
762	train driver	o
763	trainee telecommunications	o
764	trainee train driver	o
765	trainer advisor	o
766	trainer racehorse	o
767	training officer	o
768	transplant surgeon	s
769	tree surgeon	o
770	truck driver	o
771	truck driver/operator	o
772	tunnel borer	o
773	tutor	o
774	tyre fitter	o
775	tyre retailer	o
776	undermanager	o
777	unemployed	o
778	union official	o
779	university lecturer	o
780	university professor	o
781	unknown	o
782	urogynaecologist	s
783	urological surgeon	o
784	urologist	s
785	urologist & transplant surgeon	o
786	urology registrar	g
787	uro-oncologist	o
788	vascular & endovascular surgeon	s
789	vascular registrar	g
790	vascular surgeon	s
791	veterinary nurse	o
792	waitress	o
793	ward clerk	o
794	wardsman	o
795	wardsperson	o
796	water proofer	o
797	waterside worker	o
798	welder	o
799	welfare worker	o
800	wholesaler	o
801	window dresser	o
802	wire worker	o
803	workcover assessor	o
804	work place trainer	o
805	workshop manager	o
806	writer	o
807	yacht captain	o
808	youth worker	o
\.


--
-- TOC entry 4418 (class 0 OID 0)
-- Dependencies: 978
-- Name: lu_occupations_temp_pk_seq; Type: SEQUENCE SET; Schema: common; Owner: -
--

SELECT pg_catalog.setval('lu_occupations_temp_pk_seq', 808, true);


--
-- TOC entry 4410 (class 2606 OID 1287099)
-- Dependencies: 979 979 4414
-- Name: lu_occupations_temp_pkey; Type: CONSTRAINT; Schema: common; Owner: -; Tablespace: 
--

ALTER TABLE ONLY lu_occupations_temp
    ADD CONSTRAINT lu_occupations_temp_pkey PRIMARY KEY (pk);


-- Completed on 2013-07-29 20:44:30 EST

--
-- PostgreSQL database dump complete
--

alter table common.lu_occupations_temp owner to easygp;
grant all on table common.lu_occupations_temp to staff;

truncate db.lu_version;
insert into db.lu_version (lu_major,lu_minor) values (0, 308);

