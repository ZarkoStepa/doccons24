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
doctor see appointment in my appointments
    [Documentation]    doctor see all 3 appointment in my appointments
    [Tags]    doctor.appointment2
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:docAppoint_wrapper
    Click Element    xpath://tr[2]//td[2]//a[1]
    Capture Page Screenshot    confirmed-appointment-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Doctor:')]    Doctor:
    Element Text Should Be    xpath://a[contains(text(),'${NEWDOCUSER} ${NEWDOCLASTNAME}')]    ${NEWDOCUSER} ${NEWDOCLASTNAME}
    Element Text Should Be    xpath://label[contains(text(),'Patient:')]    Patient:
    Element Text Should Be    xpath://a[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]    ${NEWUSER} ${NEWLASTNAME}
    Element Text Should Be    xpath://p[contains(text(),'Doctor fee ${INPUTRATE}')]    Doctor fee ${INPUTRATE} € + Arabic Translation fee: ${arabic_fee}.00 €
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://tr[1]//td[2]//a[1]
    Capture Page Screenshot    canceled-appointment-{index}.png
    Element Text Should Be    xpath://a[contains(text(),'${NEWDOCUSER} ${NEWDOCLASTNAME}')]    ${NEWDOCUSER} ${NEWDOCLASTNAME}
    Element Text Should Be    xpath://label[contains(text(),'Patient:')]    Patient:
    Element Text Should Be    xpath://a[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]    ${NEWUSER} ${NEWLASTNAME}
    LogoutKW

doctor navigate to appointment
    [Tags]    doctor.appointment2
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Capture Page Screenshot    doc-appointment-wrapper-{index}.png
    Click Element    xpath://tr[3]//td[2]//a[1]
    Capture Page Screenshot    confirmed-appointment-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Doctor:')]    Doctor:
    Element Text Should Be    xpath://a[contains(text(),'${NEWDOCUSER} ${NEWDOCLASTNAME}')]    ${NEWDOCUSER} ${NEWDOCLASTNAME}
    Element Text Should Be    xpath://label[contains(text(),'Patient:')]    Patient:
    Element Text Should Be    xpath://a[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]    ${NEWUSER} ${NEWLASTNAME}
    Sleep    1
    Element Text Should Be    xpath://a[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]    ${NEWUSER} ${NEWLASTNAME}
    Element Text Should Be    xpath://p[contains(text(),'Doctor fee ${INPUTRATE}')]    Doctor fee ${INPUTRATE} € + Arabic Translation fee: ${arabic_fee}.00 €
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
