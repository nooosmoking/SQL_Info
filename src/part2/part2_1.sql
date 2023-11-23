CREATE OR REPLACE PROCEDURE new_p2p_check(checked_peer text, checking_peer text, 
    check_task text, status status_of_check, check_time time)
        LANGUAGE plpgsql
AS
$$
BEGIN
    IF status = 'Start'
    THEN
        INSERT INTO Checks (peer, task, "Date")
        VALUES (checked_peer, check_task, CURRENT_DATE);

        INSERT INTO p2p ("Check", CheckingPeer, "state" ,"Time")
        VALUES ((SELECT max(id) FROM checks), checking_peer, status, check_time);
    ELSE
        INSERT INTO p2p ("Check", CheckingPeer, "state" ,"Time")
        VALUES ((SELECT id FROM checks c WHERE c.peer = checked_peer AND c.task = check_task AND c."Date" = CURRENT_DATE),  checking_peer, status, check_time);
    END IF;
END
$$
;

CALL new_p2p_check('abobator','bobagovr', 'C5_s21_decimal', 'Success', '13:52:50');