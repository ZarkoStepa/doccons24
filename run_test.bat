@echo off
:: docker run --rm -e USERNAME="Foo Bar" --net=host -v //c/develop/mount/output:/output -v //c/develop/mount/suites:/suites -v //c/develop/mount/scripts:/scripts -v //c/develop/mount/reports:/reports --security-opt seccomp:unconfined --shm-size "256M" ypasmk/robot-framework

:: docker run --name testrf --rm -e USERNAME="Foo Bar" --net=host -v //c/develop/robot-framework-docker/output:/output -v //c/develop/robot-framework-docker/suites:/suites -v //c/develop/robot-framework-docker/scripts:/scripts -v //c/develop/robot-framework-docker/reports:/reports --security-opt seccomp:unconfined --shm-size "256M" rfwin

:: docker run --name testrf --rm -e USERNAME="Foo Bar" --net=host -v //c/develop/robot-framework-docker/output:/output -v //c/develop/robot-framework-docker/suites:/suites -v //c/develop/robot-framework-docker/scripts:/scripts -v //c/develop/robot-framework-docker/reports:/reports --security-opt seccomp:unconfined --shm-size "256M" ypasmk/robot-framework

docker run --name robot --rm -e USERNAME="Foo Bar" --net=host -v //c/develop/robot_dc24/output:/output -v //c/develop/robot_dc24/suites:/suites -v //c/develop/robot_dc24/scripts:/scripts -v //c/develop/robot_dc24/reports:/reports --security-opt seccomp:unconfined --shm-size "256M" jerik/robot-framework %*
