*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Library           String
Resource          _keywords.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Login
    [Tags]    admin.account.manager.doctor
    [Setup]    Setup account manager Doctor
    LoginAdminKW

Go to Doctor profile to add a manager
    [Tags]    admin.account.manager.doctor
    All Users page
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${DOCEMAIL}
    Sleep    2
    Capture Page Screenshot    search-doctor-{index}.png
    Click Element    xpath://a[@class='btn btn-success m-btn m-btn--icon m-btn--icon-only']
    Sleep    2
    Scroll Element Into View    xpath://label[contains(text(),'Phone*')]
    Click Element    xpath://a[@id='admi']
    Scroll Element Into View    xpath://div[@id='m_user_profile_tab_9']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    Capture Page Screenshot    click-on-admin-linktext-{index}.png
    Click Element    xpath://select[@id='account_manager']
    Capture Page Screenshot    click-to-open-dropdown-list-{index}.png
    Click Element    xpath://option[@id='5']
    Capture Page Screenshot    select-manager-from-dropdown-{index}.png
    Click Element    xpath://div[@id='m_user_profile_tab_9']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW

*** Keywords ***
