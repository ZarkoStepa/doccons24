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
Patient pay appointment
    [Tags]
    Setup appointment

Patient fail to cancel an appointment
    [Documentation]    You can not cancel appointment if it is in less than 24 hours
    [Tags]
    LoginKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Click Element    xpath://tr[1]//td[2]//a[1]
    Capture Page Screenshot    preview-appointment-{index}.png
    Sleep    4
    Click Element    xpath://a[@class='btn btn-danger']
    Sleep    1
    Handle Alert
    Sleep    1
    Capture Page Screenshot    fail-to-cancel-24hrs-{index}.png
    Sleep    1
    ${alert} =    Get Text    xpath://p[@class='alert alert-danger']
    Log To Console    ${alert}
    #Click Element    xpath://div[@class='toast-message']
    Sleep    3
    LogoutKW
