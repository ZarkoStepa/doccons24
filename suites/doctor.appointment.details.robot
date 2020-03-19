*** Settings ***
Documentation     Test login and logout with
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt
Library           BuiltIn
Library           String

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
doctor can invite guest to video
    [Tags]    doctor.appointment.details
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /appointments
    Capture Page Screenshot    appointment-sidebar-{index}.png
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Capture Page Screenshot    confirmed-appointment-{index}.png
    Click Element    xpath://tr[1]//td[2]//a[1]
    #Assert appointment details
    Capture Page Screenshot    preview-appointment-{index}.png
    Click Element    xpath://button[@class='btn btn-primary accordion']
    Capture Page Screenshot    preview-invitation-{index}.png
    Click Element    xpath://button[@class='send-modal btn btn-primary']
    Capture Page Screenshot    send-modal-invitation-{index}.png
    Sleep    1
    Wait Until Element Is Visible    xpath://div[@id='windowModalForSendingMail']//div[@class='modal-body']
    Element Should Be Visible    xpath://button[@class='close']
    Element Should Be Visible    xpath://div[@class='modal-header']
    Element Should Be Visible    id:id
    Element Should Be Disabled    id:id
    Wait Until Element Is Visible    xpath://label[contains(text(),'ID Room')]
    Wait Until Element Is Visible    xpath://div[@class='modal-footer']
    Wait Until Element Is Visible    xpath://label[contains(text(),'Enter email')]
    Element Text Should Be    xpath://label[contains(text(),'Enter email')]    Enter email
    Wait Until Element Is Visible    xpath://button[@class='btn btn-danger']
    Input Text    id:email    ${USEREMAIL}
    Capture Page Screenshot    wai input-email-{index}.png
    Click Element    xpath://span[@id='footer_action_button']
    Capture Page Screenshot    send-invitation-to-guest-{index}.png
    Sleep    8
    Wait Until Element Is Visible    xpath://div[@class='alert alert-info']
    ${alert-success} =    Get Text    xpath://div[@class='alert alert-info']
    Log To Console    ${alert-success}
    Element Text Should Be    xpath://div[@class='alert alert-info']    Email is successfully sent
    Capture Page Screenshot    successfull-invitation-sent-alert-{index}.png
    LogoutKW

doctor open payed appointment (preview) over my appointments
    [Tags]    doctor.appointment.details
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /appointments
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Capture Page Screenshot    confirmed-appointment-{index}.png
    Click Element    xpath://tr[1]//td[2]//a[1]
    #Assert appointment details
    LogoutKW

doctor can go to session room
    [Tags]    doctor.appointment.details
    [Setup]
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /appointments
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Click Element    xpath://tr[1]//td[2]//a[1]
    #Assert appointment details
    Element Should Contain    xpath://a[@class='btn btn-success']    Go to Session Room
    Click Element    xpath://a[@class='btn btn-success']
    Capture Page Screenshot    video-session-page-{index}.png
    Sleep    3
    Click Element    id:endCall
    Capture Page Screenshot    end-call-video-session-{index}.png
    Sleep    3
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
