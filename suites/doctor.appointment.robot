*** Settings ***
Documentation     Test login and logout with ${DOCEMAIL}
...
...               Assert and verify login page , payed appointment page
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Doctor see payed appointment in my appointments
    [Tags]    doctor.appointment
    LoginDocKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Enabled    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /appointments
    Doctor My Appointment page
    Wait Until Element Is Visible    id:docAppoint_wrapper
    Capture Page Screenshot    docAppoint_wrapper-{index}.png
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Appointments page
    LogoutKW
