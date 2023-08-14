*** Settings ***
Documentation     Hello World for robotframwork with doccons24
Library           SeleniumLibrary
Library           XvfbRobot    # documentation http://robotframework.org/Selenium2Library/Selenium2Library.html#Input%20Text    # keywords and parameters must be seperated by 2 spaces "    "

*** Variables ***
${TMP_PATH}       /tmp
## *** Test Cases ***
## User shall login to dc24 portal
## [Documentation]    First test
## [Tags]         Smoke
# headless is working now: https://stackoverflow.com/q/53017334/1933185
## Open Browser    https://admin:testserver@dev.doccons24.de/login    headlesschrome
# Get the german version
## Click Link     https://dev.doccons24.de/lang/de
# FIXME needs to set the window with wider, as the screenshots are small
## Input Text     name:email    skauto@mailinator.com
## Input Text     name:password    Shubham##99
## Submit Form
## Wait Until Page Contains    Ärzte
## Capture Page Screenshot
## Close All Browsers
# Works on https://medium.com/@ypasmk/robot-framework-with-docker-in-less-than-10-minutes-7b86df769c22

*** Test Cases ***

*** Keywords ***
Open Chrome Browser
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}
