delimiter //
drop trigger if exists medal_book1 //
CREATE TRIGGER medal_book1
	AFTER UPDATE ON salpa.checkpage FOR EACH ROW
	BEGIN
		IF 
			(select planpage from salpa.checkpage where salpa.checkpage.study_id=(select salpa.checkpage.study_id from salpa.checkpage order by salpa.checkpage.updatetime desc limit 1) order by salpa.checkpage.planpage desc  limit 1)               
			=
			(select actualpage from salpa.checkpage where salpa.checkpage.study_id=(select salpa.checkpage.study_id from salpa.checkpage order by salpa.checkpage.updatetime desc limit 1) order by salpa.checkpage.actualpage desc  limit 1)               
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (date_format(now(),'%Y-%m-%d'),4,(select salpa.study.user_id from salpa.study where salpa.study.id=(select salpa.checkpage.study_id from salpa.checkpage order by salpa.checkpage.updatetime desc limit 1)));
		END IF;
	END//