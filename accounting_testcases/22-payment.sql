# Testcase 2.2
# tear up
# Check draw up accounts
use testdb_doccons;
tee /tmp/mysql.2.out
select now() as 'start testcase 2.2 at'; 
select 'Check payed appointment, wallets and transactions' as 'Information'; 

# variables are set on status-check.sql
# you have to use the same mysql session 

# Get wallet information
select 'wallet' as '', amount, fk_uid, type from wallets where fk_uid in (1, @doc, @patA, @patB);

select '3 = completed, 5 = canceled, 2 = confirmed; 0 = awaiting payment' as 'status inforamtion';
select 'Canceled appointment: ', id, status from appointments where id = @app_patB_cancel; 

select 'Payment Transactions' as ''; 
# Check transactions for the pay appointment. should be four, with the same wallet_balance for doc and patients
select id,from_uid,to_uid,for_whom_payment,amount,amount_entry,payment_type,wallet_balance,fk_uid,appointment_id,status,cleared,accounting_id,document_id,approved_by from transactions where appointment_id in (@app_patB_translation, @app_patA);

# Status accounting reports
select 'Last accounting repots for @doc' as ''; 
select * from accountingreports where user_id = @doc order by created_at desc limit 1 \G; 

# Prepare appointment for draw up
# appointment status 3 = completed, status 5 = canceled, status 2 = confirmed; Status 0 = awaiting payment
# Set appointment (id = @appoint) to completed (status = 3) and changed date to past via database
select concat('Appointments ', @app_patB_translation, ' and ', @app_patA,  ' will be prepared for drawup with date: ', @date_before_drawup) as 'Information'; 
UPDATE appointments SET `status` = '3' WHERE id in (@app_patB_translation, @app_patA); 
UPDATE appointments SET `requested_date` = @date_before_drawup WHERE id in (@app_patB_translation, @app_patA); 

select 'Draw up account as admin and source 23-accounting.sql' as 'Next Step'
