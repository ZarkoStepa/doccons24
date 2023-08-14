*** Settings ***
Documentation     When manager create appointmetn and pay 100, if cancels his appooitment return 80 on his wallet and services fee is 20.
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
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Book an appointment')]
    Sleep    1
    Capture Page Screenshot    book-appointment-{index}.png
    Click Element    id:rq_btn3
    Capture Page Screenshot    go-to-book-{index}.png
    Click Element    id:patient_account_manager
    Capture Page Screenshot    open-dropdown-to-select-patient-{index}.png
    Click Element    id:3
    Capture Page Screenshot    select-patient-{index}.png
    Click Element    id:reason
    Capture Page Screenshot    open-dropdown-to-select-reason-{index}.png
    Click Element    xpath://option[contains(text(),'${subject_3}')]
    Capture Page Screenshot    select-reason-{index}.png
    Input Text    id:symptoms    Regarding operation'
    Input Text    id:patient_notes    Notes by patient
    Capture Page Screenshot    input-symptoms-and-notes-{index}.png
    Wait Until Element Is Visible    xpath://form[1]/div[1]/div[5]/div[3]/div[1]/label[1]/span[1]
    Click Element    xpath://form[1]/div[1]/div[5]/div[3]/div[1]/label[1]/span[1]
    Capture Page Screenshot    select-psyhical-apperiance-{index}.png
    Sleep    1
    Capture Page Screenshot    click-button-book-appointment-{index}.png
    Click Element    id:rq_btn
    Sleep    1
    Capture Page Screenshot    alert-success-{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Sleep    1
    Capture Page Screenshot    close-toast-message-{index}.png
    Click Element    xpath://button[@class='toast-close-button']
    Sleep    3
    Capture Page Screenshot    pay-appointment-{index}.png
    Click Element    xpath://a[@id='ajax_payment']
    Capture Page Screenshot    paid-appointment-{index}.png
    Sleep    2
    LogoutKW
    Manager Wallet
    [Teardown]

Manager cancel appointment
    [Tags]    accounting
    LoginManagerKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'All appointments')]
    Capture Page Screenshot    go-to-my-appointment-{index}.png
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Capture Page Screenshot    in-an-appointment-{index}.png
    ${url} =    Get Location
    Log to console    ${url}
    Sleep    1
    Click Element    xpath://a[@class='btn btn-danger']
    Handle Alert
    #to do - alert message missing
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Sleep    1
    LogoutKW
    [Teardown]
