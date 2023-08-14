*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Go to session room - doctor
    [Tags]    video.session
    LoginDocKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Capture Page Screenshot    go-to-myappointments-{index}.png
    Wait Until Element Is Visible    xpath://a[contains(text(),'Confirmed')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Sleep    3
    Click Element    xpath://tr[1]//td[3]//a[1]
    Capture Page Screenshot    appoitnment-{index}.png
    Click Element    xpath://a[@class='btn btn-success']
    Capture Page Screenshot    go-to-videosession-{index}.png
    Wait Until Element Is Visible    id:refresh_part
    Capture Page Screenshot    online-{index}.png

Go to session room - patient
    [Tags]    video.session
    [Setup]    Open Testbrowser
    LoginKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Wait Until Element Is Visible    id:appointmentTable_wrapper
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Capture Page Screenshot    appoitnmenttable-wrapper-{index}.png
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Sleep    3
    Click Element    xpath://tr[1]//td[3]//a[1]
    Capture Page Screenshot    go-to-video-session-{index}.png
    Click Element    xpath://a[@class='btn btn-success']
    Sleep    3
    Wait Until Element Is Visible    id:refresh_part
    Capture Page Screenshot    online-{index}.png
    LogoutKW
    [Teardown]

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
