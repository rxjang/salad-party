CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_checkchap_actual` AS
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
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_checkchap_actual_chap_yesterday` AS
    SELECT 
        MAX(`checkchap`.`study_id`) AS `study_id`,
        COUNT(`checkchap`.`actualtime`) AS `actual_cnt`
    FROM
        `checkchap`
    WHERE
        ((`checkchap`.`actualtime` < DATE_FORMAT(NOW(), '%Y-%m-%d'))
            AND (`checkchap`.`deleted` = 0))
    GROUP BY `checkchap`.`study_id`;
    
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_checkchap_actual_days_yesterday` AS
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
            (`checkchap`.`actualtime` < DATE_FORMAT(NOW(), '%Y-%m-%d'))
        ORDER BY `checkchap`.`actualtime`) `a`
    GROUP BY `a`.`study_id`;
    
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_checkchap_plan` AS
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
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_checkchap_plan_chap_yesterday` AS
    SELECT 
        MAX(`checkchap`.`study_id`) AS `study_id`,
        COUNT(`checkchap`.`plantime`) AS `plan_cnt`
    FROM
        `checkchap`
    WHERE
        ((`checkchap`.`plantime` < DATE_FORMAT(NOW(), '%Y-%m-%d'))
            AND (`checkchap`.`deleted` = 0))
    GROUP BY `checkchap`.`study_id`;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_checkchap_plan_days_yesterday` AS
    SELECT 
        MAX(`a`.`study_id`) AS `study_id`,
        COUNT(`a`.`plantime`) AS `plan_days`
    FROM
        (SELECT DISTINCT
            `checkchap`.`plantime` AS `plantime`,
                `checkchap`.`study_id` AS `study_id`
        FROM
            `checkchap`
        WHERE
            (`checkchap`.`plantime` < DATE_FORMAT(NOW(), '%Y-%m-%d'))
        ORDER BY `checkchap`.`plantime`) `a`
    GROUP BY `a`.`study_id`;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_checkchap_total` AS
    SELECT 
        MAX(`checkchap`.`study_id`) AS `study_id`,
        COUNT(`checkchap`.`id`) AS `total_cnt`
    FROM
        `checkchap`
    WHERE
        (`checkchap`.`deleted` = 0)
    GROUP BY `checkchap`.`study_id`;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
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
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_checkpage_actual` AS
    SELECT 
        MAX(`checkpage`.`study_id`) AS `study_id`,
        COUNT(`checkpage`.`id`) AS `plan_days`,
        COUNT(`checkpage`.`actualpage`) AS `actual_days`,
        MAX(`checkpage`.`planpage`) AS `plan_page`,
        MAX(`checkpage`.`actualpage`) AS `actual_page`
    FROM
        `checkpage`
    WHERE
        ((`checkpage`.`deleted` = 0)
            AND (`checkpage`.`date` <= NOW()))
    GROUP BY `checkpage`.`study_id`;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_checkpage_actual_yesterday` AS
    SELECT 
        MAX(`checkpage`.`study_id`) AS `study_id`,
        COUNT(`checkpage`.`id`) AS `plan_days_yesterday`,
        COUNT(`checkpage`.`actualpage`) AS `actual_days_yesterday`,
        MAX(`checkpage`.`planpage`) AS `plan_page_yesterday`,
        MAX(`checkpage`.`actualpage`) AS `actual_page_yesterday`
    FROM
        `checkpage`
    WHERE
        ((`checkpage`.`deleted` = 0)
            AND (`checkpage`.`date` < DATE_FORMAT(NOW(), '%Y-%m-%d')))
    GROUP BY `checkpage`.`study_id`;

CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
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
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
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
        `v_checkchap_total`.`total_cnt` AS `total_chap`,
        `v_checkchap_plan_chap_yesterday`.`plan_cnt` AS `plan_chap_yesterday`,
        `v_checkchap_actual_chap_yesterday`.`actual_cnt` AS `actual_chap_yesterday`,
        `v_checkchap_plan`.`plan_cnt` AS `plan_chap`,
        `v_checkchap_actual`.`actual_cnt` AS `actual_chap`,
        (COALESCE(`v_checkchap_total_days`.`total_days`, 0) + COALESCE(`v_checkpage_total`.`total_days`, 0)) AS `total_days`,
        (COALESCE(`v_checkchap_plan_days_yesterday`.`plan_days`,
                0) + COALESCE(`v_checkpage_actual_yesterday`.`plan_days_yesterday`,
                0)) AS `plan_days_yesterday`,
        (COALESCE(`v_checkchap_actual_days_yesterday`.`actual_days`,
                0) + COALESCE(`v_checkpage_actual_yesterday`.`actual_days_yesterday`,
                0)) AS `actual_days_yesterday`,
        ((COALESCE(`v_checkchap_total_days`.`total_days`, 0) + COALESCE(`v_checkpage_total`.`total_days`, 0)) - (COALESCE(`v_checkchap_plan_days_yesterday`.`plan_days`,
                0) + COALESCE(`v_checkpage_actual_yesterday`.`plan_days_yesterday`,
                0))) AS `remain_days`,
        `v_checkpage_total`.`total_pages` AS `total_pages`,
        `v_checkpage_actual_yesterday`.`plan_page_yesterday` AS `plan_page_yesterday`,
        `v_checkpage_actual_yesterday`.`actual_page_yesterday` AS `actual_page_yesterday`,
        `v_checkpage_actual`.`plan_page` AS `plan_page`,
        `v_checkpage_actual`.`actual_page` AS `actual_page`,
        (COALESCE(((`v_checkchap_actual`.`actual_cnt` / `v_checkchap_total`.`total_cnt`) * 100),
                0) + COALESCE(((`v_checkpage_actual`.`actual_page` / `v_checkpage_total`.`total_pages`) * 100),
                0)) AS `progress_rate`,
        (COALESCE(((`v_checkchap_actual`.`actual_cnt` / `v_checkchap_plan`.`plan_cnt`) * 100),
                0) + COALESCE(((`v_checkpage_actual`.`actual_page` / `v_checkpage_actual`.`plan_page`) * 100),
                0)) AS `success_rate`
    FROM
        (((((((((((((`study`
        LEFT JOIN `v_checkchap_actual` ON ((`study`.`id` = `v_checkchap_actual`.`study_id`)))
        LEFT JOIN `v_checkchap_actual_chap_yesterday` ON ((`study`.`id` = `v_checkchap_actual_chap_yesterday`.`study_id`)))
        LEFT JOIN `v_checkchap_actual_days_yesterday` ON ((`study`.`id` = `v_checkchap_actual_days_yesterday`.`study_id`)))
        LEFT JOIN `v_checkchap_plan` ON ((`study`.`id` = `v_checkchap_plan`.`study_id`)))
        LEFT JOIN `v_checkchap_plan_chap_yesterday` ON ((`study`.`id` = `v_checkchap_plan_chap_yesterday`.`study_id`)))
        LEFT JOIN `v_checkchap_plan_days_yesterday` ON ((`study`.`id` = `v_checkchap_plan_days_yesterday`.`study_id`)))
        LEFT JOIN `v_checkchap_total` ON ((`study`.`id` = `v_checkchap_total`.`study_id`)))
        LEFT JOIN `v_checkchap_total_days` ON ((`study`.`id` = `v_checkchap_total_days`.`study_id`)))
        LEFT JOIN `v_checkpage_actual` ON ((`study`.`id` = `v_checkpage_actual`.`study_id`)))
        LEFT JOIN `v_checkpage_actual_yesterday` ON ((`study`.`id` = `v_checkpage_actual_yesterday`.`study_id`)))
        LEFT JOIN `v_checkpage_total` ON ((`study`.`id` = `v_checkpage_total`.`study_id`)))
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
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_readers_cnt` AS
    SELECT 
        `b`.`bid` AS `book_bid`,
        COUNT(`s`.`book_bid`) AS `readers`,
        `b`.`title` AS `title`,
        `b`.`coverurl` AS `coverurl`
    FROM
        (`book` `b`
        LEFT JOIN `study` `s` ON ((`b`.`bid` = `s`.`book_bid`)))
    WHERE
        (`s`.`deleted` <> 1)
    GROUP BY `s`.`book_bid`;
         
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
        JOIN `club` `b` ON ((`a`.`id` = `b`.`ref`)))
    WHERE
        (`a`.`book_bid` = 0);
        
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_cal_page` AS
    SELECT 
        `study`.`user_id` AS `user_id`,
        CONCAT(`checkpage`.`study_id`,
                ':',
                DATE_FORMAT(`checkpage`.`date`, '%Y-%m-%d')) AS `sid_date`,
        'page' AS `type`,
        `checkpage`.`study_id` AS `study_id`,
        DATE_FORMAT(`checkpage`.`date`, '%Y-%m-%d') AS `date`,
        `checkpage`.`planpage` AS `plan`,
        `checkpage`.`actualpage` AS `actual`,
        (COALESCE(`checkpage`.`actualpage`, 0) - COALESCE(`checkpage`.`planpage`, 0)) AS `status`
    FROM
        (`checkpage`
        LEFT JOIN `study` ON ((`checkpage`.`study_id` = `study`.`id`)));
        
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_cal_chap_base` AS
    SELECT 
        `checkchap`.`id` AS `id`,
        `checkchap`.`toc` AS `toc`,
        `checkchap`.`plantime` AS `plantime`,
        `checkchap`.`actualtime` AS `actualtime`,
        `checkchap`.`deleted` AS `deleted`,
        `checkchap`.`study_id` AS `study_id`,
        CONCAT(`checkchap`.`study_id`,
                ':',
                DATE_FORMAT(`checkchap`.`plantime`, '%Y-%m-%d')) AS `sid_plandate`,
        CONCAT(`checkchap`.`study_id`,
                ':',
                DATE_FORMAT(`checkchap`.`actualtime`, '%Y-%m-%d')) AS `sid_actualdate`
    FROM
        `checkchap`;
        
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_cal_chap_sid_date` AS
    SELECT 
        `v_cal_chap_base`.`sid_plandate` AS `sid_date`,
        `v_cal_chap_base`.`study_id` AS `study_id`,
        DATE_FORMAT(`v_cal_chap_base`.`plantime`, '%Y-%m-%d') AS `date`
    FROM
        `v_cal_chap_base` 
    UNION SELECT 
        `v_cal_chap_base`.`sid_actualdate` AS `sid_date`,
        `v_cal_chap_base`.`study_id` AS `study_id`,
        DATE_FORMAT(`v_cal_chap_base`.`actualtime`,
                '%Y-%m-%d') AS `date`
    FROM
        `v_cal_chap_base`;
        
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_cal_chap_plan` AS
    SELECT 
        COUNT(`v_cal_chap_base`.`plantime`) AS `plan`,
        MAX(`v_cal_chap_base`.`sid_plandate`) AS `sid_plandate`
    FROM
        `v_cal_chap_base`
    GROUP BY `v_cal_chap_base`.`sid_plandate`;
    
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_cal_chap_actual` AS
    SELECT 
        COUNT(`v_cal_chap_base`.`actualtime`) AS `actual`,
        MAX(`v_cal_chap_base`.`sid_actualdate`) AS `sid_actualdate`
    FROM
        `v_cal_chap_base`
    GROUP BY `v_cal_chap_base`.`sid_actualdate`;
        
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_cal_chap` AS
    SELECT 
        `study`.`user_id` AS `user_id`,
        `v_cal_chap_sid_date`.`sid_date` AS `sid_date`,
        'chap' AS `type`,
        `v_cal_chap_sid_date`.`study_id` AS `study_id`,
        `v_cal_chap_sid_date`.`date` AS `date`,
        `v_cal_chap_plan`.`plan` AS `plan`,
        `v_cal_chap_actual`.`actual` AS `actual`,
        (COALESCE(`v_cal_chap_actual`.`actual`, 0) - COALESCE(`v_cal_chap_plan`.`plan`, 0)) AS `status`
    FROM
        (((`v_cal_chap_sid_date`
        LEFT JOIN `study` ON ((`v_cal_chap_sid_date`.`study_id` = `study`.`id`)))
        LEFT JOIN `v_cal_chap_plan` ON ((`v_cal_chap_sid_date`.`sid_date` = `v_cal_chap_plan`.`sid_plandate`)))
        LEFT JOIN `v_cal_chap_actual` ON ((`v_cal_chap_sid_date`.`sid_date` = `v_cal_chap_actual`.`sid_actualdate`)))
    WHERE
        (`v_cal_chap_sid_date`.`sid_date` IS NOT NULL);
        
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`localhost` 
    SQL SECURITY DEFINER
VIEW `v_calendar` AS
    SELECT 
        `v_cal_chap`.`user_id` AS `user_id`,
        `v_cal_chap`.`sid_date` AS `sid_date`,
        `v_cal_chap`.`type` AS `type`,
        `v_cal_chap`.`study_id` AS `study_id`,
        `v_cal_chap`.`date` AS `date`,
        `v_cal_chap`.`plan` AS `plan`,
        `v_cal_chap`.`actual` AS `actual`,
        `v_cal_chap`.`status` AS `status`
    FROM
        `v_cal_chap` 
    UNION SELECT 
        `v_cal_page`.`user_id` AS `user_id`,
        `v_cal_page`.`sid_date` AS `sid_date`,
        `v_cal_page`.`type` AS `type`,
        `v_cal_page`.`study_id` AS `study_id`,
        `v_cal_page`.`date` AS `date`,
        `v_cal_page`.`plan` AS `plan`,
        `v_cal_page`.`actual` AS `actual`,
        `v_cal_page`.`status` AS `status`
    FROM
        `v_cal_page`
    ORDER BY `sid_date`;