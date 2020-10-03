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
VIEW `v_checkchap_actual_days` AS
    SELECT 
        MAX(`a`.`study_id`) AS `study_id`,
        COUNT(`a`.`actualtime`) AS `actual_days`
    FROM
        (SELECT DISTINCT
            `checkchap`.`actualtime` AS `actualtime`,
                `checkchap`.`study_id` AS `study_id`
        FROM
            `checkchap`
        WHERE
            (`checkchap`.`actualtime` <= NOW())
        ORDER BY `checkchap`.`actualtime`) `a`
    GROUP BY `a`.`study_id`;

CREATE 
VIEW `v_checkchap_total_days` AS
    SELECT 
        MAX(`a`.`study_id`) AS `study_id`,
        COUNT(`a`.`plantime`) AS `total_days`
    FROM
        (SELECT DISTINCT
            `checkchap`.`plantime` AS `plantime`,
                `checkchap`.`study_id` AS `study_id`
        FROM
            `checkchap`
        ORDER BY `checkchap`.`plantime`) `a`
    GROUP BY `a`.`study_id`;

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
VIEW `v_study` AS
    SELECT 
        `study`.`user_id` AS `user_id`,
        `user`.`nickname` AS `nickname`,
        `study`.`book_bid` AS `book_bid`,
        `book`.`title` AS `title`,
        `book`.`pages` AS `pages`,
        `book`.`coverurl` AS `coverurl`,
        `study`.`id` AS `study_id`,
        `study`.`createtime` AS `createtime`,
        `study`.`updatetime` AS `updatetime`,
        `study`.`startdate` AS `startdate`,
        `study`.`enddate` AS `enddate`,
        `study`.`memo` AS `memo`,
        `study`.`type` AS `type`,
        `v_checkchap_plan_cnt`.`plan_cnt` AS `plan_cnt`,
        `v_checkchap_actual_cnt`.`actual_cnt` AS `actual_cnt`,
        `v_checkchap_total_cnt`.`total_cnt` AS `total_cnt`,
        `v_checkchap_actual_days`.`actual_days` AS `chap_actual_days`,
        `v_checkchap_total_days`.`total_days` AS `chap_total_days`,
        `v_checkpage_todate`.`days_todate` AS `page_actual_days`,
        `v_checkpage_total`.`total_days` AS `page_total_days`,
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
        (((((((((`study`
        LEFT JOIN `v_checkchap_total_cnt` ON ((`study`.`id` = `v_checkchap_total_cnt`.`study_id`)))
        LEFT JOIN `v_checkchap_plan_cnt` ON ((`study`.`id` = `v_checkchap_plan_cnt`.`study_id`)))
        LEFT JOIN `v_checkchap_actual_cnt` ON ((`study`.`id` = `v_checkchap_actual_cnt`.`study_id`)))
        LEFT JOIN `v_checkchap_actual_days` ON ((`study`.`id` = `v_checkchap_actual_days`.`study_id`)))
        LEFT JOIN `v_checkchap_total_days` ON ((`study`.`id` = `v_checkchap_total_days`.`study_id`)))
        LEFT JOIN `v_checkpage_total` ON ((`study`.`id` = `v_checkpage_total`.`study_id`)))
        LEFT JOIN `v_checkpage_todate` ON ((`study`.`id` = `v_checkpage_todate`.`study_id`)))
        LEFT JOIN `user` ON ((`study`.`user_id` = `user`.`id`)))
        LEFT JOIN `book` ON ((`study`.`book_bid` = `book`.`bid`)))
    WHERE
        (`study`.`deleted` = 0);
        
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

CREATE 
VIEW `v_readers_cnt` AS
    SELECT 
        b.bid AS book_bid,
        count(book_bid) AS readers,
        b.title,
        b.coverurl
    FROM	
        (salpa.book b left join salpa.study s on b.bid = s.book_bid) where s.deleted != 1 group by s.book_bid ;
        
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
        `a`.`user_id` AS `user_id`,
        `a`.`deleted` AS `deleted`
    FROM
        (`club` `a`
        inner JOIN `club` `b`)
    WHERE
        (`a`.`id` = `b`.`ref`)