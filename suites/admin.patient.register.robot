*** Settings ***
Documentation     Test login and logout with ${ADMIN}
...
...               Test register and activation witn ${ADMIN}
...
...               Test login and logout with ${patient_radnom_email} fail and success
...
...               Assert and verify register page, login page
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
Admin create patient - success
    [Tags]    patient.register
    LoginAdminKW
    Click Element    xpath://a[@class='btn btn-success']
    Admin Add New User page
    ${patient_random_name} =    Generate Random String    6    [UPPER]
    ${patient_random_name} =    Set Variable    ${patient_random_name}
    Set Suite Variable    ${patient_random_name}
    Input Text    id:inputFirstName    ${patient_random_name}
    Capture Page Screenshot    register-new-patient-firstname-{index}.png
    ${patient_random_last_name} =    Generate Random String    7    [UPPER]
    ${patient_random_last_name} =    Set Variable    ${patient_random_last_name}
    Set Suite Variable    ${patient_random_last_name}
    Input Text    id:inputLastName    ${patient_random_last_name}
    Capture Page Screenshot    register-new-patient-lastname-{index}.png
    Click Element    xpath://label[2]/span
    Click Element    xpath://option[contains(text(),'Patient')]
    ${patient_random_email} =    Generate Random String    8    [NUMBERS]
    ${patient_random_email} =    Set Variable    admin-create-patient-email-${patient_random_email}${email}
    Set Suite Variable    ${patient_random_email}
    Input Text    name:email    ${patient_random_email}
    Input Password    id:inputPassword    ${USERPW}
    Input Password    id:inputCPassword    ${USERPW}
    Click Element    xpath://button[@class='btn btn-primary']
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    new-user-added successfully-{index}.png

Admin patient activation
    [Tags]    patient.register
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Not confirmed')]
    Sleep    2
    Not Confirmed page
    Wait Until Element Is Visible    xpath://label[contains(text(),'Search:')]//input
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${patient_random_email}
    Sleep    1
    Click Element    xpath://a[@class='btn btn-primary m-btn m-btn--icon m-btn--icon-only show-delete-modal']
    Sleep    2
    Click Element    xpath://button[@type='submit']
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    admin-patient-activation-{index}.png
    Sleep    2
    LogoutKW

Patient login test - failure
    [Tags]    patient.register
    Go To    ${TESTURL}
    Login page
    Click Element    name:email
    Input Text    name:email    ${patient_random_email}
    ${RANDOM} =    Generate Random String    8    [NUMBERS]
    Input Text    name:password    ${RANDOM}
    Click Element    name:password
    Submit Form
    Capture Page Screenshot    login-failure-{index}.png

Patient login test - success
    [Tags]    patient.register
    Go To    ${TESTURL}
    Login page
    Clear Element Text    name:email
    Input Text    name:email    ${patient_random_email}
    Capture Page Screenshot    patient-email-{index}.png
    Clear Element Text    name:password
    Input Password    name:password    ${USERPW}
    Capture Page Screenshot    patient-password-{index}.png
    Click Element    xpath://label[@for='checkbox1']
    Submit Form
    Capture Page Screenshot    after-login-success-{index}.png
    Log    Patient has successfully login

Patient logout - success
    [Tags]    patient.register
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /logout
    Capture Page Screenshot    patient-logout-{index}.png
    Log    Patient has successfully logged out

Patient access my appointment without login - failure
    [Tags]    patient.register
    Go To    ${TESTURL}
    Login page
    Input Text    name:email    ${patient_random_email}
    Input Text    name:password    ${USERPW}
    Submit Form
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Capture Page Screenshot    no-any-record-found-{index}.png
    LogoutKW
    Capture Page Screenshot    doctor-after-logout-{index}.png
    [Teardown]    deactivate and delete patient

*** Keywords ***
