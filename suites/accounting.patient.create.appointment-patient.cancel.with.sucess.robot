*** Settings ***
Documentation     In this testcase we test login form for patient payment and cahs flow.
...               Accounting: patient create and pay appoitnement with succes 100
...               if patient cancel an appointment, bookkeper take services fee 20 return to patient 80
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
Patient create appointment
    [Tags]    accounting
    [Setup]    All wallets
    LoginKW
    Click Button    id:rq_btn3
    Capture Page Screenshot    before-input-appointment-{index}.png
    Click Element    id:reason
    Capture Page Screenshot    click-dropdown-list-{index}.png
    Click Element    xpath://option[contains(text(),'Follow up')]
    Capture Page Screenshot    select-reaseon-{index}.png
    Input Text    id:symptoms    Patient create and pay appointment
    Input Text    id:patient_notes    No translation fee
    Capture Page Screenshot    input-text-in-to-symptoms-and-notes-{index}.png
    Radio Button Should Be Set To    fk_appoint_type    2
    #Click Element    xpath://div[5]/div[3]/div[1]/label[1]/span[1]
    #Click Element    xpath://input[@id='No']
    Capture Page Screenshot    before-first-appointment-{index}.png
    Click Button    id:rq_btn
    ${url} =    Get Location
    Log to console    ${url}
    Capture Page Screenshot    appointment-{index}.png
    Sleep    3
    #Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    3
    Click Element    xpath://a[@id='ajax_payment']
    Capture Page Screenshot    pay-appointment-{index}.png
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
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    after-canceling-appointment-{index}.png
    Sleep    2
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Wallet')]
    Capture Page Screenshot    wallet-balance-{index}.png
    LogoutKW
    [Teardown]    All wallets
