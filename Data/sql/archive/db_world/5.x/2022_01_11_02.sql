-- DB update 2022_01_11_01 -> 2022_01_11_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_11_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_11_01 2022_01_11_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641837958335217980'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641837958335217980');

ALTER TABLE `creature`
    CHANGE COLUMN `id` `creature_id1` MEDIUMINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Creature Identifier' AFTER `guid`,
    ADD COLUMN `creature_id2` MEDIUMINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Creature Identifier' AFTER `creature_id1`,
    ADD COLUMN `chance_id1` FLOAT UNSIGNED NOT NULL DEFAULT 100 COMMENT 'Chance id1 spawns' AFTER `creature_id2`;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_11_02' WHERE sql_rev = '1641837958335217980';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
