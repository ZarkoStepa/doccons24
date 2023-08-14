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
@{MANAGER}        Shubham##99    Shubham##88

*** Test Cases ***
Account manager login - failure
    [Tags]    account.manager.password
    Go To    ${TESTURL}
    Clear Element Text    name:email
    Input Text    name:email    ${MANEMAIL}
    Capture Page Screenshot    account-manager-email-{index}.png
    Clear Element Text    name:password
    Input Password    name:password    invalid
    Capture Page Screenshot    account-manager-invalid-password-{index}.png
    Click Element    xpath://label[@for='checkbox1']
    Submit Form
    Element Text Should Be    xpath://li[contains(text(),'These credentials do not match our records.')]    These credentials do not match our records.
    Capture Page Screenshot    account-manager-login-failure-{index}.png
    ${alert} =    Get Text    xpath://li[contains(text(),'These credentials do not match our records.')]
    Log To Console    ${alert}

Account manager login - success
    [Tags]    account.manager.password
    Go To    ${TESTURL}
    Clear Element Text    name:email
    Input Text    name:email    ${MANEMAIL}
    Capture Page Screenshot    account-manager-email-{index}.png
    Clear Element Text    name:password
    Input Password    name:password    @{MANAGER}[0]
    Capture Page Screenshot    account-manager-old-password-{index}.png
    Click Element    xpath://label[@for='checkbox1']
    Submit Form
    Log    Account manager has successfully login
    Should Contain    Doctors    Doctors
    LogoutKW
    Capture Page Screenshot    account-manager-login-success-{index}.png

Account manager change password - fail
    [Tags]    account.manager.password
    LoginManagerKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    after-click-profile-{index}.png
    Click Link    /profile
    Click Element    xpath://a[contains(text(),'Change password')]
    Capture Page Screenshot    account-manager-goto-change-password-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Current password')]    Current password
    Input Text    id:current    @{MANAGER}[0]
    Capture Page Screenshot    account-manager-current-password-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'New password')]    New password
    Element Text Should Be    xpath://label[contains(text(),'Confirm password')]    Confirm password
    Click Element    id:savePasswordBtn
    Should Contain    xpath://li[contains(text(),'Password field is required.')]    Password field is required.
    Wait Until Element Is Visible    xpath://li[contains(text(),'Password field is required.')]
    ${alert} =    Get Text    xpath://li[contains(text(),'Password field is required.')]
    Log To Console    ${alert}
    Capture Page Screenshot    account-manager-password-field-id-required-{index}.png
    Click Element    xpath://a[contains(text(),'Change password')]
    Capture Page Screenshot    after-click-change-password-{index}.png
    Input Text    id:current    @{MANAGER}[0]
    Capture Page Screenshot    after-input-current-password-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'New password')]    New password
    Input Text    id:new1    short
    Capture Page Screenshot    after-input-new-password-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Confirm password')]    Confirm password
    Input Text    id:new2    invalid
    Capture Page Screenshot    account-manager-confirm-new-password-{index}.png
    Click Element    id:savePasswordBtn
    Should Contain    xpath://li[contains(text(),'The password must be at least 8 characters.')]    The password must be at least 8 characters.
    ${least} =    Get Text    xpath://li[contains(text(),'The password must be at least 8 characters.')]
    Log To Console    ${least}
    Should Contain    xpath://li[contains(text(),'The password confirmation does not match.')]    The password confirmation does not match.
    ${not_match} =    Get Text    xpath://li[contains(text(),'The password confirmation does not match.')]
    Log To Console    ${not_match}
    Should Contain    xpath://li[contains(text(),'The password format is invalid.')]    The password format is invalid.
    ${invalid} =    Get Text    xpath://li[contains(text(),'The password format is invalid.')]
    Log To Console    ${invalid}
    Capture Page Screenshot    change-password-failure-{index}.png
    Click Element    id:chan_pass
    Input Text    id:new1    ${ADMINPW}
    Input Text    id:new2    ${ADMINPW}
    Click Element    id:savePasswordBtn
    #Click Button    xpath://div[@id='m_user_profile_tab_7']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    Capture Page Screenshot    current-password-field-is-required-{index}.png
    ${required_password} =    Get Text    xpath://li[contains(text(),'The current password field is required.')]
    Log To Console    ${required_password}
    LogoutKW

Account manager change password - success
    [Tags]    account.manager.password
    LoginManagerKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Profile')]
    Capture Page Screenshot    after-click-profile-{index}.png
    Click Element    xpath://a[contains(text(),'Change password')]
    Capture Page Screenshot    account-manager-goto-change-password-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Current password')]    Current password
    Input Text    id:current    @{MANAGER}[0]
    Capture Page Screenshot    account-manager-current-password-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'New password')]    New password
    Input Text    id:new1    @{MANAGER}[1]
    Capture Page Screenshot    account-manager-new-password-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Confirm password')]    Confirm password
    Input Text    id:new2    @{MANAGER}[1]
    Capture Page Screenshot    account-manager-confirm-new-password-{index}.png
    Click Element    id:savePasswordBtn
    Should Contain    Password changed successfully.    Password changed successfully.
    Capture Page Screenshot    account-manager-changed-password-success{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW

Account manager login with old password
    [Tags]    account.manager.password
    Go To    ${TESTURL}
    Clear Element Text    name:email
    Input Text    name:email    ${MANEMAIL}
    Capture Page Screenshot    account-manager-email-{index}.png
    Clear Element Text    name:password
    Input Password    name:password    @{MANAGER}[0]
    Capture Page Screenshot    account-manager-old-password-{index}.png
    Click Element    xpath://label[@for='checkbox1']
    Submit Form
    Element Text Should Be    xpath://li[contains(text(),'These credentials do not match our records.')]    These credentials do not match our records.
    ${alert-success} =    Get Text    xpath://li[contains(text(),'These credentials do not match our records.')]
    Log To Console    ${alert-success}
    Capture Page Screenshot    account-manager-old-pass-failure-{index}.png

Account manager login with the new password
    [Tags]    account.manager.password
    Go To    ${TESTURL}
    Clear Element Text    name:email
    Input Text    name:email    ${MANEMAIL}
    Capture Page Screenshot    account-manager-email-{index}.png
    Clear Element Text    name:password
    Input Password    name:password    @{MANAGER}[1]
    Capture Page Screenshot    account-manager-new-password-{index}.png
    Click Element    xpath://label[@for='checkbox1']
    Submit Form
    Capture Page Screenshot    account-manager-login-with-new-password-{index}.png
    Log    Account manager has successfully login
    LogoutKW
    [Teardown]    Setup Account Manager password

*** Keywords ***
