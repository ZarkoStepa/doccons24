*** Settings ***
Documentation     Test password on registration
Suite Setup       Open Testbrowser    # https://www.blazemeter.com/blog/robot-framework-the-ultimate-guide-to-running-your-tests
Suite Teardown    Close All Browsers
Test Setup
Library           SeleniumLibrary
Library           XvfbRobot
Library           String
Resource          _setup.txt    # documentation http://robotframework.org/Selenium2Library/Selenium2Library.html#Input%20Text    # keywords and parameters must be seperated by 2 spaces "    "
Resource          _keywords.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp
# @todo conditions, loops, etc: https://blog.codecentric.de/en/2013/05/robot-framework-tutorial-loops-conditional-execution-and-more/
# @todo generate testdata: http://seleniummaster.com/sitecontent/index.php/selenium-robot-framework-menu/selenium-robot-framework-python-menu/273-generate-test-data-in-robot-framework-example-four

*** Test Cases ***
Password too short: short8
    [Tags]    password
    GoTo    ${TESTURL}
    #Click Link    ${TESTURL}/lang/de
    Click Link    /register
    Input Text    name:first_name    short8
    Input Text    name:last_name    robot-delete
    ${RANDOM} =    Generate Random String    4    [NUMBERS]
    Input Text    name:email    short8-${RANDOM}-${email}
    Input Text    name:password    short8
    Input Text    name:password_confirmation    short8
    Select Checkbox    id:check_agreement
    # Button to register needs an id
    Submit Form
    Wait Until Page Contains    at least 8 characters.
    #Capture Page Screenshot    Screenshot-password-short-{index}.png
    # @todo fail-test user is already registered
    # @todo fail-test password = firstname
    #Logout dc24

Password no number: noNumber
    [Tags]    password
    ${RANDOM} =    Generate Random String    4    [NUMBERS]
    Input Text    name:first_name    noNumber
    Input Text    name:email    noNumber-${RANDOM}-${email}
    Input Text    name:password    noNumber
    Input Text    name:password_confirmation    noNumber
    Select Checkbox    id:check_agreement
    # Button to register needs an id
    Submit Form
    #Capture Page Screenshot    Screenshot-password-noNumber-{index}.png
    Wait Until Page Contains    password format is invalid

Password no capital: nocapital10
    [Tags]    password
    ${RANDOM} =    Generate Random String    4    [NUMBERS]
    Input Text    name:first_name    nocapital10
    Input Text    name:email    nocapital10-${RANDOM}-${email}
    Input Text    name:password    nocapital10
    Input Text    name:password_confirmation    nocapital10
    Select Checkbox    id:check_agreement
    # Button to register needs an id
    Submit Form
    #Capture Page Screenshot    Screenshot-password-nocapital10-{index}.png
    Wait Until Page Contains    password format is invalid

Password correct: Correct8
    [Tags]    password
    ${RANDOM} =    Generate Random String    4    [NUMBERS]
    Input Text    name:first_name    Correct8
    Input Text    name:email    Correct8-${RANDOM}-${email}
    Input Text    name:password    Correct8
    Input Text    name:password_confirmation    Correct8
    Select Checkbox    id:check_agreement
    # Button to register needs an id
    Submit Form
    #Capture Page Screenshot    Screenshot-password-Correct8-{index}.png
    Wait Until Page Contains    Correct8
    Logout dc24

*** Keywords ***
Open Testbrowser
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If    '${system}' == 'Linux'    Start Virtual Display    1920    1080
    Open Chrome Browser
    # Passwörter sollten mindestens 8 Zeichen lang sein, mindestens 1 Großbuchstabe und mindestens 1 Ziffer.

Open Chrome Browser
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}
