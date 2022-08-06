DROP DATABASE IF EXISTS craiglist;

CREATE DATABASE craiglist;

\c craiglist

CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    region TEXT NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL,
    secret_password TEXT NOT NULL,
    favorite_region_id INTEGER REFERENCES regions ON DELETE SET NULL
);

CREATE TABLE categories (
    id SERIAL   PRIMARY KEY,
    category TEXT NOT NULL
);

CREATE TABLE posts (
    id SERIAL   PRIMARY KEY,
    title TEXT NOT NULL,
    post_description TEXT NOT NULL,
    location_of_post TEXT NOT NULL, 
    username_id integer NOT NULL REFERENCES users ON DELETE CASCADE,
    region_id integer REFERENCES regions ON DELETE SET NULL,
    category_id integer  REFERENCES categories ON DELETE SET NULL
);

-- EXAMPLE DATA 

INSERT INTO regions (region)
VALUES
('Georgetown'),
('Compton');

INSERT INTO users (username, secret_password, favorite_region_id)
VALUES
('doglover123', 'cookie', 2),
('catlover0103', 'sphinxcatsareweird', 1);

INSERT INTO categories (category)
VALUES
('cats'),
('dogs'),
('toys');

INSERT INTO posts (title, post_description, username_id, location_of_post, region_id, category_id)
VALUES
('Husky', 'Selling Husky dogs real cheap!', 1, 'Compton', 2, 2);

-- Here we can see who made the Husky post
SELECT title, post_description, username, category, region from posts JOIN users u ON username_id = u.id JOIN categories c ON category_id = c.id JOIN regions r ON region_id= r.id;