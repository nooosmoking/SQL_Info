--DROP PROCEDURE IF EXISTS from_csv;

CREATE OR REPLACE PROCEDURE from_csv(path text)
    LANGUAGE plpgsql
AS
$$
BEGIN
    EXECUTE 'COPY peers FROM ''' || path || '/peers.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY tasks FROM ''' || path || '/tasks.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY checks (Peer, Task, "Date") FROM ''' || path || '/checks.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY xp ("Check", XPAmount) FROM ''' || path || '/xp.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY verter ("Check", State, "Time") FROM ''' || path || '/verter.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY p2p ("Check", CheckingPeer, State, "Time") FROM ''' || path || '/p2p.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY transferredPoints (CheckingPeer, CheckedPeer, PointsAmount) FROM ''' || path || '/transferred_points.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY friends (Peer1, Peer2) FROM ''' || path || '/friends.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY recommendations (Peer, RecommendedPeer) FROM ''' || path || '/recommendations.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY timeTracking (Peer, "Date", "Time", State) FROM ''' || path || '/time_tracking.csv'' WITH (FORMAT CSV, DELIMITER '','');';
END
$$
;

CALL from_csv('/home/nooo_sm/s21_school/SQL2_Info21_v1.0-2/src/part1/csv')
;
