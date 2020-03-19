*** Settings ***
Documentation     Test login and logout with ${ADMIN}
...
...               Test register and activation witn ${ADMIN}
...
...               Test login and logout with ${manager_radnom_email} fail and success
...
...               Assert and verify login page, Add New User page , Edit User page (activation)
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
Admin create manager - success
    [Tags]    admin.manager.register
    LoginAdminKW
    Click Element    xpath://a[@class='btn btn-success']
    Admin Add New User page
    ${account_manager_random_name} =    Generate Random String    6    [UPPER]
    ${account_manager_random_name} =    Set Variable    ${account_manager_random_name}
    Set Suite Variable    ${account_manager_random_name}
    Input Text    id:inputFirstName    ${account_manager_random_name}
    Capture Page Screenshot    register-new-doctor-firstname-{index}.png
    ${account_manager_random_last_name} =    Generate Random String    7    [UPPER]
    ${account_manager_random_last_name} =    Set Variable    ${account_manager_random_last_name}
    Set Suite Variable    ${account_manager_random_last_name}
    Input Text    id:inputLastName    ${account_manager_random_last_name}
    Click Element    xpath://option[contains(text(),'Account Manager')]
    ${manager_random_email} =    Generate Random String    5    [NUMBERS]
    ${manager_random_email} =    Set Variable    admin-create-manager-email-${manager_random_email}${email}
    Set Suite Variable    ${manager_random_email}
    Input Text    name:email    ${manager_random_email}
    Input Password    id:inputPassword    ${MANAGERPW}
    Input Password    id:inputCPassword    ${MANAGERPW}
    Click Element    xpath://button[@class='btn btn-primary']
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    new-manager-added successfully-{index}.png

Admin manager activation
    [Tags]    admin.manager.register
    Click Element    xpath://a[contains(text(),'Admin')]
    Sleep    1
    Capture Page Screenshot    manager-page-admin-{index}.png
    Admin Activation Manager \ page
    Sleep    1
    Click Element    xpath://div[@id='m_user_profile_tab_9']//div[@class='m-radio-inline']//label[1]    #activate user
    Capture Page Screenshot    activate-manager-user-{index}.png
    Click Element    xpath://div[@id='m_user_profile_tab_9']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    Sleep    2
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    admin-doctor-activation-{index}.png
    LogoutKW

Manager login test - failure
    [Tags]    admin.manager.register
    Go To    ${TESTURL}
    Login page
    Click Element    name:email
    Input Text    name:email    ${manager_random_email}
    ${RANDOM} =    Generate Random String    8    [NUMBERS]
    Input Text    name:password    ${RANDOM}
    Submit Form
    Capture Page Screenshot    login-failure-{index}.png
    ${alert-success} =    Get Text    xpath://li[contains(text(),'These credentials do not match our records.')]
    Log To Console    ${alert-success}

Manager login test - success
    [Tags]    admin.manager.register
    Go To    ${TESTURL}
    Login page
    Clear Element Text    name:email
    Input Text    name:email    ${manager_random_email}
    Capture Page Screenshot    manager-email-{index}.png
    Clear Element Text    name:password
    Input Password    name:password    ${MANAGERPW}
    Capture Page Screenshot    manager-password-{index}.png
    Click Element    xpath://label[@for='checkbox1']
    Submit Form
    Capture Page Screenshot    after-login-success-{index}.png
    Log    Account manager has successfully login

Manager logout - success
    [Tags]    admin.manager.register
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    2
    Click Link    /logout
    Capture Page Screenshot    manager-logout-{index}.png
    Log    Account manager has successfully logged out

Manager access my appointment without login - failure
    [Documentation]    (check if the logout process works correctly)
    [Tags]    admin.manager.register
    [Setup]
    Go To    ${TESTURL}
    Login page
    Input Text    name:email    ${manager_random_email}
    Input Text    name:password    ${MANAGERPW}
    Submit Form
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    2
    Click Element    xpath://span[contains(text(),'All appointments')]
    Capture Page Screenshot    no-any-record-found-{index}.png
    Wait Until Element Is Visible    xpath://div[@class='alert alert-danger']
    LogoutKW
    Capture Page Screenshot    manager-after-logout-{index}.png
    [Teardown]    deactivate and delete manager

*** Keywords ***
