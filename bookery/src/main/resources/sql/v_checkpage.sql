CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`%` 
    SQL SECURITY DEFINER
VIEW `salpa`.`v_checkpage` AS
    SELECT 
        MAX(`salpa`.`checkpage`.`study_id`) AS `study_id`,
        COUNT(`salpa`.`checkpage`.`id`) AS `total_cnt`,
        SUM(`salpa`.`checkpage`.`planpages`) AS `planpages_todate`,
        MAX(`salpa`.`checkpage`.`endpage`) AS `endpage`,
        (SUM(`salpa`.`checkpage`.`endpage`) - SUM(`salpa`.`checkpage`.`startpage`)) AS `actualpages_todate`,
        (((SUM(`salpa`.`checkpage`.`endpage`) - SUM(`salpa`.`checkpage`.`startpage`)) / `salpa`.`checkpage`.`planpages`) * 100) AS `actual_vs_plan`
    FROM
        `salpa`.`checkpage`
    WHERE
        ((`salpa`.`checkpage`.`deleted` = 0)
            AND (`salpa`.`checkpage`.`date` <= NOW()))
    GROUP BY `salpa`.`checkpage`.`study_id`