# Testcase 2.3
# tear up
# Check accouting transactions
use testdb_doccons;
tee /tmp/mysql.2.out
select now() as 'start testcase 2.3 at'; 
select 'Check accounting transactions' as 'Information'; 

# Status accounting reports
select concat('Status accounting repots for doc: ', @doc) as ''; 
select accounting_no into @accno from accountingreports where user_id = @doc order by created_at desc limit 1; 
select * from accountingreports where accounting_no = @accno \G; 

select 'Accounting transactions' as ''; 
#select * from transactions where accounting_id = @accno;
select id,from_uid,to_uid,for_whom_payment,amount,amount_entry,payment_type,wallet_balance,fk_uid,appointment_id,status,cleared,accounting_id,document_id,approved_by from transactions where accounting_id = @accno;

select 'wallet' as '', amount, fk_uid, type from wallets where fk_uid in (1, @doc, @patA, @patB);
