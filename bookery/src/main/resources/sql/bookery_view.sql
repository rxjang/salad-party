CREATE 
VIEW `v_checkchap_actual_cnt` AS
    SELECT 
        MAX(`checkchap`.`study_id`) AS `study_id`,
        COUNT(`checkchap`.`actualtime`) AS `actual_cnt`
    FROM
        `checkchap`
    WHERE
        ((`checkchap`.`actualtime` <= NOW())
            AND (`checkchap`.`deleted` = 0))
    GROUP BY `checkchap`.`study_id`;

CREATE 
VIEW `v_checkchap_plan_cnt` AS
    SELECT 
        MAX(`checkchap`.`study_id`) AS `study_id`,
        COUNT(`checkchap`.`plantime`) AS `plan_cnt`
    FROM
        `checkchap`
    WHERE
        ((`checkchap`.`plantime` <= NOW())
            AND (`checkchap`.`deleted` = 0))
    GROUP BY `checkchap`.`study_id`;

CREATE 
VIEW `v_checkchap_total_cnt` AS
    SELECT 
        MAX(`checkchap`.`study_id`) AS `study_id`,
        COUNT(`checkchap`.`id`) AS `total_cnt`
    FROM
        `checkchap`
    WHERE
        (`checkchap`.`deleted` = 0)
    GROUP BY `checkchap`.`study_id`;

CREATE 
VIEW `v_checkpage_todate` AS
    SELECT 
        MAX(`checkpage`.`study_id`) AS `study_id`,
        COUNT(`checkpage`.`id`) AS `days_todate`,
        MAX(`checkpage`.`planpage`) AS `plan_page`,
        MAX(`checkpage`.`actualpage`) AS `actual_page`
    FROM
        `checkpage`
    WHERE
        ((`checkpage`.`deleted` = 0)
            AND (`checkpage`.`date` <= NOW()))
    GROUP BY `checkpage`.`study_id`;

CREATE
VIEW `v_checkpage_total` AS
    SELECT 
        MAX(`checkpage`.`study_id`) AS `study_id`,
        COUNT(`checkpage`.`id`) AS `total_days`,
        MAX(`checkpage`.`planpage`) AS `total_pages`
    FROM
        `checkpage`
    WHERE
        (`checkpage`.`deleted` = 0)
    GROUP BY `checkpage`.`study_id`;

CREATE
VIEW `salpa`.`v_study` AS
    SELECT 
        `salpa`.`study`.`user_id` AS `user_id`,
        `salpa`.`user`.`nickname` AS `nickname`,
        `salpa`.`study`.`book_bid` AS `book_bid`,
        `salpa`.`book`.`title` AS `title`,
        `salpa`.`book`.`pages` AS `pages`,
        `book`.`coverurl` AS `coverurl`,
        `salpa`.`study`.`id` AS `study_id`,
        `salpa`.`study`.`createtime` AS `createtime`,
        `salpa`.`study`.`updatetime` AS `updatetime`,
        `salpa`.`study`.`startdate` AS `startdate`,
        `salpa`.`study`.`enddate` AS `enddate`,
        `salpa`.`study`.`memo` AS `memo`,
        `salpa`.`study`.`type` AS `type`,
        `v_checkchap_plan_cnt`.`plan_cnt` AS `plan_cnt`,
        `v_checkchap_actual_cnt`.`actual_cnt` AS `actual_cnt`,
        `v_checkchap_total_cnt`.`total_cnt` AS `total_cnt`,
        `v_checkpage_total`.`total_days` AS `total_days`,
        `v_checkpage_todate`.`days_todate` AS `days_todate`,
        `v_checkpage_total`.`total_pages` AS `total_pages`,
        `v_checkpage_todate`.`plan_page` AS `plan_page`,
        `v_checkpage_todate`.`actual_page` AS `actual_page`,
        ((`v_checkchap_actual_cnt`.`actual_cnt` / `v_checkchap_total_cnt`.`total_cnt`) * 100) AS `progress_chap`,
        ((`v_checkchap_actual_cnt`.`actual_cnt` / `v_checkchap_plan_cnt`.`plan_cnt`) * 100) AS `success_chap`,
        ((`v_checkpage_todate`.`actual_page` / `v_checkpage_total`.`total_pages`) * 100) AS `progress_page`,
        ((`v_checkpage_todate`.`actual_page` / `v_checkpage_todate`.`plan_page`) * 100) AS `success_page`,
        (COALESCE(((`v_checkchap_actual_cnt`.`actual_cnt` / `v_checkchap_total_cnt`.`total_cnt`) * 100),
                0) + COALESCE(((`v_checkpage_todate`.`actual_page` / `v_checkpage_total`.`total_pages`) * 100),
                0)) AS `progress_rate`,
        (COALESCE(((`v_checkchap_actual_cnt`.`actual_cnt` / `v_checkchap_plan_cnt`.`plan_cnt`) * 100),
                0) + COALESCE(((`v_checkpage_todate`.`actual_page` / `v_checkpage_todate`.`plan_page`) * 100),
                0)) AS `success_rate`
    FROM
        (((((((`salpa`.`study`
        LEFT JOIN `salpa`.`v_checkchap_total_cnt` ON ((`salpa`.`study`.`id` = `v_checkchap_total_cnt`.`study_id`)))
        LEFT JOIN `salpa`.`v_checkchap_plan_cnt` ON ((`salpa`.`study`.`id` = `v_checkchap_plan_cnt`.`study_id`)))
        LEFT JOIN `salpa`.`v_checkchap_actual_cnt` ON ((`salpa`.`study`.`id` = `v_checkchap_actual_cnt`.`study_id`)))
        LEFT JOIN `salpa`.`v_checkpage_total` ON ((`salpa`.`study`.`id` = `v_checkpage_total`.`study_id`)))
        LEFT JOIN `salpa`.`v_checkpage_todate` ON ((`salpa`.`study`.`id` = `v_checkpage_todate`.`study_id`)))
        LEFT JOIN `salpa`.`user` ON ((`salpa`.`study`.`user_id` = `salpa`.`user`.`id`)))
        LEFT JOIN `salpa`.`book` ON ((`salpa`.`study`.`book_bid` = `salpa`.`book`.`bid`)))
    WHERE
        (`salpa`.`study`.`deleted` = 0);
        
        
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
        `a`.`user_id` AS `user_id`
    FROM
        (`medal` `m`
        JOIN `award` `a`)
    WHERE
        (`m`.`id` = `a`.`medal_id`);