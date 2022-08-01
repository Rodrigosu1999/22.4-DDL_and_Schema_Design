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

CREATE TABLE medical_center (
    id SERIAL   PRIMARY KEY,
    doctor_id INTEGER NOT NULL REFERENCES doctors ON DELETE CASCADE,
    patient_id INTEGER NOT NULL REFERENCES patients ON DELETE CASCADE,
    sickness_id INTEGER NOT NULL REFERENCES sickness_or_issue ON DELETE CASCADE
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

INSERT INTO medical_center(doctor_id, patient_id, sickness_id)
VALUES
(1,2,2),
(1,3,2),
(2,1,1),
(2,2,1),
(2,3,1),
(2,4,1),
(3,2,3);

-- Here we are seeing all of the doctor's and patien's meetings
SELECT doctors.first_name AS doctor_name, doctors.last_name AS doctor_last_name, patients.first_name AS patient_first_name, patients.last_name AS patient_last_name, sickness_name FROM medical_center JOIN doctors ON doctor_id = doctors.id JOIN patients ON patient_id = patients.id JOIN sickness_or_issue ON sickness_id = sickness_or_issue.id;

-- Here we are seeing all of  doctor' Lucas Podolski patient's meetings
SELECT doctors.first_name AS doctor_name, doctors.last_name AS doctor_last_name, patients.first_name AS patient_first_name, patients.last_name AS patient_last_name, sickness_name FROM medical_center JOIN doctors ON doctor_id = doctors.id JOIN patients ON patient_id = patients.id JOIN sickness_or_issue ON sickness_id = sickness_or_issue.id WHERE doctors.first_name = 'Lucas';
