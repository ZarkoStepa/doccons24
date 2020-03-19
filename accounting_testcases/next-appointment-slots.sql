SELECT * FROM dev1db_doccons.schedule_times;
# get the days and times for the doctor
select start_time, end_time, day_name, fk_uid from dev1db_doccons.schedule_times left join dev1db_doccons.schedule_days on schedule_days.id = schedule_times.fk_schedule_day where fk_uid = 2;
# count time entry for the doctor 
select count(day_name) as timeslots_in_week from dev1db_doccons.schedule_times left join dev1db_doccons.schedule_days on schedule_days.id = schedule_times.fk_schedule_day where fk_uid = 2;
# get the payed appointments of the doctor from date x; split timeframe to start_date, end_date; calculate dayname of date x
SELECT id, requested_date, dayname(requested_date) as day_name, substring_index(requested_time, ' - ', 1) as start_date, substring_index(requested_time, ' - ', -1) as end_date, fk_request_to, status FROM dev1db_doccons.appointments where fk_request_to = 2 and status = 2 and requested_date > '2019-06-13';

# how to calculate the next free timeslots in mysql with this information?