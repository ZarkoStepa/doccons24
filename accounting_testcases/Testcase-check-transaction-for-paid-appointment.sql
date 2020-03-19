# tear up
use testdb_doccons;
# tee /tmp/msyql.tee.out

# Doc information
select * from users where email = 'doc0815@nooda.de'; # skauto1@mailinator.com = Doc
set @doc = 33; # doctor id
select first_name, last_name from user_details where fk_uid = @doc; # Name of Doctor: Doktor Doktorovic
select * from wallets where fk_uid = @doc; # Wallet Amount: 0
select * from user_payment_details where fk_uid = @doc; # Rate of doc: 100

# Patient information
select * from users where email = 'pat0815@nooda.de';
set @pat = 32; 
select first_name, last_name from user_details where fk_uid = @pat; # Name of Patient: Pacijent Bolesnikov
select * from wallets where fk_uid = @pat; # Wallet Amount: 2088.00

# Staus Appointment of Doc:2 and Patient:3
select * from appointments where fk_request_by = @pat and fk_request_to = @doc order by created_at desc limit 1; # Get last appointment of Patient:3 + Doc:2
# https://thoughtbot.com/blog/ordering-within-a-sql-group-by-clause
select id, status, requested_date, doctor_fee, translation_fee, service_share, service_fee, total, amount_paid, created_at, updated_at from appointments where fk_request_by = @pat and fk_request_to = @doc order by created_at desc limit 1; # Get Payment facts of last appointment

# Book new appointment for Doc:2 and Patient:3 via dc24 portal 
select id, requested_date, doctor_fee, translation_fee, service_share, service_fee, total, amount_paid, created_at, updated_at from appointments where fk_request_by = @pat and fk_request_to = @doc order by created_at desc limit 1; # Get Payment facts of last appointment
# Pay appointment (id = 19) over portal 
select * from wallets where fk_uid = @pat; # Check patient wallet amount, should be reduce by appointment.total = 1988.00
select * from wallets where fk_uid = @doc; # Check doctor wallet amount, should be increased by appointment.total = 100
set @appoint = 19; 
select * from transactions where appointment_id = @appoint; # Check transactions for the pay appointment. should be two, with the same wallet_balance for doc and patient

# Status accounting reports
select * from accountingreports where user_id = @doc order by created_at desc limit 1; # Last id = 1

# Prepare appointment for draw up
# appointment status 3 = completed, status 5 = canceled, status 2 = confirmed; Status 0 = awaiting payment
# Set appointment (id = 19) to completed (status = 3) and changed date to past via database
UPDATE appointments SET `status` = '3' WHERE (`id` = @appoint );
UPDATE `testdb_doccons`.`appointments` SET `requested_date` = '2019-05-08' WHERE (`id` = @appoint);

# draw up accounting in dc24 portal 
select * from accountingreports where user_id = @doc order by created_at desc limit 1; # Last id = 2
select * from transactions where accounting_id = 'D20190905-2-1482851161';

## Wired result, I think because of testdata. I have to create 2 fresh and clean users and do the test with this

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
