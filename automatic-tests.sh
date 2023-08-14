#!/bin/bash

# run the automated test suites and move the repoorts to an web accessable place

logfile=/home/dev/sites/testlink/logs/doccons24-testlink.log
exe_dir=/home/dev/sites/testlink/current/
# development configuration 
#exe_dir=/home/dev/autotest/robot_dc24/
list_of_testcases="login login.page register.page password profile-patient manager.update patient.update doctor.update stripe doctor.register patient.register all.logs admin.manager.register patient.navigate.links doctor.navigate.all.links admin.navigate.all.links manager.navigate.all.links patient.password doctor.password account.manager.password video.session patient.appointment doctor.appointment doctor.appointment.details patient.appointment2 patient.appointment.details doctor.appointment2 doctor.create.recommendation doctor.create.prescription withdrawal.requests admin.create.clinic create.clinic doctor.choose.clinic admin.add.speciality admin.add.certification admin.add.department translation.fee admin.create.appointments admin.delete.inactive.account account.reports admin.account.manager.patient admin.account.manager.doctor accounting account.manager.transfer.money account.manager.make.appointment draw.up ngrok deposit.money account.manager.deposit.amount"
      # deposit.money
      # account.manager.deposit.amount
      # stripe
     
environment=test # default.settings
# FIXME the test suites does not support a swith right now
if test "$1" == "dev"; then 
	environment=dev
fi

function log() {
	echo $(date "+[%Y-%m-%d %H:%M:%S]") $@ >> $logfile
}
log INFO: Starting $0 on ${exe_dir}

cd ${exe_dir}
function run_testcase() {
	testcase=$1
	log INFO: Starting on environment: $environment with testcase: $testcase 
	./run_tests.sh $environment --include $testcase --timestampoutputs
	
}

function is_failed() {
	matches=$(/bin/grep fail= ${exe_dir}/reports/*.xml | /usr/bin/cut -d " " -f2)
	failed=0
	for i in $matches; do 
		eval $i
		if test $fail -gt 0; then 
			failed=1
			break; 
		fi
	done
	if test $failed == 1; then 
		log WARN: Testcase $1 failed on environment: $environment.
	fi
}

export_dir=/home/dev/sites/reports/current
function move_reports() {
	folder=reports
	if test $failed == 1; then 
		folder=failed; 
	fi
	# tag with environment
	folder=${environment}-${folder}
	# do I need to do: $failed=0 here?
	report_dir=$(date +%Y%m%d-%H%M%S_%N)-${folder}
	log INFO: Move test reports to ${report_dir}
	/bin/cp -pr ${exe_dir}/reports ${export_dir}/${report_dir}
	/bin/rm -rf ${exe_dir}/reports/*
}

for testcase in $list_of_testcases; do 
	run_testcase $testcase
	is_failed $testcase
	move_reports
done
log INFO: Finished $0
