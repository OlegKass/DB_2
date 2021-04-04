DROP TABLE IF EXISTS Region;
DROP TABLE IF EXISTS Exam_person;
DROP TABLE IF EXISTS Exam_results;
DROP TABLE IF EXISTS Establishment;


CREATE TABLE Region (
    Region_id Serial PRIMARY KEY,
    Reg_name VARCHAR(255),
    Area_Name VARCHAR(255),
    Ter_Name VARCHAR(255),
    Ter_type_name VARCHAR(255)
);


CREATE TABLE Establishment (
    School_name VARCHAR(255) PRIMARY KEY,
    Parent VARCHAR(255),
    Type VARCHAR(255),
    Reg_id Serial REFERENCES Region(Region_id)
);


CREATE TABLE Exam_person (
    Person_id VARCHAR(36) PRIMARY KEY,
    Birth INTEGER,
    Reg_id Serial,
    Reg_type VARCHAR(255),
    Class_name VARCHAR(255),
    School_name VARCHAR(255) REFERENCES Establishment(School_name)
);


CREATE TABLE Exam_results (
    Year INT,
    Person_id VARCHAR(36) REFERENCES Exam_person(Person_id),
    Test_type VARCHAR(255),
    Test_status VARCHAR(255),
    Ball100 REAL,
    Ball12 REAL,
    Ball REAL,
    Parent_name VARCHAR(255) REFERENCES Establishment(School_name),
    PRIMARY KEY(Year, Person_id, Test_type)
);