*** Settings ***
Documentation     Test login and language with ${USER}${email}
Suite Setup       Open Testbrowser    # https://www.blazemeter.com/blog/robot-framework-the-ultimate-guide-to-running-your-tests
Suite Teardown    Close All Browsers
Test Setup
Library           SeleniumLibrary
Library           XvfbRobot
Library           String
Resource          _keywords.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Choose german
    [Tags]    language    login
    GoTo    ${TESTURL}
    Click Link    ${TESTURL}/lang/de
    Wait Until Page Contains    Melden Sie sich

Password wrong: short4 de
    [Tags]    password    login
    GoTo    ${TESTURL}
    Click Link    ${TESTURL}/lang/de
    ${RANDOM} =    Generate Random String    6    [NUMBERS]
    Input Text    name:email    ${USEREMAIL}
    Input Text    name:password    ${RANDOM}
    Submit Form
    Wait Until Page Contains    stimmen nicht mit

Choose english
    [Tags]    language    login
    GoTo    ${TESTURL}
    Click Link    ${TESTURL}/lang/en
    Wait Until Page Contains    Sign in to

Password wrong: short4 en
    [Tags]    password    login
    GoTo    ${TESTURL}
    Click Link    ${TESTURL}/lang/en
    ${RANDOM} =    Generate Random String    6    [NUMBERS]
    Input Text    name:email    ${USEREMAIL}
    Input Text    name:password    ${RANDOM}
    Capture Page Screenshot    Screenshot-password-noNumber-{index}.png
    Submit Form
    Capture Page Screenshot    do-not-match-{index}.png
    Wait Until Page Contains    do not match

Choose arabic
    [Tags]    language    login
    GoTo    ${TESTURL}
    Click Link    ${TESTURL}/lang/ar
    Wait Until Page Contains    إلى حساب

Password wrong: short4 ar
    [Tags]    password    login
    GoTo    ${TESTURL}
    Click Link    ${TESTURL}/lang/ar
    ${RANDOM} =    Generate Random String    6    [NUMBERS]
    Input Text    name:email    ${USEREMAIL}
    Input Text    name:password    ${RANDOM}
    Capture Page Screenshot    Screenshot-password-noNumber-{index}.png
    Submit Form
    Wait Until Page Contains    مع سجلاتنا

Password correct
    [Tags]    password    login
    Login de
    Wait Until Page Contains    Meine Termine
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Ausloggen')]

*** Keywords ***
Open Testbrowser
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If    '${system}' == 'Linux'    Start Virtual Display    1920    1080
    Open Chrome Browser
    # Passwörter sollten mindestens 8 Zeichen lang sein, mindestens 1 Großbuchstabe und mindestens 1 Ziffer.
