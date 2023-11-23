INSERT INTO
    Tasks
VALUES
    ('C3_SimpleBashUtils', NULL, 350),
    ('C2_s21_stringplus', 'C3_SimpleBashUtils', 750),
    ('C5_s21_decimal', 'C3_SimpleBashUtils', 350),
    ('C6_s21_matrix', 'C5_s21_decimal', 200),
    ('C7_SmartCalc_v1.0', 'C6_s21_matrix', 650),
    ('C8_3DViewer_v1.0', 'C7_SmartCalc_v1.0', 1050),
    ('CPP1_s21_matrixplus', 'C8_3DViewer_v1.0', 300),
    (
        'CPP2_s21_containers',
        'CPP1_s21_matrixplus',
        450
    ),
    (
        'CPP3_SmartCalc_v2.0',
        'CPP2_s21_containers',
        700
    ),
    ('CPP4_3DViewer_v2.0', 'CPP3_SmartCalc_v2.0', 850),
    ('A1_Maze', 'CPP4_3DViewer_v2.0', 400),
    ('A2_SimpleNavigator_v1.0', 'A1_Maze', 500);

INSERT INTO
    Peers
VALUES
    ('uzomemon', '1964-12-17'),
    ('edobened', '1971-04-19'),
    ('azokazov', '1967-02-28'),
    ('unuzekad', '1976-05-20'),
    ('avomoduz', '1969-01-09'),
    ('ezudodad', '1999-02-21'),
    ('okobemug', '1978-09-17');

INSERT INTO
    TimeTracking(Peer, "Date", "Time", State)
VALUES
    ('avomoduz', '2023-03-03', '10:30:21', 1),
    ('uzomemon', '2023-03-03', '14:00:00', 1),
    ('uzomemon', '2023-03-03', '16:01:00', 2),
    ('uzomemon', '2023-03-03', '16:30:00', 1),
    ('avomoduz', '2023-03-03', '18:34:11', 2),
    ('uzomemon', '2023-03-03', '23:59:00', 2),
    ('azokazov', '2023-02-10', '06:30:45', 1),
    ('unuzekad', '2023-02-10', '10:01:30', 1),
    ('unuzekad', '2023-02-10', '13:57:45', 2),
    ('unuzekad', '2023-02-10', '14:30:20', 1),
    ('azokazov', '2023-02-10', '22:30:30', 2),
    ('unuzekad', '2023-02-10', '22:30:32', 2),
    ('avomoduz', '2023-03-21', '10:30:21', 1),
    ('avomoduz', '2023-03-21', '13:21:21', 2),
    ('avomoduz', '2023-03-21', '14:05:21', 1),
    ('avomoduz', '2023-03-21', '23:59:59', 2),
    ('edobened', '2023-04-25', '11:00:30', 1),
    ('edobened', '2023-04-25', '14:05:00', 2),
    ('edobened', '2023-04-25', '15:01:07', 1),
    ('edobened', '2023-04-25', '23:59:00', 2);

INSERT INTO
    Friends(Peer1, Peer2)
VALUES
    ('uzomemon', 'edobened'),
    ('uzomemon', 'azokazov'),
    ('uzomemon', 'avomoduz'),
    ('edobened', 'uzomemon'),
    ('edobened', 'azokazov'),
    ('uzomemon', 'unuzekad'),
    ('azokazov', 'avomoduz'),
    ('ezudodad', 'okobemug');

INSERT INTO
    Recommendations(Peer, RecommendedPeer)
VALUES
    ('uzomemon', 'azokazov'),
    ('uzomemon', 'avomoduz'),
    ('uzomemon', 'edobened'),
    ('edobened', 'azokazov'),
    ('azokazov', 'avomoduz'),
    ('uzomemon', 'unuzekad');

-------------
-- Checks: --
-------------
INSERT INTO
    checks(peer, task, "Date")
VALUES
    ('uzomemon', 'C3_SimpleBashUtils', '2023-03-03'),
    -- id1, by edobened
    ('edobened', 'C3_SimpleBashUtils', '2023-03-04'),
    -- id2, by azokazov
    ('unuzekad', 'C3_SimpleBashUtils', '2023-03-04'),
    -- id3, by uzomemon
    ('azokazov', 'C3_SimpleBashUtils', '2023-03-05'),
    -- id4, by uzomemon
    ('avomoduz', 'C3_SimpleBashUtils', '2023-03-06'),
    -- id5, by ezudodad
    ('okobemug', 'C3_SimpleBashUtils', '2023-03-16');

-- id6, by edobened
INSERT INTO
    P2P("Check", CheckingPeer, State, "Time")
VALUES
    (1, 'edobened', 'Start', '22:00:00'),
    -- id1, by uzomemon
    (1, 'edobened', 'Success', '23:30:15'),
    (2, 'azokazov', 'Start', '12:00:00'),
    -- id2, by edobened
    (2, 'azokazov', 'Success', '12:30:15'),
    (3, 'uzomemon', 'Start', '15:10:00'),
    -- id3, by unuzekad
    (3, 'uzomemon', 'Success', '15:45:05'),
    (4, 'uzomemon', 'Start', '15:10:00'),
    -- id4, by azokazov
    (4, 'uzomemon', 'Success', '15:45:05'),
    (5, 'ezudodad', 'Start', '15:10:00'),
    -- id5, by avomoduz
    (5, 'ezudodad', 'Success', '15:45:05'),
    (6, 'edobened', 'Start', '22:00:00'),
    -- id6, by okobemug
    (6, 'edobened', 'Success', '23:30:15');

INSERT INTO
    Verter("Check", State, "Time")
VALUES
    (1, 'Start', '23:15:00'),
    --
    (1, 'Success', '23:16:30'),
    (2, 'Start', '18:00:00'),
    --
    (2, 'Success', '18:01:30'),
    (3, 'Start', '15:00:00'),
    --
    (3, 'Success', '15:01:30'),
    (4, 'Start', '18:00:00'),
    (4, 'Success', '18:01:30'),
    (5, 'Start', '05:15:30'),
    (5, 'Success', '05:17:00'),
    (6, 'Start', '15:14:27'),
    (6, 'Failure', '15:16:03');

INSERT INTO
    checks (peer, task, "Date")
VALUES
    ('uzomemon', 'C2_s21_stringplus', '2023-03-16'),
    -- 7 uzomemon
    ('edobened', 'C2_s21_stringplus', '2023-03-16'),
    -- 8 edobened
    ('unuzekad', 'C2_s21_stringplus', '2023-01-18'),
    -- 9 unuzekad
    ('azokazov', 'C2_s21_stringplus', '2023-01-18'),
    -- 10 azokazov
    ('avomoduz', 'C2_s21_stringplus', '2023-01-20');

-- 11 avomoduz
INSERT INTO
    P2P("Check", CheckingPeer, State, "Time")
VALUES
    (7, 'unuzekad', 'Start', '02:00:00'),
    -- uzomemon
    (7, 'unuzekad', 'Success', '02:31:00'),
    (8, 'unuzekad', 'Start', '12:00:00'),
    -- edobened
    (8, 'unuzekad', 'Success', '12:30:00'),
    (9, 'uzomemon', 'Start', '15:15:00'),
    -- unuzekad
    (9, 'uzomemon', 'Success', '15:45:00'),
    (10, 'unuzekad', 'Start', '19:15:00'),
    -- azokazov
    (10, 'unuzekad', 'Success', '19:45:00'),
    (11, 'uzomemon', 'Start', '11:00:00'),
    -- avomoduz
    (11, 'uzomemon', 'Success', '11:30:00');

INSERT INTO
    Verter("Check", State, "Time")
VALUES
    (7, 'Start', '02:31:00'),
    (7, 'Success', '02:32:30'),
    (8, 'Start', '12:30:00'),
    (8, 'Success', '12:31:30'),
    (9, 'Start', '15:45:00'),
    (9, 'Failure', '15:46:30'),
    (10, 'Start', '19:45:00'),
    (10, 'Success', '19:46:30'),
    (11, 'Start', '11:30:00'),
    (11, 'Success', '11:31:30');

INSERT INTO
    checks (peer, task, "Date")
VALUES
    ('uzomemon', 'C5_s21_decimal', '2023-01-20'),
    -- 12 uzomemon
    ('edobened', 'C5_s21_decimal', '2023-01-22'),
    -- 13 edobened
    ('unuzekad', 'C5_s21_decimal', '2023-01-23'),
    -- 14 unuzekad
    ('azokazov', 'C5_s21_decimal', '2023-01-28'),
    -- 15 azokazov
    ('avomoduz', 'C5_s21_decimal', '2023-01-29');

-- 16 avomoduz
INSERT INTO
    P2P("Check", CheckingPeer, State, "Time")
VALUES
    (12, 'azokazov', 'Start', '12:45:00'),
    -- 12 uzomemon
    (12, 'azokazov', 'Success', '13:15:00'),
    (13, 'uzomemon', 'Start', '06:00:00'),
    -- 13 edobened
    (13, 'uzomemon', 'Success', '07:00:00'),
    (14, 'azokazov', 'Start', '10:45:00'),
    -- 14 unuzekad
    (14, 'azokazov', 'Success', '11:15:00'),
    (15, 'avomoduz', 'Start', '19:15:00'),
    --15 azokazov
    (15, 'avomoduz', 'Success', '19:45:00'),
    (16, 'uzomemon', 'Start', '18:00:00'),
    -- 16 avomoduz
    (16, 'uzomemon', 'Success', '18:45:00');

INSERT INTO
    Verter("Check", State, "Time")
VALUES
    (12, 'Start', '13:15:00'),
    (12, 'Success', '13:16:30'),
    (13, 'Start', '07:00:00'),
    (13, 'Success', '07:01:30'),
    (14, 'Start', '11:15:00'),
    (14, 'Success', '11:16:30'),
    (15, 'Start', '19:45:00'),
    (15, 'Success', '19:46:30'),
    (16, 'Start', '18:00:00'),
    (16, 'Success', '18:45:00');

INSERT INTO
    checks (peer, task, "Date")
VALUES
    ('uzomemon', 'C6_s21_matrix', '2023-01-28'),
    -- 17 uzomemon
    ('edobened', 'C6_s21_matrix', '2023-01-28'),
    -- 18 edobened
    ('unuzekad', 'C6_s21_matrix', '2023-01-31'),
    -- 19 unuzekad
    ('avomoduz', 'C6_s21_matrix', '2023-02-10');

-- 20 avomoduz
INSERT INTO
    P2P("Check", CheckingPeer, State, "Time")
VALUES
    (17, 'unuzekad', 'Start', '00:45:00'),
    -- uzomemon
    (17, 'unuzekad', 'Success', '01:15:00'),
    (18, 'uzomemon', 'Start', '12:15:00'),
    -- edobened
    (18, 'uzomemon', 'Success', '13:15:00'),
    (19, 'avomoduz', 'Start', '19:00:00'),
    -- unuzekad
    (19, 'avomoduz', 'Success', '19:45:00'),
    (20, 'edobened', 'Start', '12:15:00'),
    -- avomoduz
    (20, 'edobened', 'Success', '12:45:00');

INSERT INTO
    Verter("Check", State, "Time")
VALUES
    (17, 'Start', '01:15:00'),
    (17, 'Success', '01:16:30'),
    (18, 'Start', '13:15:00'),
    (18, 'Success', '13:16:30'),
    (19, 'Start', '19:45:00'),
    (19, 'Success', '19:46:30'),
    (20, 'Start', '12:45:00'),
    (20, 'Success', '12:46:30');

INSERT INTO
    checks (peer, task, "Date")
VALUES
    ('uzomemon', 'C7_SmartCalc_v1.0', '2023-01-28'),
    -- 21 uzomemon
    ('edobened', 'C7_SmartCalc_v1.0', '2023-01-28'),
    -- 22 edobened
    ('unuzekad', 'C7_SmartCalc_v1.0', '2023-01-31'),
    -- 23 unuzekad
    ('avomoduz', 'C7_SmartCalc_v1.0', '2023-02-10');

-- 24 avomoduz
INSERT INTO
    P2P("Check", CheckingPeer, State, "Time")
VALUES
    (21, 'avomoduz', 'Start', '10:00:00'),
    -- uzomemon
    (21, 'avomoduz', 'Success', '11:00:00'),
    (22, 'azokazov', 'Start', '18:30:00'),
    -- edobened
    (22, 'azokazov', 'Success', '19:30:00'),
    (23, 'azokazov', 'Start', '09:15:00'),
    -- unuzekad
    (23, 'azokazov', 'Success', '09:45:00'),
    (24, 'uzomemon', 'Start', '22:00:00'),
    -- avomoduz
    (24, 'uzomemon', 'Success', '22:45:00');

INSERT INTO
    checks (peer, task, "Date")
VALUES
    ('uzomemon', 'C8_3DViewer_v1.0', '2023-01-28'),
    -- 25 uzomemon
    ('edobened', 'C8_3DViewer_v1.0', '2023-01-28'),
    -- 26 edobened
    ('unuzekad', 'C8_3DViewer_v1.0', '2023-01-31'),
    -- 27 unuzekad
    ('avomoduz', 'C8_3DViewer_v1.0', '2023-02-10');

-- 28 avomoduz
INSERT INTO
    P2P("Check", CheckingPeer, State, "Time")
VALUES
    (25, 'avomoduz', 'Start', '14:00:00'),
    -- uzomemon
    (25, 'avomoduz', 'Success', '15:00:00'),
    (26, 'unuzekad', 'Start', '16:00:00'),
    -- edobened
    (26, 'unuzekad', 'Success', '16:40:00'),
    (27, 'edobened', 'Start', '11:30:00'),
    -- unuzekad
    (27, 'edobened', 'Success', '11:55:00'),
    (28, 'azokazov', 'Start', '21:45:00'),
    -- avomoduz
    (28, 'azokazov', 'Success', '22:30:00');

INSERT INTO
    checks (peer, task, "Date")
VALUES
    ('uzomemon', 'CPP1_s21_matrixplus', '2023-02-10'),
    -- 29 uzomemon
    ('edobened', 'CPP1_s21_matrixplus', '2023-02-11'),
    -- 30 edobened
    ('unuzekad', 'CPP1_s21_matrixplus', '2023-02-11');

-- 31 unuzekad
INSERT INTO
    P2P("Check", CheckingPeer, State, "Time")
VALUES
    (29, 'edobened', 'Start', '01:15:00'),
    -- uzomemon
    (29, 'edobened', 'Success', '02:00:00'),
    (30, 'unuzekad', 'Start', '17:30:00'),
    -- edobened
    (30, 'unuzekad', 'Success', '18:00:00'),
    (31, 'uzomemon', 'Start', '12:00:00'),
    -- unuzekad
    (31, 'uzomemon', 'Success', '13:00:00');

INSERT INTO
    checks (peer, task, "Date")
VALUES
    ('uzomemon', 'A1_Maze', '2023-02-18'),
    -- 32 uzomemon
    ('edobened', 'A1_Maze', '2023-02-18'),
    -- 33 edobened
    ('avomoduz', 'A1_Maze', '2023-02-18');

-- 34 avomoduz
INSERT INTO
    P2P("Check", CheckingPeer, State, "Time")
VALUES
    (32, 'azokazov', 'Start', '06:00:00'),
    -- uzomemon
    (32, 'azokazov', 'Success', '06:45:00'),
    (33, 'uzomemon', 'Start', '11:15:00'),
    (33, 'uzomemon', 'Success', '12:00:00'),
    (34, 'unuzekad', 'Start', '19:45:00'),
    --  avomoduz
    (34, 'unuzekad', 'Success', '20:30:00');

INSERT INTO
    checks (peer, task, "Date")
VALUES
    (
        'uzomemon',
        'A2_SimpleNavigator_v1.0',
        '2023-02-25'
    ),
    -- 35 uzomemon
    (
        'avomoduz',
        'A2_SimpleNavigator_v1.0',
        '2023-02-28'
    );

-- 36 avomoduz
INSERT INTO
    P2P("Check", CheckingPeer, State, "Time")
VALUES
    (35, 'edobened', 'Start', '12:00:00'),
    -- uzomemon
    (35, 'edobened', 'Success', '12:15:00'),
    (36, 'edobened', 'Start', '16:45:00'),
    -- avomoduz
    (36, 'edobened', 'Success', '17:15:00');

INSERT INTO
    XP("Check", XPAmount)
VALUES
    (1, 350),
    -- uzomemon C3_SimpleBashUtils
    (2, 340),
    -- edobened
    (3, 330),
    -- unuzekad
    (4, 340),
    -- azokazov
    (5, 300),
    -- avomoduz
    (7, 650),
    -- uzomemon C2_s21_stringplus
    (8, 690),
    -- edobened
    (10, 600),
    -- azokazov
    (11, 700),
    -- avomoduz
    (12, 300),
    -- uzomemon C5_s21_decimal
    (13, 310),
    -- edobened
    (14, 350),
    -- unuzekad
    (16, 350),
    -- avomoduz
    (17, 200),
    -- uzomemon C6_s21_matrix
    (18, 200),
    -- edobened
    (19, 190),
    -- unuzekad
    (20, 180),
    -- avomoduz
    (21, 640),
    -- uzomemon C7_SmartCalc_v1.0
    (22, 500),
    -- edobened
    (23, 500),
    -- unuzekad
    (24, 650),
    -- avomoduz
    (25, 1040),
    -- uzomemon C8_3DViewer_v1.0
    (26, 1000),
    -- edobened
    (27, 1010),
    -- unuzekad
    (28, 1040),
    -- avomoduz
    (29, 250),
    -- uzomemon CPP1_s21_matrixplus
    (30, 300),
    -- edobened
    (31, 290),
    -- unuzekad
    (32, 1500),
    -- uzomemon A1_Maze
    (33, 380),
    -- edobened
    (34, 370),
    -- avomoduz
    (35, 250),
    -- uzomemon A2_SimpleNavigator_v1.0
    (36, 300);

-- avomoduz