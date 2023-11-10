-- DB update 2021_07_24_01 -> 2021_07_24_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_24_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_24_01 2021_07_24_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626865484901243200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626865484901243200');

-- Changed the coords so it dont spawn inside terrain
UPDATE `creature` SET `position_x` = -5231.283, `position_y` = 1287.122, `position_z` = 55.708 WHERE (`id` = 5307) AND (`guid` = 51210);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_24_02' WHERE sql_rev = '1626865484901243200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
