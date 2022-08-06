DROP DATABASE IF EXISTS medical_center;

CREATE DATABASE medical_center;

\c medical_center

CREATE TABLE doctors (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    specialty TEXT NOT NULL
);

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL
);

CREATE TABLE sickness_or_issue (
    id SERIAL   PRIMARY KEY,
    sickness_name TEXT NOT NULL,
    sickness_description TEXT NOT NULL
);

CREATE TABLE visits (
    id SERIAL   PRIMARY KEY,
    patient_id INTEGER NOT NULL REFERENCES patients ON DELETE CASCADE,
    doctor_id INTEGER NOT NULL REFERENCES doctors ON DELETE CASCADE,
    sickness_id INTEGER NOT NULL REFERENCES sickness_or_issue ON DELETE CASCADE,
    visits_date DATE NOT NULL,
    special_notes TEXT

);

INSERT INTO doctors (first_name, last_name, specialty) 
VALUES 
('George', 'Kittle', 'Traumathology'),
('Lucas', 'Podolski', 'Pathology'),
('Bill', 'Gates', 'Acupuncture');

INSERT INTO patients (first_name, last_name)
VALUES
('Bob', 'Dylan'),
('Klay', 'Matthews'),
('Tom', 'Cruise'),
('Tom', 'Hanks');

INSERT INTO sickness_or_issue (sickness_name, sickness_description)
VALUES
('COVID', 'Respiratory Illness'),
('Broken Bone', 'Bone that has been partially or completely fractured'),
('Sprained Back', 'Twist of the back ligaments');

INSERT INTO visits(doctor_id, patient_id, sickness_id, visits_date)
VALUES
(1,2,2, '2021-12-20'),
(1,3,2, '2021-12-20'),
(2,1,1, '2022-01-17'),
(2,2,1, '2022-07-20'),
(2,3,1, '2022-01-17'),
(2,4,1, '2021-03-27'),
(3,2,3, '2019-10-14');

-- Here we are seeing the visits (with ids)
SELECT * FROM visits;

SELECT v.id AS visit, p.first_name AS patient_first_name, p.last_name AS patient_last_name, d.first_name AS doctor_first_name, d.last_name AS doctor_last_name, sickness_name, visits_date FROM visits v JOIN patients p ON patient_id = p.id JOIN doctors d ON doctor_id = d.id JOIN sickness_or_issue s ON sickness_id = s.id;