*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           String
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Login
    [Tags]    account.manager.transfer.money
    LoginManagerKW

Transfer money to patient
    [Tags]    account.manager.transfer.money
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Transfer money')]
    Capture Page Screenshot    click-transfer-money-{index}.png
    Wait Until Element Is Visible    class:m-subheader__title
    Element Should Be Visible    class:m-subheader__title
    Element Text Should Be    class:m-subheader__title    Transfer money to Patient
    Wait Until Element Is Visible    xpath://h5[contains(text(),'Key account balance:')]
    Element Should Be Visible    xpath://h5[contains(text(),'Key account balance:')]
    Element Text Should Be    xpath://h5[contains(text(),'Key account balance:')]    Key account balance:
    Wait Until Element Is Visible    class:col-6
    Element Should Be Visible    class:col-6
    ${balance} =    Get Text    class:col-form-label
    Log To Console    ${balance}
    ${balance} =    Get Text    class:col-6
    Log To Console    ${balance}
    Wait Until Element Is Visible    xpath://div[contains(text(),'Select Patient:')]
    Element Should Be Visible    xpath://div[contains(text(),'Select Patient:')]
    Element Text Should Be    xpath://div[contains(text(),'Select Patient:')]    Select Patient:
    Wait Until Element Is Visible    class:filter-option
    Element Should Be Visible    class:filter-option
    Wait Until Element Is Not Visible    class:bs-caret
    Element Should Not Be Visible    class:bs-caret
    Wait Until Element Is Not Visible    class:dropdown-menu
    Element Should Not Be Visible    class:dropdown-menu
    Click Element    xpath://span[@class='filter-option pull-left']
    Capture Page Screenshot    click-dropdown-list-{index}.png
    Wait Until Element Is Visible    xpath://li[@class='selected']//a
    Element Should Be Visible    xpath://li[@class='selected']//a
    Wait Until Element Is Visible    xpath://span[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]
    Element Should Be Visible    xpath://span[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]
    Click Element    xpath://span[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]
    Capture Page Screenshot    select-new-user-{index}.png
    Wait Until Element Is Visible    id:display_patient_balance
    Element Should Be Visible    id:display_patient_balance
    ${patient balance} =    Get Text    id:display_patient_balance
    Log To Console    ${patient balance}
    Element Text Should Be    xpath://h5[contains(text(),'${patient balance}')]    ${patient balance}
    Wait Until Element Is Visible    xpath://div[contains(text(),'Amount to Deposit to Patient:')]
    Element Should Be Visible    xpath://div[contains(text(),'Amount to Deposit to Patient:')]
    Element Text Should Be    xpath://div[contains(text(),'Amount to Deposit to Patient:')]    Amount to Deposit to Patient:
    Wait Until Element Is Visible    id:depositAmount
    Element Should Be Enabled    id:depositAmount
    Element Should Be Visible    id:depositAmount
    Input Text    id:depositAmount    ${AMOUNT}
    Capture Page Screenshot    input-amount-{index}.png
    Sleep    2
    Wait Until Element Is Visible    id:paymentButton
    Element Should Be Visible    id:paymentButton
    Click Element    id:paymentButton
    Capture Page Screenshot    click-pay-button-{index}.png
    Wait Until Element Is Visible    class:alert-info
    Capture Page Screenshot    capture-alert-message-{index}.png
    ${alert-info} =    Get Text    class:alert-info
    Log To Console    ${alert-info}
    LogoutKW

*** Keywords ***
