*** Settings ***
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
register doctor

delete account mannager
    [Tags]
    LoginAdminKW
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    admin-create-manager-email-
    Sleep    2
    Click Element    xpath://div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[3]/a[2]
    Sleep    1
    Click Element    xpath://button[contains(text(),'Inactive')]
    Sleep    1
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'Not confirmed')]
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    admin-create-manager-email-
    Sleep    1
    Click Element    xpath://tr[@class='odd']//a[@class='btn btn-danger m-btn m-btn--icon m-btn--icon-only send-modal']
    Sleep    1
    Click Element    xpath://span[@id='footer_action_button2']
    LogoutKW

delete doctor
    LoginAdminKW
    Click Element    xpath://span[contains(text(),'Not confirmed')]
    Input Text    xpath://label[contains(text(),'Search:')]//input    account_manager
    Click Element    xpath:/html[1]/body[1]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Click Element    xpath://button[@id='proba']
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    account_manager
    Click Element    xpath:/html[1]/body[1]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Click Element    xpath://button[@id='proba']
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    doctor
    Click Element    xpath:/html[1]/body[1]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Click Element    xpath://button[@id='proba']
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    account_manager
    Click Element    xpath:/html[1]/body[1]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Click Element    xpath://button[@id='proba']
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    patient
    Click Element    xpath:/html[1]/body[1]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Click Element    xpath://button[@id='proba']
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    patient
    Click Element    xpath:/html[1]/body[1]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Click Element    xpath://button[@id='proba']
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    account_manager
    Click Element    xpath:/html[1]/body[1]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Click Element    xpath://button[@id='proba']
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    account_manager
    Click Element    xpath:/html[1]/body[1]/div[2]/div[1]/div[2]/div[2]/div[1]/div[2]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Click Element    xpath://button[@id='proba']
    Sleep    1

*** Keywords ***
activation
    LoginAdminKW
    Capture Page Screenshot    log-as-admin-{index}.png
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Not confirmed')]
    Click Element    xpath://label[contains(text(),'Search:')]//input
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${doctor_radnom_email}
    Capture Page Screenshot    search-doctor-{index}.png
    Wait Until Element Contains    xpath://th[contains(text(),'Actions')]    Actions
    Click Element    xpath://a[@class='btn btn-success m-btn m-btn--icon m-btn--icon-only']
    Capture Page Screenshot    admin-actions-{index}.png
    Click Element    xpath://a[contains(text(),'Admin')]
    Sleep    1
    Capture Page Screenshot    before-activate-{index}.png
    # To do \ @radio button \ can't activate doctor    1
    #Select Radio Button    status    1
    Click Element    xpath://div[7]/form/div/div/div/div/label[1]    #activate
    Sleep    1
    Capture Page Screenshot    after-clicking-activate-{index}.png
    #Click Element    //div[@id='m_user_profile_tab_9']//div[@class='m-radio-inline']//label[1]
    Click Button    //div[@id='m_user_profile_tab_9']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    Sleep    1
    Capture Page Screenshot    admin-configuration-updated-successfully-{index}.png
    Click Element    xpath://a[contains(text(),'Admin')]
    Scroll Element Into View    xpath://div[@id='m_user_profile_tab_9']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    Capture Page Screenshot    after-admin-configuration-updated-successfully-{index}.png
    LogoutKW
    Capture Page Screenshot    logout-admin-{index}.png

register doctor
    Go To    ${TESTURL}
    Capture Page Screenshot    register-new-doctor-goto-{index}.png
    Wait Until Element Is Visible    xpath://a[contains(text(),'Register')]
    Click Link    /register
    Capture Page Screenshot    register-new-doctor-{index}.png
    Submit Form
    Click Element    xpath://label[@for='doctor']
    Capture Page Screenshot    register-new-doctor-role-{index}.png
    Click Element    xpath://label[@for='female']
    Capture Page Screenshot    register-new-doctor-gender-{index}.png
    ${doctor_radnom_name} =    Generate Random String    5    [NUMBERS]
    ${doctor_radnom_name}=    Set Variable    ${doctor_radnom_name} ${NEWDOCUSER}
    Set Suite Variable    ${doctor_radnom_name}
    Input Text    name:first_name    ${doctor_radnom_name}
    Capture Page Screenshot    register-new-doctor-firstname-{index}.png
    Input Text    name:last_name    ${NEWDOCLASTNAME}
    Capture Page Screenshot    register-new-doctor-lastname-{index}.png
    ${doctor_radnom_email} =    Generate Random String    5    [NUMBERS]
    ${doctor_radnom_email}=    Set Variable    doctor-${doctor_radnom_email}-email-${email}
    Set Suite Variable    ${doctor_radnom_email}
    Input Text    name:email    ${doctor_radnom_email}
    Capture Page Screenshot    register-random-doctor-email-{index}.png
    Input Text    name:password    ${DOCPW}
    Capture Page Screenshot    register-new-doctor-password-{index}.png
    Input Password    name:password_confirmation    ${DOCPW}
    Capture Page Screenshot    register-new-doctor-confirm-password-{index}.png
    Click Element    name:check_agreement
    Capture Page Screenshot    register-new-doctor-check-ageement-{index}.png
    Submit Form
    Capture Page Screenshot    register-new-doctor-signin-{index}.png
    LogoutKW
    Capture Page Screenshot    register-new-doctor-logout-{index}.png

register
    register doctor
    activation
