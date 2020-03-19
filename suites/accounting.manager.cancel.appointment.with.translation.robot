*** Settings ***
Documentation     Manager creates appointment with translation
...               Manager cancel appointment
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Resource          _keywords.txt
Resource          _mysetup.txt
Library           SeleniumLibrary
Library           String
Library           XvfbRobot

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Manager create appointment with translation
    [Tags]    accounting
    [Setup]    All wallets
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
    Input Text    id:patient_notes    Notes by manager as patient
    Capture Page Screenshot    input-symptoms-and-notes-{index}.png
    Click Element    xpath://form[1]/div[1]/div[5]/div[3]/div[1]/label[1]/span[1]
    Capture Page Screenshot    select-psyhical-apperiance-{index}.png
    Click Element    xpath://div[@class='col-8 col-form-label']//span
    Capture Page Screenshot    select-translation-arabic-{index}.png
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
    manager wallet

Manager cancel appointment
    [Tags]    accounting
    [Setup]    All wallets
    LoginManagerKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'All appointments')]
    Capture Page Screenshot    go-to-my-appointment-{index}.png
    Click Element    xpath://table[1]/tbody[1]/tr[1]/td[2]/a[1]
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
    [Teardown]    All wallets
