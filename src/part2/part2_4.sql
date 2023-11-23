CREATE OR REPLACE FUNCTION fnc_valid_xp() RETURNS TRIGGER 
    LANGUAGE plpgsql
AS $trg_new_xp$
    BEGIN
        IF (NEW.xpamount < (SELECT maxxp 
            FROM tasks t INNER JOIN checks c ON t.title = c.task
            WHERE c.id = NEW."Check"))
        THEN
            IF((SELECT state FROM p2p
                WHERE p2p."Check" = NEW."Check"
                ORDER BY "Time" DESC
                LIMIT 1) = 'Success')
            THEN
                RETURN NEW;
            ELSE 
                RETURN NULL;
            END IF;
        ELSE 
            RETURN NULL;
        END IF;
    END;
$trg_new_xp$
;

CREATE TRIGGER trg_new_xp
BEFORE INSERT ON xp
FOR EACH ROW 
EXECUTE FUNCTION fnc_valid_xp();