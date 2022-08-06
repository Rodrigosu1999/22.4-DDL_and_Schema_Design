DROP DATABASE IF EXISTS soccer_league;

CREATE DATABASE soccer_league;

\c soccer_league

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    team_name TEXT NOT NULL,
    team_location TEXT NOT NULL
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    current_team_id INTEGER NOT NULL REFERENCES teams ON DELETE CASCADE
);

CREATE TABLE referees (
    id SERIAL   PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

CREATE TABLE matches (
    id SERIAL   PRIMARY KEY,
    team_1_id INTEGER NOT NULL REFERENCES teams ON DELETE CASCADE,
    team_2_id INTEGER NOT NULL REFERENCES teams ON DELETE CASCADE,
    referee_id integer NOT NULL REFERENCES referees ON DELETE CASCADE
);

CREATE TABLE goals (
    id SERIAL PRIMARY KEY,
    match_id INTEGER NOT NULL REFERENCES matches ON DELETE CASCADE,
    player_id INTEGER NOT NULL REFERENCES players ON DELETE CASCADE,
    count_goals INTEGER CHECK (count_goals > 0) DEFAULT 0
);

CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    season_start DATE NOT NULL,
    season_end DATE NOT NULL
);

CREATE TABLE league (
    id SERIAL PRIMARY KEY,
    season_id INTEGER NOT NULL REFERENCES seasons ON DELETE CASCADE,
    team_id INTEGER NOT NULL REFERENCES teams ON DELETE CASCADE,
    wins INTEGER NOT NULL  DEFAULT 0,
    loses INTEGER NOT NULL  DEFAULT 0
);

-- EXAMPLE DATA 
INSERT INTO seasons (season_start, season_end)
VALUES
('2022-06-15', '2022-11-15');

INSERT INTO teams (team_name, team_location)
VALUES
('Barcelona', 'Barcelona'),
('Manchester United', 'Manchester'),
('Red Bulls', 'New York');

INSERT INTO players (first_name, last_name, current_team_id)
VALUES
('Carles', 'Puyol',1),
('Leonardo', 'Messi',1),
('Christiano', 'Ronaldo',2),
('Rafael', 'Marquez',3);


INSERT INTO referees (first_name, last_name)
VALUES
('Roger', 'Stevenson'),
('Brian', 'Hoyer');

INSERT INTO matches (team_1_id, team_2_id, referee_id)
VALUES
(1,2,1),
(1,3,2),
(2,3,1);

INSERT INTO goals (match_id, player_id, count_goals)
VALUES
(1,1,3),
(1,3,2),
(2,2,4),
(3,4,1);

INSERT INTO league (season_id, team_id, wins, loses)
VALUES
(1,1,2,0),
(1,2,0,2),
(1,3,1,1);

-- Here we are selecting the score leaders
SELECT first_name, last_name, team_name, count_goals FROM goals JOIN players ON player_id = players.id JOIN teams ON teams.id = current_team_id ORDER BY count_goals desc;

--Here we are selecting the season's leaderboard
SELECT team_name, wins, loses FROM league l JOIN teams t ON team_id = t.id ORDER BY wins desc;