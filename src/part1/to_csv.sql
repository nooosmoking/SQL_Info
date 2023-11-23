DROP PROCEDURE IF EXISTS to_csv;

CREATE OR REPLACE PROCEDURE to_csv(path text)
    LANGUAGE plpgsql
AS
$$
BEGIN
    EXECUTE 'COPY peers TO ''' || path || '/peers.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY tasks TO ''' || path || '/tasks.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY checks (Peer, Task, "Date") TO ''' || path || '/checks.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY xp ("Check", XPAmount) TO ''' || path || '/xp.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY verter ("Check", State, "Time") TO ''' || path || '/verter.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY p2p ("Check", CheckingPeer, State, "Time") TO ''' || path || '/p2p.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY transferredPoints (CheckingPeer, CheckedPeer, PointsAmount) TO ''' || path || '/transferred_points.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY friends (Peer1, Peer2) TO ''' || path || '/friends.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY recommendations (Peer, RecommendedPeer) TO ''' || path || '/recommendations.csv'' WITH (FORMAT CSV, DELIMITER '','');';
    EXECUTE 'COPY timeTracking (Peer, "Date", "Time", State) TO ''' || path || '/time_tracking.csv'' WITH (FORMAT CSV, DELIMITER '','');';
END
$$
;

CALL to_csv('/home/dochka/s21/SQL2_Info21_v1.0-2/src/part1/csv')
;