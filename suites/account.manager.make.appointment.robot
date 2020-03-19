*** Settings ***
Documentation     Login test with ${MANEMAIL} , book appointment , pay appointment
...               Login test with ${USEREMAIL} , see appointment
...               Login test with ${DOCEMAIL}, see appointment
...               Assert and verify pages
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Library           String
Resource          _keywords.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Login
    [Tags]    account.manager.make.appointment
    LoginManagerKW

Account manager Book Appointment
    [Tags]    account.manager.make.appointment
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    open-sidebar-menu-{index}.png
    Click Element    xpath://span[contains(text(),'Book an appointment')]
    Capture Page Screenshot    click-on-book-an-appointment-{index}.png
    Sleep    2
    Wait Until Element Is Visible    xpath://button[@id='rq_btn3']
    Click Element    xpath://button[@id='rq_btn3']
    Element Should Be Visible    xpath://div[contains(text(),'Select Patient:')]
    Element Text Should Be    xpath://div[contains(text(),'Select Patient:')]    Select Patient:
    Element Should Be Visible    xpath://div[contains(text(),'Appointment title')]
    Element Text Should Be    xpath://div[contains(text(),'Appointment title')]    Appointment title
    Element Should Be Visible    xpath://div[contains(text(),'Symptoms')]
    Element Text Should Be    xpath://div[contains(text(),'Symptoms')]    Symptoms
    Element Should Be Visible    xpath://div[contains(text(),'Notes by Patient')]
    Element Text Should Be    xpath://div[contains(text(),'Notes by Patient')]    Notes by Patient
    Element Should Be Visible    xpath://div[contains(text(),'Appontment type')]
    Element Text Should Be    xpath://div[contains(text(),'Appontment type')]    Appontment type
    Element Should Be Visible    xpath://div[contains(text(),'Translation')]
    Element Text Should Be    xpath://div[contains(text(),'Translation')]    Translation
    Element Should Be Visible    xpath://div[contains(text(),'None')]
    Element Text Should Be    xpath://div[contains(text(),'None')]    None
    Element Should Be Visible    xpath://div[contains(text(),'Arabic')]
    Element Text Should Be    xpath://div[contains(text(),'Arabic')]    Arabic
    Element Should Be Visible    xpath://span[contains(text(),'Session fee:')]
    Element Text Should Be    xpath://span[contains(text(),'Session fee:')]    Session fee:
    Element Should Be Visible    xpath://div[contains(text(),'Select date')]
    Element Text Should Be    xpath://div[contains(text(),'Select date')]    Select date
    Element Should Be Visible    xpath://div[@class='col-2']
    Element Text Should Be    xpath://div[@class='col-2']    Time-slots
    Element Should Be Visible    xpath://button[@id='rq_btn']
    Element Should Be Visible    xpath://button[@class='btn btn-danger m-btn m-btn--custom']
    Element Should Be Enabled    xpath://button[@id='rq_btn']
    Element Should Be Enabled    xpath://button[@class='btn btn-danger m-btn m-btn--custom']
    Click Element    id:patient_account_manager
    Capture Page Screenshot    after-click-book-appoitnment-button-{index}.png
    Click Element    id:3
    #Click Element    xpath://span[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]
    Capture Page Screenshot    select-patient-{index}.png
    Click Element    id:reason
    Capture Page Screenshot    click-id-reason-{index}.png
    Click Element    xpath://option[contains(text(),'Advice regarding operation')]
    Capture Page Screenshot    select-advice-regarding-operation-{index}.png
    Input Text    id:patient_notes    Account manager fill this text area
    Capture Page Screenshot    input-text-in-patient-notes-{index}.png
    Sleep    3
    Click Element    xpath://form[1]/div[1]/div[5]/div[3]/div[1]/label[1]
    Capture Page Screenshot    select-radio-button-physical-appearance-{index}.png
    Click Element    id:rq_btn
    Capture Page Screenshot    after-click-book-appoitnment-button-{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    before-payment-{index}.png
    Click Element    xpath://div[@class='toast-message']
    Click Element    css:#ajax_payment
    Capture Page Screenshot    after-click-pay-now-button-{index}.png
    Sleep    2
    ${url} =    Get Location
    Log to console    ${url}
    LogoutKW

Patient go to appointment
    [Tags]    account.manager.make.appointment
    LoginKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Patient my appointment page
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Capture Page Screenshot    after-click-confirmed-appointment-button-{index}.png
    Click Element    xpath://tbody[1]/tr[1]/td[2]/a[1]
    Capture Page Screenshot    click-on-appoitnment-{index}.png
    ${url} =    Get Location
    Log to console    ${url}
    LogoutKW

Doctor go to appointment
    [Tags]    account.manager.make.appointment
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Doctor my appointment page
    Click Element    xpath://a[contains(text(),'Confirmed')]
    Capture Page Screenshot    click-confirmed-appoitnment-button-{index}.png
    Click Element    xpath://tbody[1]/tr[1]/td[2]/a[1]
    ${url} =    Get Location
    Log to console    ${url}
    LogoutKW

*** Keywords ***
