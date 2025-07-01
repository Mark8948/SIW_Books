-- === AUTORI ===
INSERT INTO autore (nome, cognome, data_nascita, data_morte, nazionalita, fotografia_id) VALUES ('Haruki', 'Murakami', '1949-01-12', NULL, 'Giapponese', NULL);
INSERT INTO autore (nome, cognome, data_nascita, data_morte, nazionalita, fotografia_id) VALUES ('Margaret', 'Atwood', '1939-11-18', NULL, 'Canadese', NULL);
INSERT INTO autore (nome, cognome, data_nascita, data_morte, nazionalita, fotografia_id) VALUES ('Neil', 'Gaiman', '1960-11-10', NULL, 'Britannico', NULL);
INSERT INTO autore (nome, cognome, data_nascita, data_morte, nazionalita, fotografia_id) VALUES ('Elena', 'Ferrante', NULL, NULL, 'Italiana', NULL);
INSERT INTO autore (nome, cognome, data_nascita, data_morte, nazionalita, fotografia_id) VALUES ('Cormac', 'McCarthy', '1933-07-20', '2023-06-13', 'Americana', NULL);

-- === LIBRI ===
INSERT INTO libro (titolo, anno_pubblicazione) VALUES ('Kafka sulla spiaggia', 2002);
INSERT INTO libro (titolo, anno_pubblicazione) VALUES ('Il racconto dell ancella', 1985);
INSERT INTO libro (titolo, anno_pubblicazione) VALUES ('American Gods', 2001);
INSERT INTO libro (titolo, anno_pubblicazione) VALUES ('L amica geniale', 2011);
INSERT INTO libro (titolo, anno_pubblicazione) VALUES ('La strada', 2006);

-- === RELAZIONI LIBRO-AUTORE ===
INSERT INTO libro_autori (libro_id, autori_id) VALUES ((SELECT id FROM libro WHERE titolo = 'Kafka sulla spiaggia'), (SELECT id FROM autore WHERE nome = 'Haruki'));
INSERT INTO libro_autori (libro_id, autori_id) VALUES ((SELECT id FROM libro WHERE titolo = 'Il racconto dell ancella'), (SELECT id FROM autore WHERE nome = 'Margaret'));
INSERT INTO libro_autori (libro_id, autori_id) VALUES ((SELECT id FROM libro WHERE titolo = 'American Gods'), (SELECT id FROM autore WHERE nome = 'Neil'));
INSERT INTO libro_autori (libro_id, autori_id) VALUES ((SELECT id FROM libro WHERE titolo = 'L amica geniale'), (SELECT id FROM autore WHERE nome = 'Elena'));
INSERT INTO libro_autori (libro_id, autori_id) VALUES ((SELECT id FROM libro WHERE titolo = 'La strada'), (SELECT id FROM autore WHERE nome = 'Cormac'));

-- === UTENTI ===
INSERT INTO utente (nome, cognome, email) VALUES ('Marco', 'Bianchi', 'marco.bianchi@example.com');
INSERT INTO utente (nome, cognome, email) VALUES ('Sara', 'Rossi', 'sara.rossi@example.com');
INSERT INTO utente (nome, cognome, email) VALUES ('Luigi', 'Verdi', 'luigi.verdi@example.com');

-- === RECENSIONI ===
INSERT INTO recensione (titolo, voto, testo, autore_id, libro_id) VALUES ('Misterioso', 5, 'Un viaggio surreale e introspettivo.', (SELECT id FROM utente WHERE nome = 'Marco'), (SELECT id FROM libro WHERE titolo = 'Kafka sulla spiaggia'));
INSERT INTO recensione (titolo, voto, testo, autore_id, libro_id) VALUES ('Distopico e potente', 4, 'Una critica sociale avvincente.', (SELECT id FROM utente WHERE nome = 'Sara'), (SELECT id FROM libro WHERE titolo = 'Il racconto dell ancella'));
INSERT INTO recensione (titolo, voto, testo, autore_id, libro_id) VALUES ('Mitologia moderna', 5, 'Una storia ricca di simboli e significati.', (SELECT id FROM utente WHERE nome = 'Luigi'), (SELECT id FROM libro WHERE titolo = 'American Gods'));
INSERT INTO recensione (titolo, voto, testo, autore_id, libro_id) VALUES ('Toccante', 4, 'Un ritratto sincero di un amicizia.', (SELECT id FROM utente WHERE nome = 'Marco'), (SELECT id FROM libro WHERE titolo = 'L amica geniale'));
INSERT INTO recensione (titolo, voto, testo, autore_id, libro_id) VALUES ('Oscuro e poetico', 5, 'Sopravvivenza e amore in un mondo distrutto.', (SELECT id FROM utente WHERE nome = 'Sara'), (SELECT id FROM libro WHERE titolo = 'La strada'));

-- === IMMAGINI LIBRI ===
INSERT INTO immagine (nome_file, path, libro_id) VALUES ('kafka_sulla_spiaggia_1.jpeg', '/images/books/kafka_sulla_spiaggia_1.jpeg', (SELECT id FROM libro WHERE titolo = 'Kafka sulla spiaggia'));
INSERT INTO immagine (nome_file, path, libro_id) VALUES ('kafka_sulla_spiaggia_2.jpeg', '/images/books/kafka_sulla_spiaggia_2.jpeg', (SELECT id FROM libro WHERE titolo = 'Kafka sulla spiaggia'));
INSERT INTO immagine (nome_file, path, libro_id) VALUES ('il_racconto_dell_ancella_1.jpg', '/images/books/il_racconto_dell_ancella_1.jpg', (SELECT id FROM libro WHERE titolo = 'Il racconto dell ancella'));
INSERT INTO immagine (nome_file, path, libro_id) VALUES ('il_racconto_dell_ancella_2.jpg', '/images/books/il_racconto_dell_ancella_2.jpg', (SELECT id FROM libro WHERE titolo = 'Il racconto dell ancella'));
INSERT INTO immagine (nome_file, path, libro_id) VALUES ('american_gods_1.jpg', '/images/books/american_gods_1.jpg', (SELECT id FROM libro WHERE titolo = 'American Gods'));
INSERT INTO immagine (nome_file, path, libro_id) VALUES ('american_gods_2.jpg', '/images/books/american_gods_2.jpg', (SELECT id FROM libro WHERE titolo = 'American Gods'));
INSERT INTO immagine (nome_file, path, libro_id) VALUES ('l_amica_geniale_1.jpg', '/images/books/l_amica_geniale_1.jpg', (SELECT id FROM libro WHERE titolo = 'L amica geniale'));
INSERT INTO immagine (nome_file, path, libro_id) VALUES ('l_amica_geniale_2.jpg', '/images/books/l_amica_geniale_2.jpg', (SELECT id FROM libro WHERE titolo = 'L amica geniale'));
INSERT INTO immagine (nome_file, path, libro_id) VALUES ('la_strada_1.jpg', '/images/books/la_strada_1.jpg', (SELECT id FROM libro WHERE titolo = 'La strada'));
INSERT INTO immagine (nome_file, path, libro_id) VALUES ('la_strada_2.jpg', '/images/books/la_strada_2.jpg', (SELECT id FROM libro WHERE titolo = 'La strada'));

-- === IMMAGINI AUTORI ===
INSERT INTO immagine (nome_file, path, autore_id) VALUES ('haruki_murakami.jpg', '/images/authors/haruki_murakami.jpg', (SELECT id FROM autore WHERE nome = 'Haruki'));
INSERT INTO immagine (nome_file, path, autore_id) VALUES ('margaret_atwood.jpg', '/images/authors/margaret_atwood.jpg', (SELECT id FROM autore WHERE nome = 'Margaret'));
INSERT INTO immagine (nome_file, path, autore_id) VALUES ('neil_gaiman.jpg', '/images/authors/neil_gaiman.jpg', (SELECT id FROM autore WHERE nome = 'Neil'));
INSERT INTO immagine (nome_file, path, autore_id) VALUES ('elena_ferrante.jpg', '/images/authors/elena_ferrante.jpg', (SELECT id FROM autore WHERE nome = 'Elena'));
INSERT INTO immagine (nome_file, path, autore_id) VALUES ('cormac_mccarthy.jpg', '/images/authors/cormac_mccarthy.jpg', (SELECT id FROM autore WHERE nome = 'Cormac'));

-- === COLLEGA IMMAGINI AI FOTOGRAFIA_ID DEGLI AUTORI ===
UPDATE autore SET fotografia_id = (SELECT id FROM immagine WHERE nome_file = 'haruki_murakami.jpg') WHERE nome = 'Haruki';
UPDATE autore SET fotografia_id = (SELECT id FROM immagine WHERE nome_file = 'margaret_atwood.jpg') WHERE nome = 'Margaret';
UPDATE autore SET fotografia_id = (SELECT id FROM immagine WHERE nome_file = 'neil_gaiman.jpg') WHERE nome = 'Neil';
UPDATE autore SET fotografia_id = (SELECT id FROM immagine WHERE nome_file = 'elena_ferrante.jpg') WHERE nome = 'Elena';
UPDATE autore SET fotografia_id = (SELECT id FROM immagine WHERE nome_file = 'cormac_mccarthy.jpg') WHERE nome = 'Cormac';


-- === Inserimento utenti base da usare ===
INSERT INTO utente  (nome, cognome, email) VALUES ('user', 'user', 'user@example.com');
INSERT INTO credentials(id, utente_id, password, role, username) VALUES (nextval('credentials_seq'),(SELECT u.id FROM utente as u WHERE u.email='user@example.com'),'$2a$10$B2NrUAhj5773x.pOu0NeWOjj0OT48bMj5qfA8CfG5Du37szMMB5eq', 'DEFAULT','user'); --password useruser

INSERT INTO utente  (nome, cognome, email) VALUES ('admin', 'admin', 'admin@example.com');
INSERT INTO credentials(id, utente_id, password, role, username) VALUES (nextval('credentials_seq'),(SELECT u.id FROM utente as u WHERE u.email='admin@example.com'),'$2a$10$REeraSkSMA5ZzWA4vk5A5.K0tkrqldNZQo6hSi782pBpmWNu0f5lC', 'ADMIN','admin'); --password adminadmin


