# Readme

## Getting started

### 1. Install docker 
Install [docker]( https://www.docker.com/ ) 

### 2. Get the docker image
Get the docker image from https://hub.docker.com/r/jerik/robot-framework or 

Build the docker image the [Dockerfile]( Dockerfile ). Important the docker images
has to be named ``jerik/robot-framework`` that it works out of the box with the ``run_test.sh`` script.

### 3. Run the test suite
Run the test suite bei executing the ``run_test.sh``script. This should run all test from the _suite_ folder. 

## Good to know

- Dockerfile: Build the dockerfile needed for to run the test suites
- reports: Folder where the Images and Results of a testrun is stored. Especially the reports/report.html after a
  testrun is interessting
- scripts: Folder where the scripts are store. The ``run_test.sh`` executes the ``scripts/run_suite.sh`` which will
  run the test cases under ``suites``. You can add the parameters to include und exclude test by tags with the
  ``run_test.sh``. E.g. ``run_test.sh --inlcude foo --exclude bar`` this includes all testcases with the tag foo and
  excludes all testcases with the tag bar in the run. For a better understanding read the source of
  ``scripts/run_suite.sh``
- suites: Folder where all testcases are stored

For more information see https://medium.com/@ypasmk/robot-framework-with-docker-in-less-than-10-minutes-7b86df769c22

