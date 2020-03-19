*** Settings ***
Documentation     Test login and logout with ${USEREMAIL}
...
...               Book 3 appointment, 2 should be canceled , and one with tanslation should be paid.
...
...               Show location for all 3 appointements.
...
...               Assert and verify login, logout page, appointment page, delete modal
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
    [Documentation]    3x with translation
    [Tags]    patient.appointment2
    LoginKW
    #1st appointment
    Click Button    id:rq_btn3
    Capture Page Screenshot    before-input-appointment-{index}.png
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    This is the 1st \ book appointment
    Input Text    id:patient_notes    with doctor translation fee
    Radio Button Should Be Set To    fk_appoint_type    2
    Click Element    xpath://div[6]/label/span
    Capture Page Screenshot    before-first-appointment-{index}.png
    Click Button    id:rq_btn
    ${url} =    Get Location
    Log to console    ${url}
    Capture Page Screenshot    first-appointment-{index}.png
    Sleep    3
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    3
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Link    /doctors
    #2nd appointment
    Click Button    id:rq_btn3
    Capture Page Screenshot    before-input-appointment-{index}.png
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    2nd book appointment
    Input Text    id:patient_notes    with doctor translation fee
    Radio Button Should Be Set To    fk_appoint_type    2
    Click Element    xpath://div[6]/label/span
    Click Button    id:rq_btn
    ${url1} =    Get Location
    Log to console    ${url1}
    Capture Page Screenshot    second-appointment-{index}.png
    Sleep    3
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    3
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Book an appointment')]
    Click Link    /doctors
    #3rd appointment
    Click Button    id:rq_btn3
    Capture Page Screenshot    before-input-appointment-{index}.png
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    3rd book appointment
    Input Text    id:patient_notes    with doctor translation fee
    Radio Button Should Be Set To    fk_appoint_type    2
    Click Element    xpath://div[6]/label/span
    Click Button    id:rq_btn
    ${url2} =    Get Location
    Log to console    ${url2}
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

patient see appointment in my appointments
    [Tags]    patient.appointment2
    LoginKW
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
    Sleep    1
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Capture Page Screenshot    my-appointments-{index}.png
    Element Should Be Visible    id:appointmentTable
    LogoutKW
    [Teardown]

patient navigate to appointment
    [Tags]    patient.appointment2
    LoginKW
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
    Sleep    1
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    before-click-my-appointment-{index}.png
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Patient my appointment page
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Capture Page Screenshot    before-click-element-on-appointment-{index}.png
    Click Element    xpath://tr[1]//td[2]//a[1]
    Capture Page Screenshot    after-click-appointment-{index}.png
    ${url} =    Get Location
    Log to console    ${url}
    Sleep    1
    Capture Page Screenshot    before-offcanvas-{index}.png
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Capture Page Screenshot    before-click-element-on-appointment-{index}.png
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Capture Page Screenshot    before-click-element-on-appointment-{index}.png
    Click Element    xpath://tr[2]//td[2]//a[1]
    ${url1} =    Get Location
    Log to console    ${url1}
    Capture Page Screenshot    before-offcanvas-{index}.png
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Capture Page Screenshot    before-click-element-on-appointment-{index}.png
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Capture Page Screenshot    before-click-element-on-appointment-{index}.png
    Click Element    xpath://tr[3]//td[2]//a[1]
    ${url2} =    Get Location
    Log to console    ${url2}
    Capture Page Screenshot    before-click-logout-{index}.png
    LogoutKW
    [Teardown]

patient cancel appointment; canceled appointment has disappeard
    [Tags]    patient.appointment2
    LoginKW
    Capture Page Screenshot    before-click-offcanvas-toggle-{index}.png
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
    Sleep    1
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Capture Page Screenshot    before-click-element-on-appointment-{index}.png
    Click Element    xpath://tr[2]//td[2]//a[1]
    ${url} =    Get Location
    Log to console    ${url}
    Capture Page Screenshot    before-click-button-cancel-{index}.png
    Sleep    1
    Click Element    xpath://a[@class='btn btn-danger']
    Sleep    1
    Handle Alert
    Capture Page Screenshot    after-click-button-cancel-{index}.png
    LogoutKW
    [Teardown]

patient pays one appointment; status of appointment has changed
    [Tags]    patient.appointment2
    LoginKW
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
    Capture Page Screenshot    before-click-offcanvas-toggle-{index}.png
    Sleep    1
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Element Should Be Visible    id:appointmentTable
    Click Element    xpath://tr[1]//td[2]//a[1]
    ${url2} =    Get Location
    Log to console    ${url2}
    Sleep    2
    Capture Page Screenshot    before-click-ajax_payment-{index}.png
    Click Element    id:ajax_payment
    Sleep    2
    Capture Page Screenshot    after-click-ajax_payment-{index}.png
    Sleep    2
    Capture Page Screenshot    status-appointment-{index}.png
    #Wait Until Element Is Visible    xpath://div[@class='toast-message']
    #Click Element    xpath://div[@class='toast-message']
    LogoutKW
    [Teardown]

*** Keywords ***
