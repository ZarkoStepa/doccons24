*** Settings ***
Documentation     Test login and logout with ${USEREMAIL}
...
...               Show location for all 3 appointements.
...
...               Assert and verify login, logout page, appointment page, video session page
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
User open paid appointment (preview) over my appointments
    [Tags]    patient.appointment.details
    LoginKW
    Capture Page Screenshot    toast-message-{index}.png
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Wait Until Element Is Visible    xpath://a[contains(text(),'Confirmed')]
    Element Should Be Visible    xpath://a[contains(text(),'Confirmed')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Capture Page Screenshot    appointment-table-wrapper-{index}.png

User can go to the session room
    [Tags]    patient.appointment.details
    [Setup]
    Element Should Be Visible    id:appointmentTable_wrapper
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Assert Appointment with translation details
    Capture Page Screenshot    appointment-details{index}.png

User can close session room and is back on my appointments
    [Tags]    patient.appointment.details
    Capture Page Screenshot    goto-video-session-room-{index}.png
    Click Element    xpath://a[@class='btn btn-success']
    #remove sleep
    Sleep    2
    Capture Page Screenshot    before-click-endcall-{index}.png
    Wait Until Element Is Visible    id:endCall
    Click Element    id:endCall
    Wait Until Element Is Not Visible    class:media-box

Guest can access session room
    [Tags]    patient.appointment.details
    Sleep    3
    Wait Until Element Is Visible    id:2
    #Element Should Be Visible    xpath://a[contains(text(),'Confirmed')]
    Click Element    id:2
    Element Should Be Visible    id:appointmentTable_wrapper
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Assert Appointment with translation details
    Capture Page Screenshot    appointments-details-{index}.png
    Wait Until Element Is Visible    xpath://a[@class='btn btn-success']
    Click Element    xpath://a[@class='btn btn-success']
    Capture Page Screenshot    video-session-room-{index}.png
    #remove sleep
    Sleep    2
    Click Element    id:endCall
    Wait Until Element Is Not Visible    class:media-box
    LogoutKW

*** Keywords ***
