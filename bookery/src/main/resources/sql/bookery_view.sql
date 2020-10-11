-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema salpa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema salpa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `salpa` DEFAULT CHARACTER SET utf8 ;
USE `salpa` ;
USE `salpa` ;

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_awards`
-- -----------------------------------------------------
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_awards` AS
    SELECT 
        `m`.`id` AS `id`,
        `m`.`medal` AS `medal`,
        `m`.`criteria` AS `criteria`,
        `a`.`awarddate` AS `awarddate`,
        `a`.`user_id` AS `user_id`,
        `a`.`checked` AS `checked`,
        `a`.`id` AS `award_id`
    FROM
        (`medal` `m`
        JOIN `award` `a`)
    WHERE
        (`m`.`id` = `a`.`medal_id`);
-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_cal_chap`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_cal_chap` (`title` INT, `url` INT, `user_id` INT, `sid_date` INT, `type` INT, `study_id` INT, `start` INT, `plan_accum` INT, `actual_accum` INT, `plan_perday` INT, `actual_perday` INT, `status` INT, `color` INT, `textColor` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_cal_chap_actual`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_cal_chap_actual` (`actual` INT, `sid_actualdate` INT, `study_id` INT, `date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_cal_chap_base`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_cal_chap_base` (`id` INT, `toc` INT, `plantime` INT, `actualtime` INT, `deleted` INT, `study_id` INT, `sid_plandate` INT, `sid_actualdate` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_cal_chap_plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_cal_chap_plan` (`plan` INT, `sid_plandate` INT, `study_id` INT, `date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_cal_chap_sid_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_cal_chap_sid_date` (`sid_date` INT, `study_id` INT, `date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_cal_page`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_cal_page` (`title` INT, `url` INT, `user_id` INT, `sid_date` INT, `type` INT, `study_id` INT, `start` INT, `plan_accum` INT, `actual_accum` INT, `plan_perday` INT, `actual_perday` INT, `status` INT, `color` INT, `textColor` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_cal_page_base`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_cal_page_base` (`id` INT, `date` INT, `planpage` INT, `actualpage` INT, `deleted` INT, `study_id` INT, `sid_date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_cal_page_base2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_cal_page_base2` (`title` INT, `url` INT, `user_id` INT, `type` INT, `sid_date` INT, `study_id` INT, `start` INT, `planpage` INT, `actualpage` INT, `plan_accum` INT, `actual_accum` INT, `plan_perday` INT, `actual_perday` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_cal_page_sid_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_cal_page_sid_date` (`sid_date` INT, `study_id` INT, `date` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_calendar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_calendar` (`title` INT, `url` INT, `user_id` INT, `sid_date` INT, `type` INT, `study_id` INT, `start` INT, `plan_accum` INT, `actual_accum` INT, `plan_perday` INT, `actual_perday` INT, `status` INT, `color` INT, `textColor` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_checkchap_actual`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_checkchap_actual` (`study_id` INT, `actual_cnt` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_checkchap_actual_chap_yesterday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_checkchap_actual_chap_yesterday` (`study_id` INT, `actual_cnt` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_checkchap_actual_days_yesterday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_checkchap_actual_days_yesterday` (`study_id` INT, `actual_days` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_checkchap_plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_checkchap_plan` (`study_id` INT, `plan_cnt` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_checkchap_plan_chap_yesterday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_checkchap_plan_chap_yesterday` (`study_id` INT, `plan_cnt` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_checkchap_plan_days_yesterday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_checkchap_plan_days_yesterday` (`study_id` INT, `plan_days` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_checkchap_total`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_checkchap_total` (`study_id` INT, `total_cnt` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_checkchap_total_days`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_checkchap_total_days` (`study_id` INT, `total_days` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_checkpage_actual`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_checkpage_actual` (`study_id` INT, `plan_days` INT, `actual_days` INT, `plan_page` INT, `actual_page` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_checkpage_actual_yesterday`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_checkpage_actual_yesterday` (`study_id` INT, `plan_days_yesterday` INT, `actual_days_yesterday` INT, `plan_page_yesterday` INT, `actual_page_yesterday` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_checkpage_total`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_checkpage_total` (`study_id` INT, `total_days` INT, `total_pages` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_notice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_notice` (`id` INT, `createtime` INT, `answertime` INT, `title` INT, `content` INT, `answer` INT, `user_id` INT, `deleted` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_readers_cnt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_readers_cnt` (`book_bid` INT, `readers` INT, `title` INT, `coverurl` INT);

-- -----------------------------------------------------
-- Placeholder table for view `salpa`.`v_study`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salpa`.`v_study` (`user_id` INT, `nickname` INT, `book_bid` INT, `title` INT, `pages` INT, `coverurl` INT, `study_id` INT, `createtime` INT, `updatetime` INT, `startdate` INT, `enddate` INT, `memo` INT, `type` INT, `total_chap` INT, `plan_chap_yesterday` INT, `actual_chap_yesterday` INT, `plan_chap` INT, `actual_chap` INT, `total_days` INT, `plan_days_yesterday` INT, `actual_days_yesterday` INT, `remain_days` INT, `total_pages` INT, `plan_page_yesterday` INT, `actual_page_yesterday` INT, `plan_page` INT, `actual_page` INT, `progress_rate` INT, `success_rate` INT);

-- -----------------------------------------------------
-- View `salpa`.`v_awards`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_awards`;
DROP VIEW IF EXISTS `salpa`.`v_awards` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_awards` AS select `m`.`id` AS `id`,`m`.`medal` AS `medal`,`m`.`criteria` AS `criteria`,`a`.`awarddate` AS `awarddate`,`a`.`user_id` AS `user_id` from (`salpa`.`medal` `m` join `salpa`.`award` `a`) where (`m`.`id` = `a`.`medal_id`);

-- -----------------------------------------------------
-- View `salpa`.`v_cal_chap`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_cal_chap`;
DROP VIEW IF EXISTS `salpa`.`v_cal_chap` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_cal_chap` AS select `salpa`.`book`.`title` AS `title`,`v_cal_chap_sid_date`.`study_id` AS `url`,`salpa`.`study`.`user_id` AS `user_id`,`v_cal_chap_sid_date`.`sid_date` AS `sid_date`,'chap' AS `type`,`v_cal_chap_sid_date`.`study_id` AS `study_id`,`v_cal_chap_sid_date`.`date` AS `start`,(select sum(coalesce(`v_cal_chap_plan`.`plan`,0)) from `salpa`.`v_cal_chap_plan` where ((`v_cal_chap_sid_date`.`date` >= `v_cal_chap_plan`.`date`) and (`v_cal_chap_sid_date`.`study_id` = `v_cal_chap_plan`.`study_id`))) AS `plan_accum`,(select sum(coalesce(`v_cal_chap_actual`.`actual`,0)) from `salpa`.`v_cal_chap_actual` where ((`v_cal_chap_sid_date`.`date` >= `v_cal_chap_actual`.`date`) and (`v_cal_chap_sid_date`.`study_id` = `v_cal_chap_actual`.`study_id`))) AS `actual_accum`,coalesce(`v_cal_chap_plan`.`plan`,0) AS `plan_perday`,coalesce(`v_cal_chap_actual`.`actual`,0) AS `actual_perday`,(coalesce(`v_cal_chap_actual`.`actual`,0) - coalesce(`v_cal_chap_plan`.`plan`,0)) AS `status`,(case when (coalesce(`v_cal_chap_actual`.`actual`,0) > coalesce(`v_cal_chap_plan`.`plan`,0)) then '#49654d' when (coalesce(`v_cal_chap_actual`.`actual`,0) = coalesce(`v_cal_chap_plan`.`plan`,0)) then '#8ba989' when (coalesce(`v_cal_chap_actual`.`actual`,0) < coalesce(`v_cal_chap_plan`.`plan`,0)) then '#a0522d' else '#e4e6da' end) AS `color`,(case when (coalesce(`v_cal_chap_actual`.`actual`,0) > coalesce(`v_cal_chap_plan`.`plan`,0)) then '#ecece9' when (coalesce(`v_cal_chap_actual`.`actual`,0) = coalesce(`v_cal_chap_plan`.`plan`,0)) then '#ecece9' when (coalesce(`v_cal_chap_actual`.`actual`,0) < coalesce(`v_cal_chap_plan`.`plan`,0)) then '#ecece9' else '#49654d' end) AS `textColor` from ((((`salpa`.`v_cal_chap_sid_date` left join `salpa`.`study` on((`v_cal_chap_sid_date`.`study_id` = `salpa`.`study`.`id`))) left join `salpa`.`book` on((`salpa`.`study`.`book_bid` = `salpa`.`book`.`bid`))) left join `salpa`.`v_cal_chap_plan` on((`v_cal_chap_sid_date`.`sid_date` = `v_cal_chap_plan`.`sid_plandate`))) left join `salpa`.`v_cal_chap_actual` on((`v_cal_chap_sid_date`.`sid_date` = `v_cal_chap_actual`.`sid_actualdate`))) where (`v_cal_chap_sid_date`.`sid_date` is not null);

-- -----------------------------------------------------
-- View `salpa`.`v_cal_chap_actual`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_cal_chap_actual`;
DROP VIEW IF EXISTS `salpa`.`v_cal_chap_actual` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_cal_chap_actual` AS select count(`v_cal_chap_base`.`actualtime`) AS `actual`,max(`v_cal_chap_base`.`sid_actualdate`) AS `sid_actualdate`,max(`v_cal_chap_base`.`study_id`) AS `study_id`,date_format(max(`v_cal_chap_base`.`actualtime`),'%Y-%m-%d') AS `date` from `salpa`.`v_cal_chap_base` where (`v_cal_chap_base`.`sid_actualdate` is not null) group by `v_cal_chap_base`.`sid_actualdate`;

-- -----------------------------------------------------
-- View `salpa`.`v_cal_chap_base`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_cal_chap_base`;
DROP VIEW IF EXISTS `salpa`.`v_cal_chap_base` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_cal_chap_base` AS select `salpa`.`checkchap`.`id` AS `id`,`salpa`.`checkchap`.`toc` AS `toc`,`salpa`.`checkchap`.`plantime` AS `plantime`,`salpa`.`checkchap`.`actualtime` AS `actualtime`,`salpa`.`checkchap`.`deleted` AS `deleted`,`salpa`.`checkchap`.`study_id` AS `study_id`,concat(`salpa`.`checkchap`.`study_id`,':',date_format(`salpa`.`checkchap`.`plantime`,'%Y-%m-%d')) AS `sid_plandate`,concat(`salpa`.`checkchap`.`study_id`,':',date_format(`salpa`.`checkchap`.`actualtime`,'%Y-%m-%d')) AS `sid_actualdate` from `salpa`.`checkchap`;

-- -----------------------------------------------------
-- View `salpa`.`v_cal_chap_plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_cal_chap_plan`;
DROP VIEW IF EXISTS `salpa`.`v_cal_chap_plan` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_cal_chap_plan` AS select count(`v_cal_chap_base`.`plantime`) AS `plan`,max(`v_cal_chap_base`.`sid_plandate`) AS `sid_plandate`,max(`v_cal_chap_base`.`study_id`) AS `study_id`,date_format(max(`v_cal_chap_base`.`plantime`),'%Y-%m-%d') AS `date` from `salpa`.`v_cal_chap_base` group by `v_cal_chap_base`.`sid_plandate`;

-- -----------------------------------------------------
-- View `salpa`.`v_cal_chap_sid_date`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_cal_chap_sid_date`;
DROP VIEW IF EXISTS `salpa`.`v_cal_chap_sid_date` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_cal_chap_sid_date` AS select `v_cal_chap_base`.`sid_plandate` AS `sid_date`,`v_cal_chap_base`.`study_id` AS `study_id`,date_format(`v_cal_chap_base`.`plantime`,'%Y-%m-%d') AS `date` from `salpa`.`v_cal_chap_base` union select `v_cal_chap_base`.`sid_actualdate` AS `sid_date`,`v_cal_chap_base`.`study_id` AS `study_id`,date_format(`v_cal_chap_base`.`actualtime`,'%Y-%m-%d') AS `date` from `salpa`.`v_cal_chap_base`;

-- -----------------------------------------------------
-- View `salpa`.`v_cal_page`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_cal_page`;
DROP VIEW IF EXISTS `salpa`.`v_cal_page` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_cal_page` AS select `v_cal_page_base2`.`title` AS `title`,`v_cal_page_base2`.`url` AS `url`,`v_cal_page_base2`.`user_id` AS `user_id`,`v_cal_page_base2`.`sid_date` AS `sid_date`,`v_cal_page_base2`.`type` AS `type`,`v_cal_page_base2`.`study_id` AS `study_id`,`v_cal_page_base2`.`start` AS `start`,`v_cal_page_base2`.`plan_accum` AS `plan_accum`,`v_cal_page_base2`.`actual_accum` AS `actual_accum`,`v_cal_page_base2`.`plan_perday` AS `plan_perday`,`v_cal_page_base2`.`actual_perday` AS `actual_perday`,(`v_cal_page_base2`.`actual_perday` - `v_cal_page_base2`.`plan_perday`) AS `status`,(case when (`v_cal_page_base2`.`actual_perday` > `v_cal_page_base2`.`plan_perday`) then '#49654d' when (`v_cal_page_base2`.`actual_perday` = `v_cal_page_base2`.`plan_perday`) then '#8ba989' when (`v_cal_page_base2`.`actual_perday` < `v_cal_page_base2`.`plan_perday`) then '#a0522d' else '#e4e6da' end) AS `color`,(case when (`v_cal_page_base2`.`actual_perday` > `v_cal_page_base2`.`plan_perday`) then '#ecece9' when (`v_cal_page_base2`.`actual_perday` = `v_cal_page_base2`.`plan_perday`) then '#ecece9' when (`v_cal_page_base2`.`actual_perday` < `v_cal_page_base2`.`plan_perday`) then '#ecece9' else '#49654d' end) AS `textColor` from `salpa`.`v_cal_page_base2`;

-- -----------------------------------------------------
-- View `salpa`.`v_cal_page_base`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_cal_page_base`;
DROP VIEW IF EXISTS `salpa`.`v_cal_page_base` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_cal_page_base` AS select `salpa`.`checkpage`.`id` AS `id`,`salpa`.`checkpage`.`date` AS `date`,`salpa`.`checkpage`.`planpage` AS `planpage`,`salpa`.`checkpage`.`actualpage` AS `actualpage`,`salpa`.`checkpage`.`deleted` AS `deleted`,`salpa`.`checkpage`.`study_id` AS `study_id`,concat(`salpa`.`checkpage`.`study_id`,':',date_format(`salpa`.`checkpage`.`date`,'%Y-%m-%d')) AS `sid_date` from `salpa`.`checkpage`;

-- -----------------------------------------------------
-- View `salpa`.`v_cal_page_base2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_cal_page_base2`;
DROP VIEW IF EXISTS `salpa`.`v_cal_page_base2` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_cal_page_base2` AS select `salpa`.`book`.`title` AS `title`,`v_cal_page_sid_date`.`study_id` as `url`,`salpa`.`study`.`user_id` AS `user_id`,'page' AS `type`,`v_cal_page_sid_date`.`sid_date` AS `sid_date`,`v_cal_page_sid_date`.`study_id` AS `study_id`,`v_cal_page_sid_date`.`date` AS `start`,`v_cal_page_base`.`planpage` AS `planpage`,`v_cal_page_base`.`actualpage` AS `actualpage`,(select max(`v_cal_page_base`.`planpage`) from `salpa`.`v_cal_page_base` where ((`v_cal_page_base`.`date` <= `v_cal_page_sid_date`.`date`) and (`v_cal_page_sid_date`.`study_id` = `v_cal_page_base`.`study_id`))) AS `plan_accum`,(select max(coalesce(`v_cal_page_base`.`actualpage`,0)) from `salpa`.`v_cal_page_base` where ((`v_cal_page_base`.`date` <= `v_cal_page_sid_date`.`date`) and (`v_cal_page_sid_date`.`study_id` = `v_cal_page_base`.`study_id`))) AS `actual_accum`,if((`v_cal_page_base`.`planpage` is null),0,if(((select max(`v_cal_page_base`.`planpage`) from `salpa`.`v_cal_page_base` where ((`v_cal_page_base`.`date` < `v_cal_page_sid_date`.`date`) and (`v_cal_page_sid_date`.`study_id` = `v_cal_page_base`.`study_id`))) is null),`v_cal_page_base`.`planpage`,(`v_cal_page_base`.`planpage` - (select max(`v_cal_page_base`.`planpage`) from `salpa`.`v_cal_page_base` where ((`v_cal_page_base`.`date` < `v_cal_page_sid_date`.`date`) and (`v_cal_page_sid_date`.`study_id` = `v_cal_page_base`.`study_id`)))))) AS `plan_perday`,if((`v_cal_page_base`.`actualpage` is null),0,if(((select max(coalesce(`v_cal_page_base`.`actualpage`,0)) from `salpa`.`v_cal_page_base` where ((`v_cal_page_base`.`date` < `v_cal_page_sid_date`.`date`) and (`v_cal_page_sid_date`.`study_id` = `v_cal_page_base`.`study_id`))) is null),coalesce(`v_cal_page_base`.`actualpage`,0),(coalesce(`v_cal_page_base`.`actualpage`,0) - (select max(coalesce(`v_cal_page_base`.`actualpage`,0)) from `salpa`.`v_cal_page_base` where ((`v_cal_page_base`.`date` < `v_cal_page_sid_date`.`date`) and (`v_cal_page_sid_date`.`study_id` = `v_cal_page_base`.`study_id`)))))) AS `actual_perday` from (((`salpa`.`v_cal_page_sid_date` left join `salpa`.`v_cal_page_base` on((`v_cal_page_sid_date`.`sid_date` = `v_cal_page_base`.`sid_date`))) left join `salpa`.`study` on((`v_cal_page_sid_date`.`study_id` = `salpa`.`study`.`id`))) left join `salpa`.`book` on((`salpa`.`study`.`book_bid` = `salpa`.`book`.`bid`)));

-- -----------------------------------------------------
-- View `salpa`.`v_cal_page_sid_date`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_cal_page_sid_date`;
DROP VIEW IF EXISTS `salpa`.`v_cal_page_sid_date` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_cal_page_sid_date` AS select `v_cal_page_base`.`sid_date` AS `sid_date`,`v_cal_page_base`.`study_id` AS `study_id`,date_format(`v_cal_page_base`.`date`,'%Y-%m-%d') AS `date` from `salpa`.`v_cal_page_base`;

-- -----------------------------------------------------
-- View `salpa`.`v_calendar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_calendar`;
DROP VIEW IF EXISTS `salpa`.`v_calendar` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_calendar` AS select `v_cal_chap`.`title` AS `title`,`v_cal_chap`.`url` AS `url`,`v_cal_chap`.`user_id` AS `user_id`,`v_cal_chap`.`sid_date` AS `sid_date`,`v_cal_chap`.`type` AS `type`,`v_cal_chap`.`study_id` AS `study_id`,`v_cal_chap`.`start` AS `start`,`v_cal_chap`.`plan_accum` AS `plan_accum`,`v_cal_chap`.`actual_accum` AS `actual_accum`,`v_cal_chap`.`plan_perday` AS `plan_perday`,`v_cal_chap`.`actual_perday` AS `actual_perday`,`v_cal_chap`.`status` AS `status`,`v_cal_chap`.`color` AS `color`,`v_cal_chap`.`textColor` AS `textColor` from `salpa`.`v_cal_chap` union select `v_cal_page`.`title` AS `title`,`v_cal_page`.`url` AS `url`,`v_cal_page`.`user_id` AS `user_id`,`v_cal_page`.`sid_date` AS `sid_date`,`v_cal_page`.`type` AS `type`,`v_cal_page`.`study_id` AS `study_id`,`v_cal_page`.`start` AS `start`,`v_cal_page`.`plan_accum` AS `plan_accum`,`v_cal_page`.`actual_accum` AS `actual_accum`,`v_cal_page`.`plan_perday` AS `plan_perday`,`v_cal_page`.`actual_perday` AS `actual_perday`,`v_cal_page`.`status` AS `status`,`v_cal_page`.`color` AS `color`,`v_cal_page`.`textColor` AS `textColor` from `salpa`.`v_cal_page` order by `sid_date`;

-- -----------------------------------------------------
-- View `salpa`.`v_checkchap_actual`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_checkchap_actual`;
DROP VIEW IF EXISTS `salpa`.`v_checkchap_actual` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_checkchap_actual` AS select max(`salpa`.`checkchap`.`study_id`) AS `study_id`,count(`salpa`.`checkchap`.`actualtime`) AS `actual_cnt` from `salpa`.`checkchap` where ((`salpa`.`checkchap`.`actualtime` <= now()) and (`salpa`.`checkchap`.`deleted` = 0)) group by `salpa`.`checkchap`.`study_id`;

-- -----------------------------------------------------
-- View `salpa`.`v_checkchap_actual_chap_yesterday`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_checkchap_actual_chap_yesterday`;
DROP VIEW IF EXISTS `salpa`.`v_checkchap_actual_chap_yesterday` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_checkchap_actual_chap_yesterday` AS select max(`salpa`.`checkchap`.`study_id`) AS `study_id`,count(`salpa`.`checkchap`.`actualtime`) AS `actual_cnt` from `salpa`.`checkchap` where ((`salpa`.`checkchap`.`actualtime` < date_format(now(),'%Y-%m-%d')) and (`salpa`.`checkchap`.`deleted` = 0)) group by `salpa`.`checkchap`.`study_id`;

-- -----------------------------------------------------
-- View `salpa`.`v_checkchap_actual_days_yesterday`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_checkchap_actual_days_yesterday`;
DROP VIEW IF EXISTS `salpa`.`v_checkchap_actual_days_yesterday` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_checkchap_actual_days_yesterday` AS select max(`a`.`study_id`) AS `study_id`,count(`a`.`actualtime`) AS `actual_days` from (select distinct `salpa`.`checkchap`.`actualtime` AS `actualtime`,`salpa`.`checkchap`.`study_id` AS `study_id` from `salpa`.`checkchap` where (`salpa`.`checkchap`.`actualtime` < date_format(now(),'%Y-%m-%d')) order by `salpa`.`checkchap`.`actualtime`) `a` group by `a`.`study_id`;

-- -----------------------------------------------------
-- View `salpa`.`v_checkchap_plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_checkchap_plan`;
DROP VIEW IF EXISTS `salpa`.`v_checkchap_plan` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_checkchap_plan` AS select max(`salpa`.`checkchap`.`study_id`) AS `study_id`,count(`salpa`.`checkchap`.`plantime`) AS `plan_cnt` from `salpa`.`checkchap` where ((`salpa`.`checkchap`.`plantime` <= now()) and (`salpa`.`checkchap`.`deleted` = 0)) group by `salpa`.`checkchap`.`study_id`;

-- -----------------------------------------------------
-- View `salpa`.`v_checkchap_plan_chap_yesterday`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_checkchap_plan_chap_yesterday`;
DROP VIEW IF EXISTS `salpa`.`v_checkchap_plan_chap_yesterday` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_checkchap_plan_chap_yesterday` AS select max(`salpa`.`checkchap`.`study_id`) AS `study_id`,count(`salpa`.`checkchap`.`plantime`) AS `plan_cnt` from `salpa`.`checkchap` where ((`salpa`.`checkchap`.`plantime` < date_format(now(),'%Y-%m-%d')) and (`salpa`.`checkchap`.`deleted` = 0)) group by `salpa`.`checkchap`.`study_id`;

-- -----------------------------------------------------
-- View `salpa`.`v_checkchap_plan_days_yesterday`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_checkchap_plan_days_yesterday`;
DROP VIEW IF EXISTS `salpa`.`v_checkchap_plan_days_yesterday` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_checkchap_plan_days_yesterday` AS select max(`a`.`study_id`) AS `study_id`,count(`a`.`plantime`) AS `plan_days` from (select distinct `salpa`.`checkchap`.`plantime` AS `plantime`,`salpa`.`checkchap`.`study_id` AS `study_id` from `salpa`.`checkchap` where (`salpa`.`checkchap`.`plantime` < date_format(now(),'%Y-%m-%d')) order by `salpa`.`checkchap`.`plantime`) `a` group by `a`.`study_id`;

-- -----------------------------------------------------
-- View `salpa`.`v_checkchap_total`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_checkchap_total`;
DROP VIEW IF EXISTS `salpa`.`v_checkchap_total` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_checkchap_total` AS select max(`salpa`.`checkchap`.`study_id`) AS `study_id`,count(`salpa`.`checkchap`.`id`) AS `total_cnt` from `salpa`.`checkchap` where (`salpa`.`checkchap`.`deleted` = 0) group by `salpa`.`checkchap`.`study_id`;

-- -----------------------------------------------------
-- View `salpa`.`v_checkchap_total_days`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_checkchap_total_days`;
DROP VIEW IF EXISTS `salpa`.`v_checkchap_total_days` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_checkchap_total_days` AS select max(`a`.`study_id`) AS `study_id`,count(`a`.`plantime`) AS `total_days` from (select distinct `salpa`.`checkchap`.`plantime` AS `plantime`,`salpa`.`checkchap`.`study_id` AS `study_id` from `salpa`.`checkchap` order by `salpa`.`checkchap`.`plantime`) `a` group by `a`.`study_id`;

-- -----------------------------------------------------
-- View `salpa`.`v_checkpage_actual`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_checkpage_actual`;
DROP VIEW IF EXISTS `salpa`.`v_checkpage_actual` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_checkpage_actual` AS select max(`salpa`.`checkpage`.`study_id`) AS `study_id`,count(`salpa`.`checkpage`.`id`) AS `plan_days`,count(`salpa`.`checkpage`.`actualpage`) AS `actual_days`,max(`salpa`.`checkpage`.`planpage`) AS `plan_page`,max(`salpa`.`checkpage`.`actualpage`) AS `actual_page` from `salpa`.`checkpage` where ((`salpa`.`checkpage`.`deleted` = 0) and (`salpa`.`checkpage`.`date` <= now())) group by `salpa`.`checkpage`.`study_id`;

-- -----------------------------------------------------
-- View `salpa`.`v_checkpage_actual_yesterday`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_checkpage_actual_yesterday`;
DROP VIEW IF EXISTS `salpa`.`v_checkpage_actual_yesterday` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_checkpage_actual_yesterday` AS select max(`salpa`.`checkpage`.`study_id`) AS `study_id`,count(`salpa`.`checkpage`.`id`) AS `plan_days_yesterday`,count(`salpa`.`checkpage`.`actualpage`) AS `actual_days_yesterday`,max(`salpa`.`checkpage`.`planpage`) AS `plan_page_yesterday`,max(`salpa`.`checkpage`.`actualpage`) AS `actual_page_yesterday` from `salpa`.`checkpage` where ((`salpa`.`checkpage`.`deleted` = 0) and (`salpa`.`checkpage`.`date` < date_format(now(),'%Y-%m-%d'))) group by `salpa`.`checkpage`.`study_id`;

-- -----------------------------------------------------
-- View `salpa`.`v_checkpage_total`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_checkpage_total`;
DROP VIEW IF EXISTS `salpa`.`v_checkpage_total` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_checkpage_total` AS select max(`salpa`.`checkpage`.`study_id`) AS `study_id`,count(`salpa`.`checkpage`.`id`) AS `total_days`,max(`salpa`.`checkpage`.`planpage`) AS `total_pages` from `salpa`.`checkpage` where (`salpa`.`checkpage`.`deleted` = 0) group by `salpa`.`checkpage`.`study_id`;

-- -----------------------------------------------------
-- View `salpa`.`v_notice`
-- -----------------------------------------------------
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_notice` AS
    SELECT 
        `a`.`id` AS `id`,
        `a`.`createtime` AS `createtime`,
        `b`.`createtime` AS `answertime`,
        `a`.`title` AS `title`,
        `a`.`content` AS `content`,
        `b`.`content` AS `answer`,
        `b`.`title` AS `checked`,
        `b`.`id` AS `club_id`,
        `a`.`user_id` AS `user_id`,
        `a`.`deleted` AS `deleted`
    FROM
        (`club` `a`
        JOIN `club` `b` ON ((`a`.`id` = `b`.`ref`)))
    WHERE
        (`a`.`book_bid` = 0);
-- -----------------------------------------------------
-- View `salpa`.`v_readers_cnt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_readers_cnt`;
DROP VIEW IF EXISTS `salpa`.`v_readers_cnt` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_readers_cnt` AS select `b`.`bid` AS `book_bid`,count(`s`.`book_bid`) AS `readers`,`b`.`title` AS `title`,`b`.`coverurl` AS `coverurl` from (`salpa`.`book` `b` left join `salpa`.`study` `s` on((`b`.`bid` = `s`.`book_bid`))) where (`s`.`deleted` <> 1) group by `s`.`book_bid`;

-- -----------------------------------------------------
-- View `salpa`.`v_study`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salpa`.`v_study`;
DROP VIEW IF EXISTS `salpa`.`v_study` ;
USE `salpa`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`scott`@`localhost` SQL SECURITY DEFINER VIEW `salpa`.`v_study` AS select `salpa`.`study`.`user_id` AS `user_id`,`salpa`.`user`.`nickname` AS `nickname`,`salpa`.`study`.`book_bid` AS `book_bid`,`salpa`.`book`.`title` AS `title`,`salpa`.`book`.`pages` AS `pages`,`salpa`.`book`.`coverurl` AS `coverurl`,`salpa`.`study`.`id` AS `study_id`,`salpa`.`study`.`createtime` AS `createtime`,`salpa`.`study`.`updatetime` AS `updatetime`,`salpa`.`study`.`startdate` AS `startdate`,`salpa`.`study`.`enddate` AS `enddate`,`salpa`.`study`.`memo` AS `memo`,`salpa`.`study`.`type` AS `type`,`v_checkchap_total`.`total_cnt` AS `total_chap`,`v_checkchap_plan_chap_yesterday`.`plan_cnt` AS `plan_chap_yesterday`,`v_checkchap_actual_chap_yesterday`.`actual_cnt` AS `actual_chap_yesterday`,`v_checkchap_plan`.`plan_cnt` AS `plan_chap`,`v_checkchap_actual`.`actual_cnt` AS `actual_chap`,(coalesce(`v_checkchap_total_days`.`total_days`,0) + coalesce(`v_checkpage_total`.`total_days`,0)) AS `total_days`,(coalesce(`v_checkchap_plan_days_yesterday`.`plan_days`,0) + coalesce(`v_checkpage_actual_yesterday`.`plan_days_yesterday`,0)) AS `plan_days_yesterday`,(coalesce(`v_checkchap_actual_days_yesterday`.`actual_days`,0) + coalesce(`v_checkpage_actual_yesterday`.`actual_days_yesterday`,0)) AS `actual_days_yesterday`,((coalesce(`v_checkchap_total_days`.`total_days`,0) + coalesce(`v_checkpage_total`.`total_days`,0)) - (coalesce(`v_checkchap_plan_days_yesterday`.`plan_days`,0) + coalesce(`v_checkpage_actual_yesterday`.`plan_days_yesterday`,0))) AS `remain_days`,`v_checkpage_total`.`total_pages` AS `total_pages`,`v_checkpage_actual_yesterday`.`plan_page_yesterday` AS `plan_page_yesterday`,`v_checkpage_actual_yesterday`.`actual_page_yesterday` AS `actual_page_yesterday`,`v_checkpage_actual`.`plan_page` AS `plan_page`,`v_checkpage_actual`.`actual_page` AS `actual_page`,(coalesce(((`v_checkchap_actual`.`actual_cnt` / `v_checkchap_total`.`total_cnt`) * 100),0) + coalesce(((`v_checkpage_actual`.`actual_page` / `v_checkpage_total`.`total_pages`) * 100),0)) AS `progress_rate`,(coalesce(((`v_checkchap_actual`.`actual_cnt` / `v_checkchap_plan`.`plan_cnt`) * 100),0) + coalesce(((`v_checkpage_actual`.`actual_page` / `v_checkpage_actual`.`plan_page`) * 100),0)) AS `success_rate` from (((((((((((((`salpa`.`study` left join `salpa`.`v_checkchap_actual` on((`salpa`.`study`.`id` = `v_checkchap_actual`.`study_id`))) left join `salpa`.`v_checkchap_actual_chap_yesterday` on((`salpa`.`study`.`id` = `v_checkchap_actual_chap_yesterday`.`study_id`))) left join `salpa`.`v_checkchap_actual_days_yesterday` on((`salpa`.`study`.`id` = `v_checkchap_actual_days_yesterday`.`study_id`))) left join `salpa`.`v_checkchap_plan` on((`salpa`.`study`.`id` = `v_checkchap_plan`.`study_id`))) left join `salpa`.`v_checkchap_plan_chap_yesterday` on((`salpa`.`study`.`id` = `v_checkchap_plan_chap_yesterday`.`study_id`))) left join `salpa`.`v_checkchap_plan_days_yesterday` on((`salpa`.`study`.`id` = `v_checkchap_plan_days_yesterday`.`study_id`))) left join `salpa`.`v_checkchap_total` on((`salpa`.`study`.`id` = `v_checkchap_total`.`study_id`))) left join `salpa`.`v_checkchap_total_days` on((`salpa`.`study`.`id` = `v_checkchap_total_days`.`study_id`))) left join `salpa`.`v_checkpage_actual` on((`salpa`.`study`.`id` = `v_checkpage_actual`.`study_id`))) left join `salpa`.`v_checkpage_actual_yesterday` on((`salpa`.`study`.`id` = `v_checkpage_actual_yesterday`.`study_id`))) left join `salpa`.`v_checkpage_total` on((`salpa`.`study`.`id` = `v_checkpage_total`.`study_id`))) left join `salpa`.`user` on((`salpa`.`study`.`user_id` = `salpa`.`user`.`id`))) left join `salpa`.`book` on((`salpa`.`study`.`book_bid` = `salpa`.`book`.`bid`))) where (`salpa`.`study`.`deleted` = 0);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
