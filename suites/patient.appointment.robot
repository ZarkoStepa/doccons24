*** Settings ***
Documentation     Test login and logout with ${USEREMAIL}
...
...               Book 3 appointment, 2 should be canceled , and one without tanslation should be paid.
...
...               Show location for all 3 appointements.
...
...               Assert and verify login, logout page, appointment page, video session page
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt
Library           DateTime
Library           String

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
patient books 3 appointments - success
    [Tags]    patient.appointment
    LoginKW
    #First appointment
    Sleep    3
    Scroll Element Into View    id:rq_btn3
    Capture Page Screenshot    go-to-rq_btn3-{index}.png
    Sleep    2
    Click Button    id:rq_btn3
    Capture Page Screenshot    after-click-rq_btn3-button-{index}.png
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Awaiting Payment
    Input Text    id:patient_notes    This is my 1st appointment
    Radio Button Should Be Set To    fk_appoint_type    2
    #Select Radio Button    fk_appoint_type    1
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
    Sleep    3
    Click Element    id:m_aside_left_offcanvas_toggle
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
    #Select Radio Button    fk_appoint_type    1
    #@to do    https://trello.com/c/Tk6Q26D0
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
    Sleep    4
    Click Element    id:m_aside_left_offcanvas_toggle
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
    LogoutKW

patient see appointment in my appointments
    [Tags]    patient.appointment
    LoginKW
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
    Sleep    1
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
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
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://tr[2]//td[2]//a[1]
    Capture Page Screenshot    second-appointment-preview-{index}.png
    ${url1}    Get Location
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://tr[1]//td[2]//a[1]
    ${url2}    Get Location
    Capture Page Screenshot    third-appointment-preview-{index}.png
    LogoutKW

patient navigate to appointment
    [Tags]    patient.appointment
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
    Click Element    xpath://tr[3]//td[2]//a[1]
    Capture Page Screenshot    first-appointment-{index}.png
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

patient cancel appointment - canceled appointment has disappeard
    [Tags]    patient.appointment
    LoginKW
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
    Sleep    1
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Click Element    xpath://tr[2]//td[2]//a[1]
    ${url1}    Select Window
    Capture Page Screenshot    preview-appointment-{index}.png
    Click Element    xpath://a[@class='btn btn-danger']
    Sleep    1
    Handle Alert
    Capture Page Screenshot    patient-after-canceling-appointment-{index}.png
    Sleep    3
    Element Text Should Be    xpath://span[@class='m-badge m-badge--brand m-badge--wide m-appointment-title-btn m-color-status-cancelled']    Cancelled
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Wait Until Element Is Visible    id:appointmentTable_wrapper
    Capture Page Screenshot    canceled-appointment-{index}.png
    Sleep    2
    LogoutKW

patient pays one appointment - status of appointment has changed
    [Tags]    patient.appointment
    LoginKW
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
    Sleep    1
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
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
    Capture Page Screenshot    status-appointment-{index}.png
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
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
