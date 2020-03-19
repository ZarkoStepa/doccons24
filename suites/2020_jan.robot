*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Resource          _mysetup.txt
Library           XvfbRobot
Library           String

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
patient books 3 appointments - success
    [Tags]    test
    LoginKW
    #First appointment
    Sleep    3
    Capture Page Screenshot    rq_btn3-button-{index}.png
    Click Element    class:toast-close-button
    Scroll Element Into View    id:rq_btn3
    Capture Page Screenshot    capture-rq_btn3-button-{index}.png
    Sleep    2
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Awaiting Payment
    Input Text    id:patient_notes    This is my 1st appointment
    Radio Button Should Be Set To    fk_appoint_type    2
    Radio Button Should Be Set To    translation    0
    Click Element    xpath://div[@class='form-group m-form__group row']//label[1]
    Scroll Element Into View    id:rq_btn
    Capture Page Screenshot    time-slot-{index}.png
    Click Button    id:rq_btn
    ${url}=    Get Location
    Log to console    ${url}
    Sleep    2
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Link    /doctors
    #2nd book appointment
    Sleep    3
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Cancelled
    Input Text    id:patient_notes    This is my 2nd appointment
    Radio Button Should Be Set To    fk_appoint_type    2
    Radio Button Should Be Set To    translation    0
    Click Element    xpath://div[@class='form-group m-form__group row']//label[1]
    Scroll Element Into View    id:rq_btn
    Capture Page Screenshot    time-slot-{index}.png
    Click Button    id:rq_btn
    ${url1}=    Get Location
    Log to console    ${url1}
    Sleep    2
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Link    /doctors
    Sleep    3
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Confirmed
    Input Text    id:patient_notes    This is my 3rd appointment
    Radio Button Should Be Set To    fk_appoint_type    2
    Radio Button Should Be Set To    translation    0
    Click Element    xpath://div[@class='form-group m-form__group row']//label[1]
    Scroll Element Into View    id:rq_btn
    Capture Page Screenshot    time-slot-{index}.png
    Click Button    id:rq_btn
    ${url2}=    Get Location
    Log to console    ${url2}
    Sleep    2
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    3
    Click Link    /logout

patient see appointment in my appointments
    [Tags]    test
    LoginKW
    Click Element    class:toast-close-button
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Wait Until Page Contains Element    id:appointmentTable_wrapper
    Capture Page Screenshot    my-appointments-{index}.png
    Get All Links
    Click Element    xpath://tr[3]//td[2]//a[1]
    Capture Page Screenshot    first-appointment-preview-{index}.png
    ${url}    Get Location
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://tr[2]//td[2]//a[1]
    Capture Page Screenshot    second-appointment-preview-{index}.png
    ${url1}    Get Location
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://tr[1]//td[2]//a[1]
    ${url2}    Get Location
    Capture Page Screenshot    third-appointment-preview-{index}.png
    Click Link    /logout

patient navigate to appointment
    [Tags]    test
    LoginKW
    Click Element    class:toast-close-button
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Click Element    xpath://tr[3]//td[2]//a[1]
    Capture Page Screenshot    first-appointment-{index}.png
    ${url}=    Get Location
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Go To    ${url}
    Element Text Should Be    xpath://span[@class='m-badge m-badge--brand m-badge--wide m-appointment-title-btn m-color-status-awaiting']    Awaiting Payment
    Click Link    /logout

patient cancel appointment - canceled appointment has disappeard
    [Tags]    test
    LoginKW
    Sleep    1
    Click Element    class:toast-close-button
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Click Element    xpath://tr[2]//td[2]//a[1]
    ${url1}    Select Window
    Capture Page Screenshot    preview-appointment-{index}.png
    Click Element    xpath://a[@class='btn btn-danger']
    Capture Page Screenshot    patient-after-canceling-appointment-{index}.png
    Sleep    3
    Element Text Should Be    xpath://span[@class='m-badge m-badge--brand m-badge--wide m-appointment-title-btn m-color-status-cancelled']    Cancelled
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Wait Until Element Is Visible    id:appointmentTable_wrapper
    Capture Page Screenshot    canceled-appointment-{index}.png
    Sleep    2
    Click Link    /logout

patient pays one appointment - status of appointment has changed
    [Tags]    test
    LoginKW
    Sleep    1
    Click Element    class:toast-close-button
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Click Element    xpath://tr[1]//td[2]//a[1]
    ${url2}    Select Window
    Capture Page Screenshot    preview-appointment-{index}.png
    Sleep    2
    Click Element    id:ajax_payment
    Sleep    3
    Capture Page Screenshot    status-appointment-{index}.png
    Click Link    /logout

*** Keywords ***
LoginKW
    GoTo    ${TESTURL}
    Capture Page Screenshot    loginkw-goto-{index}.png
    Clear Element Text    name:email
    Input Text    name:email    ${USEREMAIL}
    Capture Page Screenshot    loginkw-email-{index}.png
    Clear Element Text    name:password
    Input Password    name:password    ${USERPW}
    Capture Page Screenshot    loginkw-password-{index}.png
    Click Element    xpath://label[@for='checkbox1']
    Capture Page Screenshot    loginkw-checkbox-{index}.png
    Submit Form
    Capture Page Screenshot    loginkw-after-submit-{index}.png
    Log    The patient has successfully logged in

Open Testbrowser
    ${system}=    Evaluate    platform.system()    platform
    #Run Keyword If    '${system}' == 'Linux'    Start Virtual Display    2560    1440
    Run Keyword If    '${system}' == 'Linux'    Start Virtual Display    1600    900
    Open Chrome Browser

Open Chrome Browser
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}
