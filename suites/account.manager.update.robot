*** Settings ***
Documentation     Test login and logouth with ${accountmanager}
...
...               Assert all pages which include steps in test cases.
...
...               Test update all pages which include steps in test cases.
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _keywords.txt
Resource          _mysetup.txt
Library           String

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Manager update personal info
    [Tags]    manager.update
    [Setup]
    LoginManagerKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /profile
    Personal Info page
    Clear Element Text    id:inputFirstName
    Input Text    id:inputFirstName    ${MANAGERNAME}
    Capture Page Screenshot    input-first-name-{index}.png
    Clear Element Text    id:inputLastName
    Input Text    id:inputLastName    ${MANAGERLASTNAME}
    Capture Page Screenshot    input-last-name-{index}.png
    Click Element    xpath://div[@class='m-radio-inline']/label[2]
    Capture Page Screenshot    click-gender-{index}.png
    Click Element    id:inputDOB
    Capture Page Screenshot    account-manager-personalinfo-DOB-{index}.png
    Click Element    xpath://tr[2]//td[3]
    Clear Element Text    id:inputPhone
    ${phone_number} =    Generate Random String    7    [NUMBERS]
    Input Text    id:inputPhone    +49${phone_number}
    Capture Page Screenshot    input-phone-{index}.png
    Clear Element Text    id:inputAltPhone
    ${phone_number} =    Generate Random String    7    [NUMBERS]
    Input Text    id:inputAltPhone    +49${phone_number}
    Capture Page Screenshot    input-alt-phone-{index}.png
    Click Element    xpath://button[@id='btnsave']
    Element Should Contain    xpath://div[@class='m-content']    Personal detail updated successfully.
    Capture Page Screenshot    personal-details-update-successfully-{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}

Manager update account info
    [Tags]    manager.update
    Wait Until Element Is Visible    xpath://a[contains(text(),'General')]
    Click Element    xpath://a[contains(text(),'General')]
    Click Element    xpath://a[@id='aco_deta']
    Account Info page
    Click Element    xpath://select[@name='role']
    Capture Page Screenshot    click-role-{index}.png
    Click Element    xpath://option[contains(text(),'Account Manager')]
    Element Should Be Disabled    xpath://input[@id='inputEmail']
    Clear Element Text    name:alt_email
    Element Should Be Enabled    name:fk_security_question
    Element Should Be Visible    xpath://option[contains(text(),'Please choose security question.')]
    Element Should Be Enabled    id:inputAnswer
    Click Element    xpath://div[@id='m_user_profile_tab_2']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    Capture Page Screenshot    after-click-save-changes-{index}.png
    Should Contain    Account detail updated successfully.    Account detail updated successfully.
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}

Manager update location info
    [Tags]    manager.update
    Wait Until Element Is Visible    xpath://a[contains(text(),'General')]
    Click Element    xpath://a[contains(text(),'General')]
    Click Element    xpath://a[contains(text(),'Location')]
    Location page
    Capture Page Screenshot    account-mannager-location-page-{index}.png
    Clear Element Text    id:inputAddress
    Input Text    id:inputAddress    ${ADRESS}
    Capture Page Screenshot    account-manager-address-{index}.png
    Click Element    id:inputCity
    Input Text    id:inputCity    ${CITY}
    Capture Page Screenshot    account-manager-city-{index}.png
    Click Element    id:inputProvince
    Input Text    id:inputProvince    ${PROVINCE}
    Capture Page Screenshot    account-manager-province-{index}.png
    Click Element    id:inputZip
    Input Text    id:inputZip    ${ZIP}
    Capture Page Screenshot    account-manager-zip-{index}.png
    Click Element    id:selectCountry
    Click Element    xpath://option[contains(@value,'RS')]
    Capture Page Screenshot    account-manager-country-{index}.png
    Click Button    xpath://div[@id='m_user_profile_tab_3']//button[@type='submit'][contains(text(),'Save changes')]
    Capture Page Screenshot    account-manager-location-updated-{index}.png
    Should Contain    Address detail updated successfully.    Address detail updated successfully.
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}

Manager update payment info
    [Tags]    manager.update
    Wait Until Element Is Visible    xpath://a[@id='paym_info']
    Click Element    id:paym_info
    Payment Info page
    Clear Element Text    id:inputAON
    Input Text    id:inputAON    skAuto2 Do
    Capture Page Screenshot    account-manager-inputAON-{index}.png
    Click Element    id:inputIBAN
    Input Text    id:inputIBAN    987654321
    Capture Page Screenshot    account-manager-IBAN-{index}.png
    Click Element    id:inputBIC
    Input Text    id:inputBIC    DABAIE2D
    Capture Page Screenshot    account-manager-inputBIC-{index}.png
    Click Element    id:inputRATE
    Input Text    id:inputRATE    ${INPUTRATE2}
    Capture Page Screenshot    account-manager-input-rate-{index}.png
    Click Element    xpath://div[@id='m_user_profile_tab_6']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    Capture Page Screenshot    account-manager-after-save-changes-payment-info-{index}.png
    Should Contain    Payment information updated successfully.    Payment information updated successfully.
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW

*** Keywords ***
