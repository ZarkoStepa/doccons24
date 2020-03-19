*** Settings ***
Suite Setup       Open Chrome Browser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _keywords.txt
Resource          _mysetup.txt
Library           String

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
doctor recommendation - success
    [Tags]
    [Setup]
    LoginAdminKW
    Click Element    xpath://a[@class='btn btn-success']
    Sleep    1
    Input Text    id:inputFirstName    ${NEWUSER}
    Input Text    id:inputLastName    ${NEWLASTNAME}
    Click Element    id:exampleSelect1
    Click Element    xpath://option[contains(text(),'Doctor')]
    ${doctor_radnom_email} =    Generate Random String    6    [NUMBERS]
    ${doctor_radnom_email} =    Set Variable    user-${doctor_radnom_email}@nooda.de
    Set Suite Variable    ${doctor_radnom_email}
    Input Text    id:inputPassword    ${USERPW}
    Input Password    id:inputCPassword    ${USERPW}

Delete clinic -sucess
    [Tags]
    LoginAdminKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Browse hospitals')]
    Click Element    xpath://span[contains(text(),'All hospitals')]
    Click Element    xpath://div[1]/table[1]/tbody[1]/tr[1]/td[7]/a[2]
    Click Element    css:.modal-footer > .btn-primary
    Capture Page Screenshot    after-derlete-hospital-{index}.png
    LogoutKW

cancel appointment from doctor
    [Tags]
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Input Text    xpath://label[contains(text(),'Search:')]//input    02:30
    Click Element    xpath://tr[1]/td[2]/a[@class='btn btn-primary btn-sm m-appointment-title-btn']
    Click Element    xpath://a[@class='btn btn-danger']
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Input Text    xpath://label[contains(text(),'Search:')]//input    02:30
    Click Element    xpath://tr[1]/td[2]/a[@class='btn btn-primary btn-sm m-appointment-title-btn']
    Click Element    xpath://a[@class='btn btn-danger']
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Input Text    xpath://label[contains(text(),'Search:')]//input    02:30
    Click Element    xpath://tr[1]/td[2]/a[@class='btn btn-primary btn-sm m-appointment-title-btn']
    Click Element    xpath://a[@class='btn btn-danger']

admin delete inactive user
    [Tags]
    LoginAdminKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Not confirmed')]
    Click Element    xpath://table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Click Element    id:footer_action_button2
    Sleep    1
    Click Element    xpath://table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Click Element    id:footer_action_button2
    Sleep    1
    Click Element    xpath://table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Click Element    id:footer_action_button2
    Sleep    1
    Click Element    xpath://table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Sleep    1
    Click Element    id:footer_action_button2

Setup Clinic
    LoginAdminKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    2
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Browse hospitals')]
    Sleep    1
    Click Element    xpath://span[contains(text(),'Add new hospital')]
    Sleep    1
    Admin New Hospital page
    Capture Page Screenshot    before-input-credentials-hospital-{index}.png
    Input Text    id:inputClinicName    ${CLINICNAME}
    Input Text    id:inputAboutClinic    ${ABOUTCLINIC}
    Input Text    id:inputStreet    ${ADRESS}
    Input Text    id:inputCity    ${CITY}
    Input Text    id:inputState    ${COUNTRY}
    Input Text    id:inputZipCode    ${ZIP}
    Click Element    id:selectCountry
    Click Element    xpath://option[contains(text(),'Germany')]
    Click Element    id:selectRequested
    Click Element    xpath://select[@id='selectRequested']//option[contains(text(),'${ADMINNAME} ${ADMINLASTNAME}')]
    Click Element    id:selectAdded
    Click Element    xpath://select[@id='selectAdded']//option[contains(text(),'${ADMINNAME} ${ADMINLASTNAME}')]
    Capture Page Screenshot    before-save-hospital-{index}.png
    Click Element    xpath://button[@class='btn btn-primary']
    Capture Page Screenshot    after-save-hospital-{index}.png
    Admin Clinic Activation page
    Capture Page Screenshot    before-activate-hospital-{index}.png
    Click Element    xpath://label[contains(.,'Activated')]
    Capture Page Screenshot    after-activate-hospital-{index}.png
    Scroll Element Into View    xpath://button[@class='btn btn-primary']
    Click Element    xpath://button[@class='btn btn-primary']
    Capture Page Screenshot    save-activated-hospital-{index}.png
    Sleep    1
    LogoutKW

check clinic
    LoginAdminKW
    Click Element    xpath://div[1]/table[1]/tbody[1]/tr[1]/td[2]/a[1]
    Click Element    xpath://a[@id='qua']
    Scroll Element Into View    xpath://font[contains(text(),'New document')]
    Capture Page Screenshot    hospital-select-{imdex}.png
    Sleep    5

delete doctor emails
    [Documentation]    limitation for delete emails
    GoTo    ${email_server}
    Click Element    xpath://a[contains(text(),'EMAIL')]
    Click Element    xpath://input[@id='inbox_field']
    Clear Element Text    xpath://input[@id='inbox_field']
    Input Text    xpath://input[@id='inbox_field']    ${DOCUSER}
    Click Element    xpath://button[@id='go_inbox']
    Click Element    xpath://a[@class='cc-btn cc-dismiss']
    Sleep    2
    Click Element    css:body.nav-md.ng-scope:nth-child(2) div.container.body:nth-child(2) div.main_container div.right_col:nth-child(3) div.col-md-12.col-sm-12.col-xs-12:nth-child(8) div.x_panel div.x_content div.table-responsive:nth-child(1) table.table.table-striped.jambo_table tbody:nth-child(2) tr.even.pointer.ng-scope:nth-child(1) td:nth-child(4) > a.ng-binding
    Sleep    2
    Capture Page Screenshot    delete-email-{index}.png
    Click Element    xpath://body[@id='InboxCtrl']/div[@class='container body']/div[@class='main_container']/div[@class='right_col']/div/div[@id='inbox_page_title']/div[@class='title_left']/div[@class='col-md-11 col-sm-11 col-xs-11 form-group pull-left top_search']/div/button[@id='trash_but']/*[1]
    Sleep    2
    Handle Alert
    Close Browser

register doctor
    Go To    ${TESTURL}
    Capture Page Screenshot    register-new-doctor-goto-{index}.png
    Wait Until Element Is Visible    xpath://a[contains(text(),'Register')]
    Click Link    /register
    Registration page
    Capture Page Screenshot    register-new-doctor-{index}.png
    Submit Form
    Registration Required fields
    Click Element    xpath://label[@for='doctor']
    Capture Page Screenshot    register-new-doctor-role-{index}.png
    Click Element    xpath://label[@for='female']
    Capture Page Screenshot    register-new-doctor-gender-{index}.png
    Input Text    name:first_name    ${NEWDOCUSER}
    Capture Page Screenshot    register-new-doctor-firstname-{index}.png
    Input Text    name:last_name    ${NEWDOCLASTNAME}
    Capture Page Screenshot    register-new-doctor-lastname-{index}.png
    ${random_email} =    Generate Random String    5    [NUMBERS]
    ${random_email} =    Set Variable    doctor-${random_email}-email-${emails}
    Set Suite Variable    ${random_email}
    Input Text    name:email    ${random_email}
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

delete email
    GoTo    ${email_server}
    Click Element    xpath://input[@id='inbox_field']
    Clear Element Text    xpath://input[@id='inbox_field']
    Input Text    xpath://input[@id='inbox_field']    ${USER}
    Click Element    xpath://button[@id='go_inbox']
    Click Element    xpath://a[@class='cc-btn cc-dismiss']
    Sleep    2
    Click Element    css:body.nav-md.ng-scope:nth-child(2) div.container.body:nth-child(2) div.main_container div.right_col:nth-child(3) div.col-md-12.col-sm-12.col-xs-12:nth-child(8) div.x_panel div.x_content div.table-responsive:nth-child(1) table.table.table-striped.jambo_table tbody:nth-child(2) tr.even.pointer.ng-scope:nth-child(1) td:nth-child(4) > a.ng-binding
    Sleep    2
    Capture Page Screenshot    delete-email-{index}.png
    Click Element    xpath://body[@id='InboxCtrl']/div[@class='container body']/div[@class='main_container']/div[@class='right_col']/div/div[@id='inbox_page_title']/div[@class='title_left']/div[@class='col-md-11 col-sm-11 col-xs-11 form-group pull-left top_search']/div/button[@id='trash_but']/*[1]
    Sleep    2
    Handle Alert

deactivate and delete
    LoginAdminKW
    Input Text    xpath://label[contains(text(),'Search:')]//input    correct8
    Sleep    3
    Click Element    xpath://table[1]/tbody[1]/tr[1]/td[3]/a[3]
    Sleep    1
    Click Element    xpath://span[@id='footer_action_button2']
    Sleep    1
    delete user
    delete user
    delete user
    delete user
    delete user
    delete user
    delete user
    delete user
    delete user
    delete user

*** Keywords ***
Opem Testbrowser
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If    '${system}' == 'Linux'    Start Virtual Display    1920    1080
    Open Chrome Browser

Open Chrome Browser
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}

delete user
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'All users')]
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    correct8
    Sleep    3
    Click Element    xpath://table[1]/tbody[1]/tr[1]/td[3]/a[3]
    Sleep    1
    Click Element    css:#footer_action_button2
    Sleep    1
