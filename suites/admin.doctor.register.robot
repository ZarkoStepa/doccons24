*** Settings ***
Documentation     Test login and logout with ${ADMIN}
...
...               Test register and activation witn ${ADMIN}
...
...               Test login and logout with ${doctor_radnom_email} fail and success
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
Admin create doctor - success
    [Tags]    doctor.register
    LoginAdminKW
    Click Element    xpath://a[@class='btn btn-success']
    Admin Add New User page
    Capture Page Screenshot    admin-add-new-doctor-{index}.png
    ${doctor_random_name} =    Generate Random String    6    [UPPER]
    ${doctor_random_name} =    Set Variable    ${doctor_random_name}
    Set Suite Variable    ${doctor_random_name}
    Input Text    id:inputFirstName    ${doctor_random_name}
    Capture Page Screenshot    register-new-doctor-firstname-{index}.png
    ${doctor_random_last_name} =    Generate Random String    7    [UPPER]
    ${doctor_random_last_name} =    Set Variable    ${doctor_random_last_name}
    Set Suite Variable    ${doctor_random_last_name}
    Input Text    id:inputLastName    ${doctor_random_last_name}
    Click Element    xpath://label[2]/span
    Click Element    xpath://option[contains(text(),'Doctor')]
    Capture Page Screenshot    admin-add-credentials-{index}.png
    ${doctor_random_email} =    Generate Random String    6    [NUMBERS]
    ${doctor_random_email} =    Set Variable    admin-create-doctor-email-${doctor_random_email}-${email}
    Set Suite Variable    ${doctor_random_email}
    Input Text    name:email    ${doctor_random_email}
    Input Password    id:inputPassword    ${DOCPW}
    Input Password    id:inputCPassword    ${DOCPW}
    Capture Page Screenshot    admin-input-password-{index}.png
    Click Element    xpath://button[@class='btn btn-primary']
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    new-user-added successfully-{index}.png

Admin doctor activation
    [Tags]    doctor.register
    Click Element    xpath://a[contains(text(),'Admin')]
    Sleep    1
    Capture Page Screenshot    user-page-admin-{index}.png
    Admin Activation Edit User page
    Scroll Element Into View    xpath://div[@id='m_user_profile_tab_9']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    Click Element    xpath://div[@id='m_user_profile_tab_9']//div[@class='m-radio-inline']//label[1]    #activate user
    Capture Page Screenshot    activate-user-{index}.png
    Click Element    xpath://div[@id='m_user_profile_tab_9']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    admin-doctor-activation-{index}.png
    Sleep    2
    LogoutKW

Doctor login test - failure
    [Tags]    doctor.register
    Go To    ${TESTURL}
    Login page
    Click Element    name:email
    Input Text    name:email    ${doctor_random_email}
    ${RANDOM} =    Generate Random String    8    [NUMBERS]
    Input Text    name:password    ${RANDOM}
    Click Element    name:password
    Submit Form
    Capture Page Screenshot    login-failure-{index}.png
    ${alert-success} =    Get Text    xpath://li[contains(text(),'These credentials do not match our records.')]
    Log To Console    ${alert-success}

Doctor login test - success
    [Tags]    doctor.register
    Go To    ${TESTURL}
    Login page
    Clear Element Text    name:email
    Input Text    name:email    ${doctor_random_email}
    Capture Page Screenshot    doctor-email-{index}.png
    Clear Element Text    name:password
    Input Password    name:password    ${DOCPW}
    Capture Page Screenshot    doctor-password-{index}.png
    Click Element    xpath://label[@for='checkbox1']
    Submit Form
    Capture Page Screenshot    after-login-success-{index}.png
    Log    Doctor has successfully login

Doctor logout - success
    [Tags]    doctor.register
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /logout
    Capture Page Screenshot    doctor-logout-{index}.png
    Log    Doctor has successfully logged out

Doctor access my appointment without login - failure
    [Documentation]    (check if the logout process works correctly)
    [Tags]    doctor.register
    Go To    ${TESTURL}
    Login page
    Input Text    name:email    ${doctor_random_email}
    Input Text    name:password    ${DOCPW}
    Submit Form
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Capture Page Screenshot    no-any-record-found-{index}.png
    LogoutKW
    Capture Page Screenshot    doctor-after-logout-{index}.png
    [Teardown]

Delete dooctor account
    LoginAdminKW
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${doctor_random_email}
    Sleep    1
    Capture Page Screenshot    search-doctor-{index}.png
    Click Element    xpath://table[1]/tbody[1]/tr[1]/td[3]/a[2]
    Sleep    1
    Capture Page Screenshot    edit-user-{index}.png
    Click Element    xpath://button[@class='btn btn-primary']
    Capture Page Screenshot    save-changes-{index}.png
    Sleep    1
    Click Element    xpath://a[@id='m_aside_left_offcanvas_toggle']
    Click Element    xpath://span[contains(text(),'Not confirmed')]
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${doctor_random_email}
    Sleep    1
    Capture Page Screenshot    search-doctor-{index}.png
    Click Element    xpath:/html[1]/body[1]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Capture Page Screenshot    deactivate-user-{index}.png
    Click Element    xpath://button[@id='proba']
    Capture Page Screenshot    delete-user-{index}.png
    Sleep    1
    LogoutKW

*** Keywords ***
