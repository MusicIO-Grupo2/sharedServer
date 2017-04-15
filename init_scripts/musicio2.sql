--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Album; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Album" (
    "AlbumID" bigint NOT NULL,
    "Nombre" character varying(100) NOT NULL,
    "FechaLanzamiento" date,
    "Activo" boolean DEFAULT true
);


ALTER TABLE "Album" OWNER TO postgres;

--
-- Name: TABLE "Album"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Album" IS 'Tabla para albumes';


--
-- Name: AlbumCancion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "AlbumCancion" (
    "AlbumID" bigint NOT NULL,
    "CancionID" bigint NOT NULL
);


ALTER TABLE "AlbumCancion" OWNER TO postgres;

--
-- Name: TABLE "AlbumCancion"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "AlbumCancion" IS 'Tabla de canciones que estan para un album.';


--
-- Name: Album_AlbumID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Album_AlbumID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Album_AlbumID_seq" OWNER TO postgres;

--
-- Name: Album_AlbumID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Album_AlbumID_seq" OWNED BY "Album"."AlbumID";


--
-- Name: Artista; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Artista" (
    "ArtistaID" bigint NOT NULL,
    "Nombre" character varying(100),
    "Apellido" character varying(100),
    "Edad" smallint,
    "Activo" boolean DEFAULT true NOT NULL
);


ALTER TABLE "Artista" OWNER TO postgres;

--
-- Name: TABLE "Artista"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Artista" IS 'Tabla para datos de Artistas';


--
-- Name: ArtistaCancion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ArtistaCancion" (
    "ArtistaID" bigint NOT NULL,
    "CancionID" bigint NOT NULL
);


ALTER TABLE "ArtistaCancion" OWNER TO postgres;

--
-- Name: TABLE "ArtistaCancion"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "ArtistaCancion" IS 'Tabla para los artistas que compusieron las canciones.';


--
-- Name: ArtistaUser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ArtistaUser" (
    "ArtistaID" bigint NOT NULL,
    "UserID" bigint NOT NULL
);


ALTER TABLE "ArtistaUser" OWNER TO postgres;

--
-- Name: TABLE "ArtistaUser"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "ArtistaUser" IS 'Artistas seguidos por el UserID. Borrado fisico on delete.';


--
-- Name: Artista_ArtistaID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Artista_ArtistaID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Artista_ArtistaID_seq" OWNER TO postgres;

--
-- Name: Artista_ArtistaID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Artista_ArtistaID_seq" OWNED BY "Artista"."ArtistaID";


--
-- Name: Cancion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Cancion" (
    "CancionID" bigint NOT NULL,
    "Nombre" character varying(100) NOT NULL,
    "Descripcion" character varying(500),
    "Activo" boolean DEFAULT true NOT NULL
);


ALTER TABLE "Cancion" OWNER TO postgres;

--
-- Name: TABLE "Cancion"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Cancion" IS 'Tabla para canciones';


--
-- Name: Cancion_CancionID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Cancion_CancionID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Cancion_CancionID_seq" OWNER TO postgres;

--
-- Name: Cancion_CancionID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Cancion_CancionID_seq" OWNED BY "Cancion"."CancionID";


--
-- Name: Contacto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Contacto" (
    "UserID" bigint NOT NULL,
    "ContactoID" bigint NOT NULL,
    "Activo" boolean DEFAULT true NOT NULL
);


ALTER TABLE "Contacto" OWNER TO postgres;

--
-- Name: TABLE "Contacto"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Contacto" IS 'Tabla de contactos para un usuario dado.';


--
-- Name: Genero; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Genero" (
    "GeneroID" bigint NOT NULL,
    "Descripcion" character varying(100) NOT NULL,
    "Activo" boolean DEFAULT true NOT NULL
);


ALTER TABLE "Genero" OWNER TO postgres;

--
-- Name: TABLE "Genero"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Genero" IS 'Tabla para generos musicales.';


--
-- Name: GeneroAlbum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "GeneroAlbum" (
    "AlbumID" bigint NOT NULL,
    "GeneroID" bigint NOT NULL
);


ALTER TABLE "GeneroAlbum" OWNER TO postgres;

--
-- Name: TABLE "GeneroAlbum"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "GeneroAlbum" IS 'Tabla para generos de un album. Borrado fisico on delete.';


--
-- Name: GeneroArtista; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "GeneroArtista" (
    "ArtistaID" bigint NOT NULL,
    "GeneroID" bigint NOT NULL
);


ALTER TABLE "GeneroArtista" OWNER TO postgres;

--
-- Name: TABLE "GeneroArtista"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "GeneroArtista" IS 'Tabla para generos de un artista. Borrado fisico on delete.';


--
-- Name: GeneroCancion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "GeneroCancion" (
    "CancionID" bigint NOT NULL,
    "GeneroID" bigint NOT NULL
);


ALTER TABLE "GeneroCancion" OWNER TO postgres;

--
-- Name: TABLE "GeneroCancion"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "GeneroCancion" IS 'Tabla para generos de la cancion. Borrado fisico on delete.';


--
-- Name: Genero_GeneroID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Genero_GeneroID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Genero_GeneroID_seq" OWNER TO postgres;

--
-- Name: Genero_GeneroID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Genero_GeneroID_seq" OWNED BY "Genero"."GeneroID";


--
-- Name: MarcaCancion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "MarcaCancion" (
    "UserID" bigint NOT NULL,
    "CancionID" bigint NOT NULL
);


ALTER TABLE "MarcaCancion" OWNER TO postgres;

--
-- Name: TABLE "MarcaCancion"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "MarcaCancion" IS 'Tabla con marcas de canciones por los usuario (like). Borrado fisico on delete.';


--
-- Name: Playlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Playlist" (
    "PlaylistID" bigint NOT NULL,
    "Nombre" character varying(100) NOT NULL,
    "UserCreacion" bigint NOT NULL,
    "Activo" boolean DEFAULT true NOT NULL
);


ALTER TABLE "Playlist" OWNER TO postgres;

--
-- Name: TABLE "Playlist"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Playlist" IS 'Tabla para datos de playlist';


--
-- Name: PlaylistAlbum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PlaylistAlbum" (
    "PlaylistID" bigint NOT NULL,
    "AlbumID" bigint NOT NULL
);


ALTER TABLE "PlaylistAlbum" OWNER TO postgres;

--
-- Name: TABLE "PlaylistAlbum"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "PlaylistAlbum" IS 'Tabla de relacion de playlist y album. Borrado fisico on delete.';


--
-- Name: PlaylistCancion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PlaylistCancion" (
    "PlaylistID" bigint NOT NULL,
    "CancionID" bigint NOT NULL
);


ALTER TABLE "PlaylistCancion" OWNER TO postgres;

--
-- Name: TABLE "PlaylistCancion"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "PlaylistCancion" IS 'Tabla relacional playlist cancion';


--
-- Name: Playlist_PlaylistID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Playlist_PlaylistID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Playlist_PlaylistID_seq" OWNER TO postgres;

--
-- Name: Playlist_PlaylistID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "Playlist_PlaylistID_seq" OWNED BY "Playlist"."PlaylistID";


--
-- Name: PuntuacionCancion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PuntuacionCancion" (
    "UserID" bigint NOT NULL,
    "CancionID" bigint NOT NULL,
    "Puntaje" smallint NOT NULL
);


ALTER TABLE "PuntuacionCancion" OWNER TO postgres;

--
-- Name: TABLE "PuntuacionCancion"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "PuntuacionCancion" IS 'Tabla de puntuacion de canciones.';


--
-- Name: ReproduccionCancion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ReproduccionCancion" (
    "CancionID" bigint NOT NULL,
    "UserID" bigint NOT NULL,
    "Fecha" date NOT NULL
);


ALTER TABLE "ReproduccionCancion" OWNER TO postgres;

--
-- Name: TABLE "ReproduccionCancion"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "ReproduccionCancion" IS 'Tabla con la reproduccion de las canciones por un usuario.';


--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE "SequelizeMeta" OWNER TO postgres;

--
-- Name: Users_UserID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "Users_UserID_seq"
    START WITH 4
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "Users_UserID_seq" OWNER TO postgres;

--
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Users" (
    "UserID" bigint DEFAULT nextval('"Users_UserID_seq"'::regclass) NOT NULL,
    "Name" character varying(100),
    "LastName" character varying(100),
    "Email" character varying(100),
    "Passwd" character varying,
    "FechaNacimiento" date,
    "Activo" boolean DEFAULT false NOT NULL
);


ALTER TABLE "Users" OWNER TO postgres;

--
-- Name: Album AlbumID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Album" ALTER COLUMN "AlbumID" SET DEFAULT nextval('"Album_AlbumID_seq"'::regclass);


--
-- Name: Artista ArtistaID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Artista" ALTER COLUMN "ArtistaID" SET DEFAULT nextval('"Artista_ArtistaID_seq"'::regclass);


--
-- Name: Cancion CancionID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Cancion" ALTER COLUMN "CancionID" SET DEFAULT nextval('"Cancion_CancionID_seq"'::regclass);


--
-- Name: Genero GeneroID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Genero" ALTER COLUMN "GeneroID" SET DEFAULT nextval('"Genero_GeneroID_seq"'::regclass);


--
-- Name: Playlist PlaylistID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Playlist" ALTER COLUMN "PlaylistID" SET DEFAULT nextval('"Playlist_PlaylistID_seq"'::regclass);


--
-- Data for Name: Album; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Album" ("AlbumID", "Nombre", "FechaLanzamiento", "Activo") FROM stdin;
\.


--
-- Data for Name: AlbumCancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "AlbumCancion" ("AlbumID", "CancionID") FROM stdin;
\.


--
-- Name: Album_AlbumID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Album_AlbumID_seq"', 1, false);


--
-- Data for Name: Artista; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Artista" ("ArtistaID", "Nombre", "Apellido", "Edad", "Activo") FROM stdin;
\.


--
-- Data for Name: ArtistaCancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ArtistaCancion" ("ArtistaID", "CancionID") FROM stdin;
\.


--
-- Data for Name: ArtistaUser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ArtistaUser" ("ArtistaID", "UserID") FROM stdin;
\.


--
-- Name: Artista_ArtistaID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Artista_ArtistaID_seq"', 1, false);


--
-- Data for Name: Cancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Cancion" ("CancionID", "Nombre", "Descripcion", "Activo") FROM stdin;
\.


--
-- Name: Cancion_CancionID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Cancion_CancionID_seq"', 1, false);


--
-- Data for Name: Contacto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Contacto" ("UserID", "ContactoID", "Activo") FROM stdin;
\.


--
-- Data for Name: Genero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Genero" ("GeneroID", "Descripcion", "Activo") FROM stdin;
\.


--
-- Data for Name: GeneroAlbum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "GeneroAlbum" ("AlbumID", "GeneroID") FROM stdin;
\.


--
-- Data for Name: GeneroArtista; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "GeneroArtista" ("ArtistaID", "GeneroID") FROM stdin;
\.


--
-- Data for Name: GeneroCancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "GeneroCancion" ("CancionID", "GeneroID") FROM stdin;
\.


--
-- Name: Genero_GeneroID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Genero_GeneroID_seq"', 1, false);


--
-- Data for Name: MarcaCancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "MarcaCancion" ("UserID", "CancionID") FROM stdin;
\.


--
-- Data for Name: Playlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Playlist" ("PlaylistID", "Nombre", "UserCreacion", "Activo") FROM stdin;
\.


--
-- Data for Name: PlaylistAlbum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PlaylistAlbum" ("PlaylistID", "AlbumID") FROM stdin;
\.


--
-- Data for Name: PlaylistCancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PlaylistCancion" ("PlaylistID", "CancionID") FROM stdin;
\.


--
-- Name: Playlist_PlaylistID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Playlist_PlaylistID_seq"', 1, false);


--
-- Data for Name: PuntuacionCancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PuntuacionCancion" ("UserID", "CancionID", "Puntaje") FROM stdin;
\.


--
-- Data for Name: ReproduccionCancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ReproduccionCancion" ("CancionID", "UserID", "Fecha") FROM stdin;
\.


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "SequelizeMeta" (name) FROM stdin;
20170403005935-AddColumnFechaNacimiento.js
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Users" ("UserID", "Name", "LastName", "Email", "Passwd", "FechaNacimiento", "Activo") FROM stdin;
7	Marcos	Pernica	marcospernica@yahoo.com.ar	52iYoK8kb5830ff4773ae8bd4eca4585d458fa7ef	1991-01-01	t
8	Nicolas	Fernandez	nflabo@gmail.comr	U8UuVq7U!da0a1189708d3ec8814ab962331fbd49	1991-01-01	t
9	Nicolas	Alvarez	nicolasgalvarez91@gmail.com	SXTfXwugP1b4021919cdee8cf5a2bf0ed26df2fbd	1991-01-01	t
14	taller	taller	testtaller2@taller2.com	j78#VA!uV3872c24d6ca429d698e354dab900b44d	1991-01-01	f
51	taller	taller	testtaller2@taller2.com	O4d2LnOgW2a13d03e9a9ba3e4931b4527610bcda5	1991-01-01	f
39	taller	taller	testtaller2@taller2.com	VUpsKdz7Nd6d5d7352d8bc3db97c320483beb4cea	1991-01-01	f
15	taller	taller	testtaller2@taller2.com	NS3zebC3h055178bdaf68a775722eec08b821dbad	1991-01-01	f
25	taller	taller	testtaller2@taller2.com	8nwB!8cdNf6d211bd7a60b186f227190cb7fc063b	1991-01-01	f
16	taller	taller	testtaller2@taller2.com	aa3krjVUb9d2d193fae1e7a38efac070e1c8ae518	1991-01-01	f
33	taller	taller	testtaller2@taller2.com	ZfU2E1Euf0472963380c015316f851c3d1f29b2e3	1991-01-01	f
44	taller	taller	testtaller2@taller2.com	TC9r662Uae5172a2288e49044ad953f3987749d8d	1991-01-01	f
17	taller	taller	testtaller2@taller2.com	M1hhbgatE634e001b39eb62822f129be65036b54a	1991-01-01	f
26	taller	taller	testtaller2@taller2.com	ow0XNo3ut89919ab495417b22442c115d2f84f22b	1991-01-01	f
18	taller	taller	testtaller2@taller2.com	FAwdhf72w5f990c893628749abe69ae07135f25bc	1991-01-01	f
48	taller	taller	testtaller2@taller2.com	GPjKrYoHy751a4afcbaa6e66a93b1e2548bfa2044	1991-01-01	f
34	taller	taller	testtaller2@taller2.com	0PaH68aPm18bafcdc4a7af8bf4353dcf4b7dc4f09	1991-01-01	f
27	taller	taller	testtaller2@taller2.com	e0Nc.DQNPafb53c5c19ec36f8afd513a6f5bce67e	1991-01-01	f
19	taller	taller	testtaller2@taller2.com	62kkZhUNR8e9da6fc87e687c8ac7d244774217926	1991-01-01	f
40	taller	taller	testtaller2@taller2.com	74ylwIFAU420a4aefe6cb9df770e4b8ce9f4e0c90	1991-01-01	f
20	taller	taller	testtaller2@taller2.com	v3RYpo6bWe488af558a2b785a70b8441b3384a13f	1991-01-01	f
28	taller	taller	testtaller2@taller2.com	QUzgnosdIa880bf9cb156d5423b0f7036d7e8fd29	1991-01-01	f
21	taller	taller	testtaller2@taller2.com	.FKR7Oc7nfde999440dae415ce2154a48d1109c83	1991-01-01	f
12	taller	taller	testtaller2@taller2.com	9hvcwJ6CMde95f3b2d4edabc87af9f3703b16e3b9	1991-01-01	f
35	taller	taller	testtaller2@taller2.com	ED5.5leDB21fd2dcdc3be89fd0087a6e417a96cf9	1991-01-01	f
22	taller	taller	testtaller2@taller2.com	CWTUpfX!m73151a9e882c798497f7aacbae062c30	1991-01-01	f
13	taller	taller	testtaller2@taller2.com	.hO!549y9c42652431ddd37429c6e7b9a4c7e7869	1991-01-01	f
29	taller	taller	testtaller2@taller2.com	X0dK2fyUW925c174a3b86d07a311c5dc0f00ba3ed	1991-01-01	f
45	taller	taller	testtaller2@taller2.com	UI1qH65Nu5249b0567fa8835c77c712d3dc496d78	1991-01-01	f
41	taller	taller	testtaller2@taller2.com	96c3VccIW471120ff9ccb53a3119327e792f06c39	1991-01-01	f
23	taller	taller	testtaller2@taller2.com	SzLJ5hXU.3ad2d95f1039762bcc608074403fd7d5	1991-01-01	f
36	taller	taller	testtaller2@taller2.com	RvbsC8ZRL8f7c7610749500a9adca9f79ea3c0ed0	1991-01-01	f
30	taller	taller	testtaller2@taller2.com	1RF1scRxt254ebbda46a6cd2efa35926f2fd37ced	1991-01-01	f
24	taller	taller	testtaller2@taller2.com	ySDsikB#Obc9c4813b5024f72ca7deaac0c21cb77	1991-01-01	f
31	taller	taller	testtaller2@taller2.com	BwPF5S.!n000ffe4d415b49dd76c772accd8bdcb9	1991-01-01	f
10	Nicolas	Alvarez	nicofer87@gmail.com	Z37A1CAS339702816bcd539cc4b760c47faef7f01	1991-01-01	t
37	taller	taller	testtaller2@taller2.com	0#eNBGKVu4c8f8669c2a6b706f70ab9e651ee13c4	1991-01-01	f
42	taller	taller	testtaller2@taller2.com	BdI0EtyVk1f50c90777460e9ac68ced599055cdaf	1991-01-01	f
32	taller	taller	testtaller2@taller2.com	8c7ouc6hVfb894332bb9c0d598e2d143282a1446f	1991-01-01	f
49	taller	taller	testtaller2@taller2.com	paHVejlI4c3422c02a40eb41da2d1a9bab245c6a7	1991-01-01	f
46	taller	taller	testtaller2@taller2.com	lloti7SC61d8493abdd1d3f809a359defb280efd3	1991-01-01	f
38	taller	taller	testtaller2@taller2.com	6Tb324Bj.76c44aa9a4e15af377c83203f9a3d253	1991-01-01	f
54	taller	taller	testtaller2@taller2.com	vPI9L7vcdf6342b3af3069beaa1b43b6f254ae0d3	1991-01-01	f
43	taller	taller	testtaller2@taller2.com	Hfc1W1iqac5c9a184491fdf26a83b03bab65b495d	1991-01-01	f
52	taller	taller	testtaller2@taller2.com	!a#m7SRG54fcbc5c23b69a1cae7918ac756cfa5bd	1991-01-01	f
50	taller	taller	testtaller2@taller2.com	z6nt6qVIka2a7e18018449a0f6b658ce541fe3fa1	1991-01-01	f
47	taller	taller	testtaller2@taller2.com	nptmMrmhi57fd912d1b218c2c22b2a164749d9f15	1991-01-01	f
53	taller	taller	testtaller2@taller2.com	SFo#gxehvc0a753d221f9f5e7b06d8e9be8013864	1991-01-01	f
55	taller	taller	testtaller2@taller2.com	DCGD4ogkrb616aa02e7653ef82a759b2766cf3253	1991-01-01	f
56	taller	taller	testtaller2@taller2.com	mmVahyLuR3ce5a6279e51bac53b6302f5d45cae32	1991-01-01	t
11	Nicolas	Fernandez	nflabo@gmail.com	Rl866IhUW1e8d9d81176b247199514e564d911aa0	1991-01-01	t
\.


--
-- Name: Users_UserID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Users_UserID_seq"', 56, true);


--
-- Name: AlbumCancion AlbumCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AlbumCancion"
    ADD CONSTRAINT "AlbumCancion_pkey" PRIMARY KEY ("AlbumID", "CancionID");


--
-- Name: Album Album_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Album"
    ADD CONSTRAINT "Album_pkey" PRIMARY KEY ("AlbumID");


--
-- Name: ArtistaCancion ArtistaCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ArtistaCancion"
    ADD CONSTRAINT "ArtistaCancion_pkey" PRIMARY KEY ("ArtistaID", "CancionID");


--
-- Name: ArtistaUser ArtistaUser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ArtistaUser"
    ADD CONSTRAINT "ArtistaUser_pkey" PRIMARY KEY ("ArtistaID", "UserID");


--
-- Name: Artista Artista_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Artista"
    ADD CONSTRAINT "Artista_pkey" PRIMARY KEY ("ArtistaID");


--
-- Name: Cancion Cancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Cancion"
    ADD CONSTRAINT "Cancion_pkey" PRIMARY KEY ("CancionID");


--
-- Name: Contacto Contacto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Contacto"
    ADD CONSTRAINT "Contacto_pkey" PRIMARY KEY ("UserID", "ContactoID");


--
-- Name: GeneroAlbum GeneroAlbum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GeneroAlbum"
    ADD CONSTRAINT "GeneroAlbum_pkey" PRIMARY KEY ("AlbumID", "GeneroID");


--
-- Name: GeneroArtista GeneroArtista_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GeneroArtista"
    ADD CONSTRAINT "GeneroArtista_pkey" PRIMARY KEY ("ArtistaID", "GeneroID");


--
-- Name: GeneroCancion GeneroCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GeneroCancion"
    ADD CONSTRAINT "GeneroCancion_pkey" PRIMARY KEY ("CancionID", "GeneroID");


--
-- Name: Genero Genero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Genero"
    ADD CONSTRAINT "Genero_pkey" PRIMARY KEY ("GeneroID");


--
-- Name: MarcaCancion MarcaCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MarcaCancion"
    ADD CONSTRAINT "MarcaCancion_pkey" PRIMARY KEY ("UserID", "CancionID");


--
-- Name: Users PKUserID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "PKUserID" PRIMARY KEY ("UserID");


--
-- Name: PlaylistAlbum PlaylistAlbum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlaylistAlbum"
    ADD CONSTRAINT "PlaylistAlbum_pkey" PRIMARY KEY ("PlaylistID", "AlbumID");


--
-- Name: PlaylistCancion PlaylistCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlaylistCancion"
    ADD CONSTRAINT "PlaylistCancion_pkey" PRIMARY KEY ("PlaylistID", "CancionID");


--
-- Name: Playlist Playlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Playlist"
    ADD CONSTRAINT "Playlist_pkey" PRIMARY KEY ("PlaylistID");


--
-- Name: PuntuacionCancion PuntuacionCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PuntuacionCancion"
    ADD CONSTRAINT "PuntuacionCancion_pkey" PRIMARY KEY ("UserID", "CancionID");


--
-- Name: ReproduccionCancion ReproduccionCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ReproduccionCancion"
    ADD CONSTRAINT "ReproduccionCancion_pkey" PRIMARY KEY ("CancionID", "UserID");


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: PlaylistAlbum FKPlaylistAlbumIDAlbum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlaylistAlbum"
    ADD CONSTRAINT "FKPlaylistAlbumIDAlbum" FOREIGN KEY ("AlbumID") REFERENCES "Album"("AlbumID");


--
-- Name: PlaylistAlbum FKPlaylistAlbumIDPlaylist; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlaylistAlbum"
    ADD CONSTRAINT "FKPlaylistAlbumIDPlaylist" FOREIGN KEY ("PlaylistID") REFERENCES "Playlist"("PlaylistID");


--
-- Name: AlbumCancion FK_AlbumCancionIDAlbum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AlbumCancion"
    ADD CONSTRAINT "FK_AlbumCancionIDAlbum" FOREIGN KEY ("AlbumID") REFERENCES "Album"("AlbumID");


--
-- Name: AlbumCancion FK_AlbumCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AlbumCancion"
    ADD CONSTRAINT "FK_AlbumCancionIDCancion" FOREIGN KEY ("CancionID") REFERENCES "Cancion"("CancionID");


--
-- Name: ArtistaCancion FK_ArtistaCancionIDArtista; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ArtistaCancion"
    ADD CONSTRAINT "FK_ArtistaCancionIDArtista" FOREIGN KEY ("ArtistaID") REFERENCES "Artista"("ArtistaID");


--
-- Name: ArtistaCancion FK_ArtistaCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ArtistaCancion"
    ADD CONSTRAINT "FK_ArtistaCancionIDCancion" FOREIGN KEY ("CancionID") REFERENCES "Cancion"("CancionID");


--
-- Name: ArtistaUser FK_ArtistaUserIDArtista; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ArtistaUser"
    ADD CONSTRAINT "FK_ArtistaUserIDArtista" FOREIGN KEY ("ArtistaID") REFERENCES "Artista"("ArtistaID");


--
-- Name: ArtistaUser FK_ArtistaUserIDUser; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ArtistaUser"
    ADD CONSTRAINT "FK_ArtistaUserIDUser" FOREIGN KEY ("UserID") REFERENCES "Users"("UserID");


--
-- Name: Contacto FK_ContactoIDContacto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Contacto"
    ADD CONSTRAINT "FK_ContactoIDContacto" FOREIGN KEY ("ContactoID") REFERENCES "Users"("UserID");


--
-- Name: Contacto FK_ContactoIDUser; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Contacto"
    ADD CONSTRAINT "FK_ContactoIDUser" FOREIGN KEY ("UserID") REFERENCES "Users"("UserID");


--
-- Name: GeneroAlbum FK_GeneroAlbumIDAlbum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GeneroAlbum"
    ADD CONSTRAINT "FK_GeneroAlbumIDAlbum" FOREIGN KEY ("AlbumID") REFERENCES "Album"("AlbumID");


--
-- Name: GeneroAlbum FK_GeneroAlbumIDGenero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GeneroAlbum"
    ADD CONSTRAINT "FK_GeneroAlbumIDGenero" FOREIGN KEY ("GeneroID") REFERENCES "Genero"("GeneroID");


--
-- Name: GeneroArtista FK_GeneroArtistaIDArtista; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GeneroArtista"
    ADD CONSTRAINT "FK_GeneroArtistaIDArtista" FOREIGN KEY ("ArtistaID") REFERENCES "Artista"("ArtistaID");


--
-- Name: GeneroArtista FK_GeneroArtistaIDGenero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GeneroArtista"
    ADD CONSTRAINT "FK_GeneroArtistaIDGenero" FOREIGN KEY ("GeneroID") REFERENCES "Genero"("GeneroID");


--
-- Name: GeneroCancion FK_GeneroCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GeneroCancion"
    ADD CONSTRAINT "FK_GeneroCancionIDCancion" FOREIGN KEY ("CancionID") REFERENCES "Cancion"("CancionID");


--
-- Name: GeneroCancion FK_GeneroCancionIDGenero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GeneroCancion"
    ADD CONSTRAINT "FK_GeneroCancionIDGenero" FOREIGN KEY ("GeneroID") REFERENCES "Genero"("GeneroID");


--
-- Name: MarcaCancion FK_MarcaCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MarcaCancion"
    ADD CONSTRAINT "FK_MarcaCancionIDCancion" FOREIGN KEY ("CancionID") REFERENCES "Cancion"("CancionID");


--
-- Name: MarcaCancion FK_MarcaCancionIDUser; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MarcaCancion"
    ADD CONSTRAINT "FK_MarcaCancionIDUser" FOREIGN KEY ("UserID") REFERENCES "Users"("UserID");


--
-- Name: PlaylistCancion FK_PlaylistCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlaylistCancion"
    ADD CONSTRAINT "FK_PlaylistCancionIDCancion" FOREIGN KEY ("CancionID") REFERENCES "Cancion"("CancionID");


--
-- Name: PlaylistCancion FK_PlaylistCancionIDPlaylist; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlaylistCancion"
    ADD CONSTRAINT "FK_PlaylistCancionIDPlaylist" FOREIGN KEY ("PlaylistID") REFERENCES "Playlist"("PlaylistID");


--
-- Name: PuntuacionCancion FK_PuntuacionCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PuntuacionCancion"
    ADD CONSTRAINT "FK_PuntuacionCancionIDCancion" FOREIGN KEY ("CancionID") REFERENCES "Cancion"("CancionID");


--
-- Name: PuntuacionCancion FK_PuntuacionCancionIDUser; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PuntuacionCancion"
    ADD CONSTRAINT "FK_PuntuacionCancionIDUser" FOREIGN KEY ("UserID") REFERENCES "Users"("UserID");


--
-- Name: ReproduccionCancion FK_ReproduccionCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ReproduccionCancion"
    ADD CONSTRAINT "FK_ReproduccionCancionIDCancion" FOREIGN KEY ("CancionID") REFERENCES "Cancion"("CancionID");


--
-- Name: ReproduccionCancion FK_ReproduccionCancionIDUser; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ReproduccionCancion"
    ADD CONSTRAINT "FK_ReproduccionCancionIDUser" FOREIGN KEY ("UserID") REFERENCES "Users"("UserID");


--
-- Name: Playlist FK_UserCreacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Playlist"
    ADD CONSTRAINT "FK_UserCreacion" FOREIGN KEY ("UserCreacion") REFERENCES "Users"("UserID");


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

