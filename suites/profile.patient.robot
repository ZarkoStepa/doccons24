*** Settings ***
Documentation     Test patient profile
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

*** Test Cases ***
Change first name
    [Tags]    profile-patient
    Login de
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /profile
    Wait Until Page Contains    Profil
    Input Text    name:first_name    Calvin
    ${phone_number} =    Generate Random String    7    [NUMBERS]
    Input Text    id:inputPhone    +49${phone_number}
    Capture Page Screenshot    Screenshot-profile-patient-{index}.png
    Submit Form
    #Capture Page Screenshot    Screenshot-profile-patient-{index}.png
    Wait Until Page Contains    Calvin

Rollback first name
    [Tags]    profile-patient
    Input Text    name:first_name    ${NEWUSER}
    Submit Form
    # Capture Page Screenshot    Screenshot-profile-patient-rollback-{index}.png
    Wait Until Page Contains    ${NEWUSER}
    Logout dc24

*** Keywords ***
