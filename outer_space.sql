-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE galaxies (
  id SERIAL PRIMARY KEY,
  galaxy_name TEXT NOT NULL
);

CREATE TABLE stars (
  id SERIAL PRIMARY KEY,
  star_name TEXT NOT NULL
);

CREATE TABLE planets(
  id SERIAL PRIMARY KEY,
  planet_name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  star_id INTEGER NOT NULL REFERENCES stars ON DELETE CASCADE,
  galaxy_id INTEGER NOT NULL REFERENCES galaxies ON DELETE CASCADE
);

CREATE TABLE moons (
  id SERIAL PRIMARY KEY,
  moon_name TEXT NOT NULL,
  planet_id INTEGER NOT NULL REFERENCES planets ON DELETE CASCADE
);

INSERT INTO galaxies (galaxy_name)
VALUES
('Milky Way');

INSERT INTO stars (star_name)
VALUES
('The Sun'),
('Proxima Centauri'),
('Gliese 876');

INSERT INTO planets (planet_name, orbital_period_in_years, star_id, galaxy_id)
VALUES
('Earth', 1.00, 1, 1),
('Mars', 1.88, 1, 1),
('Venus', 0.62, 1,1),
('Neptune', 164.8, 1,1),
('Proxima Centauri b', 0.03, 2,1),
('Gliese 876 b', 0.23,3,1);

INSERT INTO moons (moon_name, planet_id)
VALUES
('The Moon',1),
('Phobos',2), 
('Deimos',2),
('Naiad',4), 
('Thalassa',4), 
('Despina',4), 
('Galatea',4), 
('Larissa',4), 
('S/2004 N 1',4), 
('Proteus',4), 
('Triton',4), 
('Nereid',4), 
('Halimede',4), 
('Sao',4), 
('Laomedeia',4), 
('Psamathe',4), 
('Neso',4);

-- Here we are selecting all of Neptune's moons
SELECT planet_name, moon_name FROM moons JOIN planets ON planet_id = planets.id WHERE planet_id = 4;

-- Here we are selecting each planet's orbit time and on which star they orbit around
SELECT planet_name, orbital_period_in_years, star_name from planets JOIN stars ON star_id = stars.id;

