 # http://www.mysqltutorial.org/stored-procedures-loop.aspx
 # https://medium.com/@smayzes/stored-procedures-in-laravel-60e7cb255fc9
 DELIMITER $$
 DROP PROCEDURE IF EXISTS next_appointment$$
 CREATE PROCEDURE next_appointment(in doctor_id int, earliest_date date)
 BEGIN
 DECLARE x  INT;
 DECLARE str  VARCHAR(255);
 
 SET x = 1;
 SET str =  '';
 
 WHILE x  <= doctor_id DO
 SET  str = CONCAT(str,x,',', earliest_date);
 SET  x = x + 1; 
 END WHILE;
 
 SELECT str;
 END$$
DELIMITER ;

call next_appointment(2, '2019-06-14')