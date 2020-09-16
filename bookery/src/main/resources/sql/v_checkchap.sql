CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `scott`@`%` 
    SQL SECURITY DEFINER
VIEW `salpa`.`v_checkchap` AS
    SELECT 
        MAX(`salpa`.`checkchap`.`study_id`) AS `study_id`,
        COUNT(`salpa`.`checkchap`.`id`) AS `total_cnt`,
        (SELECT 
                COUNT(`salpa`.`checkchap`.`plantime`)
            FROM
                `salpa`.`checkchap`
            WHERE
                (`salpa`.`checkchap`.`plantime` <= NOW())) AS `plan_cnt`,
        (SELECT 
                COUNT(`salpa`.`checkchap`.`actualtime`)
            FROM
                `salpa`.`checkchap`
            WHERE
                (`salpa`.`checkchap`.`actualtime` <= NOW())) AS `actual_cnt`,
        (((SELECT 
                COUNT(`salpa`.`checkchap`.`actualtime`)
            FROM
                `salpa`.`checkchap`
            WHERE
                (`salpa`.`checkchap`.`actualtime` <= NOW())) / (SELECT 
                COUNT(`salpa`.`checkchap`.`plantime`)
            FROM
                `salpa`.`checkchap`
            WHERE
                (`salpa`.`checkchap`.`plantime` <= NOW()))) * 100) AS `actual_vs_plan`
    FROM
        `salpa`.`checkchap`
    WHERE
        (`salpa`.`checkchap`.`deleted` = 0)
    GROUP BY `salpa`.`checkchap`.`study_id`