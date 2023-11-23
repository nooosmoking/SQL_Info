--DROP DATABASE IF EXISTS school_22_database;

--CREATE DATABASE school_22_database;


CREATE TABLE Tasks (
  Title VARCHAR(255) NOT NULL PRIMARY KEY,
  ParentTask VARCHAR(255) REFERENCES Tasks(Title),
  MaxXP BIGINT NOT NULL
);

CREATE TABLE Peers (
  Nickname VARCHAR(255) NOT NULL PRIMARY KEY,
  Birthday DATE NOT NULL
);

CREATE TABLE TimeTracking (
  ID SERIAL PRIMARY KEY,
  Peer VARCHAR(255) NOT NULL REFERENCES Peers(Nickname),
  "Date" DATE NOT NULL,
  "Time" TIME(0) NOT NULL,
  State CHAR(1) CHECK (State IN ('1', '2'))
);

CREATE TABLE Recommendations (
  ID SERIAL PRIMARY KEY,
  Peer VARCHAR(255) NOT NULL REFERENCES Peers(Nickname),
  RecommendedPeer VARCHAR(255) NOT NULL REFERENCES Peers(Nickname) CHECK (Peer <> RecommendedPeer)
);

CREATE TABLE Friends (
  ID SERIAL PRIMARY KEY,
  Peer1 VARCHAR(255) NOT NULL REFERENCES Peers(Nickname),
  Peer2 VARCHAR(255) NOT NULL REFERENCES Peers(Nickname)
);

-------------
-- Checks: --
-------------

CREATE TYPE status_of_check AS ENUM ('Start', 'Success', 'Failure');

CREATE TABLE Checks (
  ID SERIAL PRIMARY KEY,
  Peer VARCHAR(255) NOT NULL REFERENCES Peers(Nickname),
  Task VARCHAR(255) NOT NULL REFERENCES Tasks(Title),
  "Date" DATE NOT NULL
);

CREATE TABLE Verter (
  ID SERIAL PRIMARY KEY,
  "Check" INTEGER NOT NULL REFERENCES Checks(ID),
  State status_of_check,
  "Time" TIME(0) NOT NULL
);

CREATE TABLE P2P (
  ID SERIAL PRIMARY KEY,
  "Check" INTEGER NOT NULL REFERENCES Checks(ID),
  CheckingPeer VARCHAR(255) NOT NULL REFERENCES Peers(Nickname),
  State status_of_check,
  "Time" TIME(0) NOT NULL
);

CREATE TABLE XP (
  ID SERIAL PRIMARY KEY,
  "Check" INTEGER REFERENCES Checks(ID),
  XPAmount INTEGER
);

CREATE TABLE TransferredPoints (
  ID SERIAL PRIMARY KEY,
  CheckingPeer VARCHAR(255) NOT NULL REFERENCES Peers(Nickname),
  CheckedPeer VARCHAR(255) NOT NULL REFERENCES Peers(Nickname),
  PointsAmount NUMERIC(5, 0) NOT NULL
);

--------------------------
-- IMPORT CSV PROCEDURE --
--------------------------