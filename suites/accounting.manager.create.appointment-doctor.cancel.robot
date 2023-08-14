*** Settings ***
Documentation     Test scenario: Login as manager, create appointment, pay appointment, logout.
...               Login as doctor, go to appointment, cancel appointment.
...               Accounting: manager wallet 100 - 100 appointment cost =0
...               doctor wallet 100
...               cancel appointment 100-100 = 0
...               patient wallet
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
Manager create appointment
    [Tags]    accounting
    [Setup]
    LoginManagerKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Element    xpath://span[contains(text(),'Book an appointment')]
    Sleep    1
    Click Element    id:rq_btn3
    Click Element    id:patient_account_manager
    Click Element    id:3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'${subject_3}')]
    Input Text    id:symptoms    Regarding operation'
    Input Text    id:patient_notes    Notes by patient
    Click Element    xpath://form[1]/div[1]/div[5]/div[3]/div[1]/label[1]/span[1]
    Sleep    1
    Click Element    id:rq_btn
    Sleep    1
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Sleep    1
    Click Element    xpath://button[@class='toast-close-button']
    Sleep    3
    Wait Until Element Is Visible    xpath://a[@id='ajax_payment']
    Click Element    xpath://a[@id='ajax_payment']
    Sleep    2
    LogoutKW

Doctor cancel appointment
    [Tags]    accounting
    [Setup]
    LoginDocKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Capture Page Screenshot    go-to-my-appointment-{index}.png
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Capture Page Screenshot    in-an-appointment-{index}.png
    ${url} =    Get Location
    Log to console    ${url}
    Capture Page Screenshot    before-canceling-appointment-{index}.png
    Click Element    xpath://a[@class='btn btn-danger']
    Handle Alert
    ${alert-success} =    Get Text    class:alert-danger
    Log To Console    ${alert-success}
    Capture Page Screenshot    after-canceling-appointment-{index}.png
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Wallet')]
    Click Element    xpath://span[contains(text(),'Wallet')]
    Capture Page Screenshot    wallet-balance-{index}.png
    LogoutKW
    [Teardown]

Manager cancel appointment
    [Tags]    accounting
    LoginManagerKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'All appointments')]
    Click Element    xpath://span[contains(text(),'All appointments')]
    Capture Page Screenshot    go-to-my-appointment-{index}.png
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Capture Page Screenshot    in-an-appointment-{index}.png
    ${url} =    Get Location
    Log to console    ${url}
    Sleep    1
    Capture Page Screenshot    cancel-appointment-{index}.png
    Click Element    xpath://a[@class='btn btn-danger']
    Handle Alert
    Capture Page Screenshot    allert-message-{index}.png
    Sleep    1
    LogoutKW
