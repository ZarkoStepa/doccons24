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
user open payed appointment (preview) over my appointments
    [Tags]    patient.appointment.details
    LoginKW
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    Capture Page Screenshot    toast-message-{index}.png
    #Click Element    xpath://div[@class='toast-message']
    Sleep    1
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    xpath://a[contains(text(),'Confirmed')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Capture Page Screenshot    appointment-table-wrapper-{index}.png

user can go to session room
    [Tags]    patient.appointment.details
    [Setup]
    Element Should Be Visible    id:appointmentTable_wrapper
    Click Element    xpath://tr[1]//td[2]//a[1]
    #Assert appointment details
    Capture Page Screenshot    appointment-details{index}.png

user can close session room and is back on my appointments
    [Tags]    patient.appointment.details
    #Wait Until Element Is Visible    xpath://a[@class='btn btn-success']
    Capture Page Screenshot    goto-video-session-room-{index}.png
    Click Element    xpath://a[@class='btn btn-success']
    #Wait Until Element Is Visible    xpath://div[@class='media-box']//video
    Sleep    5
    Capture Page Screenshot    before-click-endcall-{index}.png
    Click Element    id:endCall
    Sleep    3

guest can access session room
    [Tags]    patient.appointment.details
    Element Should Be Visible    xpath://a[contains(text(),'Confirmed')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Click Element    xpath://tr[1]//td[2]//a[1]
    Assert appointment details
    Capture Page Screenshot    appointments-details-{index}.png
    Wait Until Element Is Visible    xpath://a[@class='btn btn-success']
    Click Element    xpath://a[@class='btn btn-success']
    #Wait Until Element Is Visible    xpath://div[@class='media-box']//video
    Capture Page Screenshot    video-session-room-{index}.png
    Sleep    3
    Click Element    id:endCall
    Sleep    3
    LogoutKW

*** Keywords ***
