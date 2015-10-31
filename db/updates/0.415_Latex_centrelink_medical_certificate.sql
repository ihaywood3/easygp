-- Insert a LaTEx template into the test templates table for a centrelink medical certificate: SU4151312 Oct 2015
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.9
-- Dumped by pg_dump version 9.3.9
-- Started on 2015-09-29 14:41:54 AEST

SET statement_timeout = 0;
--SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = admin, pg_catalog;

--
-- TOC entry 4878 (class 0 OID 1135114)
-- Dependencies: 1101
-- Data for Name: test_latex_templates; Type: TABLE DATA; Schema: admin; Owner: -
--

INSERT INTO test_latex_templates VALUES (1, 'centrelink medical certificate', '\documentclass[a4paper,12pt]{article}
\usepackage{graphicx}
\usepackage {picture}
\setlength\parindent{0pt}\setlength\unitlength{1mm}
\setlength{\hoffset}{-!print-offset-horizontal}
\setlength{\voffset}{-!print-offset-vertical}
\setlength{\parindent}{0pt}
\setlength{\textwidth}{210mm}
\setlength{\textheight}{295mm}
\DeclareRobustCommand{\text}[4]{\put(#1,-#2){ \parbox[t]{#3 mm}{#4}}}
\begin{document}
\begin{picture} (210,295)(0,-295)
%The patients name and address and how long have attended doctor or practice
\text{32}{35}{65}{\footnotesize Patient}
\text{32}{41}{65}{\footnotesize Peter}
\text{32}{55}{25}{\footnotesize 08/04/1921}
\text{132}{35}{65}{\footnotesize 4 Some Close}
\text{132}{46}{45}{\footnotesize SOMEWHERE}
\text{184}{46}{20}{\footnotesize 1010}
\text{189}{54}{10}{\footnotesize 1992}
\text{189}{61}{10}{\footnotesize 1993}
%Date of onset primary and none for secondary conditions (included on the condition 
%line as there can be multiple on this line
\text{60}{100}{5}{\footnotesize 09}
\text{67}{100}{5}{\footnotesize 2009}
%the primary and secondary diagnoses
\text{13}{81}{100}{\footnotesize Metastatic Carcinoma bowel}
\text{112}{81}{160}{\footnotesize Ankle fusion with poor mobility onset 2006}
\text{112}{87}{160}{\footnotesize \relax}
\text{112}{93}{160}{\footnotesize \relax}
%Whethere the condition is tempory, permanant or exacerbation
\text{24}{108.5}{10}{\footnotesize X}
\text{56}{108.5}{10}{\footnotesize X}
\text{95}{108.5}{10}{\footnotesize X}
\text{124}{108.5}{10}{\footnotesize X}
\text{155}{108.5}{10}{\footnotesize X}
\text{194}{108.5}{10}{\footnotesize X}
% The checkboxes to due with expected duration of symptoms affecting work or study
\text{35}{127}{10}{\footnotesize X}
\text{72}{127}{10}{\footnotesize X}
\text{94}{127}{10}{\footnotesize X}
\text{35}{132}{10}{\footnotesize X}
\text{72}{132}{10}{\footnotesize X}
\text{134}{127}{10}{\footnotesize X}
\text{171}{127}{10}{\footnotesize X}
\text{194}{127}{10}{\footnotesize X}
\text{134}{132}{10}{\footnotesize X}
\text{171}{132}{10}{\footnotesize X}
%The symptoms and treatment for the primary condition
\text{11}{145}{84}{\footnotesize primary symptoms - abdominal pain, breathlessness, weight loss, peripheral oedema abdominal distentsion}
\text{22}{166}{75}{\footnotesize bowel resection}
\text{22}{172}{75}{\footnotesize chemotherapy}
\text{22}{183}{75}{\footnotesize chemotherapy and palliative care}
%The symptoms and treatment for the secondary condition
\text{110}{145}{84}{ \footnotesize difficulty walking because of pain}
\text{122}{166}{75}{\footnotesize foot fusion}
\text{122}{172}{75}{\footnotesize analgesia}
\text{122}{183}{75}{\footnotesize nil}
%Other impacting medical conditions and factors
\text{11}{197}{85}{ \footnotesize depression}
\text{11}{260}{85}{\footnotesize socially disadvantaged}
%Dates of unfitness
\text{17}{223}{5}{\footnotesize 01}
\text{27}{223}{5}{\footnotesize 01}
\text{35}{223}{5}{\footnotesize 2015}
\text{57}{223}{5}{\footnotesize 20}
\text{67}{223}{5}{\footnotesize 01}
\text{75}{223}{5}{\footnotesize 2015}
%Ability to do usual or other work
\text{14}{232.5}{5}{\footnotesize X}
\text{25}{232.5}{5}{\footnotesize X}
\text{14}{242.5}{5}{\footnotesize X}
\text{25}{242.5}{5}{\footnotesize X}
%Practitioner and Practice Details
\text{140}{195}{55}{\footnotesize Dr Best Doctor}
\text{178}{201}{10}{\footnotesize 458332T}
\text{137}{208}{55}{\footnotesize Very Best Medical Centre }
\text{120}{215}{75}{\footnotesize 141 Any Rd}
\text{120}{226}{43}{\footnotesize ANYTOWN}
\text{177}{226}{15}{\footnotesize 1000}
\text{155}{233}{40}{\footnotesize 02 1111111}
\text{119}{249}{5}{\footnotesize 29}
\text{128}{249}{5}{\footnotesize 09}
\text{137}{249}{5}{\footnotesize 2015}
\end {picture}
\end{document}', false, -35.0, -38.5);


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 1100
-- Name: test_latex_templates_pk_seq; Type: SEQUENCE SET; Schema: admin; Owner: -
--

SELECT pg_catalog.setval('test_latex_templates_pk_seq', 1, true);


-- Completed on 2015-09-29 14:41:55 AEST

--
-- PostgreSQL database dump complete
--

update db.lu_version set lu_minor=415;
