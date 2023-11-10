-- DB update 2021_08_01_00 -> 2021_08_03_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_01_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_01_00 2021_08_03_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627303283998958800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627303283998958800');

-- Changed the speed movement from 2.22 to 1 of Grunter (8303)
UPDATE `creature_template` SET `speed_walk` = 1 WHERE (`entry` = 8303);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_03_00' WHERE sql_rev = '1627303283998958800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
