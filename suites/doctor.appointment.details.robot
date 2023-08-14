*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt
Library           String

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Doctor open payed appointment (preview) over my appointments
    [Tags]    doctor.appointment.details
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /appointments
    Doctor My Appointment page
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Capture Page Screenshot    confirmed-appointment-{index}.png
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Assert appointment details
    LogoutKW

The doctor can invite a guest to video
    [Tags]    doctor.appointment.details
    LoginDocKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /appointments
    Doctor My Appointment page
    Capture Page Screenshot    appointment-sidebar-{index}.png
    Wait Until Element Is Visible    xpath://a[contains(text(),'Confirmed')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Capture Page Screenshot    confirmed-appointment-{index}.png
    Sleep    3
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Assert appointment details
    Capture Page Screenshot    preview-appointment-{index}.png
    Click Element    class:accordion
    Capture Page Screenshot    preview-invitation-{index}.png
    Click Element    class:send-modal
    Invite guest to video modal
    Input Text    id:email    ${USEREMAIL}
    Capture Page Screenshot    wai input-email-{index}.png
    Click Element    xpath://span[@id='footer_action_button']
    Capture Page Screenshot    send-invitation-to-guest-{index}.png
    Wait Until Element Is Visible    id:msg_email_guest
    Element Should Be Visible    id:msg_email_guest
    ${invite_list} =    Get Text    class:alert-info
    Log To Console    ${invite_list}
    Wait Until Element Is Visible    xpath://div[@class='alert alert-info']
    ${alert-success} =    Get Text    xpath://div[@class='alert alert-info']
    Log To Console    ${alert-success}
    Should Contain    Email is successfully sent    Email is successfully sent
    Capture Page Screenshot    successfull-invitation-sent-alert-{index}.png
    LogoutKW

The doctor can go to session room
    [Tags]    doctor.appointment.details
    [Setup]
    LoginDocKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /appointments
    Wait Until Element Is Visible    xpath://a[contains(text(),'Confirmed')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Sleep    2
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Assert appointment details
    Element Should Contain    xpath://a[@class='btn btn-success']    Go to Session Room
    Click Element    xpath://a[@class='btn btn-success']
    Capture Page Screenshot    video-session-page-{index}.png
    Sleep    3
    Click Element    id:endCall
    Capture Page Screenshot    end-call-video-session-{index}.png
    Doctor My Appointment page
    LogoutKW

*** Keywords ***
Open Testbrowser
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If    '${system}' == 'Linux'    Start Virtual Display    1920    1080
    Open Chrome Browser

Open Chrome Browser
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}
