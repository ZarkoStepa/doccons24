# 2018-10-02 automatisierte testen mit http://robotframework.org auf OSX mit python 3.5
1. Robotframwork installiert, musste dazu pip3.5 fixen, wegen eines ssl fehlers
- pip fixen: curl https://bootstrap.pypa.io/get-pip.py | python3.5
- robotframework installieren: pip3.5 intsall robotframework
2. Youtube angeschaut um zu verstehen wie das robotframework funktioniert
- https://www.youtube.com/watch?v=T0SK5A1rwdk , ff
- https://www.youtube.com/watch?v=C_0PGpz5M90
3. Hello World geschrieben und mit pybot ausgefuehrt. PATH erweitert damit pybot gefunden werden kann
- PATH erweitert: export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.5/bin
4. selenium und libraries fuer robotframework installiert
- pip3.5 install --upgrade robotframework-selenium2library
5. Hello World getestet. Fehler, es fehlt noch WebDriverException: Message: 'geckodriver' executable needs to be in PATH.
6. Geckodriver installiert, um mit firefox zu testen
- brew install geckodriver
6a. Chromiumdriver installieren
- brew cask install chromedriver
7. Klappt;
- Optimierung chrome im headless mode nutzen
- robotframework and jenkins integration: https://www.youtube.com/watch?v=819sBbvT6gM
- robotframework and testlink integration: https://stackoverflow.com/questions/34148337/testlink-integration-with-robotframework

# 2018-10-27 Upgrade from Selenium2Library to Selenium2Library 3.0 ( aka SeleniumLibrary )
pip install --upgrade robotframework-selenium2library

I did not install the Selenium2Library 1.8.0, for legacy

## Mo 2018-11-26 1545:21 get the docker container for testing up and running on Windows

1. Edited the Dockerfile that /scripts/run_suites.sh is now executed when the docker container is started
2. Build the image: 	docker build --build-arg http_proxy=http://proxy.id.dvag.com:3128 --build-arg https_proxy=http://proxy.id.dvag.com:3128 -t rf-no-autorun ./
3. Run container: docker run --name foo --net=host --rm -dit rf-no-autorun
		the '-dit' part is essentieil, as it (d)etach the container, maket it (i)teractive and (t) allocate a pseudo TTY
3a. The container is listed under: docker ps -a 
4. Connect to the container with: docker attach foo
		then you are in shell on the container named foo (here the started rf-no-autorun container)
5. Do you stuff on the shell; Wehn you exit, the container will be destroyed and removed (as you run it with the flag --rm)

:: now we try to mount folders from the host system --> works!

3. Run container with scripts folder: docker run --name foo --net=host --rm -dit -v c:/develop/robot-framework-docker/scripts:/scripts rf-no-autorun
4. Run container with all folders: docker run --name foo --net=host --rm -dit -v c:/develop/robot-framework-docker/scripts:/scripts -v c:/develop/robot-framework-docker/output:/output -v c:/develop/robot-framework-docker/reports:/reports -v c:/develop/robot-framework-docker/suites:/suites rf-no-autorun

:: Now it works with the original as well 
The problem was that the /scripts/run_suites.sh had a dos Carrage Return which lead to missinterpretation: 
	/usr/bin/env bash\r was not found
With vim.tiny I converted that file through: set ff=unix; :x
When I run then the container it works like charm

3. Run continer: docker run --name testrf --rm -e USERNAME="Foo Bar" --net=host -v //c/develop/robot-framework-docker/output:/output -v //c/develop/robot-framework-docker/suites:/suites -v //c/develop/robot-framework-docker/scripts:/scripts -v //c/develop/robot-framework-docker/reports:/reports --security-opt seccomp:unconfined --shm-size "256M" ypasmk/robot-framework

:: 2019-01-03 Ops, if the windows user password was changed, you have to disable/enable the shared drive c:\ on the docker settings
