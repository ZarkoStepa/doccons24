*** Settings ***
Documentation     Test login and logout with ${DOCEMAIL}
...
...               Assert and werify appoitnment page
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _keywords.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Doctor see appointment in my appointments
    [Documentation]    doctor see all 3 appointment in my appointments
    [Tags]    doctor.appointment2
    LoginDocKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Wait Until Element Is Visible    xpath://tr[2]//td[3]//a[1]
    Click Element    xpath://tr[2]//td[3]//a[1]
    Capture Page Screenshot    confirmed-appointment-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Doctor:')]    Doctor:
    Element Text Should Be    xpath://a[contains(text(),'${NEWDOCUSER} ${NEWDOCLASTNAME}')]    ${NEWDOCUSER} ${NEWDOCLASTNAME}
    Element Text Should Be    xpath://label[contains(text(),'Patient:')]    Patient:
    Element Text Should Be    xpath://a[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]    ${NEWUSER} ${NEWLASTNAME}
    Element Text Should Be    xpath://p[contains(text(),'Doctor fee ${INPUTRATE}')]    Doctor fee ${INPUTRATE} € + Arabic Translation fee: ${arabic_fee}.00 €
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Enabled    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Wait Until Element Is Enabled    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Wait Until Element Is Visible    xpath://tr[2]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Capture Page Screenshot    canceled-appointment-{index}.png
    Element Text Should Be    xpath://a[contains(text(),'${NEWDOCUSER} ${NEWDOCLASTNAME}')]    ${NEWDOCUSER} ${NEWDOCLASTNAME}
    Element Text Should Be    xpath://label[contains(text(),'Patient:')]    Patient:
    Element Text Should Be    xpath://a[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]    ${NEWUSER} ${NEWLASTNAME}
    Element Text Should Be    xpath://p[contains(text(),'Doctor fee ${INPUTRATE}')]    Doctor fee ${INPUTRATE} € + Arabic Translation fee: ${arabic_fee}.00 €
    LogoutKW

Doctor navigate to appointment
    [Tags]    doctor.appointment2
    LoginDocKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Capture Page Screenshot    doc-appointment-wrapper-{index}.png
    Wait Until Element Is Visible    xpath://tr[3]//td[3]//a[1]
    Click Element    xpath://tr[3]//td[3]//a[1]
    Capture Page Screenshot    confirmed-appointment-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Doctor:')]    Doctor:
    Element Text Should Be    xpath://a[contains(text(),'${NEWDOCUSER} ${NEWDOCLASTNAME}')]    ${NEWDOCUSER} ${NEWDOCLASTNAME}
    Element Text Should Be    xpath://label[contains(text(),'Patient:')]    Patient:
    Element Text Should Be    xpath://a[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]    ${NEWUSER} ${NEWLASTNAME}
    Element Text Should Be    xpath://label[contains(text(),'Fees:')]    Fees:
    Element Text Should Be    xpath://p[contains(text(),'Doctor fee ${INPUTRATE}')]    Doctor fee ${INPUTRATE} € + Arabic Translation fee: ${arabic_fee}.00 €
    LogoutKW
