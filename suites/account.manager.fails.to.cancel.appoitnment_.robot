*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           String
Library           XvfbRobot
Resource          _keywords.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Patient make appointment
    [Tags]    account.manager.cancel.appointment
    LoginKW
    Click Element    xpath://button[@id='rq_btn3']
    Sleep    1
    Click Element    xpath://button[@id='rq_btn']
    ${url} =    Get Location
    Log to console    ${url}
    Sleep    1
    Click Element    xpath://a[@id='ajax_payment']
    Sleep    1
    LogoutKW

Account manager go to appointment and fail to cancel
    [Tags]    account.manager.cancel.appointment
    LoginManagerKW
    Click Element    xpath://a[@id='m_aside_left_offcanvas_toggle']
    Click Element    xpath://span[contains(text(),'All appointments')]
    Sleep    1
    Click Element    xpath://tr[1]//td[2]//a[1]
    ${url} =    Get Location
    Log to console    ${url}
    Click Element    xpath://a[@class='btn btn-danger']
    Capture Page Screenshot    account-manage-can-not-cancel-this-appointment-{index}.png
    ${alert-success} =    Get Text    class=alert-danger
    Log To Console    ${alert-success}
    LogoutKW
