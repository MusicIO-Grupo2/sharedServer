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
    "albumId" bigint NOT NULL,
    name character varying(100) NOT NULL,
    "dateRelease" date,
    active boolean DEFAULT true
);


ALTER TABLE "Album" OWNER TO postgres;

--
-- Name: TABLE "Album"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Album" IS 'Tabla para albumes';


--
-- Name: AlbumTrack; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "AlbumTrack" (
    "albumId" bigint NOT NULL,
    "trackId" bigint NOT NULL
);


ALTER TABLE "AlbumTrack" OWNER TO postgres;

--
-- Name: TABLE "AlbumTrack"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "AlbumTrack" IS 'Tabla de canciones que estan para un album.';


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

ALTER SEQUENCE "Album_AlbumID_seq" OWNED BY "Album"."albumId";


--
-- Name: Artist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Artist" (
    "artistId" bigint NOT NULL,
    "firstName" character varying(100),
    "lastName" character varying(100),
    age smallint,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE "Artist" OWNER TO postgres;

--
-- Name: TABLE "Artist"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Artist" IS 'Tabla para datos de Artistas';


--
-- Name: ArtistTrack; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ArtistTrack" (
    "artistId" bigint NOT NULL,
    "trackId" bigint NOT NULL
);


ALTER TABLE "ArtistTrack" OWNER TO postgres;

--
-- Name: TABLE "ArtistTrack"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "ArtistTrack" IS 'Tabla para los artistas que compusieron las canciones.';


--
-- Name: ArtistUser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ArtistUser" (
    "artistId" bigint NOT NULL,
    "userId" bigint NOT NULL
);


ALTER TABLE "ArtistUser" OWNER TO postgres;

--
-- Name: TABLE "ArtistUser"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "ArtistUser" IS 'Artistas seguidos por el UserID. Borrado fisico on delete.';


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

ALTER SEQUENCE "Artista_ArtistaID_seq" OWNED BY "Artist"."artistId";


--
-- Name: Track; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Track" (
    "trackId" bigint NOT NULL,
    name character varying(100) NOT NULL,
    description character varying(500),
    active boolean DEFAULT true NOT NULL,
    duration bigint
);


ALTER TABLE "Track" OWNER TO postgres;

--
-- Name: TABLE "Track"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Track" IS 'Tabla para canciones';


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

ALTER SEQUENCE "Cancion_CancionID_seq" OWNED BY "Track"."trackId";


--
-- Name: Contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Contact" (
    "userId" bigint NOT NULL,
    "contactId" bigint NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE "Contact" OWNER TO postgres;

--
-- Name: TABLE "Contact"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Contact" IS 'Tabla de contactos para un usuario dado.';


--
-- Name: FavoriteTrack; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "FavoriteTrack" (
    "userId" bigint NOT NULL,
    "trackId" bigint NOT NULL
);


ALTER TABLE "FavoriteTrack" OWNER TO postgres;

--
-- Name: TABLE "FavoriteTrack"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "FavoriteTrack" IS 'Tabla con marcas de canciones por los usuario (like). Borrado fisico on delete.';


--
-- Name: Gender; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Gender" (
    "genderId" bigint NOT NULL,
    description character varying(100) NOT NULL,
    active boolean DEFAULT true NOT NULL
);


ALTER TABLE "Gender" OWNER TO postgres;

--
-- Name: TABLE "Gender"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "Gender" IS 'Tabla para generos musicales.';


--
-- Name: GenderAlbum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "GenderAlbum" (
    "albumId" bigint NOT NULL,
    "genderId" bigint NOT NULL
);


ALTER TABLE "GenderAlbum" OWNER TO postgres;

--
-- Name: TABLE "GenderAlbum"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "GenderAlbum" IS 'Tabla para generos de un album. Borrado fisico on delete.';


--
-- Name: GenderArtist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "GenderArtist" (
    "artistId" bigint NOT NULL,
    "genderId" bigint NOT NULL
);


ALTER TABLE "GenderArtist" OWNER TO postgres;

--
-- Name: TABLE "GenderArtist"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "GenderArtist" IS 'Tabla para generos de un artista. Borrado fisico on delete.';


--
-- Name: GenderTrack; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "GenderTrack" (
    "trackId" bigint NOT NULL,
    "genderId" bigint NOT NULL
);


ALTER TABLE "GenderTrack" OWNER TO postgres;

--
-- Name: TABLE "GenderTrack"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "GenderTrack" IS 'Tabla para generos de la cancion. Borrado fisico on delete.';


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

ALTER SEQUENCE "Genero_GeneroID_seq" OWNED BY "Gender"."genderId";


--
-- Name: PlayTrack; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PlayTrack" (
    "trackId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    date date NOT NULL
);


ALTER TABLE "PlayTrack" OWNER TO postgres;

--
-- Name: TABLE "PlayTrack"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "PlayTrack" IS 'Tabla con la reproduccion de las canciones por un usuario.';


--
-- Name: Playlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Playlist" (
    "playlistId" bigint NOT NULL,
    name character varying(100) NOT NULL,
    owner bigint NOT NULL,
    active boolean DEFAULT true NOT NULL
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
    "playlistId" bigint NOT NULL,
    "albumId" bigint NOT NULL
);


ALTER TABLE "PlaylistAlbum" OWNER TO postgres;

--
-- Name: TABLE "PlaylistAlbum"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "PlaylistAlbum" IS 'Tabla de relacion de playlist y album. Borrado fisico on delete.';


--
-- Name: PlaylistTrack; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PlaylistTrack" (
    "playlistId" bigint NOT NULL,
    "trackId" bigint NOT NULL
);


ALTER TABLE "PlaylistTrack" OWNER TO postgres;

--
-- Name: TABLE "PlaylistTrack"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "PlaylistTrack" IS 'Tabla relacional playlist cancion';


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

ALTER SEQUENCE "Playlist_PlaylistID_seq" OWNED BY "Playlist"."playlistId";


--
-- Name: RateTrack; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "RateTrack" (
    "userId" bigint NOT NULL,
    "trackId" bigint NOT NULL,
    rate smallint NOT NULL
);


ALTER TABLE "RateTrack" OWNER TO postgres;

--
-- Name: TABLE "RateTrack"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE "RateTrack" IS 'Tabla de puntuacion de canciones.';


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
    "userId" bigint DEFAULT nextval('"Users_UserID_seq"'::regclass) NOT NULL,
    "firstName" character varying(100),
    "lastName" character varying(100),
    email character varying(100),
    password character varying,
    birthdate date,
    active boolean DEFAULT false NOT NULL,
    image character varying,
    "userName" character varying,
    country character varying
);


ALTER TABLE "Users" OWNER TO postgres;

--
-- Name: Album albumId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Album" ALTER COLUMN "albumId" SET DEFAULT nextval('"Album_AlbumID_seq"'::regclass);


--
-- Name: Artist artistId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Artist" ALTER COLUMN "artistId" SET DEFAULT nextval('"Artista_ArtistaID_seq"'::regclass);


--
-- Name: Gender genderId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Gender" ALTER COLUMN "genderId" SET DEFAULT nextval('"Genero_GeneroID_seq"'::regclass);


--
-- Name: Playlist playlistId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Playlist" ALTER COLUMN "playlistId" SET DEFAULT nextval('"Playlist_PlaylistID_seq"'::regclass);


--
-- Name: Track trackId; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Track" ALTER COLUMN "trackId" SET DEFAULT nextval('"Cancion_CancionID_seq"'::regclass);


--
-- Data for Name: Album; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Album" ("albumId", name, "dateRelease", active) FROM stdin;
\.


--
-- Data for Name: AlbumTrack; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "AlbumTrack" ("albumId", "trackId") FROM stdin;
\.


--
-- Name: Album_AlbumID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Album_AlbumID_seq"', 1, false);


--
-- Data for Name: Artist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Artist" ("artistId", "firstName", "lastName", age, active) FROM stdin;
1	Ricky	Martin	30	t
\.


--
-- Data for Name: ArtistTrack; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ArtistTrack" ("artistId", "trackId") FROM stdin;
1	2
\.


--
-- Data for Name: ArtistUser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ArtistUser" ("artistId", "userId") FROM stdin;
\.


--
-- Name: Artista_ArtistaID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Artista_ArtistaID_seq"', 1, true);


--
-- Name: Cancion_CancionID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Cancion_CancionID_seq"', 149, true);


--
-- Data for Name: Contact; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Contact" ("userId", "contactId", active) FROM stdin;
11	8	t
11	9	t
\.


--
-- Data for Name: FavoriteTrack; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "FavoriteTrack" ("userId", "trackId") FROM stdin;
8	1
\.


--
-- Data for Name: Gender; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Gender" ("genderId", description, active) FROM stdin;
1	Folklore	t
2	Pop	t
3	Latino	t
\.


--
-- Data for Name: GenderAlbum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "GenderAlbum" ("albumId", "genderId") FROM stdin;
\.


--
-- Data for Name: GenderArtist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "GenderArtist" ("artistId", "genderId") FROM stdin;
\.


--
-- Data for Name: GenderTrack; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "GenderTrack" ("trackId", "genderId") FROM stdin;
2	3
1	2
\.


--
-- Name: Genero_GeneroID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Genero_GeneroID_seq"', 1, true);


--
-- Data for Name: PlayTrack; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PlayTrack" ("trackId", "userId", date) FROM stdin;
\.


--
-- Data for Name: Playlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Playlist" ("playlistId", name, owner, active) FROM stdin;
\.


--
-- Data for Name: PlaylistAlbum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PlaylistAlbum" ("playlistId", "albumId") FROM stdin;
\.


--
-- Data for Name: PlaylistTrack; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PlaylistTrack" ("playlistId", "trackId") FROM stdin;
\.


--
-- Name: Playlist_PlaylistID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Playlist_PlaylistID_seq"', 1, false);


--
-- Data for Name: RateTrack; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "RateTrack" ("userId", "trackId", rate) FROM stdin;
7	1	5
8	1	10
\.


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "SequelizeMeta" (name) FROM stdin;
20170403005935-AddColumnFechaNacimiento.js
\.


--
-- Data for Name: Track; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Track" ("trackId", name, description, active, duration) FROM stdin;
55	VaalfoDctb36060c2207a5880c31da491a522106d	Nm4evxi8Cba181aa0a5675dce1660ef8ebc6eaf7b	t	\N
29	BHlicctsC38b8765329b56b36ca9b2526da0e0784	CF.pGyVHE136e20977164e16491074217a1953f1f	t	\N
52	YztSsofmqf7e8f6f816649e385481860ad5ae0cf9	CuQBrdlsc91115d9d44c648a97af216ff4685eb70	t	\N
59	cy#W7hMQGa47f6d42894dd0310ab725a1d72447fe	fxxzZU2J63132fb6fee1b240729de0d25fdbf2589	t	\N
41	MSwdSzKfq88985da9c30399ef10a85081b7b117b7	o3zUzB5jV11f18167275991357edaf0865a1a1df1	t	\N
30	pfX0wI0Om7e2c0f767588629cf06735347efb247f	I!ehOJRA!87e2e8bbe0932fc74f164c5173ad649d	t	\N
48	y5BK7PtT#db7ac91835e22eac67b23e44db390f5f	vDYwXefs0fdfcbefe7e6a153e8bd4df6f5932ac6d	t	\N
53	dmv7srOzVb49fe2f8faa80c28494ebe8cfda6de4f	nQy6ZUehW665dbd36148f851bf60f1863666fcd6a	t	\N
58	FIvOm8!a290dd2afbb9ee532c4edffed4815826dd	9h.94#Vk4f5a73d996c433194bd9971477c427cc5	t	\N
31	uZG!sBVc6251119cbfdbc267291f5aa6bc5374f97	QSN7HbLtGbdf04195f779bc487e997ab083476f97	t	\N
42	FFLfcHeAHafd3b630242e5f7dfe462de198516668	5q!tH9AP512fcb46b0dc491e3ac000338b48e4367	t	\N
57	xYC0Toqj82de70248e72be89e9cb48dfdf6a879ad	CQfc9NALX1be63d782654d3d0aea8ab8348b695d7	t	\N
49	iTvtFtSdwb4236a3a01d53d3cbe9e31087657774a	ZGmU1Alzoa258d622c97d788a90a3df19d77bf40d	t	\N
32	24QkdtU0Cd3733d708bc49e48a56a2b850a347b3c	dynBTCXpHf460f5906e5a745c356187d1b050c02f	t	\N
56	3vxqBudS960e7c0ae9e4245ceb541c5378b3e0e62	xNY9o1S8mb3b1de14115ebdacef1727d0aa4b6f9b	t	\N
43	fe8LKg5!y855ef2db2426e2f47cbe364715670e58	FZNfB2nqy4ba1a37c8418ac2eddc8519173c1dd67	t	\N
54	BzctIcNUT07b1588f9557d9dbae7e2ff337150601	mj5Gb!GUk7a99065019a213406d1b76a78c34db2e	t	\N
33	Ccep5iQdoc6cc8c3ee0d5d871683176902b7d9288	.Y1IOFsLxd908d8583ef0e69754077f41d527e39a	t	\N
60	2l7TbxhYH75068c146f7f4021fc7e90bc8817580d	R0rpDokO2bbd3c507cdbc6d5622aab1d5b1fc6828	t	\N
23	i9J60sSDs553d28b3d49d5f643c4ba0b402eeee10	9OrRiIeco0e87eeeac8b6c9ea321642d60178b428	t	150
2	La Mordidita	Tema de moda	t	150
24	upz6trMdW88ccc84566e58994128052e43afb7e35	3SX40yA1v510ede9c9c49ff35e491270cc5b58ed2	t	150
3	Testeame	Testeame	f	150
4	Testeame	Testeame	t	150
25	aBeplb6Kfed9cf740d77aa21d3a7ce336e3f586ae	#4Q#.nd1y9ca20371e73a236411c45bdfa6cd38eb	t	150
26	TuDUB3j6Kbe932f87a3383df900e9a4880656e5d8	PHhyoT#7E35fd02d608322c2475d96935ed344c7b	t	150
5	MxO50EhTx7ca6912c4412f59c0718e14dad8a8d6c	5irHypMsia6f4caa682e44e6e70462ff26f5009b0	t	150
6	!YhbushkEff951f7e7033c2507e2e1cb7e5cbfee5	e#RAhWlWj34468a77720b6c0ca9a633c45f4df12b	t	150
27	JhH2Zxx.Gfdb55b44b1d757d7fca7c10bd3dadd94	tfDZhEX3Q815e2193817f7205e3cae388082555ad	t	150
7	#dgzQT7Nkd29b07b3107c8ffc233f3d843277498a	RgSBjUnxV429c54b0c1ad6aaf348284224764de34	t	150
8	HOZkoUUn25ad0fa7793ecb5a2b9258f8b8399a4a0	Su0MUxZd03cd7c5afc8ae705dd6a11b8ee5c59c3c	t	150
28	TfvmJtR!#f0c243a5f3244f6990caef56083ed29c	vR9mOK#eM970d651c63ca0b9bac1ffab053cd713e	t	150
9	sBn3fKgpZ0d9ee55c79d015fe35355c6d63692cb7	AYQBw#.WM4de7e70fabb2841587ebc94ace0474f4	t	150
50	sqC1c7r!E439c1ba5d93a2592c06ffefb4bb4b4d3	pUocauF5pb4b24a16bfedc20fc60362223ce179db	t	\N
10	WxudjZXRGe3e662d3637b9652784f75be968d60a5	RQru2off46bcae193660505b7a1d19ffb8fb07f04	t	150
11	M30C4FToQ6928aac298aee719158011634f52925e	aUg4fU6.#221cf06f9658f2fad81c57ad258cd894	t	150
12	#pSbuOFq8828499eee9b1111fc13954574907d36a	WngQRmr4Uec70cc7c0dd0a57b99cf64262883cc8d	t	150
13	coI!OPNru31cbcae7ad22bfa6bc6189cdf0bbcc08	klTAmA6Zjc674bcdff850d394f302bce7f25449bf	t	150
14	!Ml4santf247ad20ce1366405bb1b9481b14ae468	o.RXpoISX15e30bc26a8446a031cbb8579899d402	t	150
15	eovBmLh1x31e2e3a5eae7326ce4a6ef7c368f991a	u989TrCem90a76161612a5751050697f9107f494e	t	150
16	uozrbGXYr75a029507464a9fa7857a88134759f5f	mkou982zr4be42c9a14ee29a460ab1584adf46662	t	150
17	MWBrqrDpm63cedeed278dbb114905e1822a7f864f	fABLTDziJb232cd9a8ea8d08c930ed6b9e96144e6	t	150
18	23W5Zp2fv12ab4727a5c66a4056a4acc7b2a386f0	DiTFNVGaRd34cb95f9921277304d80d5ba8b507d6	t	150
19	kvkgpdOdU4a728e7b2345152ad73545eb082b9aa5	MCO3eMf3H5c0b5f5a0030280cb6f79289df127c77	t	150
20	ZQ7RuzKbQ2219cce55ee14a0d87d3f27ef0f688fc	O9HC1TXaU347ddf62b2e09d7380e29ac1d69e3137	t	150
21	Gh7RN.#DK426d525566613698ffacad9b55e7ec4c	ElI#Fwnkk718b66efaa9bac1661690a0a47b20111	t	150
22	uDdJA81jl1bbc8dbe4276d842bc7b248ef20f817c	GCPBbUAd195b0b1a7467e24e82ed6d7c6fc199bba	t	150
44	KmBlb.f.#f03776c22a595eb8e6a4488e4a2db198	SaPkl8L6ud8e16cd2209902c24e39d53b6e26567e	t	\N
61	uF7wXW28nfab0f4db0bf2cc6e1ff867aeb369d35a	#7n0MiN!of03df434b167a2aaa38489898dee91df	t	\N
34	UUQs1s3nOc7a72cccce496939fbb07324baa6f7b9	hugV0kZDy154f9cfedef1f4efbc6752ffdbd635f1	t	\N
62	!Hkai6dUv67284096202d6ab9180753abe5e0802e	U#Dvi9EdHa799febda5c75d1b99c26541cfd56291	t	\N
63	SXC9k.psi1c9efd074235bd7fd99aaf3fc50bbbf5	wzgiJZ3zvc61a1dce60f6b121e6f2e796c9a7c276	t	\N
45	So6fQy4UNfc96cea47eac7f372d4bbc065c03851b	FyiY2xf.57fb5efb905f768efac2dabdb19249767	t	\N
35	0#HZjcKjEbfe80d5c9d26686ff4d41b8b4ad49d78	OAzO4HZuI3f54313d5220e7440ead4e01d0b4449b	t	\N
51	JDlfPXaf9c1903a2d50ba71322e6752fad9f4c9aa	7N6BxZ8jV45070032ada053cb1b7c4b0deba6c283	t	\N
64	2GH2yoVCuec93aa188fc98a5110e35d8a9d5d73b8	GRtxVOs7Q97dce48ee93c94111be555f962b9c818	t	\N
1	testeame	testeame	f	150
36	scolmTUtGe0df48450b9f574704a252e901162fa1	hBwAF7TX!e2cba96dfc7e62487fc7a81f4621e2d6	t	\N
46	cmwmONGts7c7ad674108f909a795d4f19132e9506	4jrGnuSCma199d84c322b426d6000790dd2225961	t	\N
37	EW7nejl8C8efed85fad2891b7de8f62cc5a7821e2	Qr6eFCUkM0c8e565db1f849d69d8a0108fd01ed7b	t	\N
47	!UniTu42ia26ac2acace2e66a24ae35dc213684e3	VJPTjm#Un1bc63a880b1041e8198ac35bd23878cf	t	\N
38	FcWUaCmVu4d769918929dedf262a735d61c2e5a28	Huajgqo5f29e66260d906f933f44db535bec38644	t	\N
39	l.vE9QjSDae42774eceff1fa58af5c8af5c05cd66	UBTCTNk7ude64b77404a568c3d622b99dfba25eec	t	\N
40	mOIuIJI0x26a53d7b45ed981773a3ba6bf00e4a38	yVUjBNl5Edc10873b81ec0148b86a1e1933fe9095	t	\N
65	OG!29uIX4699ddac71c6e946884c9cd41fbdfa81b	zrtTfIiRz6333352dc48d2560c4ee34418d1e5935	t	\N
66	GHkU8N!Ti4c4b5618df894d393278c20c1e2d262a	feK5K6uku42ae8fb9e3bdb6b9c055af3f237a4a5f	t	\N
67	Uwo1TCG#66452051ec306fb47c8ded3de141df0fb	9e1D2pzuEec174b752025141fab883f6e54f68c8e	t	\N
68	1hRTUwPwO839ecc82f021bf064fafdbae8eda92eb	cddP2ba42ca6a52a4b0890059fd307e54108b574c	t	\N
69	32wbhVdy166ef0b55d63782bab6a60d4328d280b4	4fauBH2s#62ad1fe81794350fefc6d97eda56ff9e	t	\N
70	Uw!hMCh1deb678b1376fb71484c1e9a995ba08b6f	bRaydvRGv1c429d5f155920fbcb76f0962a906fda	t	\N
71	!mGP6SmjIe0f1b9da6dddba67093456a0c7759640	5u11AXv5#030f5a97d3e20df4ce50ec40ea3167ce	t	\N
72	YB3hU0WKpc3d7758689f4099ae63ad8dbef976136	xDdFlPnPJf118eba1b04e87df1238efd6f6604c17	t	\N
73	2pJrtbf5I3e8021baff4f8c58cd4d095c4f4fc3bc	3Xsar!jyu0a567e2f460de2582f24d54ce84f2ed0	t	\N
74	q7.OkEpxTdde28c3164cddd976f419a54ae2f1a0f	plBwjfyWx26066c9d44ab51554f3d220772bc5b71	t	\N
75	TwuW8So9gd649e129440fb125fb114a39eaa374c6	i3csG29Nfc90299dc37aadb7758ac033db2016eca	t	\N
76	CaRaLDh#t0091209d8bf8de97ca80bfbdfb55da9d	U#7AOFA1ua3f134a3c31f5dc7b10fbd3fbfc07e59	t	\N
77	9.x1Iidfj810850abff24b01ab6b0dae0f95ce945	GYabwdDzse15a58f47d73526cc914805495be3f00	t	\N
78	Ud8o44py7a472a593f4b849d35baed01d7d1c3e33	21VRiuQA258f26160841a4babb84bb3370e498d10	t	\N
79	OWu#qBKkY9af8747aa7187cb6db93e6a00e68d339	02ru!Xf.4ab3a91a872aacea58c3e77df1a9d9e9c	t	\N
80	n9hA#!dxf239af7834a3cac23f7eb03947e76cdac	bLGm5OW9M84030a3c37a14d5c2daf573be986dd2e	t	\N
81	pUPZXDuf5328f19bc17eb77f584b4de7cf06c98e9	Ova829TKv4392d41033926958ea4e888509122dff	t	\N
82	tABuz5QrF1ef04efc272a792df1f058832610ebfc	K5xJDQMEq485d40a2771e3d5afc7f10ece5c830c5	t	\N
83	rSwU1EQsP7f63f0f838dcd8ba84faf6e8d571c341	W9fTEpGUT0a49c64e73e3a7bd996d36bc95360dbd	t	\N
84	NeNUb.QO100a1f8ee065929a868ebc6ff8567b2ed	iF6s7c43u9b04e2b54d13ad12695e38d7cc2b2ef3	t	\N
85	sVNLac#R!8e3e8da54f0419e5ef8fce6d2bd14cf4	p5.IZqWW89b3d37bc1cfc7123bda4cfac0af64b81	t	\N
86	nZ6rgVayUded4128c9470385c7741305e1ca08ad6	ZFF4rDXpVf3fd8e986c19117792a22921f7e1d932	t	\N
87	v9y.Rbrc1ffc5cd8b4b252a10668fabab49846f23	U14gWcG0q49f90659bede677af01b216c33d27059	t	\N
88	1AlGHaxQ#fc4d10603286d324d932a737e5e7c5f1	JimqI0bkMb2daf6daf079d53b1f423352ae2133a5	t	\N
89	eFhtcRuU7e93652576e88caa62850d445accc60c7	G3l6Y4HYEeb9980618ac44b038d5e1523ca7d927d	t	\N
90	eAly6yPX39645fccf78fc790c8de59accc274c34a	.EjUo40xuf6f096f01cf6a4cb1411f382ca55a378	t	\N
91	1jkSuntG926d066e933efdd05db0a94cf86b7cf0b	uvg09UHKxf5d10578ff8345d46514b8c31e06c1b0	t	\N
92	slRux3DzLa9c7b15f79298c5200a2509d5e589577	h7q1iejjF098e4300beda3142f9cb19d2fa7435da	t	\N
93	zX1kAAdSi72bc847467d7c4947c6a36bd604adf02	IbR!z8cIgebb63e3d39b6c081667c5ba294256162	t	\N
94	BH3d47hmJf6932dd98dad605558a356b4d6b58d0c	.NouaIGZH323e9825fc33736e1b036ef66f29997a	t	\N
95	UUwOLgxJn15383295d01863e46ced251de32912e5	j!SXwIPuxbd7a2d47ae84fed53e1b7dbfc296e8ef	t	\N
96	SobQOXRrR99115b370a8dc92b7ad088bcdee281ee	wp2uNihvy16aeb923f2c3252fda7621f908f69016	t	\N
97	4PebZLAjUea21c752dbf3591815212a2c198ce5b0	KE4G6tDV7082e7bcd397b5123a616263f85378838	t	\N
98	cVn#iTBima5b62b2f2d57f095ae18811b45b33512	0B3yGlGjMbb4360ecef45a0b9d2ad0cc6e91ea2c8	t	\N
99	D1AzN9jCPb4d1810ea502d8491c03627180ee8e24	HaE!uEuy0ac25e0fc4d3a7325e0755b3303cad7b4	t	\N
100	lhzJmIH3k9682bb5de7295bdde0bcbbf691cc1967	U89OUuBjp8a80cc6ed399c1e8b75756f90c77c4d5	t	\N
101	RrRl9gEAEa6ce2ea52ba72c492a77a9a76fb304a1	u6ze#JPDJ5a8d5bc0d176aa79ae1cd3210564d7bc	t	\N
102	T9HPbEpie93d58e764c995cd0c75930f347412143	vUcM!1KBU429f28426bacb69132a09815efaa5e47	t	\N
103	YFFqHDZfQ17e3addcc4a6bbee90be9bba58c77458	3ZmpZ!sbn597c2443b72ffaa8657fcfe861c2e51a	t	\N
104	YljuvRlE47b2b711defda3978f11c25e3e32e9b0f	5zDu6tiB!2c4d7424cc57cd7352c8b5048da4b0d0	t	\N
105	kTIZ9JVO2e3bc55f93c3e9e57475bcdcd5e7e63a7	pQZ5yeuvmf517f109067e35a70bc0f7d3269f5aed	t	\N
106	t7ag2HgUle9ba7a4ec579b607de9eabde35b5491f	F8Dg3fFRE721e3815b31de98f5ddb558964828a1d	t	\N
107	uKWavI0WCa193dd9ddedd1926813a8c6378cbaf35	GWhvi3iWT2251b6be0025a06fca03d2d0549c2c6b	t	\N
108	mnqiZi1vDe63d142f312affb2a60b00fbaa417fc0	KRaUge6cu0129d3de5a3b3a95daa2822385ec370f	t	\N
109	vWLfYz0CF5a8ddca91798bba93d7a28a032a8d42a	475EsRwp288e314eb4fb10e061ea9b119c48b815d	t	\N
110	eGizwBgPj8012cac776c9879d917b25466b251bfc	C!BEZvAyh9ecd6fe56c72a6220eb3ebf039d19a43	t	\N
111	V!eZKV2KGf16009c6996a8961aa4cf13067893095	!Veyt817w77f9ddd8a42efe5b421f9ad6ad759f18	t	\N
112	Uv8SKII6z2a78950bd85af8028abf9630042ad197	aOzDcDNVU8b85f06e13f359a0549a17eaaae148ad	t	\N
113	kS3#ZOMTjb02c047eed188117a998a5e0e0797a26	WJThj0rz64c7c084aab310dbe533c20d82a3b7ba6	t	\N
114	xiws175u575f889c6bdbad1b589a31d67c8cb1bb4	NiZU0znBb7c24401e8ffc089fc4d4b850306bc6d3	t	\N
115	rDZwqj7VP87fd78ca7a0c6cd23cc5682f05bc35bc	2Tu6sU1zA9bf1f752eb47f291ef3c70c23ed3dd4d	t	\N
116	iYPxQ!6iB51df107501b8c815119f3f771ca87124	3A1Silj1Y9956e207081938369876d7eda156ab74	t	\N
117	8J#RVkFFC67a2b8de2031bc72acc39dc9d947dc81	BB0mmuCp8166ddb97e802926a798c31f93ad0e263	t	\N
118	7ubiJKd1ibed9321bedc7686482bfb64fca7cdcb8	cuNf!qL.#03c44fdbc0c56b0b6f5f954f7f886d49	t	\N
119	iufJ40bOfd85d1a99c5ee5f7d2e80be14e29d1480	FuMhuRJgwc980d2f311885266a5215126e8555575	t	\N
120	l5#uM8KBt9f0971cc8dad5fc98813654ff94f39bf	muZ7xe!cAee56a736369a21fe638b067a774149a3	t	\N
121	EEDLVdQ3Nb9dd63c07dcf1eb30045d42023f7deec	LdBhNOehPcc49d74a3ec661bad648366d66016491	t	\N
122	YrBv!5SBMf65ca5eb7c3d8fc750f899f86c95d24c	VzQFdGon06bd425342de11f3b82e18d691037e75a	t	\N
123	lpBCQtxSQecaf1b8f4afef61f4bfb285201b9fdb6	zW0k8tv5Yc0d9038431b2a4881eccde55e52b1d62	t	\N
124	nlI#kh7R0852e034106170bfdc553540f62871682	lBPlkbwhC343ad41d21cc20c1a521dd4034366cf2	t	\N
125	yMgwU73jO4f46aa327162dae124aefba17994531a	.xOjLULNdec5e116742ded413c62f933101a385c4	t	\N
126	i5XnAZz4!69757bdedaa58ac97685088af68e7596	dQUp3FiEk67f42009766dcb1f55427f4924b4be32	t	\N
127	s9IygYNmWf9c28e122eeb92fc0128b290c17fd923	I6wni8kpd9191e97e4dee7c3f7f35f499ab401322	t	\N
128	zWXeFxzhq0c88af84105e772f925b486fc6146437	pBL.sNtQQ6c7138b481b7052a80ea553935be50da	t	\N
129	PGYO8uePgd24805f6eb1c0d9581f083e27446e372	YHF3!Nxg1c5e3b90df235d217fe5a5d0107809b08	t	\N
130	UZZp77Oqu5b83e1d97cb4ace5055a63d18c1ebb88	iN.A.dguE679f3db92b8af99776353984f70b1367	t	\N
131	zpdNUesIs1f141c1fec86b87c83cc8cc2650bc09b	iIQiIMTUu5bdd5a3edc7cc85fee7504921bda9fc5	t	\N
132	87QcuOjVH29e475a7206b6e9272003eef30718bc4	uMGEl3OGw450e6892f2b6a9a7c77d766236e71870	t	\N
133	qBv0ZMQdHfcd3ea6a51849dfd20b36c56eecf7531	p6Y9AQjcSeec6e2a6ee6453a2443608d6ef147ea0	t	\N
134	aXujJpmO2ee8943a3466cef4abf077998e064008f	ftrHgp63cc81b036b8c74b1f084c1bbbc67cd1304	t	\N
135	KQ1.Ot4Ppecceb2ce6e8d7fc34d9572e6ee9a91a1	h1GyEc!M!4e2472263c3f90fc25429923001d55e5	t	\N
136	W.Xl7kONG9795dd9b68e51567a63626e71aea7d57	ZADuV5ySuf72ef2eb8aa4a1b963f01f9b7db10257	t	\N
137	fuHpEKAwU51f0488f5465d6081b9cb6fcc7070b41	IEd2FjUhwccc63e9f8ccd9143ac01ddc7d14fa27a	t	\N
138	hXNf#EcVE7e513dc10f6cbb872ae6a69233f13a4e	Y9wz!1CuW8f11e5caac8e33fe211ea93ed0b36a03	t	\N
139	m0pnpG!kPc0fa31c353c0a2f0359b7fbdd7018c62	UiizSzjTa631b2634688a7c53ea61b002d8f9e3ca	t	\N
140	qir.Di9d7df09f27ad2fed2a67ad8c4c45489af58	F1cE05n.U5f56bd0d42cdacdc5dcf71a70c46e53b	t	\N
141	f!sjXSmSY63329ce17583681cae3d9939ec1b9499	9aRSQVFzN6035ff929f3cf0f3b7ef490bd72de85a	t	\N
142	eSlvPAKF4e4b646e39c3f7ba2bfb1b76c7b682d65	ONSFp8X6I7d561d9107240902513e8ee4ec0c6a43	t	\N
143	ASpa0j3nU0744cd9e4596a14c28fa11eebba440b8	.4jl!UK3qdc29d52a42a0298a020a6cda60e4bec8	t	\N
144	#gcUi7f15d7029d9992401b856f6c2648142b269d	NRSit8o!c17bbbe990aa2590a33a1f2136cb28dc2	t	\N
145	shtA5zsETcf26d7756313bb4e06416a9e8f4f13a4	ccAKXTdOcda45da26e0f63c59f7529ba5033853c0	t	\N
146	!Um8d9Yjnc7dcf73c04b6fed45baf364c6146cdef	r5OgSUcTxdc1b6ad3becbd53a80cb5aef92458cd8	t	\N
147	WgygVzDS3f42fd21b2553267f99214b802313395d	HPj!KHrnQ913441d762671ef91f7d7f6ff5214c1a	t	\N
148	HXe80A5Aw90d60c597ba79335e7a6f0806ee1bbf9	v6zuE2jULfc6b76bec60e934a1607d87a4de27fba	t	\N
149	NCiMHJ#Rg5ed8b6fbe27c9ed2b0d5b7a6b28ffcc6	iGug7erwc8563ce41b2a856e508fde21a7a770afb	t	\N
\.


--
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Users" ("userId", "firstName", "lastName", email, password, birthdate, active, image, "userName", country) FROM stdin;
221	taller	taller	testtaller2@taller2.com	IiNMNwjul04fecdb13a4efd749bd9d70a220e2a8d	1991-01-01	f	image-e9c7bf1542c708418689742c406f83bbecb85bc9.png	\N	Argentina
10	Nicolas	Alvarez	nicofer87@gmail.com	Z37A1CAS339702816bcd539cc4b760c47faef7f01	1991-01-01	f	\N	\N	\N
225	taller	taller	jPOtVbtFW6a4619c2c475044fbfa9ca7d02f5b2f4	Rh##zvGP6a3eca411fa8eaaca3e1c9c35cb333abf	1991-01-01	t	image-88e2e5666d375cacced30ebdb471e17363150263.png	\N	Argentina
9	Nicolas	Alvarez	nicolasgalvarez91@gmail.com	SXTfXwugP1b4021919cdee8cf5a2bf0ed26df2fbd	1991-01-01	t	\N	\N	\N
235	taller	taller	Jb2uk.!vgc17055dee5fbe43cd73a0dd36dc3b397	Y9WZqZygC3fe078dcadcd0c695f812e803ff5b3a7	1991-01-01	t	image-674f0bd535bd51713cb2a90ef09b4bd3835b006b.png	\N	Argentina
226	taller	taller	testtaller2@taller2.com	dTZy!O0Vz46067d117c09cbeb197e3fb92e719343	1991-01-01	f	image-bb37a91175242d0fb02d54cf11401dadb6573bc6.png	\N	Argentina
229	taller	taller	Ex8GymviS21b014ea4e70abb501415bddef9d186e	kd!zryC2e286beba9fd62290324fcf3cc107ff8e2	1991-01-01	t	image-cfc085242ee604bde63ed0f3cc4ca27aec6ecd3b.png	\N	Argentina
232	taller	taller	LXsJmDTmfc8749537e8f317a7c233eb5d8bf19a7b	SHWRViZMYb319f548b3d2828a50f33c9a4e9992e0	1991-01-01	t	image-79f6b191c369d99917b9437678d6293d7b3c64e2.png	\N	Argentina
8	Nicolas	Fernandez	nflabo@gmail.com	lKNjAxrNu371ac65cf02189af3fcb38051eac9bd7	1991-01-01	t	image-6fc42401c1a14648ebb30e732fbf89c42eebcdec.png	\N	\N
238	taller	taller	xjPzt.Pd.f51144ad2c16ecde35e87ccfcf0b47a7	UObdohLGd011e54336089302b00ebe0091d25b272	1991-01-01	t	image-77c8f8609a4b7a04bef41b869bbc946654e20923.png	\N	Argentina
241	taller	taller	2oNubcSbi09b83710c41ee909196dc44fb06d649e	SByouIor8333fdb593ca5a488be1f57685e509264	1991-01-01	t	image-d670debe65be866520c1dd50220ae0fa7a49b24b.png	\N	Argentina
222	taller	taller	uO38Kv3dGc214ae5e48b707a89e0af5b334fd7f81	2eJRWeCgr5618211ce474aafc8de21c0f2d2b2e07	1991-01-01	t	image-d0ad182047e5d63f2f481addb622636b51103c01.png	\N	Argentina
236	taller	taller	sZj7mRgDA6ec77b8fcdbbba997e255b68a256dadd	ZJxlugNzl3f5fcfb827db1baabecb39527d0c5c6b	1991-01-01	t	image-ef76c37da9ed4a8efdd29159dc32aa6d0cf53695.png	\N	Argentina
223	taller	taller	testtaller2@taller2.com	4ve9M5yJu3e2656a0ceb9bcde17e8b5be64ff0b3d	1991-01-01	f	image-8681938b9633e6c57687f21aec813d17867c4e69.png	\N	Argentina
227	taller	taller	sDS4FErmp08d71c85086a047217111e140493a74f	BU!qUNPn381e71a25f6e624e828706784373bdb92	1991-01-01	t	image-86408a3511d4adcb6fed8de3a4f5c52b98c8db61.png	\N	Argentina
239	taller	taller	fCSG0oLoQ22012f144b7a2c5f88d89e2882940417	h3!jwSU4G4e4842bdbec9d1d64714f4758306fdda	1991-01-01	t	image-64a4f65bdf0e8d7ecfad6cc22911645a6bee92d4.png	\N	Argentina
220	taller	taller	testtaller2@taller2.com	vLYg5IoFPdfa16c6e9462ce12196f720f3f4f8a34	1991-01-01	f	image-96e7d27555a7a6f12cbb562c7e77f02179a2e444.png	\N	Argentina
230	taller	taller	UIC.0dFnNd63d66c7fa27d01ed9c072ecd9006157	HMw8w4p3ia02894a7eaed3b21c3fc15d43a9ee562	1991-01-01	t	image-964091b37750d0824abff362249eac0e88149c83.png	\N	Argentina
233	taller	taller	do1FuQsf!ce1b5906640a751a2cd35967d4c6662c	i0RKaNU2S9c124836a1bf192843e5a7a2f5bcf5cd	1991-01-01	t	image-8637ef15b562587c7649afd769e2912d3ab10f9b.png	\N	Argentina
242	taller	taller	gB5ximVpN57c8abd21b1ca6ee7c0596fe02634512	Ua0VZg7E1ffc360c0525c714ea8e093d3e1c4786e	1991-01-01	t	image-1f6a47248cfd97e5fdb13bbe299bf55022477738.png	\N	Argentina
7	Marcos	Pernica	marcospernica@yahoo.com.ar	ez0wD8!G#f7999c46846ac1ca868ce3b747c059db	1991-01-01	t	image-542daa53b45a85c47202b451c2f6cccfdedc99c1.png	\N	\N
231	taller	taller	U9y!jrlaT0010592106e6bc6597fb3e8f3911f9b2	xcyuDez3c262c62b6ccd9bb2d58118d588b82f7c0	1991-01-01	t	image-2f456c78618dd0c47de5b7a3e466b1c08bcdc413.png	\N	Argentina
224	taller	taller	ObruH.pePfe75c2c1080cc085173ea58aaa43cfb5	a8BWxJjuD729c39a25ba4fbcac15eaec46254ef8b	1991-01-01	t	image-41055e2218db871564981f82638a6a4974f99a54.png	\N	Argentina
237	taller	taller	wf5D9zHP.6c9bf21d00ed0bf067dd3322b1ec9ec3	jO9e#9OiTb3c7f5e3a49049958cc2446e616c4c3b	1991-01-01	t	image-94b6dedeb378f1a6147023d8c70c534faceba7f6.png	\N	Argentina
243	taller	taller	2kU37cCDD50f73e64c40a6b85d4a688d84cace91b	01#O3sjDHbeb9f8efd629b9e5b7c02d2a6e45546e	1991-01-01	t	image-fa89869df35e7de2ebf1b0c42e4f1d8488b1436b.png	\N	Argentina
11	taller	taller	testtaller2@taller2.com	xhd5wGLRH59df3a4a6feccbbef459aacac4e958f2	1991-01-01	t	image-a54ab4d7e268893c382a9c160e28f1bed79e5ff2.png	\N	Argentina
228	taller	taller	Aow2ff9Dsa1ee17932673fb1784a0525be40cdf30	DBu#YoMJq9bda765886352c7455e7df65d8fa11e6	1991-01-01	t	image-838c96ff6d57fa8fe107d851611aec247a6d0402.png	\N	Argentina
234	taller	taller	xmZq!pyMXafb88592303d3c1fccd1ab8bbb7e634a	Iw3XUukvnbc617af5c7e5be29a4d5a998ea6a4628	1991-01-01	t	image-d300210ad1ad5c232d28185e6bb01cc6c8038616.png	\N	Argentina
240	taller	taller	yGUAlmNakc652a5a693e171e0fef90eac760fbcc4	iu5deMlm0b5bab3c561f3ab9ed6917a974e27d7bf	1991-01-01	t	image-34abbfa713a500582d33de1aac987f2147000f9e.png	\N	Argentina
\.


--
-- Name: Users_UserID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Users_UserID_seq"', 243, true);


--
-- Name: AlbumTrack AlbumCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AlbumTrack"
    ADD CONSTRAINT "AlbumCancion_pkey" PRIMARY KEY ("albumId", "trackId");


--
-- Name: Album Album_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Album"
    ADD CONSTRAINT "Album_pkey" PRIMARY KEY ("albumId");


--
-- Name: ArtistTrack ArtistaCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ArtistTrack"
    ADD CONSTRAINT "ArtistaCancion_pkey" PRIMARY KEY ("artistId", "trackId");


--
-- Name: ArtistUser ArtistaUser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ArtistUser"
    ADD CONSTRAINT "ArtistaUser_pkey" PRIMARY KEY ("artistId", "userId");


--
-- Name: Artist Artista_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Artist"
    ADD CONSTRAINT "Artista_pkey" PRIMARY KEY ("artistId");


--
-- Name: Track Cancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Track"
    ADD CONSTRAINT "Cancion_pkey" PRIMARY KEY ("trackId");


--
-- Name: Contact Contacto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Contact"
    ADD CONSTRAINT "Contacto_pkey" PRIMARY KEY ("userId", "contactId");


--
-- Name: GenderAlbum GeneroAlbum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GenderAlbum"
    ADD CONSTRAINT "GeneroAlbum_pkey" PRIMARY KEY ("albumId", "genderId");


--
-- Name: GenderArtist GeneroArtista_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GenderArtist"
    ADD CONSTRAINT "GeneroArtista_pkey" PRIMARY KEY ("artistId", "genderId");


--
-- Name: GenderTrack GeneroCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GenderTrack"
    ADD CONSTRAINT "GeneroCancion_pkey" PRIMARY KEY ("trackId", "genderId");


--
-- Name: Gender Genero_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Gender"
    ADD CONSTRAINT "Genero_pkey" PRIMARY KEY ("genderId");


--
-- Name: FavoriteTrack MarcaCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "FavoriteTrack"
    ADD CONSTRAINT "MarcaCancion_pkey" PRIMARY KEY ("userId", "trackId");


--
-- Name: Users PKUserID; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Users"
    ADD CONSTRAINT "PKUserID" PRIMARY KEY ("userId");


--
-- Name: PlaylistAlbum PlaylistAlbum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlaylistAlbum"
    ADD CONSTRAINT "PlaylistAlbum_pkey" PRIMARY KEY ("playlistId", "albumId");


--
-- Name: PlaylistTrack PlaylistCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlaylistTrack"
    ADD CONSTRAINT "PlaylistCancion_pkey" PRIMARY KEY ("playlistId", "trackId");


--
-- Name: Playlist Playlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Playlist"
    ADD CONSTRAINT "Playlist_pkey" PRIMARY KEY ("playlistId");


--
-- Name: RateTrack PuntuacionCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RateTrack"
    ADD CONSTRAINT "PuntuacionCancion_pkey" PRIMARY KEY ("userId", "trackId");


--
-- Name: PlayTrack ReproduccionCancion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlayTrack"
    ADD CONSTRAINT "ReproduccionCancion_pkey" PRIMARY KEY ("trackId", "userId");


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: PlaylistAlbum FKPlaylistAlbumIDAlbum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlaylistAlbum"
    ADD CONSTRAINT "FKPlaylistAlbumIDAlbum" FOREIGN KEY ("albumId") REFERENCES "Album"("albumId");


--
-- Name: PlaylistAlbum FKPlaylistAlbumIDPlaylist; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlaylistAlbum"
    ADD CONSTRAINT "FKPlaylistAlbumIDPlaylist" FOREIGN KEY ("playlistId") REFERENCES "Playlist"("playlistId");


--
-- Name: AlbumTrack FK_AlbumCancionIDAlbum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AlbumTrack"
    ADD CONSTRAINT "FK_AlbumCancionIDAlbum" FOREIGN KEY ("albumId") REFERENCES "Album"("albumId");


--
-- Name: AlbumTrack FK_AlbumCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AlbumTrack"
    ADD CONSTRAINT "FK_AlbumCancionIDCancion" FOREIGN KEY ("trackId") REFERENCES "Track"("trackId");


--
-- Name: ArtistTrack FK_ArtistaCancionIDArtista; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ArtistTrack"
    ADD CONSTRAINT "FK_ArtistaCancionIDArtista" FOREIGN KEY ("artistId") REFERENCES "Artist"("artistId");


--
-- Name: ArtistTrack FK_ArtistaCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ArtistTrack"
    ADD CONSTRAINT "FK_ArtistaCancionIDCancion" FOREIGN KEY ("trackId") REFERENCES "Track"("trackId");


--
-- Name: ArtistUser FK_ArtistaUserIDArtista; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ArtistUser"
    ADD CONSTRAINT "FK_ArtistaUserIDArtista" FOREIGN KEY ("artistId") REFERENCES "Artist"("artistId");


--
-- Name: ArtistUser FK_ArtistaUserIDUser; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ArtistUser"
    ADD CONSTRAINT "FK_ArtistaUserIDUser" FOREIGN KEY ("userId") REFERENCES "Users"("userId");


--
-- Name: Contact FK_ContactoIDContacto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Contact"
    ADD CONSTRAINT "FK_ContactoIDContacto" FOREIGN KEY ("contactId") REFERENCES "Users"("userId");


--
-- Name: Contact FK_ContactoIDUser; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Contact"
    ADD CONSTRAINT "FK_ContactoIDUser" FOREIGN KEY ("userId") REFERENCES "Users"("userId");


--
-- Name: GenderAlbum FK_GeneroAlbumIDAlbum; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GenderAlbum"
    ADD CONSTRAINT "FK_GeneroAlbumIDAlbum" FOREIGN KEY ("albumId") REFERENCES "Album"("albumId");


--
-- Name: GenderAlbum FK_GeneroAlbumIDGenero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GenderAlbum"
    ADD CONSTRAINT "FK_GeneroAlbumIDGenero" FOREIGN KEY ("genderId") REFERENCES "Gender"("genderId");


--
-- Name: GenderArtist FK_GeneroArtistaIDArtista; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GenderArtist"
    ADD CONSTRAINT "FK_GeneroArtistaIDArtista" FOREIGN KEY ("artistId") REFERENCES "Artist"("artistId");


--
-- Name: GenderArtist FK_GeneroArtistaIDGenero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GenderArtist"
    ADD CONSTRAINT "FK_GeneroArtistaIDGenero" FOREIGN KEY ("genderId") REFERENCES "Gender"("genderId");


--
-- Name: GenderTrack FK_GeneroCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GenderTrack"
    ADD CONSTRAINT "FK_GeneroCancionIDCancion" FOREIGN KEY ("trackId") REFERENCES "Track"("trackId");


--
-- Name: GenderTrack FK_GeneroCancionIDGenero; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "GenderTrack"
    ADD CONSTRAINT "FK_GeneroCancionIDGenero" FOREIGN KEY ("genderId") REFERENCES "Gender"("genderId");


--
-- Name: FavoriteTrack FK_MarcaCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "FavoriteTrack"
    ADD CONSTRAINT "FK_MarcaCancionIDCancion" FOREIGN KEY ("trackId") REFERENCES "Track"("trackId");


--
-- Name: FavoriteTrack FK_MarcaCancionIDUser; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "FavoriteTrack"
    ADD CONSTRAINT "FK_MarcaCancionIDUser" FOREIGN KEY ("userId") REFERENCES "Users"("userId");


--
-- Name: PlaylistTrack FK_PlaylistCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlaylistTrack"
    ADD CONSTRAINT "FK_PlaylistCancionIDCancion" FOREIGN KEY ("trackId") REFERENCES "Track"("trackId");


--
-- Name: PlaylistTrack FK_PlaylistCancionIDPlaylist; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlaylistTrack"
    ADD CONSTRAINT "FK_PlaylistCancionIDPlaylist" FOREIGN KEY ("playlistId") REFERENCES "Playlist"("playlistId");


--
-- Name: RateTrack FK_PuntuacionCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RateTrack"
    ADD CONSTRAINT "FK_PuntuacionCancionIDCancion" FOREIGN KEY ("trackId") REFERENCES "Track"("trackId");


--
-- Name: RateTrack FK_PuntuacionCancionIDUser; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RateTrack"
    ADD CONSTRAINT "FK_PuntuacionCancionIDUser" FOREIGN KEY ("userId") REFERENCES "Users"("userId");


--
-- Name: PlayTrack FK_ReproduccionCancionIDCancion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlayTrack"
    ADD CONSTRAINT "FK_ReproduccionCancionIDCancion" FOREIGN KEY ("trackId") REFERENCES "Track"("trackId");


--
-- Name: PlayTrack FK_ReproduccionCancionIDUser; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PlayTrack"
    ADD CONSTRAINT "FK_ReproduccionCancionIDUser" FOREIGN KEY ("userId") REFERENCES "Users"("userId");


--
-- Name: Playlist FK_UserCreacion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Playlist"
    ADD CONSTRAINT "FK_UserCreacion" FOREIGN KEY (owner) REFERENCES "Users"("userId");


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

