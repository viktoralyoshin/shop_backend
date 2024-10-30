--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Bucket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Bucket" (
    id integer NOT NULL,
    "userId" text
);


ALTER TABLE public."Bucket" OWNER TO postgres;

--
-- Name: Bucket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Bucket_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Bucket_id_seq" OWNER TO postgres;

--
-- Name: Bucket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Bucket_id_seq" OWNED BY public."Bucket".id;


--
-- Name: Category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Category" (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public."Category" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Category_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Category_id_seq" OWNER TO postgres;

--
-- Name: Category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Category_id_seq" OWNED BY public."Category".id;


--
-- Name: Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order" (
    id text NOT NULL,
    price double precision NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" text
);


ALTER TABLE public."Order" OWNER TO postgres;

--
-- Name: Picture; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Picture" (
    id integer NOT NULL,
    "imageUrl" text NOT NULL,
    "productId" integer
);


ALTER TABLE public."Picture" OWNER TO postgres;

--
-- Name: Picture_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Picture_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Picture_id_seq" OWNER TO postgres;

--
-- Name: Picture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Picture_id_seq" OWNED BY public."Picture".id;


--
-- Name: Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Product" (
    id integer NOT NULL,
    name text NOT NULL,
    description text NOT NULL,
    price double precision DEFAULT 0 NOT NULL,
    "categoryId" integer,
    quantity integer DEFAULT 0 NOT NULL,
    rating double precision DEFAULT 0 NOT NULL
);


ALTER TABLE public."Product" OWNER TO postgres;

--
-- Name: Product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Product_id_seq" OWNER TO postgres;

--
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
-- Name: Review; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Review" (
    id integer NOT NULL,
    content text,
    rating double precision DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "userId" text,
    "productId" integer
);


ALTER TABLE public."Review" OWNER TO postgres;

--
-- Name: Review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Review_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Review_id_seq" OWNER TO postgres;

--
-- Name: Review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Review_id_seq" OWNED BY public."Review".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    id text NOT NULL,
    username text NOT NULL,
    password text NOT NULL,
    email text,
    phone text,
    "firstName" text,
    "lastName" text,
    role text DEFAULT 'user'::text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "avatarUrl" text
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: Wishlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Wishlist" (
    id integer NOT NULL,
    "userId" text
);


ALTER TABLE public."Wishlist" OWNER TO postgres;

--
-- Name: Wishlist_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Wishlist_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Wishlist_id_seq" OWNER TO postgres;

--
-- Name: Wishlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Wishlist_id_seq" OWNED BY public."Wishlist".id;


--
-- Name: _BucketToProduct; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_BucketToProduct" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_BucketToProduct" OWNER TO postgres;

--
-- Name: _OrderToProduct; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_OrderToProduct" (
    "A" text NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_OrderToProduct" OWNER TO postgres;

--
-- Name: _ProductToWishlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_ProductToWishlist" (
    "A" integer NOT NULL,
    "B" integer NOT NULL
);


ALTER TABLE public."_ProductToWishlist" OWNER TO postgres;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO postgres;

--
-- Name: Bucket id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bucket" ALTER COLUMN id SET DEFAULT nextval('public."Bucket_id_seq"'::regclass);


--
-- Name: Category id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category" ALTER COLUMN id SET DEFAULT nextval('public."Category_id_seq"'::regclass);


--
-- Name: Picture id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Picture" ALTER COLUMN id SET DEFAULT nextval('public."Picture_id_seq"'::regclass);


--
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- Name: Review id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Review" ALTER COLUMN id SET DEFAULT nextval('public."Review_id_seq"'::regclass);


--
-- Name: Wishlist id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Wishlist" ALTER COLUMN id SET DEFAULT nextval('public."Wishlist_id_seq"'::regclass);


--
-- Data for Name: Bucket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Bucket" (id, "userId") FROM stdin;
\.


--
-- Data for Name: Category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Category" (id, name) FROM stdin;
1	Смартфоны
3	Ноутбуки
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Order" (id, price, "createdAt", "userId") FROM stdin;
\.


--
-- Data for Name: Picture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Picture" (id, "imageUrl", "productId") FROM stdin;
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Product" (id, name, description, price, "categoryId", quantity, rating) FROM stdin;
1	HONOR MagicBook 15	Ноутбук Honor MagicBook 15 BMH-WDQ9HN подходит для домашней и офисной работы. Модель с безрамочным экраном диагональю 15.6 охватывает NTSC 45% цветового пространства.	41999	3	2	2.1
\.


--
-- Data for Name: Review; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Review" (id, content, rating, "createdAt", "userId", "productId") FROM stdin;
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" (id, username, password, email, phone, "firstName", "lastName", role, "createdAt", "avatarUrl") FROM stdin;
\.


--
-- Data for Name: Wishlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Wishlist" (id, "userId") FROM stdin;
\.


--
-- Data for Name: _BucketToProduct; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_BucketToProduct" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _OrderToProduct; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_OrderToProduct" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _ProductToWishlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_ProductToWishlist" ("A", "B") FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
95d51135-3e0b-46ef-9b41-f2a5bba30fa4	f89b86e5360d06266e235d98eea50a971fe4bc7e6b62d97891e78603bf5b4d3c	2024-10-30 15:29:53.206275+08	20241030072953_init	\N	\N	2024-10-30 15:29:53.125467+08	1
988b60c0-bbdf-4aa2-9ffa-bd7d56a18803	a8fa2ade9e16bec777e4aef17c20b41d87d7f3128a5e3f4d26e253540e5c5ea6	2024-10-30 16:18:47.096635+08	20241030081847_init	\N	\N	2024-10-30 16:18:47.088267+08	1
\.


--
-- Name: Bucket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Bucket_id_seq"', 1, false);


--
-- Name: Category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Category_id_seq"', 3, true);


--
-- Name: Picture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Picture_id_seq"', 1, false);


--
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 2, true);


--
-- Name: Review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Review_id_seq"', 1, false);


--
-- Name: Wishlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Wishlist_id_seq"', 1, false);


--
-- Name: Bucket Bucket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bucket"
    ADD CONSTRAINT "Bucket_pkey" PRIMARY KEY (id);


--
-- Name: Category Category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Category"
    ADD CONSTRAINT "Category_pkey" PRIMARY KEY (id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- Name: Picture Picture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Picture"
    ADD CONSTRAINT "Picture_pkey" PRIMARY KEY (id);


--
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- Name: Review Review_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: Wishlist Wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Wishlist"
    ADD CONSTRAINT "Wishlist_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: Bucket_userId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Bucket_userId_key" ON public."Bucket" USING btree ("userId");


--
-- Name: Category_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Category_name_key" ON public."Category" USING btree (name);


--
-- Name: User_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "User_username_key" ON public."User" USING btree (username);


--
-- Name: Wishlist_userId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "Wishlist_userId_key" ON public."Wishlist" USING btree ("userId");


--
-- Name: _BucketToProduct_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_BucketToProduct_AB_unique" ON public."_BucketToProduct" USING btree ("A", "B");


--
-- Name: _BucketToProduct_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_BucketToProduct_B_index" ON public."_BucketToProduct" USING btree ("B");


--
-- Name: _OrderToProduct_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_OrderToProduct_AB_unique" ON public."_OrderToProduct" USING btree ("A", "B");


--
-- Name: _OrderToProduct_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_OrderToProduct_B_index" ON public."_OrderToProduct" USING btree ("B");


--
-- Name: _ProductToWishlist_AB_unique; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "_ProductToWishlist_AB_unique" ON public."_ProductToWishlist" USING btree ("A", "B");


--
-- Name: _ProductToWishlist_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_ProductToWishlist_B_index" ON public."_ProductToWishlist" USING btree ("B");


--
-- Name: Bucket Bucket_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Bucket"
    ADD CONSTRAINT "Bucket_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Order Order_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Picture Picture_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Picture"
    ADD CONSTRAINT "Picture_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Product Product_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."Category"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Review Review_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Review Review_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Wishlist Wishlist_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Wishlist"
    ADD CONSTRAINT "Wishlist_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: _BucketToProduct _BucketToProduct_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_BucketToProduct"
    ADD CONSTRAINT "_BucketToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES public."Bucket"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _BucketToProduct _BucketToProduct_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_BucketToProduct"
    ADD CONSTRAINT "_BucketToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _OrderToProduct _OrderToProduct_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_OrderToProduct"
    ADD CONSTRAINT "_OrderToProduct_A_fkey" FOREIGN KEY ("A") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _OrderToProduct _OrderToProduct_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_OrderToProduct"
    ADD CONSTRAINT "_OrderToProduct_B_fkey" FOREIGN KEY ("B") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ProductToWishlist _ProductToWishlist_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_ProductToWishlist"
    ADD CONSTRAINT "_ProductToWishlist_A_fkey" FOREIGN KEY ("A") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _ProductToWishlist _ProductToWishlist_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_ProductToWishlist"
    ADD CONSTRAINT "_ProductToWishlist_B_fkey" FOREIGN KEY ("B") REFERENCES public."Wishlist"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

