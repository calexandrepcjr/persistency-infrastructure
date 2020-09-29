--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.4

-- Started on 2020-09-28 23:24:52 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 641 (class 1247 OID 16420)
-- Name: endereco_completo; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.endereco_completo AS (
	cep integer,
	logradouro character varying(255),
	complemento character varying(255),
	tipo character varying(255),
	numero integer,
	cidade character varying(255),
	bairro character varying(255),
	estado character varying(255)
);


ALTER TYPE public.endereco_completo OWNER TO admin;

--
-- TOC entry 638 (class 1247 OID 16417)
-- Name: nome_completo; Type: TYPE; Schema: public; Owner: admin
--

CREATE TYPE public.nome_completo AS (
	"primeiroNome" character varying(255),
	"nomeIntermediario" character varying(255),
	sobrenome character varying(255)
);


ALTER TYPE public.nome_completo OWNER TO admin;

--
-- TOC entry 215 (class 1255 OID 16407)
-- Name: calc_idade(date); Type: FUNCTION; Schema: public; Owner: admin
--

CREATE FUNCTION public.calc_idade(ano_nascimento date) RETURNS integer
    LANGUAGE plpgsql IMMUTABLE
    AS $$
BEGIN
    RETURN extract( year FROM CURRENT_DATE )
           - extract( year FROM ano_nascimento )
           + 1;
END
$$;


ALTER FUNCTION public.calc_idade(ano_nascimento date) OWNER TO admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 202 (class 1259 OID 16395)
-- Name: Aluno; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Aluno" (
    cpf integer NOT NULL,
    rg integer NOT NULL,
    "dataNascimento" date NOT NULL,
    telefone character varying[] NOT NULL,
    idade integer GENERATED ALWAYS AS (public.calc_idade("dataNascimento")) STORED NOT NULL,
    nome public.nome_completo NOT NULL,
    endereco public.endereco_completo NOT NULL,
    numero integer NOT NULL
);


ALTER TABLE public."Aluno" OWNER TO admin;

--
-- TOC entry 206 (class 1259 OID 16423)
-- Name: Curso; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Curso" (
    id integer NOT NULL,
    nome character varying NOT NULL,
    sigla character varying NOT NULL,
    site character varying NOT NULL,
    telefone integer NOT NULL,
    departamento character varying NOT NULL
);


ALTER TABLE public."Curso" OWNER TO admin;

--
-- TOC entry 205 (class 1259 OID 16421)
-- Name: Curso_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Curso_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Curso_id_seq" OWNER TO admin;

--
-- TOC entry 3048 (class 0 OID 0)
-- Dependencies: 205
-- Name: Curso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Curso_id_seq" OWNED BY public."Curso".id;


--
-- TOC entry 214 (class 1259 OID 16539)
-- Name: CursosRealizados; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."CursosRealizados" (
    aluno integer NOT NULL,
    curso integer NOT NULL
);


ALTER TABLE public."CursosRealizados" OWNER TO admin;

--
-- TOC entry 209 (class 1259 OID 16445)
-- Name: Departamento; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Departamento" (
    codigo character varying NOT NULL,
    nome character varying NOT NULL,
    sigla character varying NOT NULL,
    email character varying NOT NULL,
    telefone character varying NOT NULL
);


ALTER TABLE public."Departamento" OWNER TO admin;

--
-- TOC entry 208 (class 1259 OID 16436)
-- Name: Disciplina; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."Disciplina" (
    id integer NOT NULL,
    nome character varying NOT NULL,
    sigla character varying NOT NULL,
    programa character varying NOT NULL,
    ementa character varying NOT NULL,
    bibliografia text NOT NULL,
    carga_horaria integer NOT NULL
);


ALTER TABLE public."Disciplina" OWNER TO admin;

--
-- TOC entry 207 (class 1259 OID 16434)
-- Name: Disciplina_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public."Disciplina_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Disciplina_id_seq" OWNER TO admin;

--
-- TOC entry 3049 (class 0 OID 0)
-- Dependencies: 207
-- Name: Disciplina_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public."Disciplina_id_seq" OWNED BY public."Disciplina".id;


--
-- TOC entry 212 (class 1259 OID 16509)
-- Name: DisciplinasConcluidas; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."DisciplinasConcluidas" (
    aluno integer NOT NULL,
    disciplina integer NOT NULL
);


ALTER TABLE public."DisciplinasConcluidas" OWNER TO admin;

--
-- TOC entry 211 (class 1259 OID 16479)
-- Name: DisciplinasCurso; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."DisciplinasCurso" (
    tipo character varying NOT NULL,
    disciplina integer NOT NULL,
    curso integer NOT NULL
);


ALTER TABLE public."DisciplinasCurso" OWNER TO admin;

--
-- TOC entry 213 (class 1259 OID 16524)
-- Name: MatriculadosDisciplina; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."MatriculadosDisciplina" (
    aluno integer NOT NULL,
    disciplina integer NOT NULL
);


ALTER TABLE public."MatriculadosDisciplina" OWNER TO admin;

--
-- TOC entry 210 (class 1259 OID 16459)
-- Name: PrerequisitoDisciplina; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public."PrerequisitoDisciplina" (
    disciplina_prerequisito integer NOT NULL,
    disciplina integer NOT NULL
);


ALTER TABLE public."PrerequisitoDisciplina" OWNER TO admin;

--
-- TOC entry 2873 (class 2604 OID 16426)
-- Name: Curso id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Curso" ALTER COLUMN id SET DEFAULT nextval('public."Curso_id_seq"'::regclass);


--
-- TOC entry 2874 (class 2604 OID 16439)
-- Name: Disciplina id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Disciplina" ALTER COLUMN id SET DEFAULT nextval('public."Disciplina_id_seq"'::regclass);


--
-- TOC entry 3032 (class 0 OID 16395)
-- Dependencies: 202
-- Data for Name: Aluno; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Aluno" (cpf, rg, "dataNascimento", telefone, nome, endereco, numero) FROM stdin;
\.


--
-- TOC entry 3034 (class 0 OID 16423)
-- Dependencies: 206
-- Data for Name: Curso; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Curso" (id, nome, sigla, site, telefone, departamento) FROM stdin;
\.


--
-- TOC entry 3042 (class 0 OID 16539)
-- Dependencies: 214
-- Data for Name: CursosRealizados; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."CursosRealizados" (aluno, curso) FROM stdin;
\.


--
-- TOC entry 3037 (class 0 OID 16445)
-- Dependencies: 209
-- Data for Name: Departamento; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Departamento" (codigo, nome, sigla, email, telefone) FROM stdin;
\.


--
-- TOC entry 3036 (class 0 OID 16436)
-- Dependencies: 208
-- Data for Name: Disciplina; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."Disciplina" (id, nome, sigla, programa, ementa, bibliografia, carga_horaria) FROM stdin;
\.


--
-- TOC entry 3040 (class 0 OID 16509)
-- Dependencies: 212
-- Data for Name: DisciplinasConcluidas; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."DisciplinasConcluidas" (aluno, disciplina) FROM stdin;
\.


--
-- TOC entry 3039 (class 0 OID 16479)
-- Dependencies: 211
-- Data for Name: DisciplinasCurso; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."DisciplinasCurso" (tipo, disciplina, curso) FROM stdin;
\.


--
-- TOC entry 3041 (class 0 OID 16524)
-- Dependencies: 213
-- Data for Name: MatriculadosDisciplina; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."MatriculadosDisciplina" (aluno, disciplina) FROM stdin;
\.


--
-- TOC entry 3038 (class 0 OID 16459)
-- Dependencies: 210
-- Data for Name: PrerequisitoDisciplina; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public."PrerequisitoDisciplina" (disciplina_prerequisito, disciplina) FROM stdin;
\.


--
-- TOC entry 3050 (class 0 OID 0)
-- Dependencies: 205
-- Name: Curso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Curso_id_seq"', 1, false);


--
-- TOC entry 3051 (class 0 OID 0)
-- Dependencies: 207
-- Name: Disciplina_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public."Disciplina_id_seq"', 1, false);


--
-- TOC entry 2876 (class 2606 OID 16433)
-- Name: Aluno Aluno_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Aluno"
    ADD CONSTRAINT "Aluno_pkey" PRIMARY KEY (numero, cpf);


--
-- TOC entry 2880 (class 2606 OID 16431)
-- Name: Curso Curso_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Curso"
    ADD CONSTRAINT "Curso_pkey" PRIMARY KEY (id);


--
-- TOC entry 2894 (class 2606 OID 16543)
-- Name: CursosRealizados CursosRealizados_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."CursosRealizados"
    ADD CONSTRAINT "CursosRealizados_pkey" PRIMARY KEY (curso, aluno);


--
-- TOC entry 2884 (class 2606 OID 16452)
-- Name: Departamento Departamento_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Departamento"
    ADD CONSTRAINT "Departamento_pkey" PRIMARY KEY (codigo);


--
-- TOC entry 2882 (class 2606 OID 16444)
-- Name: Disciplina Disciplina_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Disciplina"
    ADD CONSTRAINT "Disciplina_pkey" PRIMARY KEY (id);


--
-- TOC entry 2890 (class 2606 OID 16513)
-- Name: DisciplinasConcluidas DisciplinasConcluidas_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."DisciplinasConcluidas"
    ADD CONSTRAINT "DisciplinasConcluidas_pkey" PRIMARY KEY (disciplina, aluno);


--
-- TOC entry 2888 (class 2606 OID 16486)
-- Name: DisciplinasCurso DisciplinasCurso_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."DisciplinasCurso"
    ADD CONSTRAINT "DisciplinasCurso_pkey" PRIMARY KEY (curso, disciplina);


--
-- TOC entry 2892 (class 2606 OID 16528)
-- Name: MatriculadosDisciplina MatriculadosDisciplina_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."MatriculadosDisciplina"
    ADD CONSTRAINT "MatriculadosDisciplina_pkey" PRIMARY KEY (disciplina, aluno);


--
-- TOC entry 2886 (class 2606 OID 16473)
-- Name: PrerequisitoDisciplina PrerequisitoDisciplina_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."PrerequisitoDisciplina"
    ADD CONSTRAINT "PrerequisitoDisciplina_pkey" PRIMARY KEY (disciplina_prerequisito, disciplina);


--
-- TOC entry 2878 (class 2606 OID 16508)
-- Name: Aluno UNIQUE_aluno; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Aluno"
    ADD CONSTRAINT "UNIQUE_aluno" UNIQUE (numero);


--
-- TOC entry 2900 (class 2606 OID 16514)
-- Name: DisciplinasConcluidas FK_Aluno; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."DisciplinasConcluidas"
    ADD CONSTRAINT "FK_Aluno" FOREIGN KEY (aluno) REFERENCES public."Aluno"(numero);


--
-- TOC entry 2902 (class 2606 OID 16529)
-- Name: MatriculadosDisciplina FK_Aluno; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."MatriculadosDisciplina"
    ADD CONSTRAINT "FK_Aluno" FOREIGN KEY (aluno) REFERENCES public."Aluno"(numero) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2904 (class 2606 OID 16544)
-- Name: CursosRealizados FK_Aluno; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."CursosRealizados"
    ADD CONSTRAINT "FK_Aluno" FOREIGN KEY (aluno) REFERENCES public."Aluno"(numero) ON DELETE CASCADE;


--
-- TOC entry 2899 (class 2606 OID 16492)
-- Name: DisciplinasCurso FK_Curso; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."DisciplinasCurso"
    ADD CONSTRAINT "FK_Curso" FOREIGN KEY (curso) REFERENCES public."Curso"(id) ON DELETE CASCADE;


--
-- TOC entry 2905 (class 2606 OID 16549)
-- Name: CursosRealizados FK_Curso; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."CursosRealizados"
    ADD CONSTRAINT "FK_Curso" FOREIGN KEY (curso) REFERENCES public."Curso"(id) ON DELETE CASCADE;


--
-- TOC entry 2895 (class 2606 OID 16497)
-- Name: Curso FK_Departamento; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."Curso"
    ADD CONSTRAINT "FK_Departamento" FOREIGN KEY (departamento) REFERENCES public."Departamento"(codigo) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;


--
-- TOC entry 2896 (class 2606 OID 16462)
-- Name: PrerequisitoDisciplina FK_Disciplina; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."PrerequisitoDisciplina"
    ADD CONSTRAINT "FK_Disciplina" FOREIGN KEY (disciplina) REFERENCES public."Disciplina"(id) NOT VALID;


--
-- TOC entry 2898 (class 2606 OID 16487)
-- Name: DisciplinasCurso FK_Disciplina; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."DisciplinasCurso"
    ADD CONSTRAINT "FK_Disciplina" FOREIGN KEY (disciplina) REFERENCES public."Disciplina"(id) ON DELETE CASCADE;


--
-- TOC entry 2901 (class 2606 OID 16519)
-- Name: DisciplinasConcluidas FK_Disciplina; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."DisciplinasConcluidas"
    ADD CONSTRAINT "FK_Disciplina" FOREIGN KEY (disciplina) REFERENCES public."Disciplina"(id);


--
-- TOC entry 2903 (class 2606 OID 16534)
-- Name: MatriculadosDisciplina FK_Disciplina; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."MatriculadosDisciplina"
    ADD CONSTRAINT "FK_Disciplina" FOREIGN KEY (disciplina) REFERENCES public."Disciplina"(id) ON DELETE CASCADE;


--
-- TOC entry 2897 (class 2606 OID 16474)
-- Name: PrerequisitoDisciplina FK_Prerequisito; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public."PrerequisitoDisciplina"
    ADD CONSTRAINT "FK_Prerequisito" FOREIGN KEY (disciplina_prerequisito) REFERENCES public."Disciplina"(id) ON DELETE CASCADE NOT VALID;


-- Completed on 2020-09-28 23:24:52 -03

--
-- PostgreSQL database dump complete
--

