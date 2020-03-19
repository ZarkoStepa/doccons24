@echo off
:: docker run --rm -e USERNAME="Foo Bar" --net=host -v //c/develop/mount/output:/output -v //c/develop/mount/suites:/suites -v //c/develop/mount/scripts:/scripts -v //c/develop/mount/reports:/reports --security-opt seccomp:unconfined --shm-size "256M" ypasmk/robot-framework

:: docker run --name testrf --rm -e USERNAME="Foo Bar" --net=host -v //c/develop/robot-framework-docker/output:/output -v //c/develop/robot-framework-docker/suites:/suites -v //c/develop/robot-framework-docker/scripts:/scripts -v //c/develop/robot-framework-docker/reports:/reports --security-opt seccomp:unconfined --shm-size "256M" rfwin

set name=testrf

docker run --name %name% --rm -dit -e USERNAME="Foo Bar" --net=host -v //c/develop/robot-framework-docker/output:/output -v //c/develop/robot-framework-docker/suites:/suites -v //c/develop/robot-framework-docker/scripts:/scripts -v //c/develop/robot-framework-docker/reports:/reports --security-opt seccomp:unconfined --shm-size "256M" rf-no-autorun

echo "connnect with: docker attach %name%"

