-- DB update 2022_02_17_02 -> 2022_02_17_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_17_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_17_02 2022_02_17_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1645123941917942700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1645123941917942700');

DELETE FROM `acore_string` WHERE `entry` BETWEEN 600 AND 704;
DELETE FROM `acore_string` WHERE `entry` BETWEEN 724 AND 726;
DELETE FROM `acore_string` WHERE `entry` BETWEEN 753 AND 755;
DELETE FROM `acore_string` WHERE `entry` BETWEEN 1205 AND 1299;
DELETE FROM `acore_string` WHERE `entry` BETWEEN 1326 AND 1330;
DELETE FROM `acore_string` WHERE `entry` = 1333;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_17_03' WHERE sql_rev = '1645123941917942700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
