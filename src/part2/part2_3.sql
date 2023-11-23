CREATE OR REPLACE FUNCTION fnc_insert_transferred_points() RETURNS TRIGGER 
    LANGUAGE plpgsql
AS $trg_new_p2p$
    BEGIN
        IF ((SELECT COUNT(*) FROM transferredpoints WHERE checkingpeer = NEW.checkingPeer AND checkedpeer =  (SELECT peer FROM checks c WHERE c.id = NEW."Check")) > 0)
        THEN
            UPDATE transferredPoints
            SET PointsAmount = PointsAmount + 1
            WHERE checkingpeer = NEW.checkingPeer AND checkedpeer =  (SELECT peer FROM checks c WHERE c.id = NEW."Check");
        ELSE
            INSERT INTO transferredPoints (CheckingPeer, CheckedPeer, PointsAmount)
            VALUES (NEW.checkingPeer, (SELECT peer FROM checks c WHERE c.id = NEW."Check"), 1);
        END IF;
        RETURN NULL;
    END;
$trg_new_p2p$
;

CREATE TRIGGER trg_new_p2p
AFTER INSERT ON p2p
FOR EACH ROW 
WHEN ( NEW.state = 'Start' )
EXECUTE FUNCTION fnc_insert_transferred_points();