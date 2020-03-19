#!/usr/bin/env bash
# This file should be run from https://github.com/jerik/robot-framework-docker ./run_test.sh
# To register a new user
	# ex: ./run_test.sh register
	# ex: ./run_test.sh register:patient-firstname
	# ex: ./run_test.sh register-patient:patient-firstname
	# ex: ./run_test.sh register-doctor
	# ex: ./run_test.sh register-doctor:doctor-firstname
	# ex: ./run_test.sh register dev
	# ex: ./run_test.sh register test
# To run specific test cases on dev, dev is default environment
	# ex: ./run_test.sh dev --include tag
	# ex: ./run_test.sh --include tag
	# ex: ./run_test.sh --exclude tag
# To run specific test cases on test
	# ex: ./run_test.sh test --include tag
	# ex: ./run_test.sh test --exclude tag

# @todo register-patient, reg-doc, reg:doc
# @todo regsiter:patient=skauto, register:doctor=skauto1
# @todo use:patient=skauto, use:doc=skauto1

set -e

# FIXME seems not to work to clean the reports
# tidy up reports folder 
# if [ -d "reports" ]; then 
#	rm reports/*
#	echo tidied up reports folder
#fi

# ex: ./run_test.sh 
# @obsolet will never be run: CMD="robot --console verbose --exclude once --outputdir /reports /suites"

# get parameters from run_test.sh
params="$@"

# run init.sh with params
# bash $init_file $params

env="dev" # default environement is test
# @obsolet will never be run: params="--exclude once" # default params for robotframework is exclude test once ( new creation of user )
env_free_params=""
create_user=0 # 0 = false, 1 = patient; 2 = doctor; this is called when register parameter is used
user_file=scripts/user.conf
setup_file=suites/_setup.txt
once_check_params=""
new_user=""

function check_register(  ) { 
	first_param="$1"
	if [[ $first_param == "register" ]]; then 
		echo "new random patient will be created"	
		create_user=1
		shift
	elif [[ $first_param =~ "register-patient:" ]]; then 
		new_user=${first_param#*:}
		echo "new patient $new_user will be created"	
		create_user=1
		shift
	elif [[ $first_param =~ "register-doctor:" ]]; then 
		new_user=${first_param#*:}
		echo "new doctor $new_user will be created"	
		create_user=2
		shift
	elif [[ $first_param =~ "register-doctor" ]]; then 
		echo "new random doctor will be created"	
		create_user=2
		shift
	elif [[ $first_param =~ "register:" ]]; then 
		new_user=${first_param#*:}
		echo "new patient $new_user will be created"	
		create_user=1
		shift
	fi
	once_check_params="$@"

}
check_register "$@"

# params can be: 
#		dev --include foo
# 		test --exclude bar
# 		dev --include foo --exlude bar
#		... 
# the first parameter is the keyword for the test environement
function prepare_params(  ) { 
if [[ ! -z "$@" ]]; then 
	#echo params has value "$@"
	first_param="$1"
	if [[ $first_param =~ "--" ]]; then 
		echo "no environement detected: run tests with default environment: $env"
	else 
		if test $first_param == "test"; then 
		# check if the dev1 environemnt should be used
			env="test"
			echo "environement detected: run tests with environment: $env"
		elif test $first_param == "dev"; then 
			echo "environement detected: run tests with environment: $env"
		else 
		# wrong environment found, used default one
			echo "faulty environement detected: run tests with default environment: $env"
		fi
		shift
	fi
	env_free_params="$@"
else 
	echo "no environement detected: run tests with default environment: $env"
fi
} 
prepare_params $once_check_params

function get_user(  ) { 
if test -z "$new_user" ; then
	zufall=$( openssl rand -hex 4 )
	new_user=bot-${zufall}
fi
}
# @todo refactor files 
# robot_dc24 is the main folder where the test are run 
#	adapt to run_test.sh and test on windows

# ex: ./run_test.sh register
# this will run the testcases with the tag "register-patient" and "register-doctor"
# In this testcase I create a random new user with the login credetials of suites/newuser.txt
# the user is then activated and can be used by the other tests, where the testcases with tag "register-patient" and
# "register-doctor" are excluded
function prepare_new_user(  ) { 
	get_user
	#echo "create new user $new_user"
	echo '*** Variables ***' > $user_file
	echo "\${USER}    ${new_user}" >> $user_file
	# echo "\${EMAIL}    ${new_user}@mailinator.com" >> $user_file
	echo "\${EMAIL}    ${new_user}@nooda.de" >> $user_file
	echo "\${USERPW}    Calvin##99" >> $user_file

	cat $user_file
}

# Create new user if needed
if test $create_user -gt 0; then
	prepare_new_user
fi

function setup_default_user(  ) { 
	user_file_example=${user_file}.example
	if [ ! -f $user_file_example ]; then 
		echo "error: $user_file_example does not exists. Exit"
		exit
	fi
	cat $user_file_example $env_file > $setup_file
	echo "created default setup in $setup_file with"
	cat $setup_file

}

function create_setup_file(  ) { 
	env_file=scripts/env_${env}.conf
	if [ ! -f $env_file ]; then 
		echo "error: $env_file does not exists. Exit"
		exit
	elif [ ! -f $user_file ]; then 
		echo "warning: $user_file does not exists." 
		echo ">> Will setup default user (patient) to run test."
		setup_default_user
	else 
		cat $user_file $env_file > $setup_file
		#cat $user_file $env_file 
	fi
}

function do_setup(  ) { 
	if [ -f $setup_file ]; then 
		if test $create_user -gt 0; then 
			create_setup_file
		fi
		
		if test ! $( grep -c env:$env $setup_file ) == 1; then 
			create_setup_file
		fi
	else
		create_setup_file
	fi
	# cat $setup_file
}
do_setup


if test $create_user -gt 0; then 
	register_tag="register-patient" # default
	if test $create_user == 2; then 
		register_tag="register-doctor" # default
	fi
	
	CMD="robot --console verbose --include $register_tag --outputdir /reports /suites"
else
	# ex: ./run_test.sh --include capture
	# ex: ./run_test.sh --exclude capture
	CMD="robot --console verbose $env_free_params --outputdir /reports /suites"
fi

echo Script run with arguments :: "$env_free_params"
echo ${CMD}

``${CMD}``
