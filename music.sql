-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  artist_name TEXT UNIQUE NOT NULL
);

CREATE TABLE producers (
  id SERIAL PRIMARY KEY,
  producers_name TEXT NOT NULL
);

CREATE TABLE albums (
  id SERIAL PRIMARY KEY,
  album_name TEXT NOT NULL
);

CREATE TABLE songs(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL,
  album_id INTEGER  REFERENCES albums ON DELETE CASCADE,
  artist_id INTEGER NOT NULL REFERENCES artists ON DELETE CASCADE,
  featured_artist_id INTEGER REFERENCES artists ON DELETE CASCADE,
  producer_id INTEGER NOT NULL REFERENCES producers ON DELETE CASCADE,
  featured_producer_id INTEGER REFERENCES producers ON DELETE CASCADE
);

INSERT INTO artists (artist_name)
VALUES
('Hanson'),
('Queen'),
('Mariah Cary'),
('Boyz II Men'),
('Lady Gaga'),
('Bradley Cooper'),
('Nickelback'),
('Jay Z'),
('Alicia Keys'),
('Katy Perry'),
('Juicy J'),
('Maroon 5'),
('Christina Aguilera'),
('Avril Lavinge'),
('Destiny`s Child');

INSERT INTO producers (producers_name)
VALUES
('Dust Brothers'),
('Stephen Lironi'),
('Roy Thomas Baker'),
('Walter Afanasieff'),
('Benjamin Rice'),
('Rick Parashar'),
('Al Shux'),
('Max Martin'),
('Cirkut'),
('Shellback'),
('Benny Blanco'),
('The Matrix'),
('Darkchild');

INSERT INTO albums (album_name)
VALUES
('Middle of Nowhere'),
('A Night at the Opera'),
('Daydream'),
('A Star is Born'),
('Silver Side Up'),
('The Blueprint 3'),
('Prism'),
('Hands All Over'),
('Let Go'),
('The Weiting`s on the Wall');

INSERT INTO songs (title, duration_in_seconds, release_date, album_id, artist_id, featured_artist_id, producer_id, featured_producer_id)
VALUES
 ('MMMBop', 238, '04-15-1997', 1, 1, NULL, 1, 2),
  ('Bohemian Rhapsody', 355, '10-31-1975', 2,2,NULL,3,NULL),
  ('One Sweet Day', 282, '11-14-1995', 3,3,4,4,NULL),
  ('Shallow', 216, '09-27-2018',4,5,6,5,NULL),
  ('How You Remind Me', 223, '08-21-2001', 5,7,NULL,6,NULL),
  ('New York State of Mind', 276, '10-20-2009', 6,8,9,7,NULL),
  ('Dark Horse', 215, '12-17-2013', 7,10,11,8,9),
  ('Moves Like Jagger', 201, '06-21-2011', 8,12,13,10,11),
  ('Complicated', 244, '05-14-2002', 9,14,NULL,12,NULL),
  ('Say My Name', 240, '11-07-1999', 10,15,NULL,13,NULL);



-- Here we are lookig at the song with it's artist
SELECT title, artist_name FROM songs JOIN artists ON artist_id = artists.id;

-- Here we are lookig at the song with it's featured artist
SELECT title, artist_name FROM songs JOIN artists ON featured_artist_id = artists.id;

-- Here we are lookig at the song with it's producer
SELECT title, producers_name FROM songs JOIN producers ON producer_id = producers.id;

-- Here we are lookig at the song with it's featured producer
SELECT title, producers_name FROM songs JOIN producers ON featured_producer_id = producers.id;