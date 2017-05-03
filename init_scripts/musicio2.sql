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
    "Activo" boolean DEFAULT true NOT NULL,
    "Duracion" bigint
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
    "Activo" boolean DEFAULT false NOT NULL,
    "ImageName" character varying
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
1	Ricky	Martin	30	t
\.


--
-- Data for Name: ArtistaCancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ArtistaCancion" ("ArtistaID", "CancionID") FROM stdin;
1	2
\.


--
-- Data for Name: ArtistaUser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ArtistaUser" ("ArtistaID", "UserID") FROM stdin;
\.


--
-- Name: Artista_ArtistaID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Artista_ArtistaID_seq"', 1, true);


--
-- Data for Name: Cancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Cancion" ("CancionID", "Nombre", "Descripcion", "Activo", "Duracion") FROM stdin;
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
36	scolmTUtGe0df48450b9f574704a252e901162fa1	hBwAF7TX!e2cba96dfc7e62487fc7a81f4621e2d6	t	\N
46	cmwmONGts7c7ad674108f909a795d4f19132e9506	4jrGnuSCma199d84c322b426d6000790dd2225961	t	\N
1	testeame	testeame	f	150
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
\.


--
-- Name: Cancion_CancionID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Cancion_CancionID_seq"', 87, true);


--
-- Data for Name: Contacto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Contacto" ("UserID", "ContactoID", "Activo") FROM stdin;
11	8	t
11	9	t
\.


--
-- Data for Name: Genero; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "Genero" ("GeneroID", "Descripcion", "Activo") FROM stdin;
1	Folklore	t
2	Pop	t
3	Latino	t
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
2	3
1	2
\.


--
-- Name: Genero_GeneroID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Genero_GeneroID_seq"', 1, true);


--
-- Data for Name: MarcaCancion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "MarcaCancion" ("UserID", "CancionID") FROM stdin;
8	1
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
7	1	5
8	1	10
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

COPY "Users" ("UserID", "Name", "LastName", "Email", "Passwd", "FechaNacimiento", "Activo", "ImageName") FROM stdin;
8	Nicolas	Fernandez	nflabo@gmail.comr	U8UuVq7U!da0a1189708d3ec8814ab962331fbd49	1991-01-01	t	\N
9	Nicolas	Alvarez	nicolasgalvarez91@gmail.com	SXTfXwugP1b4021919cdee8cf5a2bf0ed26df2fbd	1991-01-01	t	\N
14	taller	taller	testtaller2@taller2.com	j78#VA!uV3872c24d6ca429d698e354dab900b44d	1991-01-01	f	\N
51	taller	taller	testtaller2@taller2.com	O4d2LnOgW2a13d03e9a9ba3e4931b4527610bcda5	1991-01-01	f	\N
39	taller	taller	testtaller2@taller2.com	VUpsKdz7Nd6d5d7352d8bc3db97c320483beb4cea	1991-01-01	f	\N
15	taller	taller	testtaller2@taller2.com	NS3zebC3h055178bdaf68a775722eec08b821dbad	1991-01-01	f	\N
25	taller	taller	testtaller2@taller2.com	8nwB!8cdNf6d211bd7a60b186f227190cb7fc063b	1991-01-01	f	\N
16	taller	taller	testtaller2@taller2.com	aa3krjVUb9d2d193fae1e7a38efac070e1c8ae518	1991-01-01	f	\N
33	taller	taller	testtaller2@taller2.com	ZfU2E1Euf0472963380c015316f851c3d1f29b2e3	1991-01-01	f	\N
44	taller	taller	testtaller2@taller2.com	TC9r662Uae5172a2288e49044ad953f3987749d8d	1991-01-01	f	\N
17	taller	taller	testtaller2@taller2.com	M1hhbgatE634e001b39eb62822f129be65036b54a	1991-01-01	f	\N
26	taller	taller	testtaller2@taller2.com	ow0XNo3ut89919ab495417b22442c115d2f84f22b	1991-01-01	f	\N
18	taller	taller	testtaller2@taller2.com	FAwdhf72w5f990c893628749abe69ae07135f25bc	1991-01-01	f	\N
48	taller	taller	testtaller2@taller2.com	GPjKrYoHy751a4afcbaa6e66a93b1e2548bfa2044	1991-01-01	f	\N
34	taller	taller	testtaller2@taller2.com	0PaH68aPm18bafcdc4a7af8bf4353dcf4b7dc4f09	1991-01-01	f	\N
27	taller	taller	testtaller2@taller2.com	e0Nc.DQNPafb53c5c19ec36f8afd513a6f5bce67e	1991-01-01	f	\N
19	taller	taller	testtaller2@taller2.com	62kkZhUNR8e9da6fc87e687c8ac7d244774217926	1991-01-01	f	\N
40	taller	taller	testtaller2@taller2.com	74ylwIFAU420a4aefe6cb9df770e4b8ce9f4e0c90	1991-01-01	f	\N
20	taller	taller	testtaller2@taller2.com	v3RYpo6bWe488af558a2b785a70b8441b3384a13f	1991-01-01	f	\N
28	taller	taller	testtaller2@taller2.com	QUzgnosdIa880bf9cb156d5423b0f7036d7e8fd29	1991-01-01	f	\N
21	taller	taller	testtaller2@taller2.com	.FKR7Oc7nfde999440dae415ce2154a48d1109c83	1991-01-01	f	\N
12	taller	taller	testtaller2@taller2.com	9hvcwJ6CMde95f3b2d4edabc87af9f3703b16e3b9	1991-01-01	f	\N
35	taller	taller	testtaller2@taller2.com	ED5.5leDB21fd2dcdc3be89fd0087a6e417a96cf9	1991-01-01	f	\N
22	taller	taller	testtaller2@taller2.com	CWTUpfX!m73151a9e882c798497f7aacbae062c30	1991-01-01	f	\N
13	taller	taller	testtaller2@taller2.com	.hO!549y9c42652431ddd37429c6e7b9a4c7e7869	1991-01-01	f	\N
29	taller	taller	testtaller2@taller2.com	X0dK2fyUW925c174a3b86d07a311c5dc0f00ba3ed	1991-01-01	f	\N
45	taller	taller	testtaller2@taller2.com	UI1qH65Nu5249b0567fa8835c77c712d3dc496d78	1991-01-01	f	\N
41	taller	taller	testtaller2@taller2.com	96c3VccIW471120ff9ccb53a3119327e792f06c39	1991-01-01	f	\N
23	taller	taller	testtaller2@taller2.com	SzLJ5hXU.3ad2d95f1039762bcc608074403fd7d5	1991-01-01	f	\N
36	taller	taller	testtaller2@taller2.com	RvbsC8ZRL8f7c7610749500a9adca9f79ea3c0ed0	1991-01-01	f	\N
30	taller	taller	testtaller2@taller2.com	1RF1scRxt254ebbda46a6cd2efa35926f2fd37ced	1991-01-01	f	\N
24	taller	taller	testtaller2@taller2.com	ySDsikB#Obc9c4813b5024f72ca7deaac0c21cb77	1991-01-01	f	\N
31	taller	taller	testtaller2@taller2.com	BwPF5S.!n000ffe4d415b49dd76c772accd8bdcb9	1991-01-01	f	\N
62	taller	taller	testtaller2@taller2.com	0RHolrT!B192339a91eaded90fcbc6ce1306a2891	1991-01-01	f	\N
37	taller	taller	testtaller2@taller2.com	0#eNBGKVu4c8f8669c2a6b706f70ab9e651ee13c4	1991-01-01	f	\N
42	taller	taller	testtaller2@taller2.com	BdI0EtyVk1f50c90777460e9ac68ced599055cdaf	1991-01-01	f	\N
32	taller	taller	testtaller2@taller2.com	8c7ouc6hVfb894332bb9c0d598e2d143282a1446f	1991-01-01	f	\N
49	taller	taller	testtaller2@taller2.com	paHVejlI4c3422c02a40eb41da2d1a9bab245c6a7	1991-01-01	f	\N
46	taller	taller	testtaller2@taller2.com	lloti7SC61d8493abdd1d3f809a359defb280efd3	1991-01-01	f	\N
38	taller	taller	testtaller2@taller2.com	6Tb324Bj.76c44aa9a4e15af377c83203f9a3d253	1991-01-01	f	\N
54	taller	taller	testtaller2@taller2.com	vPI9L7vcdf6342b3af3069beaa1b43b6f254ae0d3	1991-01-01	f	\N
43	taller	taller	testtaller2@taller2.com	Hfc1W1iqac5c9a184491fdf26a83b03bab65b495d	1991-01-01	f	\N
52	taller	taller	testtaller2@taller2.com	!a#m7SRG54fcbc5c23b69a1cae7918ac756cfa5bd	1991-01-01	f	\N
50	taller	taller	testtaller2@taller2.com	z6nt6qVIka2a7e18018449a0f6b658ce541fe3fa1	1991-01-01	f	\N
47	taller	taller	testtaller2@taller2.com	nptmMrmhi57fd912d1b218c2c22b2a164749d9f15	1991-01-01	f	\N
56	taller	taller	testtaller2@taller2.com	mmVahyLuR3ce5a6279e51bac53b6302f5d45cae32	1991-01-01	f	\N
61	taller	taller	testtaller2@taller2.com	UdQ77YT6I73bda76b4ff61548368bf503b4602d32	1991-01-01	f	\N
59	taller	taller	testtaller2@taller2.com	g207GvQ.E88eed9bfdc88e15e6f2936e7b200292d	1991-01-01	f	\N
53	taller	taller	testtaller2@taller2.com	SFo#gxehvc0a753d221f9f5e7b06d8e9be8013864	1991-01-01	f	\N
55	taller	taller	testtaller2@taller2.com	DCGD4ogkrb616aa02e7653ef82a759b2766cf3253	1991-01-01	f	\N
58	taller	taller	testtaller2@taller2.com	5ewgac!NA77687cd72d52b2c6a4c2ee50f1099e9c	1991-01-01	f	\N
57	taller	taller	testtaller2@taller2.com	98!Oy9aLR6f73c788bae90bcc2c739874f1d53e98	1991-01-01	f	\N
60	taller	taller	testtaller2@taller2.com	GYoVc5PmZd016ac460a56d27d1e3b309a5b59926b	1991-01-01	f	\N
63	taller	taller	testtaller2@taller2.com	#SCPsepXG58c650bbcd16b8086f3b5e5988e7eabe	1991-01-01	f	\N
10	Nicolas	Alvarez	nicofer87@gmail.com	Z37A1CAS339702816bcd539cc4b760c47faef7f01	1991-01-01	t	\N
64	taller	taller	testtaller2@taller2.com	jQwu4YPwU9f8d00d9c5b23a7e929409e0f2cacff1	1991-01-01	f	\N
65	taller	taller	testtaller2@taller2.com	a26euA9em909131ec1951b3926a5bfcb45b13a5fd	1991-01-01	f	\N
66	taller	taller	testtaller2@taller2.com	2cUTnwZ.O114426359398f83422be3d88306f9b1a	1991-01-01	f	\N
67	taller	taller	testtaller2@taller2.com	Ai2XUT5VB337080607cabb5a25a19f8ca519c1dca	1991-01-01	f	\N
68	taller	taller	testtaller2@taller2.com	Vr2srJ2u3da2f5ccd908545613dcf8e4ed658b6d8	1991-01-01	f	\N
69	taller	taller	testtaller2@taller2.com	9Iqk0#Xpc157ff9cfca8811b06e01d5f4c4409af9	1991-01-01	f	\N
89	taller	taller	testtaller2@taller2.com	NMpQyYQBk67243d7ff792c4ac411e37d707214121	1991-01-01	f	\N
70	taller	taller	testtaller2@taller2.com	Q!!tOu9Fue862bf9dabb48fc539b99ee94bf917db	1991-01-01	f	\N
71	taller	taller	testtaller2@taller2.com	7sE4gF3ek21ef45c2319f6cf07fc6469ef0542a48	1991-01-01	f	\N
116	taller	taller	testtaller2@taller2.com	ID.nzFXqv30187cba58f6642102873b2ab8f30788	1991-01-01	f	\N
72	taller	taller	testtaller2@taller2.com	4Fd5C5o0c2c75913b00bba1bdc928082a55acbfd9	1991-01-01	f	\N
90	taller	taller	testtaller2@taller2.com	!XoTZ9mwk4dc6720f2e845582ec241a5f16afc2a9	1991-01-01	f	\N
73	taller	taller	testtaller2@taller2.com	YldZJT9SJd0a99795a692acf42fd38115aba19bc8	1991-01-01	f	\N
74	taller	taller	testtaller2@taller2.com	7E6xR1mOY7422be136c065dcdc37518c1469de098	1991-01-01	f	\N
102	taller	taller	testtaller2@taller2.com	ci4YD89kA8cddb112f9802d67f2684b38472029ef	1991-01-01	f	\N
75	taller	taller	testtaller2@taller2.com	jYQYlDAffe0e2213d0c626d4282e8b49200b7ab85	1991-01-01	f	\N
91	taller	taller	testtaller2@taller2.com	uu#z7h3dK7efd3c57abe0dc9e16a7042d60d9a0e3	1991-01-01	f	\N
76	taller	taller	testtaller2@taller2.com	sz8fnDKBQfdd688087bdf9dc0d23dee0f59295918	1991-01-01	f	\N
77	taller	taller	testtaller2@taller2.com	0W7ix..xY26aa272ff37bd67ff7dcb9f830fa3ae5	1991-01-01	f	\N
78	taller	taller	testtaller2@taller2.com	a7CrkJwORae29942be25a99f643fa02a77f2c44e9	1991-01-01	f	\N
92	taller	taller	testtaller2@taller2.com	ml#dagF#Na4f95c24c5f601b07910d57fd72eaa31	1991-01-01	f	\N
79	taller	taller	testtaller2@taller2.com	KuPuLazTo3754d921ad6d16f300fe6c75d73431a2	1991-01-01	f	\N
80	taller	taller	testtaller2@taller2.com	pilHUYVgB7e5b61f7bda2d4d263d8d05003f00b9c	1991-01-01	f	\N
81	taller	taller	testtaller2@taller2.com	Uocuo77kscc789233d86cc4e3b46ddb72ded686ef	1991-01-01	f	\N
93	taller	taller	testtaller2@taller2.com	8OOyJHiIw7f25225a7e5c4f788956f26b45ba59ba	1991-01-01	f	\N
82	taller	taller	testtaller2@taller2.com	msVvBs1oPb110d7514f46ef93f9617f1eb6a15875	1991-01-01	f	\N
83	taller	taller	testtaller2@taller2.com	USmUvGhy0323ebe716bf42be44a2f14a2d930b7f3	1991-01-01	f	\N
108	taller	taller	testtaller2@taller2.com	GIgcjb8FK9cbaeb67847c29b6022c347ccc8a93f8	1991-01-01	f	\N
84	taller	taller	testtaller2@taller2.com	c1kMZ0b!A2d6b040abab9eff7e389d553b0347953	1991-01-01	f	\N
94	taller	taller	testtaller2@taller2.com	JaLVuN0Vk4fe71b2ad45cea29ed7043cb4a3ab414	1991-01-01	f	\N
85	taller	taller	testtaller2@taller2.com	ieljiwloj047130f8526d2ee6f21aac3687366700	1991-01-01	f	\N
86	taller	taller	testtaller2@taller2.com	Dc#Of4wmY1a712fba968b2c3a468a7e94eda44bc0	1991-01-01	f	\N
87	taller	taller	testtaller2@taller2.com	2E2wv6r9oa5ce0ca3a53ff96de1c6a50d8e5013d8	1991-01-01	f	\N
95	taller	taller	testtaller2@taller2.com	19D7Iy2fje6ce6d49c3554f8c7f2d411662a4e967	1991-01-01	f	\N
88	taller	taller	testtaller2@taller2.com	it7uw4PbPb622e94f93518374862b807e85239430	1991-01-01	f	\N
113	taller	taller	testtaller2@taller2.com	uoJwjfbTNc3b7ef4b815fc76f3be002315ee11393	1991-01-01	f	\N
109	taller	taller	testtaller2@taller2.com	fFUqAroPt5c9066a4d53604b118b287f18796d606	1991-01-01	f	\N
96	taller	taller	testtaller2@taller2.com	FEubEfNeZ1416ec3dea25d9b6afbb05436e5b2a20	1991-01-01	f	\N
103	taller	taller	testtaller2@taller2.com	EpDgL2ZCnc372882c24f62e1cbb04b638e815eed3	1991-01-01	f	\N
97	taller	taller	testtaller2@taller2.com	3RX8#lVgz97cb46667b92b4d82b47be9a947208c1	1991-01-01	f	\N
98	taller	taller	testtaller2@taller2.com	6RdDuSbU77da274aa7304f15520e1526a14471a9c	1991-01-01	f	\N
99	taller	taller	testtaller2@taller2.com	34JZXboyS7afa3ca0c40d57608ff9a1e17fc3371b	1991-01-01	f	\N
104	taller	taller	testtaller2@taller2.com	nzuINGmdDd290551a9dcb6fd55fd197e51e4a189c	1991-01-01	f	\N
100	taller	taller	testtaller2@taller2.com	#oEb7tpZu8e7f92fd221f91f6acfc4efecfeee15f	1991-01-01	f	\N
101	taller	taller	testtaller2@taller2.com	jalgTsRIuab1540da978fcadeae3b6303b0fca739	1991-01-01	f	\N
110	taller	taller	testtaller2@taller2.com	wKyJxajGqeef6c278f277c84aae2d4486a4988513	1991-01-01	f	\N
105	taller	taller	testtaller2@taller2.com	pEE432bSq21a17278711e18b1cad08487dfba3ec4	1991-01-01	f	\N
106	taller	taller	testtaller2@taller2.com	1M0ayvUiz45740cb96234be7e69ca5a78e710e0e1	1991-01-01	f	\N
107	taller	taller	testtaller2@taller2.com	uA7gMMZTde94218d97d8a34901553bfaae205e2f8	1991-01-01	f	\N
114	taller	taller	testtaller2@taller2.com	PgmsXwm3Jc6fda0a6a4fda4a74b2447fa0eaebe1d	1991-01-01	f	\N
111	taller	taller	testtaller2@taller2.com	18ZIsQ3N5c642d561416f4b0a207a7be3d4403e1c	1991-01-01	f	\N
118	taller	taller	testtaller2@taller2.com	gM1Mi9Y4Ue4e824a55fe3dc44038e9903d01aa688	1991-01-01	f	\N
112	taller	taller	testtaller2@taller2.com	W2TZD8CXm3e10178b779429f8ceeab2bd77f4dfae	1991-01-01	f	\N
115	taller	taller	testtaller2@taller2.com	uuMG8sN7342a427f208ed301ba88fb60afe9cf0d8	1991-01-01	f	\N
120	taller	taller	testtaller2@taller2.com	WqcvjXgIO36bf9d81a07f39038c012bdea1036416	1991-01-01	f	\N
117	taller	taller	testtaller2@taller2.com	gPB7HNTcqe1cf1dac8a24e6fd362230f8a9104a2a	1991-01-01	f	\N
119	taller	taller	testtaller2@taller2.com	WvJ4GXSxzef3ab9274cd3f23588e9d541ba560f1f	1991-01-01	f	\N
121	taller	taller	testtaller2@taller2.com	ZJSh6Uan8ed20d317d1551a4f999abc9bb4fd5d63	1991-01-01	f	\N
123	taller	taller	testtaller2@taller2.com	CDIDUHS0ef3f8914f39bdef310c21f4bd70713a57	1991-01-01	f	\N
122	taller	taller	testtaller2@taller2.com	GcIoKe9OZb7e8d1fe05442de99f560c2e2b868283	1991-01-01	f	\N
124	taller	taller	testtaller2@taller2.com	f9ILmoW6Rb98fc3c8736a79c8cb2d4a9323cf9bb9	1991-01-01	f	\N
125	taller	taller	testtaller2@taller2.com	0FmxP1BAZ3982d932511a956ea669800925f64a8d	1991-01-01	f	\N
126	taller	taller	testtaller2@taller2.com	gb7Ra2wgL0700d7dd6ab393b088f31931c3fdf05e	1991-01-01	f	\N
127	taller	taller	testtaller2@taller2.com	ufa!rAO.Kf1315d23570714b3dd23411863ec696b	1991-01-01	f	\N
128	taller	taller	testtaller2@taller2.com	KHXMqkejC6bb0c326ec89be609ebd239ba8eca1cf	1991-01-01	f	\N
129	taller	taller	testtaller2@taller2.com	!Lu2U3TuE9fcdf1fd3d082fc3365945bacbcbdfd8	1991-01-01	f	\N
7	Marcos	Pernica	marcospernica@yahoo.com.ar	ez0wD8!G#f7999c46846ac1ca868ce3b747c059db	1991-01-01	t	image-67f36c667dc04639eb923c739accbb677e544abc.png
130	taller	taller	testtaller2@taller2.com	on5hNfGUJfd9d6c32ea5a98b749f1da89350eee34	1991-01-01	f	\N
147	taller	taller	testtaller2@taller2.com	cDt4e9ugxd0a4f9d823218cd114ce76dae6fd29af	1991-01-01	f	\N
131	taller	taller	testtaller2@taller2.com	P7MBNpCRufb25eed9dd8d72ab67516244d4fc41d2	1991-01-01	f	\N
132	taller	taller	testtaller2@taller2.com	opmv1ylk04b1f4113f735dca000409632c2117b5f	1991-01-01	f	\N
133	taller	taller	testtaller2@taller2.com	UqF.9PPSF7c660d2f9e63e51d3caaca34b6e118b8	1991-01-01	f	\N
148	taller	taller	testtaller2@taller2.com	aHAi7ti2u50a7cd0e343dcb9ba11b7fc1bf26b356	1991-01-01	f	\N
134	taller	taller	testtaller2@taller2.com	rYE5i2i0E2273a3e67d5a0945945eb6ad6b250be4	1991-01-01	f	\N
135	taller	taller	testtaller2@taller2.com	egC7BJ56N36a60857900cce4160ecfafada7e3724	1991-01-01	f	\N
159	taller	taller	testtaller2@taller2.com	!HQ7AP3Zx27c5044d4348ae7036282287cd9d4b59	1991-01-01	f	\N
136	taller	taller	testtaller2@taller2.com	dRi6UNoL02d5738609f30e94850aa05f101ad95b3	1991-01-01	f	\N
149	taller	taller	testtaller2@taller2.com	bJ4.PubkR653086836c0d6dd2f353183737a5a43f	1991-01-01	f	\N
137	taller	taller	testtaller2@taller2.com	hEhsIZQjJ24f19d6cc8bf484776d6df57dd3afff9	1991-01-01	f	\N
138	taller	taller	testtaller2@taller2.com	v3M4BigHe7b3ecb5f2cc671d21714ddd365883f05	1991-01-01	f	\N
139	taller	taller	testtaller2@taller2.com	GJpmOcRpc6f8e4d252512f76c38afe8c62fa3d05c	1991-01-01	f	\N
150	taller	taller	testtaller2@taller2.com	hg.1rdJfW9ab637269ff461fdee823653fb1bd2b5	1991-01-01	f	\N
140	taller	taller	testtaller2@taller2.com	vGX7svUV#d7190d6db02c51f12d6fc8f78b47c900	1991-01-01	f	\N
141	taller	taller	testtaller2@taller2.com	cjOJrtuam5348134ab3dc35dbcc1cd2a002456d82	1991-01-01	f	\N
142	taller	taller	testtaller2@taller2.com	i97fGLXZW411022f03fe8edee480a73511223853b	1991-01-01	f	\N
151	taller	taller	testtaller2@taller2.com	08C3hVV2re0d71785be06fcd3d401eb796e2af2e0	1991-01-01	f	\N
143	taller	taller	testtaller2@taller2.com	rNk5uuGuH9fd8d9dc6340aa9a648d02c0a982159c	1991-01-01	f	\N
144	taller	taller	testtaller2@taller2.com	2MpUUxdNn02712b92ddb9da496a61044d6a6bba75	1991-01-01	f	\N
160	taller	taller	testtaller2@taller2.com	Ed4VF!3ZL613fbe94711c152e58fef6c44c4063a4	1991-01-01	f	\N
145	taller	taller	testtaller2@taller2.com	PcIxPqI#p805dedf2d8293405c8ad0b080e20b157	1991-01-01	f	\N
146	taller	taller	testtaller2@taller2.com	KEz#0liAId5177d8ad742337936a65b9db06b8b0d	1991-01-01	f	\N
152	taller	taller	testtaller2@taller2.com	UzLiyrSLt723ee59c69f0e5e51d5c78796dd2d5e9	1991-01-01	f	\N
153	taller	taller	testtaller2@taller2.com	7z54lcN3Ob1b9d083166c9e227686b30e939812eb	1991-01-01	f	\N
161	taller	taller	testtaller2@taller2.com	GSJzwlgdL9a6c9116529f29e1cb73b5b4d50a156d	1991-01-01	f	\N
154	taller	taller	testtaller2@taller2.com	nS9XkFovJf975100f31e3bf3cb6995913e03bfb13	1991-01-01	f	\N
155	taller	taller	testtaller2@taller2.com	ZTRCAZUNub9b29575f05bcdb588904eb96a4a27d0	1991-01-01	f	\N
156	taller	taller	testtaller2@taller2.com	Spj6ylpJs7a657ffd6728c7ada5253646d00406be	1991-01-01	f	\N
162	taller	taller	testtaller2@taller2.com	aulV2DzoQf8831b3f573c0289978376d11105a39e	1991-01-01	f	\N
157	taller	taller	testtaller2@taller2.com	Vauj.uRS76aec40325400a7739da1506c2dcd62a9	1991-01-01	f	\N
158	taller	taller	testtaller2@taller2.com	rjPSm.ejZ75b916434c8405ed42a4c9c7586f0029	1991-01-01	f	\N
163	taller	taller	testtaller2@taller2.com	pzODYnh6#4004be13050bc7cb1a6fdb8279e63af5	1991-01-01	f	\N
164	taller	taller	testtaller2@taller2.com	CzBbIZNfi7e7765af40b22d54b3548ed5c270fba3	1991-01-01	f	\N
165	taller	taller	testtaller2@taller2.com	6TPST7BHV7958754969b2b7596973938cc95b1154	1991-01-01	t	\N
11	Nicolas	Fernandez	nflabo@gmail.com	TajGp0ceg31e33a683c02329b0c22e42a46b327fc	1991-01-01	t	image-f87e4b7e0d4db0148a69c35a374a2f811fc46e64.png
\.


--
-- Name: Users_UserID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"Users_UserID_seq"', 165, true);


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

