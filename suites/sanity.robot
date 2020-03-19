*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Resource          _keywords.txt
Resource          _mysetup.txt
Library           XvfbRobot

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
cancel appointments
    [Tags]
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Input Text    xpath://label[contains(text(),'Search:')]//input    02:30
    Click Element    xpath://tr[1]/td[2]/a[@class='btn btn-primary btn-sm m-appointment-title-btn']
    Click Element    xpath://a[@class='btn btn-danger']
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Input Text    xpath://label[contains(text(),'Search:')]//input    02:30
    Click Element    xpath://tr[1]/td[2]/a[@class='btn btn-primary btn-sm m-appointment-title-btn']
    Click Element    xpath://a[@class='btn btn-danger']
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Input Text    xpath://label[contains(text(),'Search:')]//input    02:30
    Click Element    xpath://tr[1]/td[2]/a[@class='btn btn-primary btn-sm m-appointment-title-btn']
    Click Element    xpath://a[@class='btn btn-danger']
