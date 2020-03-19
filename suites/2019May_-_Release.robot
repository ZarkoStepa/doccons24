*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt
Library           String
Library           DateTime

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
user login test - failure invalid email
    [Documentation]    user login test - failure inwalid email
    [Tags]    2019
    Go To    ${TESTURL}
    Click Element    name:email
    ${RANDOM} =    Generate Random String    10    [STRING]
    Input Text    name:email    ${RANDOM}.com
    Click Element    name:password
    ${RANDOM} =    Generate Random String    10    [STRING]
    Input Text    name:password    ${RANDOM}
    Submit Form
    Element Should Contain    xpath://li[contains(text(),'The email must be a valid email address.')]    The email must be a valid email address.
    Wait Until Element Contains    xpath://li[contains(text(),'The email must be a valid email address.')]    The email must be a valid email address.
    Capture Page Screenshot    invalid-email-adress-{index}.png

user login test - failure - wrong pass
    [Documentation]    user login test - failure - wrong pass
    [Tags]    2019
    Go To    ${TESTURL}
    ${RANDOM} =    Generate Random String    3    [NUMBERS]
    Input Text    name:email    user-${RANDOM}@nooda.de
    Click Element    name:email
    ${RANDOM} =    Generate Random String    3    [NUMBERS]
    Input Text    name:password    ${RANDOM}
    Click Element    name:password
    Submit Form
    Element Should Contain    xpath://li[contains(text(),'These credentials do not match our records.')]    These credentials do not match our records.
    Wait Until Element Contains    xpath://li[contains(text(),'These credentials do not match our records.')]    These credentials do not match our records.
    Capture Page Screenshot    login-failure-{index}.png

user login test - failure no email
    [Documentation]    user login test - failure no email
    [Tags]    2019
    Go To    ${TESTURL}
    ${RANDOM} =    Generate Random String    5    [STRING]
    Input Text    name:password    ${RANDOM}
    Submit Form
    Element Should Contain    xpath://li[contains(text(),'Email field is required.')]    Email field is required.
    Wait Until Element Contains    xpath://li[contains(text(),'Email field is required.')]    Email field is required.
    Capture Page Screenshot    email-field-req-{index}.png

user login test - failure no password
    [Documentation]    user login test - failure no password
    [Tags]    2019
    Go To    ${TESTURL}
    ${RANDOM} =    Generate Random String    10    [STRING]
    Input Text    name:email    ${RANDOM}@nooda.de
    Submit Form
    Element Should Contain    xpath://li[contains(text(),'Password field is required.')]    Password field is required.
    Wait Until Element Contains    xpath://li[contains(text(),'Password field is required.')]    Password field is required.
    Capture Page Screenshot    password-field-req-{index}.png

pick a date
    LoginKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /doctors
    Wait Until Page Contains    Doctors
    Click Element    id:pdate
    # Select Date on Datepicker
    ${current_date_noon} =    Get Current Date    result_format=%Y-%m-%d 00:00:00
    # Log    ${a}
    ${date_in_7d} =    Add Time To Date    ${current_date_noon}    7 days
    ${unixtime} =    get time    epoch    ${date_in_7d}
    ${data_format} =    Set Variable    ${unixtime}000
    # Log To Console    ${data_format}
    Click Element    xpath=//td[@data-date="${data_format}"]
    Submit Form

role - gender
    Go To    ${TESTURL}
    Click Link    /register
    Select Radio Button    role    3
    Sleep    3
    Select Radio Button    gender    2
    Sleep    3

doctor about me
    [Documentation]    ElementNotVisibleException: Message: element not interactable
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Profile')]
    Click Element    xpath://div[@id='About_en']/div[2]/div[6]/div/div/div/div
    Input Text    xpath://div[@id='About_en']//div[textarea]    I am a doctor with more than 30 years of experiance.
    ${aboutme_en}=    Get WebElement    xpath://div[@id='About_en']/div[2]/div/textarea
    Input Text    ${aboutme_en}    I am a doctor with more than 30 years of experiance.
    Capture Page Screenshot    input-about-en-{index}.png
    Click Element    css:#About_de .CodeMirror-line
    Input Text    css:#About_de .CodeMirror-line    I am a doctor with more than 30 years of experiance.
    Capture Page Screenshot    input-about-de-{index}.png
    Clear Element Text    xpath=//div[@id='About_ar']/div[2]/div/textarea
    Input Text    xpath=//div[@id='About_ar']/div[2]/div/textarea    I am a doctor with more than 30 years of experiance.
    Capture Page Screenshot    input-about-ar-{index}.png
    Click Button    xpath://button[@id='btnsave']
    LogoutKW

doctor about me editor toolbar
    Go To    ${BASEURL}
    Input Text    name:email    ${DOCEMAIL}
    Input Password    name :password    ${DOCPW}
    Click Button    xpath://button[@class='btn btn-primary btn-cons m-t-10']
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Personal info')]
    Wait Until Element Is Enabled    xpath://div[@id='About_en']//a[@class='fa fa-bold']
    Click Element    xpath://div[@id='About_en']//a[@class='fa fa-bold']
    Wait Until Element Is Enabled    xpath://div[@id='About_en']//a[@class='fa fa-italic']
    Click Element    xpath://div[@id='About_en']//a[@class='fa fa-italic']
    Wait Until Element Is Enabled    xpath://div[@id='About_en']//a[@class='fa fa-header']
    Click Element    xpath://div[@id='About_en']//a[@class='fa fa-header']
    Wait Until Element Is Enabled    xpath://div[@id='About_en']//a[@class='fa fa-quote-left']
    Click Element    xpath://div[@id='About_en']//a[@class='fa fa-quote-left']
    Wait Until Element Is Enabled    xpath://div[@id='About_en']//a[@class='fa fa-list-ul']
    Click Element    xpath://div[@id='About_en']//a[@class='fa fa-list-ul']
    Wait Until Element Is Enabled    xpath://div[@id='About_en']//a[@class='fa fa-list-ol']
    Click Element    xpath://div[@id='About_en']//a[@class='fa fa-list-ol']
    Wait Until Element Is Enabled    xpath://div[@id='About_en']//a[@class='fa fa-link']
    Click Element    xpath://div[@id='About_en']//a[@class='fa fa-link']
    Sleep    5
    Wait Until Element Is Enabled    xpath://div[@id='About_en']//a[@class='fa fa-picture-o']
    Click Element    xpath://div[@id='About_en']//a[@class='fa fa-picture-o']
    Wait Until Element Is Enabled    xpath://div[@id='About_en']//a[@class='fa fa-eye no-disable']
    Click Element    xpath://div[@id='About_en']//a[@class='fa fa-eye no-disable']
    Wait Until Element Is Enabled    xpath://div[@id='About_en']//a[@class='fa fa-columns no-disable no-mobile']
    Wait Until Element Is Enabled    xpath://div[@id='About_en']//a[@class='fa fa-arrows-alt no-disable no-mobile']
    Click Element    xpath://div[@id='About_en']//a[@class='fa fa-columns no-disable no-mobile']
    Click Element    xpath://a[@class='fa fa-arrows-alt no-disable no-mobile active']
    Click Element    xpath://div[@id='About_en']//div[@class='CodeMirror-scroll']
    #@to do cant input text
    Submit Form
    LogoutKW

patient history
    LoginKW
    Click Link    /profile
    Click Element    xpath://a[contains(text(),'Patient Data')]
    Click Element    xpath://a[contains(text(),'Patient history')]
    Input Text    id:blood_type    A
    Input Text    id:weight    80
    Input Text    id:height    180
    #Select Radio Button    1_drug_allergies    no
    #Select Radio Button    1_drug_allergies    yes
    Input Text    id:1_name_of_drug    Penicilin
    Checkbox Should Not Be Selected    name:current_or_past_illness
    Click Element    xpath://label[contains(.,'Diabetes')]
    Input Text    id:other_illment    No
    Input Text    id:problems_with_birth    No
    Input Text    id:born_and_raised    Yes
    #Select Radio Button    currently_working    yes
    Select Radio Button    currently_working    no
    Input Text    id:Hours_week    yes

TC01
    [Documentation]    https://trello.com/c/NUyUPkVT
    LoginKW
    Click Element    xpath://span[contains(text(),'Wallet')]
    Input Text    id:depositAmount    100
    Click Button    id:paymentButton
    Sleep    3
    Click Element    xpath://button[@class='btn btn-primary btn-large']//img
    Sleep    3
    Input Text    id:email    irenafemic@hotmail.com
    Click Button    id:btnNext
    Sleep    3
    Input Text    id:password    1111111
    Click Button    id:btnLogin
    Click Element    xpath://span[contains(text(),'CREDIT UNION 1 ‏')]
    Click Button    xpath://button[@class='btn full confirmButton continueButton']
    Click Button    xpath://input[@id='confirmButtonTop']

Book and pay timeslot
    LoginKW
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Some symptoms
    Input Text    id:patient_notes    Some patient notes
    Radio Button Should Be Set To    fk_appoint_type    2
    #Select Radio Button    fk_appoint_type    1
    #@to do    https://trello.com/c/Tk6Q26D0
    Radio Button Should Be Set To    translation    0
    #Radio Button Should Be Set To    requested_time    16:00 - 16:30
    Click Element    xpath://div[@class='form-group m-form__group row']//label[1]
    Capture Page Screenshot    time-slot-{index}.png
    Click Button    id:rq_btn
    Sleep    2
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    3
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Click Element    xpath://tr[1]//td[2]//a[1]
    Capture Page Screenshot    preview-appointment-{index}.png
    Sleep    3
    Click Element    id:ajax_payment
    Sleep    3
    Click Element    xpath://div[@class='toast-message']
    Sleep    3
    LogoutKW

register as female patient
    [Documentation]    testing gender patient female. Should be saved as female (patient,admin)
    Go To    ${TESTURL}
    Capture Page Screenshot    register-patient-goto-{index}.png
    Wait Until Element Is Visible    xpath://a[contains(text(),'Register')]
    Click Link    /register
    Capture Page Screenshot    register-patient-{index}.png
    Submit Form
    Capture Page Screenshot    register-patient-requiredfields-{index}.png
    Wait Until Element Is Visible    id:first_name-error
    Element Text Should Be    id:first_name-error    ${REQUIREDFIELDS}
    Element Text Should Be    id:last_name-error    ${REQUIREDFIELDS}
    Element Text Should Be    id:password-error    ${REQUIREDFIELDS}
    Element Text Should Be    id:check_agreement-error    ${REQUIREDFIELDS}
    Element Should Contain    xpath://label[contains(text(),'Role')]    Role
    Wait Until Element Is Visible    xpath://label[@for='doctor']
    Wait Until Element Is Visible    xpath://label[@for='patient']
    Select Radio Button    role    3
    Capture Page Screenshot    register-new-doctor-role-{index}.png
    #Click Element    xpath://label[@for='patient']
    #Click Element    xpath://label[@for='female']
    Capture Page Screenshot    register-patient-gender-{index}.png
    Element Should Contain    xpath://label[contains(text(),'Gender')]    Gender
    Wait Until Element Is Visible    xpath://label[contains(text(),'Male')]
    Wait Until Element Is Visible    xpath://label[@for='female']
    Sleep    3
    Select Radio Button    gender    0
    #Click Element    xpath://label[@for='female']
    Capture Page Screenshot    register-patient-gender-{index}.png
    Input Text    name:first_name    ${NEWUSER}
    #Click Element    register-patient-firstname-{index}.png
    Input Text    name:last_name    ${NEWLASTNAME}
    ${random_email} =    Generate Random String    5    [NUMBERS]
    ${random_email}=    Set Variable    patient-${random_email}-email@nooda.de
    Set Suite Variable    ${random_email}
    Input Text    name:email    ${random_email}
    Capture Page Screenshot    register-random-patient-email-{index}.png
    Input Text    name:password    ${USERPW}
    Capture Page Screenshot    register-patient-password-{index}.png
    Input Password    name:password_confirmation    ${USERPW}
    Capture Page Screenshot    register-patient-password-confirmation-{index}.png
    Click Element    name:check_agreement
    Capture Page Screenshot    register-patient-check-ageement-{index}.png
    Element Should Contain    xpath://div[contains(@class,'row m-t-10')]//small[1]    I agree to the
    Element Should Contain    link:DocCons24 Terms    DocCons24 Terms
    Element Should Contain    link:Privacy    Privacy
    Click Button    xpath://button[contains(@type,'submit')]
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    2
    Click Link    /profile
    Radio Button Should Be Set To    gender    0    #female
    LogoutKW
    LoginAdminKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Not confirmed')]
    Click Element    xpath://label[contains(text(),'Search:')]//input
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${NEWUSER} ${NEWLASTNAME}
    Wait Until Element Contains    xpath://th[contains(text(),'Actions')]    Actions
    Click Element    xpath://a[@class='btn btn-success m-btn m-btn--icon m-btn--icon-only']
    Click Element    xpath://a[contains(text(),'Admin')]
    #Radio Button Should Be Set To    xpath://div[@id='m_user_profile_tab_9']//label[2]    Inactive
    #Select Radio Button    name:status    1
    Click Element    css:la-pencil
    Sleep    3
    Radio Button Should Be Set To    gender    0    #female
    Capture Page Screenshot    admin-gender-{index}.png
    Sleep    5
    LogoutKW

german doctor register
    Go To    ${TESTURL}
    Click Element    xpath://a[contains(text(),'DE')]
    Click Element    xpath://a[contains(text(),'Registrieren')]
    Click Element    xpath://label[contains(text(),'Ich bin ein Arzt')]
    Click Element    name:first_name
    Input Text    name:first_name    ${NEWDOCUSER}
    Click Element    name:last_name
    Input Text    name:last_name    ${NEWLASTNAME}
    ${random_email} =    Generate Random String    5
    ${random_email}=    Set Variable    doctor-${random_email}-DE@nooda.de
    Set Suite Variable    ${random_email}
    Input Text    name:email    ${random_email}
    Input Text    name:password    ${DOCPW}
    Input Password    name:password_confirmation    ${DOCPW}
    Click Element    name:check_agreement
    Submit Form
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Ausloggen')]
    LoginAdminKW
    Capture Page Screenshot    log-as-admin-{index}.png
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    2
    Click Element    xpath://span[contains(text(),'Alle Nutzer')]
    Click Element    xpath://label[contains(text(),'Search:')]//input
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${NEWDOCUSER} ${NEWDOCLASTNAME}
    Capture Page Screenshot    search-doctor-{index}.png
    Wait Until Element Contains    xpath://th[contains(text(),'Actions')]    Actions
    Click Element    xpath://a[@class='btn btn-success m-btn m-btn--icon m-btn--icon-only']
    Click Element    xpath://a[contains(text(),'Admin')]
    Radio Button Should Be Set To    status    2
    Sleep    1
    Click Element    xpath://div[7]/form/div/div/div/div/label[1]    #activate
    Capture Page Screenshot    after-clicking-activate-{index}.png
    #Click Element    //div[@id='m_user_profile_tab_9']//div[@class='m-radio-inline']//label[1]
    Click Button    //div[@id='m_user_profile_tab_9']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    Capture Page Screenshot    admin-configuration-updated-successfully-{index}.png
    LogoutKW
    Clear Element Text    name:email
    Input Text    name:email    ${random_email}
    Capture Page Screenshot    user-email-{index}.png
    Clear Element Text    name:password
    Input Password    name:password    ${DOCPW}
    Capture Page Screenshot    user-password-{index}.png
    Click Element    xpath://label[@for='checkbox1']
    Submit Form
    Sleep    2
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Working days')]
    Element Text Should Be    xpath://a[contains(text(),'Working days')]    Working days
    Element Text Should Be    xpath://div[contains(@class,'m-portlet__body')]//div[1]//div[1]//div[1]//label[1]    Monday
    ${monday} =    Get WebElement    css:.m-form__group:nth-child(1) > .col-7 span
    Select Checkbox    ${monday}
    Sleep    1
    ${moday_start_time} =    Get WebElement    name:monday[start_time][]
    Click Element    ${moday_start_time}
    Sleep    1
    Element Text Should Be    xpath://div[@id='m_user_profile_tab_5']//div[3]//div[1]//div[1]//label[1]    Tuesday
    ${tuesday} =    Get WebElement    css:.m-form__group:nth-child(3) > .col-7 span
    Select Checkbox    ${tuesday}
    Sleep    1
    ${tuesday_start_time} =    Get WebElement    name:tuesday[start_time][]
    Click Element    ${tuesday_start_time}
    Sleep    1
    Element Text Should Be    xpath://div[@id='m_user_profile_tab_5']//div[5]//div[1]//div[1]//label[1]    Wednesday
    ${wednesday} =    Get WebElement    css:.m-form__group:nth-child(5) > .col-7 span
    Select Checkbox    ${wednesday}
    Sleep    1
    ${wednesday_start_time} =    Get WebElement    name:wednesday[start_time][]
    Click Element    ${wednesday_start_time}
    Sleep    1
    Element Text Should Be    xpath://div[@id='m_user_profile_tab_5']//div[7]//div[1]//div[1]//label[1]    Thursday
    ${thursday} =    Get WebElement    css:.m-form__group:nth-child(7) span
    Select Checkbox    ${thursday}
    Sleep    1
    ${thursday_start_time} =    Get WebElement    name:thursday[start_time][]
    Click Element    ${thursday_start_time}
    Element Text Should Be    xpath://div[9]//div[1]//div[1]//label[1]    Friday
    ${friday} =    Get WebElement    css:.m-form__group:nth-child(9) span
    Select Checkbox    ${friday}
    Sleep    1
    ${friday_start_time} =    Get WebElement    name:friday[start_time][]
    Click Element    ${friday_start_time}
    Sleep    1
    Element Text Should Be    xpath://div[11]//div[1]//div[1]//label[1]    Saturday
    ${saturday} =    Get WebElement    xpath://div[@id='m_user_profile_tab_5']/form/div/div[11]/div/div/label/span
    Select Checkbox    ${saturday}
    Sleep    1
    ${saturday_start_time} =    Get WebElement    name:saturday[start_time][]
    Click Element    ${saturday_start_time}
    Element Text Should Be    xpath://div[13]//div[1]//div[1]//label[1]    Sunday
    ${sunday} =    Get WebElement    css:.m-form__group:nth-child(13) span
    Select Checkbox    ${sunday}
    Sleep    1
    ${saturday_start_time} =    Get WebElement    name:sunday[start_time][]
    Click Element    ${saturday_start_time}
    Sleep    2
    Click Button    xpath://div[@id='m_user_profile_tab_5']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    LogoutKW

gender value 1
    Go To    ${TESTURL}
    Capture Page Screenshot    register-patient-goto-{index}.png
    Wait Until Element Is Visible    xpath://a[contains(text(),'Register')]
    Click Link    /register
    Capture Page Screenshot    register-patient-{index}.png
    Submit Form
    Capture Page Screenshot    register-patient-requiredfields-{index}.png
    Wait Until Element Is Visible    id:first_name-error
    Element Text Should Be    id:first_name-error    ${REQUIREDFIELDS}
    Element Text Should Be    id:last_name-error    ${REQUIREDFIELDS}
    Element Text Should Be    id:password-error    ${REQUIREDFIELDS}
    Element Text Should Be    id:check_agreement-error    ${REQUIREDFIELDS}
    Element Should Contain    xpath://label[contains(text(),'Role')]    Role
    Wait Until Element Is Visible    xpath://label[@for='doctor']
    Wait Until Element Is Visible    xpath://label[@for='patient']
    Select Radio Button    role    3
    Capture Page Screenshot    register-new-doctor-role-{index}.png
    #Click Element    xpath://label[@for='patient']
    #Click Element    xpath://label[@for='female']
    Capture Page Screenshot    register-patient-gender-{index}.png
    Element Should Contain    xpath://label[contains(text(),'Gender')]    Gender
    Wait Until Element Is Visible    xpath://label[contains(text(),'Male')]
    Wait Until Element Is Visible    xpath://label[@for='female']
    Sleep    3
    Select Radio Button    gender
    #Click Element    xpath://label[@for='female']
    Capture Page Screenshot    register-patient-gender-{index}.png
    Click Element    ort

fk appoint type
    LoginKW
    #1st appointment
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    This is the first book appointment
    Input Text    id:patient_notes    with doctor translation fee
    Radio Button Should Be Set To    fk_appoint_type    2
    Click Element    css:.col-8 > .m-radio-inline > .m-radio:nth-child(1) > span
    Radio Button Should Be Set To    fk_appoint_type    1
    Click Button    id:rq_btn
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    5
    LogoutKW

tc02
    [Documentation]    make 3 appointment
    LoginKW
    #1st appointment
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    This is the 1st appointment
    Input Text    id:patient_notes    with doctor translation fee
    Radio Button Should Be Set To    fk_appoint_type    2
    Click Element    xpath://div[6]/label/span
    Click Button    id:rq_btn
    ${url}=    Get Location
    Log to console    ${url}
    Sleep    3
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    3
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Link    /doctors
    #2nd appointment
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    2nd book appointment
    Input Text    id:patient_notes    with out doctor translation fee
    Radio Button Should Be Set To    fk_appoint_type    2
    Click Button    id:rq_btn
    ${url1}=    Get Location
    Log to console    ${url1}
    Sleep    3
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    3
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Link    /doctors
    #3rd appointment
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    3rd book appointment
    Input Text    id:patient_notes    with out doctor translation fee
    Radio Button Should Be Set To    fk_appoint_type    2
    ${url2}=    Get Location
    Log to console    ${url2}
    Click Button    id:rq_btn
    Sleep    3
    Capture Page Screenshot    third-appointment-{index}.png
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    3
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Link    /appointments
    Element Should Be Visible    id:appointmentTable_wrapper
    LogoutKW
    Sleep    3

tc03
    [Documentation]    appointment availability
    LoginKW
    Wait Until Element Is Visible    xpath://div[@class='toast-message']
    Click Element    xpath://div[@class='toast-message']
    Sleep    1
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Click Element    xpath://tr[2]//td[2]//a[1]
    ${url2}=    Get Location
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Go To    ${url2}
    ${url2}    Select Window
    Element Text Should Be    xpath://span[@class='m-badge m-badge--brand m-badge--wide m-appointment-title-btn m-color-status-cancelled']    Cancelled
    Sleep    5
    LogoutKW

*** Keywords ***
Open Testbrowser
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If    '${system}' == 'Linux'    Start Virtual Display    1920    1080
    Open Chrome Browser

Open Chrome Browser
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}
