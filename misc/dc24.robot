*** Settings ***
Documentation  Hello World for robotframwork with doccons24
Library  SeleniumLibrary
# documentation http://robotframework.org/Selenium2Library/Selenium2Library.html#Input%20Text
# keywords and parameters must be seperated by 2 spaces "  "

### https://stackoverflow.com/questions/28537290/how-to-set-path-chrome-driver-in-robot-framework
# Library  OperatingSystem
# Suite Setup  Setup chromedriver

*** Keywords ****
# Setup chromedriver
  # Set Environment Variable  webdriver.chrome.driver  /usr/local/bin/chromedriver

*** Test Cases ***
User shall login to dc24 portal
	[Documentation]  First test
	[Tags]  Smoke
	Open Browser  https://test.doccons24.de/login  ff
	#Open Browser  https://test.doccons24.de/login  headlesschrome
	#Open Browser  https://heise.de  headlesschrome
	Input Text  name:email  skauto@mailinator.com 
	Input Text  name:password  Shubham##99
	Submit Form 
	Wait Until Page Contains  Ärzte
	Capture Page Screenshot
	Close All Browsers
