# Testcase 2.1
# 
# The testcase series 2 will check: 
# - an correct appointment with between 1 doc and patient A
# - an correct appointment with between 1 doc and patient B
# - an canceled appointment with between 1 doc and patient B, without cancelation fees
#
# Acceptance criteria
# - the transactions and wallets are correct calculated
# - all appointment should be listed in the accounting pdf and in transactions
# - the canceled appointment should not create any transactions
# - the canceled appointment should not be listed in the accounting pdf
#
# tear up
# A: Book new appointment for @doc and @patA via dc24 portal 
# B: Book new appointment with translation for @doc and @patB via dc24 portal 
# B: Book new appointment for @doc and @patB via dc24 portal 
# B: Cancel new appointment for @doc and @patB via dc24 portal 

use testdb_doccons;
tee /tmp/mysql.2.out
select now() as 'start testcase 2.1 at' ;
select 'Check patient, doctor, wallets and booked appointment' as 'Information'; 

set @docemail = 'doc4711@nooda.de'; 
set @patemailA = 'pat4711@nooda.de';
set @patemailB = 'pat0815@nooda.de';
select date_add(curdate(), interval -1 day) into @date_before_drawup;

# Doc information, and set variable
select id into @doc from users where email = @docemail; 
select 'doctor' as '', users.id, email, rate from users inner join user_payment_details on users.id = fk_uid where users.id = @doc;

# Patient information, and set variable
select  id into @patA from users where email = @patemailA; 
select  id into @patB from users where email = @patemailB; 
select 'patient' as '', id, email from users where id in (@patA, @patB) ; 

# Get wallet information
select 'wallet' as '', amount, fk_uid, type from wallets where fk_uid in (1, @doc, @patA, @patB);

# Staus Appointment of @doc and @patA, @patB
# https://thoughtbot.com/blog/ordering-within-a-sql-group-by-clause

# each appointment in one variable
select id into @app_patB_translation from appointments where fk_request_to = 6 and status = 0 and translation_fee > 0 and fk_request_by = @patB;
select id into @app_patB_cancel from appointments where fk_request_to = 6 and status = 0 and fk_request_by = @patB and id not in (@app_patB_translation); 
select id into @app_patA from appointments where fk_request_to = 6 and status = 0 and fk_request_by = @patA and status = 0; 

select '3 = completed, 5 = canceled, 2 = confirmed; 0 = awaiting payment' as 'status inforamtion';
select @app_patB_translation, @app_patB_cancel, @app_patA; 


select 'appointment', id, fk_request_by as 'patient', status, requested_date, doctor_fee, translation_fee, service_share, service_fee, total, amount_paid, created_at, updated_at from appointments where fk_request_to = @doc and status = 0; # Get Payment facts of appointments

select concat('cancel appointment ', @app_patB_cancel) as 'Next Step';
select concat('Pay appointments ', @app_patB_translation, ',' , @app_patA, ' and source 22-payment.sql') as 'Next Step';

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

