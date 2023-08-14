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
    LoginKW
    Click Element    id:rq_btn3
    Sleep    1
    Click Element    id:rq_btn
    ${url} =    Get Location
    Log to console    ${url}
    Sleep    1
    Click Element    id:ajax_payment
    Sleep    1
    LogoutKW

Account manager go to appointment and fail to cancel
    LoginManagerKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'All appointments')]
    Click Element    xpath://span[contains(text(),'All appointments')]
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    ${url} =    Get Location
    Log to console    ${url}
    #Click Element    xpath://a[@class='btn btn-danger']
    Click Element    class:btn-danger
    Sleep    2
    Handle Alert
    ${alert-success} =    Get Text    class=alert-danger
    Log To Console    ${alert-success}
    Capture Page Screenshot    account-manage-can-not-cancel-this-appointment-{index}.png
    LogoutKW
