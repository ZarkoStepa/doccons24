# Testcase 1.1
# 
# The testcase series 1 will check: 
# - an appointment with transactions, payments and draw up between 1 doc and 1 patient
# - the appointment should be listed correct in the accounting pdf and transactions
#
# tear up
# Book new appointment for @doc and @pat via dc24 portal 

use testdb_doccons;
tee /tmp/mysql.1.out
select now() as 'start testcase 1.1 at' ;
select 'Check patient, doctor, wallets and booked appointment' as 'Information'; 

set @docemail = 'doc4711@nooda.de'; 
set @patemail = 'pat4711@nooda.de';
select date_add(curdate(), interval -1 day) into @date_before_drawup;

# Doc information, and set variable
select id into @doc from users where email = @docemail; 
select 'doctor' as '', users.id, email, rate from users inner join user_payment_details on users.id = fk_uid where users.id = @doc;

# Patient information, and set variable
select  id into @pat from users where email = @patemail; 
select 'patient' as '', id, email from users where id = @pat; 

# Get wallet information
select 'wallet' as '', amount, fk_uid, type from wallets where fk_uid in (1, @doc, @pat);

# Staus Appointment of @doc and @pat
# https://thoughtbot.com/blog/ordering-within-a-sql-group-by-clause

select '3 = completed, 5 = canceled, 2 = confirmed; 0 = awaiting payment' as 'status inforamtion';
select id into @appoint from appointments where fk_request_by = @pat and fk_request_to = @doc order by created_at desc limit 1 \G; # Get id of last appointment

select 'appointment', id, status, requested_date, doctor_fee, translation_fee, service_share, service_fee, total, amount_paid, created_at, updated_at from appointments where id = @appoint \G; # Get Payment facts of last appointment

select concat('Pay appointment ', @appoint, ' and source 12-payment.sql') as 'Next Step'

/*
## Save output into textfile 
# https://alvinalexander.com/mysql/how-save-output-mysql-query-file
# https://dev.mysql.com/doc/refman/8.0/en/mysql-batch-commands.html 
# https://stackoverflow.com/questions/6332994/write-results-of-sql-query-to-a-file-in-mysql

testcase.sql # contains the sql to execute
- querys should end with \G; for a better formatting
- to state information use: select 'This is my information i want to show' as '' \G; 

$ mysql -u user -p 
mysql> use database; # perhaps this can be already in testcase.sql 
mysql> tee /tmp/mysql.out
mysql> source testcase.sql 
mysql> quit
$ cat /tmp/mysql.out

*/

