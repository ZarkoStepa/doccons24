*** Settings ***
Documentation     Test login and and logout with ${USEREMIAL}
...
...
...               Assert and werify all pages with ${USEREMIAL}
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Resource          _mysetup.txt
Resource          _keywords.txt
Library           XvfbRobot

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Login en
    [Tags]    patient.navigate.links
    LoginKW

My appointments
    [Tags]    patient.navigate.links
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Element Text Should Be    xpath://span[contains(text(),'My appointments')]    My appointments
    Click Link    /appointments
    Capture Page Screenshot    patient-appointmentTable_wrapper-{index}.png
    Patient my appointment page

Book an apointment
    [Tags]    patient.navigate.links
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Element Text Should Be    xpath://span[contains(text(),'Book an appointment')]    Book an appointment
    Click Link    /doctors
    Patient Search Doctor page
    Capture Page Screenshot    search-doctor-page-{index}.png

Profile
    [Tags]    patient.navigate.links
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    #Element Text Should Be    xpath://span[contains(text(),'Profile')]    Profile
    Click Link    /profile
    Patient Profile page
    Capture Page Screenshot    patient-profile-page-{index}.png
    Click Element    xpath://a[contains(text(),'Personal info')]
    Patient Profile Info page
    Capture Page Screenshot    profile-info-top-{index}.png
    Scroll Element Into View    xpath://a[contains(text(),'Account info')]
    Wait Until Element Is Visible    xpath://a[contains(text(),'Account info')]
    Click Element    xpath://a[contains(text(),'Account info')]
    Patient Account Info page
    Capture Page Screenshot    account-info-page-{index}.png
    Click Element    xpath://a[contains(text(),'Location')]
    Location page
    Capture Page Screenshot    lodaction-info-page-{index}.png
    Click Element    xpath://a[contains(text(),'Patient Data')]
    Click Element    xpath://a[contains(text(),'Patient documentation')]
    Patient Data page
    Capture Page Screenshot    patient-documentation-page-{index}.png
    Click Element    xpath://a[contains(text(),'Patient Data')]
    Capture Page Screenshot    patient-data-index-{index}.png
    Click Element    xpath://a[contains(text(),'Patient history')]
    Patient History page
    Capture Page Screenshot    patient-history-page-{index}.png
    Click Element    xpath://a[contains(text(),'Change password')]
    Patient Change Password page
    Capture Page Screenshot    pchange-password-page-{index}.png

Wallet
    [Tags]    patient.navigate.links
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Element Text Should Be    xpath://span[contains(text(),'Wallet')]    Wallet
    Click Link    /wallet
    #Wait Until Element Is Visible    id:paymentTable_wrapper
    Capture Page Screenshot    wallet-page-{index}.png
    Patient Wallet page

Reports
    [Tags]    patient.navigate.links
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    id:report_a
    Wait Until Element Is Visible    xpath://span[contains(text(),'Payment report')]
    Wait Until Element Is Visible    xpath://span[contains(text(),'Login history')]
    Element Text Should Be    xpath://span[contains(text(),'Payment report')]    Payment report
    Element Text Should Be    xpath://span[contains(text(),'Login history')]    Login history
    Click Link    /reports/payment
    Capture Page Screenshot    patReports_wrapper-{index}.png
    Patient Payment History page
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /reports/login_history
    Capture Page Screenshot    loginHist_wrapper-{index}.png
    Patient Login History page

Recommendation/Prescription
    [Tags]    patient.navigate.links
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Element Text Should Be    xpath://span[contains(text(),'Recommendation/Prescription')]    Recommendation/Prescription
    Click Element    xpath://span[contains(text(),'Recommendation/Prescription')]
    #Wait Until Element Is Visible    id:mytable_wrapper
    Patient Recommendation/Prescription page
    Capture Page Screenshot    recomendation-prescription-{index}.png

Language
    [Tags]    patient.navigate.links
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    id:languages_a
    Wait Until Element Is Visible    xpath://span[contains(text(),'English')]
    Wait Until Element Is Visible    xpath://span[contains(text(),'German')]
    Wait Until Element Is Visible    xpath://span[contains(text(),'Arabic')]
    Element Text Should Be    xpath://span[contains(text(),'English')]    English
    Element Text Should Be    xpath://span[contains(text(),'German')]    German
    Element Text Should Be    xpath://span[contains(text(),'Arabic')]    Arabic

Help
    [Tags]    patient.navigate.links
    #Click Element    id:m_aside_left_offcanvas_toggle
    Element Text Should Be    xpath://span[contains(text(),'Help')]    Help
    Click Element    xpath://span[contains(text(),'Help')]
    Help page
    Capture Page Screenshot    help-page-{index}.png

System check
    [Tags]    patient.navigate.links
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Element Text Should Be    xpath://span[contains(text(),'System Check')]    System Check
    Click Element    xpath://span[contains(text(),'System Check')]
    Sleep    3
    System Check page
    Capture Page Screenshot    system-check-{index}.png

Logout
    [Tags]    patient.navigate.links
    LogoutKW

*** Keywords ***
