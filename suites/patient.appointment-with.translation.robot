*** Settings ***
Documentation     Test login and logout with ${USEREMAIL}
...
...               Book 3 appointment, 2 should be canceled , and one with tanslation should be paid.
...
...               Show location for all 3 appointements.
...
...               Assert and verify login, logout page, appointment page, delete modal
...
...               doctor language should be selected german and english to show arabic trnalsation fee
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
Patient books 3 appointments - success
    [Documentation]    3x with translation
    [Tags]    patient.appointment2
    LoginKW
    #1st appointment
    Wait Until Element Is Visible    id:rq_btn3
    Click Button    id:rq_btn3
    Capture Page Screenshot    before-input-appointment-{index}.png
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Awaiting Payment
    Input Text    id:patient_notes    This is the 1st appointment with translation fee
    Radio Button Should Be Set To    fk_appoint_type    2
    Radio Button Should Be Set To    translation    0
    Click Element    xpath://div[6]/label/span
    Capture Page Screenshot    before-first-appointment-{index}.png
    Click Element    id:rq_btn
    ${url} =    Get Location
    Log to console    ${url}
    Capture Page Screenshot    first-appointment-{index}.png
    Wait Until Element Is Visible    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Wait Until Element Is Visible    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Wait Until Element Is Not Visible    id:toast-container
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Enabled    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Link    /doctors
    #2nd appointment
    Click Button    id:rq_btn3
    Capture Page Screenshot    before-input-appointment-{index}.png
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Awaiting Payment
    Input Text    id:patient_notes    This is the 2nd appointment with translation fee
    Radio Button Should Be Set To    fk_appoint_type    2
    Radio Button Should Be Set To    translation    0
    Click Element    xpath://div[6]/label/span
    Click Button    id:rq_btn
    ${url1} =    Get Location
    Log to console    ${url1}
    Capture Page Screenshot    second-appointment-{index}.png
    Wait Until Element Is Visible    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Wait Until Element Is Visible    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Wait Until Element Is Not Visible    id:toast-container
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Enabled    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Link    /doctors
    #3rd appointment
    Click Button    id:rq_btn3
    Capture Page Screenshot    before-input-appointment-{index}.png
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Awaiting Payment
    Input Text    id:patient_notes    This is the 3rd appointment with translation fee
    Radio Button Should Be Set To    fk_appoint_type    2
    Radio Button Should Be Set To    translation    0
    Click Element    xpath://div[6]/label/span
    Click Button    id:rq_btn
    ${url2} =    Get Location
    Log to console    ${url2}
    Wait Until Element Is Visible    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Wait Until Element Is Visible    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Capture Page Screenshot    third-appointment-{index}.png
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Wait Until Element Is Not Visible    id:toast-container
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Enabled    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Link    /appointments
    Element Should Be Visible    id:appointmentTable_wrapper
    Capture Page Screenshot    all-appointment-{index}.png
    LogoutKW

The patient sees an appointment in my appointments
    [Tags]    patient.appointment2
    LoginKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Enabled    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Link    /appointments
    Capture Page Screenshot    my-appointments-{index}.png
    Element Should Be Visible    id:appointmentTable
    Capture Page Screenshot    my-appointments-{index}.png
    Wait Until Element Is Visible    xpath://tr[3]//td[3]//a[1]
    Click Element    xpath://tr[3]//td[3]//a[1]
    Capture Page Screenshot    first-appointment-preview-{index}.png
    ${url}    Get Location
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Wait Until Element Is Visible    xpath://tr[2]//td[3]//a[1]
    Click Element    xpath://tr[2]//td[3]//a[1]
    Capture Page Screenshot    second-appointment-preview-{index}.png
    ${url1}    Get Location
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    ${url2}    Get Location
    Capture Page Screenshot    third-appointment-preview-{index}.png
    LogoutKW
    [Teardown]

Patient navigate to appointment
    [Tags]    patient.appointment2
    LoginKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    before-click-my-appointment-{index}.png
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Patient my appointment page
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Capture Page Screenshot    before-click-element-on-appointment-{index}.png
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Capture Page Screenshot    after-click-appointment-{index}.png
    ${url} =    Get Location
    Log to console    ${url}
    Capture Page Screenshot    before-offcanvas-{index}.png
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    before-click-element-on-appointment-{index}.png
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Capture Page Screenshot    before-click-element-on-appointment-{index}.png
    Wait Until Element Is Visible    xpath://tr[2]//td[3]//a[1]
    Click Element    xpath://tr[2]//td[3]//a[1]
    ${url1} =    Get Location
    Log to console    ${url1}
    Capture Page Screenshot    before-offcanvas-{index}.png
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    before-click-element-on-appointment-{index}.png
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Capture Page Screenshot    before-click-element-on-appointment-{index}.png
    Wait Until Element Is Visible    xpath://tr[3]//td[3]//a[1]
    Click Element    xpath://tr[3]//td[3]//a[1]
    ${url2} =    Get Location
    Log to console    ${url2}
    Capture Page Screenshot    before-click-logout-{index}.png
    LogoutKW
    [Teardown]

Patient cancel appointment - canceled appointment has disappeared
    [Tags]    patient.appointment2
    LoginKW
    Capture Page Screenshot    before-click-offcanvas-toggle-{index}.png
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Capture Page Screenshot    before-click-element-on-appointment-{index}.png
    Wait Until Element Is Visible    xpath://tr[2]//td[3]//a[1]
    Click Element    xpath://tr[2]//td[3]//a[1]
    ${url} =    Get Location
    Log to console    ${url}
    Capture Page Screenshot    before-click-button-cancel-{index}.png
    Appointments page
    Click Element    xpath://a[@class='btn btn-danger']
    Sleep    1
    Handle Alert
    Capture Page Screenshot    after-click-button-cancel-{index}.png
    LogoutKW
    [Teardown]

Patient pays one appointment - the status of appointment has changed
    [Tags]    patient.appointment2
    LoginKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Enabled    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Link    /appointments
    Wait Until Element Is Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    ${url2} =    Get Location
    Log to console    ${url2}
    Appointments page
    Capture Page Screenshot    preview-appointment-{index}.png
    Wait Until Element Is Visible    class:m-color-status-awaiting
    Wait Until Element Is Visible    id:ajax_payment
    Click Element    id:ajax_payment
    Wait Until Element Is Visible    class:btn-group8
    Sleep    5
    Wait Until Element Is Not Visible    xpath://span[contains(text(),'Awaiting Payment')]
    Capture Page Screenshot    status-appointment-{index}.png
    LogoutKW
    [Teardown]

*** Keywords ***
