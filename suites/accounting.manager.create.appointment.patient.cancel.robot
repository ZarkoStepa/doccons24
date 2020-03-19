*** Settings ***
Documentation     In this testcase we test login form for patient an manager.
...               Accounting: manager create and pay appoitnement with succes 100 eur
...               if patient cancel an appointment, bookkeper take services fee 20%
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
    [Setup]    All wallets
    LoginManagerKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Book an appointment')]
    Sleep    1
    Click Element    id:rq_btn3
    Sleep    1
    Click Element    id:patient_account_manager
    Click Element    id:3
    #Click Element    xpath://span[@class='filter-option pull-left']    id:patient_account_manager
    #Click Element    xpath://span[contains(text(),'Peter Jürgen')]    id:3
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
    #${status-of-appointment} =    Get Text    xpath://span[@class='m-badge m-badge--brand m-badge--wide m-appointment-title-btn m-color-status-awaiting']
    #Log To Console    ${status-of-appointment} =
    #${balance} =    Get Text    xpath://a[@class='btn btn-default disabled']
    #Log To Console    ${balance} =
    #${bookins-status} =    Get Text    class:m-portlet__head-text
    #Log To Console    ${bookins-status} =
    Click Element    xpath://a[@id='ajax_payment']
    Sleep    2
    LogoutKW

Patient cancel appointment
    [Tags]    accounting
    [Setup]    All wallets
    LoginKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Capture Page Screenshot    go-to-my-appointment-{index}.png
    Click Element    xpath://table[1]/tbody[1]/tr[1]/td[2]/a[1]
    Capture Page Screenshot    in-an-appointment-{index}.png
    ${url} =    Get Location
    Log to console    ${url}
    #${status-of-appointment} =    Get Text    class:m-portlet__body
    #Log To Console    ${status-of-appointment} =
    #${status-of-appointment} =    Get Text    class:col-md-3
    #Log To Console    ${status-of-appointment} =
    Capture Page Screenshot    before-canceling-appointment-{index}.png
    Click Element    xpath://a[@class='btn btn-danger']
    Handle Alert
    ${alert-success} =    Get Text    class:alert-danger
    Log To Console    ${alert-success}
    Capture Page Screenshot    after-canceling-appointment-{index}.png
    Sleep    2
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Wallet')]
    Capture Page Screenshot    wallet-balance-{index}.png
    LogoutKW
    [Teardown]    All wallets
