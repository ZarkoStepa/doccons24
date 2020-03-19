*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           String
Resource          _mysetup.txt
Resource          _keywords.txt
Library           XvfbRobot

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
TC01
    [Documentation]    Doctor go to video session
    [Tags]
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Click Element    xpath://tr[1]//td[2]//a[1]
    Click Element    xpath://a[@class='btn btn-success']

TC02
    [Documentation]    Patient go to the video session
    [Tags]
    [Setup]    Open Chrome Browser
    LoginKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Wait Until Element Is Visible    id:appointmentTable_wrapper
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Click Element    xpath://tr[1]//td[2]//a[1]
    Click Element    xpath://a[@class='btn btn-success']
    Sleep    5
    Input Text    xpath://input[@id='input-text-chat']    I am test patient and this is my text
    Sleep    3
    Click Element    xpath://button[@id='btn-chat']
    LogoutKW
    [Teardown]

Book 3 appointment
    [Documentation]    dev1
    LoginKW
    #First appointment
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Some symptoms
    Input Text    id:patient_notes    This is my 1st appointment
    Radio Button Should Be Set To    fk_appoint_type    2
    #Select Radio Button    fk_appoint_type    1
    Radio Button Should Be Set To    translation    0
    Click Element    xpath://div[@class='form-group m-form__group row']//label[1]
    Capture Page Screenshot    time-slot-{index}.png
    Click Button    id:rq_btn
    ${url}=    Get Location
    Set Suite Variable    ${url}
    Sleep    2
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    5
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Link    /doctors
    #2nd book appointment
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Some symptoms
    Input Text    id:patient_notes    This is my 2nd appointment
    Radio Button Should Be Set To    fk_appoint_type    2
    #Select Radio Button    fk_appoint_type    1
    #@to do    https://trello.com/c/Tk6Q26D0
    Radio Button Should Be Set To    translation    0
    Click Element    xpath://div[@class='form-group m-form__group row']//label[1]
    Capture Page Screenshot    time-slot-{index}.png
    Click Button    id:rq_btn
    ${url1}=    Get Location
    Set Suite Variable    ${url1}
    Sleep    2
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    4
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Link    /doctors
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Some symptoms
    Input Text    id:patient_notes    This is my 3rd appointment
    Radio Button Should Be Set To    fk_appoint_type    2
    Radio Button Should Be Set To    translation    0
    Click Element    xpath://div[@class='form-group m-form__group row']//label[1]
    Capture Page Screenshot    time-slot-{index}.png
    Click Button    id:rq_btn
    ${url2}=    Get Location
    Set Suite Variable    ${url2}
    Sleep    2
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    3
    LogoutKW

Cancel allpointment
    LoginKW
    Sleep    1
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Click Element    xpath://tr[2]//td[2]//a[1]
    ${url1}    Select Window
    Capture Page Screenshot    preview-appointment-{index}.png
    Click Element    xpath://a[@class='btn btn-danger']
    Capture Page Screenshot    patient-after-canceling-appointment-{index}.png
    Sleep    5
    Element Text Should Be    xpath://span[@class='m-badge m-badge--brand m-badge--wide m-appointment-title-btn m-color-status-cancelled']    Cancelled
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Wait Until Element Is Visible    id:appointmentTable_wrapper
    Capture Page Screenshot    canceled-appointment-{index}.png
    Sleep    2
    LogoutKW

patient pay appointment
    LoginKW
    Sleep    1
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Click Element    xpath://tr[1]//td[2]//a[1]
    ${url2}    Select Window
    Capture Page Screenshot    preview-appointment-{index}.png
    Sleep    2
    Click Element    id:ajax_payment
    Sleep    3
    Click Element    xpath://div[@class='toast-message']
    Sleep    3
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Link    /appointments
    Capture Page Screenshot    status-appointment-{index}.png
    LogoutKW

patient navigate to appointment
    [Documentation]    dev1
    LoginKW
    Sleep    1
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Click Element    xpath://tr[3]//td[2]//a[1]
    ${url}=    Get Location
    Sleep    1
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Go To    ${url}
    Element Text Should Be    xpath://span[@class='m-badge m-badge--brand m-badge--wide m-appointment-title-btn m-color-status-awaiting']    Awaiting Payment
    Sleep    2
    LogoutKW

patient see appointment in my appointment
    LoginKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Wait Until Page Contains Element    id:appointmentTable_wrapper
    Get All Links
    Click Element    xpath://tr[3]//td[2]//a[1]
    ${url}    Get Location
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://tr[2]//td[2]//a[1]
    ${url1}    Get Location
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://tr[1]//td[2]//a[1]
    ${url2}    Get Location
    LogoutKW

doctor add for every working day time slot
    [Documentation]    dev1
    [Tags]
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    #Click Element    xpath://span[contains(text(),'Profile')]
    Click Link    /profile
    Click Element    xpath://a[contains(text(),'Working days')]
    Element Text Should Be    xpath://div[contains(@class,'m-portlet__body')]//div[1]//div[1]//div[1]//label[1]    Monday
    ${monday} =    Get WebElement    css:.m-form__group:nth-child(2) span
    Select Checkbox    ${monday}
    Sleep    1
    ${moday_start_time} =    Get WebElement    name:monday[start_time][]
    Click Element    ${moday_start_time}
    Sleep    1
    Element Text Should Be    xpath://div[@id='m_user_profile_tab_5']//div[3]//div[1]//div[1]//label[1]    Tuesday
    ${tuesday} =    Get WebElement    css:.m-form__group:nth-child(4) > .col-7 span
    Select Checkbox    ${tuesday}
    Sleep    1
    ${tuesday_start_time} =    Get WebElement    name:tuesday[start_time][]
    Click Element    ${tuesday_start_time}
    Sleep    1
    Element Text Should Be    xpath://div[@id='m_user_profile_tab_5']//div[5]//div[1]//div[1]//label[1]    Wednesday
    ${wednesday} =    Get WebElement    css:.m-form__group:nth-child(6) > .col-7 span
    Select Checkbox    ${wednesday}
    Sleep    1
    ${wednesday_start_time} =    Get WebElement    name:wednesday[start_time][]
    Click Element    ${wednesday_start_time}
    Sleep    1
    Element Text Should Be    xpath://div[@id='m_user_profile_tab_5']//div[7]//div[1]//div[1]//label[1]    Thursday
    ${thursday} =    Get WebElement    css:.m-form__group:nth-child(8) span
    Select Checkbox    ${thursday}
    Sleep    1
    ${thursday_start_time} =    Get WebElement    name:thursday[start_time][]
    Click Element    ${thursday_start_time}
    Element Text Should Be    xpath://div[9]//div[1]//div[1]//label[1]    Friday
    ${friday} =    Get WebElement    css:.m-form__group:nth-child(10) > .col-7 span
    Select Checkbox    ${friday}
    Sleep    1
    ${friday_start_time} =    Get WebElement    name:friday[start_time][]
    Click Element    ${friday_start_time}
    Sleep    1
    Element Text Should Be    xpath://div[11]//div[1]//div[1]//label[1]    Saturday
    ${saturday} =    Get WebElement    css:.m-form__group:nth-child(12) > .col-7 span
    Select Checkbox    ${saturday}
    Sleep    1
    ${saturday_start_time} =    Get WebElement    name:saturday[start_time][]
    Click Element    ${saturday_start_time}
    Element Text Should Be    xpath://div[13]//div[1]//div[1]//label[1]    Sunday
    ${sunday} =    Get WebElement    css:.m-form__group:nth-child(14) span
    Select Checkbox    ${sunday}
    Sleep    1
    ${saturday_start_time} =    Get WebElement    name:sunday[start_time][]
    Click Element    ${saturday_start_time}
    Sleep    1
    Click Button    xpath://div[@id='m_user_profile_tab_5']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    LogoutKW

doctor deselect all days
    [Documentation]    dev1
    [Tags]
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /profile
    Click Element    xpath://a[contains(text(),'Working days')]
    ${monday} =    Get WebElement    css:.m-form__group:nth-child(2) span
    Select Checkbox    ${monday}
    Sleep    1
    ${tuesday} =    Get WebElement    css:.m-form__group:nth-child(4) > .col-7 span
    Select Checkbox    ${tuesday}
    Sleep    1
    ${wednesday} =    Get WebElement    css:.m-form__group:nth-child(6) > .col-7 span
    Select Checkbox    ${wednesday}
    Sleep    1
    ${thursday} =    Get WebElement    css:.m-form__group:nth-child(8) span
    Select Checkbox    ${thursday}
    Sleep    1
    ${friday} =    Get WebElement    css:.m-form__group:nth-child(10) > .col-7 span
    Select Checkbox    ${friday}
    Sleep    1
    ${saturday} =    Get WebElement    css:.m-form__group:nth-child(12) > .col-7 span
    Select Checkbox    ${saturday}
    Sleep    1
    ${sunday} =    Get WebElement    css:.m-form__group:nth-child(14) span
    Select Checkbox    ${sunday}
    Sleep    1
    Click Button    xpath://div[@id='m_user_profile_tab_5']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    LogoutKW

Admin create patient account, activate
    LoginAdminKW
    Click Element    xpath://a[@class='btn btn-success']
    Input Text    id:inputFirstName    ${NEWUSER}
    Input Text    id:inputLastName    ${NEWLASTNAME}
    Radio Button Should Be Set To    gender    1
    Click Element    xpath://label[2]/span
    #Click Element    id:exampleSelect1    Patient
    Click Element    xpath://option[contains(text(),'Patient')]
    ${random_email} =    Generate Random String    5    [NUMBERS]
    ${random_email} =    Set Variable    admin-create-patient-email-${random_email}@nooda.de
    Set Suite Variable    ${random_email}
    Input Text    name:email    ${random_email}
    Input Password    id:inputPassword    ${USERPW}
    Input Password    id:inputCPassword    ${USERPW}
    Click Element    xpath://button[@class='btn btn-primary']
    Element Should Be Visible    css:.alert
    #Element Text Should Be    css:.alert    New user added successfully.
    Click Element    xpath://a[contains(text(),'Admin')]
    Radio Button Should Be Set To    status    2
    Sleep    1
    Click Element    xpath://div[@id='m_user_profile_tab_9']//div[@class='m-radio-inline']//label[1]
    Click Element    xpath:(//button[@type='submit'])[6]
    Sleep    5
    LogoutKW

Check patient account -success
    Go To    ${TESTURL}
    Clear Element Text    name:email
    Input Text    name:email    ${random_email}
    Capture Page Screenshot    user-email-{index}.png
    Clear Element Text    name:password
    Input Password    name:password    ${USERPW}
    Capture Page Screenshot    user-password-{index}.png
    Click Element    xpath://label[@for='checkbox1']
    Submit Form
    Log    Patient has successfully login
    Sleep    5

Patient logout success
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Logout')]
    Click Link    /logout
    Capture Page Screenshot    user-logout-{index}.png
    Log    Patient has successfully logged out

set appointment
    LoginKW
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
    Sleep    1
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Set appointment
    Input Text    id:patient_notes    Without paying this appointment is not able to cancel an appointment after changing doctor working days in 24 hrs.
    Radio Button Should Be Set To    fk_appoint_type    2
    Click Element    xpath://label[contains(.,'Physical appearance')]
    Radio Button Should Be Set To    translation    0
    Click Element    xpath://div[@class='form-group m-form__group row']//label[1]
    Capture Page Screenshot    time-slot-{index}.png
    Click Button    id:rq_btn
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    3
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Click Element    xpath://tr[1]//td[2]//a[1]
    Capture Page Screenshot    preview-appointment-{index}.png
    Sleep    2
    Click Element    id:ajax_payment
    Sleep    2
    #Click Element    xpath://div[@class='toast-message']
    LogoutKW

appointment details
    [Documentation]    no translation fee
    LoginKW
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
    Sleep    1
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Click Element    xpath://tr[1]//td[2]//a[1]
    Element Text Should Be    xpath://label[contains(text(),'Doctor:')]    Doctor:
    Element Text Should Be    xpath://a[contains(text(),'${NEWDOCUSER} ${NEWDOCLASTNAME}')]    ${NEWDOCUSER} ${NEWDOCLASTNAME}
    Element Text Should Be    xpath://label[contains(text(),'Patient:')]    Patient:
    Element Text Should Be    xpath://a[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]    ${NEWUSER} ${NEWLASTNAME}
    Element Text Should Be    xpath://p[contains(text(),'Doctor fee ${INPUTRATE} ')]    Doctor fee ${INPUTRATE} €

assertation my appointment
    [Documentation]    assert all tab on table in my appointment page
    LoginKW
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
    Sleep    1
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Link    /appointments
    Wait Until Element Is Visible    xpath://h3[@class='m-subheader__title m-pageheading']
    Element Text Should Be    xpath://h3[@class='m-subheader__title m-pageheading']    Appointments
    Wait Until Element Is Visible    xpath://label[contains(text(),'Search:')]
    Element Should Be Visible    xpath://label[contains(text(),'Search:')]
    Wait Until Element Is Visible    id:appointmentTable_wrapper
    Wait Until Element Is Visible    xpath://th[@class='text-center sorting_desc']
    Element Should Be Visible    xpath://th[@class='text-center sorting_desc']
    Wait Until Element Is Visible    xpath://th[contains(text(),'Status')]
    Element Should Be Visible    xpath://th[contains(text(),'Status')]
    Element Text Should Be    xpath://th[contains(text(),'Status')]    Status
    Wait Until Element Is Visible    xpath://th[contains(text(),'Actions')]
    Element Should Be Visible    xpath://th[contains(text(),'Actions')]
    Element Text Should Be    xpath://th[contains(text(),'Actions')]    Actions
    Wait Until Element Is Visible    xpath://i[@class='fa fa-language fa-2x']
    Element Should Be Visible    xpath://i[@class='fa fa-language fa-2x']
    Wait Until Element Is Visible    xpath://th[contains(text(),'Title')]
    Element Should Be Visible    xpath://th[contains(text(),'Title')]
    Element Text Should Be    xpath://th[contains(text(),'Title')]    Title
    Wait Until Element Is Visible    xpath://th[contains(text(),'Doctor')]
    Element Should Be Visible    xpath://th[contains(text(),'Doctor')]
    Element Text Should Be    xpath://th[contains(text(),'Doctor')]    Doctor
    Wait Until Element Is Visible    xpath://th[contains(text(),'Type')]
    Element Should Be Visible    xpath://th[contains(text(),'Type')]
    Element Text Should Be    xpath://th[contains(text(),'Type')]    Type
    Wait Until Element Is Visible    xpath://th[contains(text(),'Date')]
    Element Should Be Visible    xpath://th[contains(text(),'Date')]
    Element Text Should Be    xpath://th[contains(text(),'Date')]    Date
    Wait Until Element Is Visible    xpath://th[contains(text(),'Time')]
    Element Should Be Visible    xpath://th[contains(text(),'Time')]
    Element Text Should Be    xpath://th[contains(text(),'Time')]    Time

add amount - paypal
    [Tags]
    LoginKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Wallet')]
    Input Text    id:depositAmount    500
    Sleep    1
    Click Element    id:paymentButton
    Sleep    1
    Click Element    xpath://button[@class='btn btn-primary btn-large']//img
    Sleep    8
    Input Text    xpath://input[@id='email']    irenafemic@hotmail.com
    Click Element    xpath://button[@id='btnNext']
    Sleep    5
    Input Text    xpath://input[@id='password']    1111111111
    Click Element    xpath://button[@id='btnLogin']
    Sleep    15
    Click Element    xpath://input[@id='confirmButtonTop']
    Sleep    10
    Wait Until Element Is Visible    xpath://div[@class='alert alert-success']
    LogoutKW

*** Keywords ***
Open Chrome Browser
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}

Open Testbrowser
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If    '${system}' == 'Linux'    Start Virtual Display    1920    1080
    Open Chrome Browser
