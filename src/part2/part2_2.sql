CREATE OR REPLACE PROCEDURE new_verter_check(checked_peer text, check_task text,
    status status_of_check, check_time time)
        LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO Verter ("Check", "state" ,"Time")
    VALUES ((SELECT c.id 
        FROM checks c INNER JOIN p2p p 
            ON c.id = p."Check"
        WHERE c.task = check_task AND c.peer = checked_peer AND p.state = 'Success'
        ORDER BY c."Date" DESC, p."Time" DESC
        LIMIT 1), status, check_time);
END
$$
;

CALL new_verter_check('evadakud', 'C3_SimpleBashUtils', 'Success', '13:56:50');