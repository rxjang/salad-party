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