delimiter //
drop trigger if exists medal_record_page//
CREATE TRIGGER medal_record_page
	AFTER update ON salpa.checkpage for each row
	begin
		if
			(select distinct user_id from salpa.award where medal_id=1 and user_id=(select distinct user_id from study where id=(select study_id from salpa.checkpage order by updatetime desc limit 1)))
			is null            
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),1,(select distinct user_id from study where id=(select study_id from salpa.checkpage order by updatetime desc limit 1)));
		END IF;
        if
			(select count(c.actualpage) from checkpage as c inner join study as s on c.study_id=s.id where s.user_id=(select distinct user_id from study where id=(select study_id from salpa.checkpage order by updatetime desc limit 1)))=10
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),2,(select distinct user_id from study where id=(select study_id from salpa.checkpage order by updatetime desc limit 1)));
        END IF;
        if
			(select count(c.actualpage) from checkpage as c inner join study as s on c.study_id=s.id where s.user_id=(select distinct user_id from study where id=(select study_id from salpa.checkpage order by updatetime desc limit 1)))=30
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),3,(select distinct user_id from study where id=(select study_id from salpa.checkpage order by updatetime desc limit 1)));
        END IF;
        if
			(select count(c.actualpage) from checkpage as c inner join study as s on c.study_id=s.id where s.user_id=(select distinct user_id from study where id=(select study_id from salpa.checkpage order by updatetime desc limit 1)))=77
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),4,(select distinct user_id from study where id=(select study_id from salpa.checkpage order by updatetime desc limit 1)));
        END IF;
	END//
delimiter //
drop trigger if exists medal_record_chap//
CREATE TRIGGER medal_record_chap
	AFTER update ON salpa.checkchap for each row
	begin
		if
			(select distinct user_id from salpa.award where medal_id=1 and user_id=(select distinct user_id from study where id=(select study_id from salpa.checkchap order by actualtime desc limit 1)))
			is null            
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),1,(select distinct user_id from study where id=(select study_id from salpa.checkchap order by actualtime desc limit 1)));
		END IF;
        if
			(select count(distinct c.actualtime) from checkchap as c inner join study as s on c.study_id=s.id where s.user_id=(select distinct user_id from study where id=(select study_id from salpa.checkchap order by actualtime desc limit 1)))=10
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),2,(select distinct user_id from study where id=(select study_id from salpa.checkchap order by actualtime desc limit 1)));
        END IF;
        if
			(select count(distinct c.actualtime) from checkchap as c inner join study as s on c.study_id=s.id where s.user_id=(select distinct user_id from study where id=(select study_id from salpa.checkchap order by actualtime desc limit 1)))=30
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),3,(select distinct user_id from study where id=(select study_id from salpa.checkchap order by actualtime desc limit 1)));
        END IF;
        if
			(select count(distinct c.actualtime) from checkchap as c inner join study as s on c.study_id=s.id where s.user_id=(select distinct user_id from study where id=(select study_id from salpa.checkchap order by actualtime desc limit 1)))=77
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),4,(select distinct user_id from study where id=(select study_id from salpa.checkchap order by actualtime desc limit 1)));
        END IF;
	END//

delimiter //
drop trigger if exists medal_finbooks_page//
CREATE TRIGGER medal_finbooks_page
	AFTER UPDATE ON salpa.checkpage FOR EACH ROW
	BEGIN
		IF 
			(select planpage from salpa.checkpage where salpa.checkpage.study_id=(select salpa.checkpage.study_id from salpa.checkpage order by salpa.checkpage.updatetime desc limit 1) order by salpa.checkpage.planpage desc  limit 1)               
			=
			(select actualpage from salpa.checkpage where salpa.checkpage.study_id=(select salpa.checkpage.study_id from salpa.checkpage order by salpa.checkpage.updatetime desc limit 1) order by salpa.checkpage.actualpage desc  limit 1)               
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),5,(select salpa.study.user_id from salpa.study where salpa.study.id=(select salpa.checkpage.study_id from salpa.checkpage order by salpa.checkpage.updatetime desc limit 1)));
		END IF;
        IF
			(select count(medal_id) from salpa.award where salpa.award.user_id=(select salpa.award.user_id from salpa.award order by salpa.award.awarddate desc limit 1) and medal_id=5)               
			=3    
        THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),6,(select a.user_id from salpa.award as a order by a.awarddate desc limit 1));
		END IF;
        IF
			(select count(medal_id) from salpa.award where salpa.award.user_id=(select salpa.award.user_id from salpa.award order by salpa.award.awarddate desc limit 1) and medal_id=5)               
			=5
        THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),7,(select a.user_id from salpa.award as a order by a.awarddate desc limit 1));
		END IF;
        IF
			(select count(medal_id) from salpa.award where salpa.award.user_id=(select salpa.award.user_id from salpa.award order by salpa.award.awarddate desc limit 1) and medal_id=5)               
			=10
        THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),8,(select a.user_id from salpa.award as a order by a.awarddate desc limit 1));
		END IF;
	END//
    
delimiter //
drop trigger if exists medal_finbooks_chap//
CREATE TRIGGER medal_finbooks_chap
	AFTER UPDATE ON salpa.checkchap FOR EACH ROW
	BEGIN
		IF 
			(select count(plantime) from salpa.checkchap where salpa.checkchap.study_id=(select salpa.checkchap.study_id from salpa.checkchap order by salpa.checkchap.actualtime desc limit 1))             
			=
			(select count(actualtime) from salpa.checkchap where salpa.checkchap.study_id=(select salpa.checkchap.study_id from salpa.checkchap order by salpa.checkchap.actualtime desc limit 1))               
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),5,(select salpa.study.user_id from salpa.study where salpa.study.id=(select salpa.checkpage.study_id from salpa.checkpage order by salpa.checkpage.updatetime desc limit 1)));
		END IF;
        IF
			(select count(medal_id) from salpa.award where salpa.award.user_id=(select salpa.award.user_id from salpa.award order by salpa.award.awarddate desc limit 1) and medal_id=5)               
			=3    
        THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),6,(select a.user_id from salpa.award as a order by a.awarddate desc limit 1));
		END IF;
        IF
			(select count(medal_id) from salpa.award where salpa.award.user_id=(select salpa.award.user_id from salpa.award order by salpa.award.awarddate desc limit 1) and medal_id=5)               
			=5
        THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),7,(select a.user_id from salpa.award as a order by a.awarddate desc limit 1));
		END IF;
        IF
			(select count(medal_id) from salpa.award where salpa.award.user_id=(select salpa.award.user_id from salpa.award order by salpa.award.awarddate desc limit 1) and medal_id=5)               
			=10
        THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),8,(select a.user_id from salpa.award as a order by a.awarddate desc limit 1));
		END IF;
	END//    

delimiter //
drop trigger if exists medal_club_content//
CREATE TRIGGER medal_club_content
	AFTER INSERT ON salpa.club for each row
	begin
		if
			(select distinct user_id from award where medal_id=9 and user_id=(select c.user_id from salpa.club as c where c.book_bid!=0 and deleted!=1 order by c.createtime desc limit 1))
			is null            
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),9,(select distinct c2.user_id from salpa.club as c2 where c2.user_id=(select c.user_id from salpa.club as c  where c.book_bid!=0 and deleted!=1 order by c.createtime desc limit 1)));
		END IF;
        if
			(SELECT count(*) FROM salpa.club where user_id=(select c.user_id from salpa.club as c where c.book_bid!=0 and deleted!=1 order by c.createtime desc limit 1))=20
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),10,(select distinct c2.user_id from salpa.club as c2 where c2.user_id=(select c.user_id from salpa.club as c  where c.book_bid!=0 and deleted!=1 order by c.createtime desc limit 1)));
		END IF;
	END//
    
    delimiter //
drop trigger if exists medal_club_like//
CREATE TRIGGER medal_club_like
	AFTER update ON salpa.club for each row
	begin
		if
			(select user_id from award where medal_id=11 and user_id =(select user_id from club order by updatetime desc limit 1)) is null
            and (select num from club where user_id=(select user_id from club order by updatetime desc limit 1) order by num desc limit 1)=10
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),11,(select distinct c2.user_id from salpa.club as c2 where c2.user_id=(select c.user_id from salpa.club as c  where c.book_bid!=0 and deleted!=1 order by c.updatetime desc limit 1)));
		END IF;
        if
			(select user_id from award where medal_id=12 and user_id =(select user_id from club order by updatetime desc limit 1)) is null
            and (select num from club where user_id=(select user_id from club order by updatetime desc limit 1) order by num desc limit 1)=30
		THEN
			insert into salpa.award (awarddate,medal_id,user_id) values (now(),12,(select distinct c2.user_id from salpa.club as c2 where c2.user_id=(select c.user_id from salpa.club as c  where c.book_bid!=0 and deleted!=1 order by c.updatetime desc limit 1)));
		END IF;
	END//
    