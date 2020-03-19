*** Settings ***
Documentation     Test login and and logout with ${DOCEMAIL}
...
...               Assert and werify all pages with ${DOCEMAIL}
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Login en
    [Tags]    doctor.navigate.all.links
    LoginDocKW

Personal Info
    [Tags]    doctor.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Personal info')]
    Personal Info page
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Account info')]
    Account Info page
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Location')]
    Location page
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Qualifications')]
    Doctor Qualification page
    #Click Element    xpath://div[@class='col-2']//a[@class='btn btn-primary m-btn m-btn--icon m-btn--icon-only']
    #Doctor New Hospital modal
    #Click Button    xpath://button[@class='btn btn-secondary']
    Sleep    1
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Working days')]
    Working Days page
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Payment info')]
    Payment Info page
    Click Element    xpath://a[contains(text(),'Change password')]
    Change Password page
    Capture Page Screenshot    doctor-change-pass-{index}.png

My appointments
    [Tags]    doctor.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'My appointments')]
    Doctor My Appointment page

Wallet
    [Tags]    doctor.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    side-bar-{index}.png
    Click Element    xpath://span[contains(text(),'Wallet')]
    Element Should Be Visible    xpath://h1[contains(text(),'Your Balance')]
    Capture Page Screenshot    your-balance-{index}.png

Reports
    [Tags]    doctor.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    sidemenu-reports-{index}.png
    Click Element    id:report_a
    Capture Page Screenshot    sidemenu-accoutning-report-{index}.png
    Click Element    xpath://span[contains(text(),'Accounting report')]
    Capture Page Screenshot    doctor-accoutning-report-page-{index}.png
    Doctor Accoutning Reports page
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    sidemenu-reports-{index}.png
    Click Element    xpath://span[contains(text(),'Payment report')]
    Capture Page Screenshot    payment-report-{index}.png
    Doctor Payment Report page
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    reports-sidemenu-{index}.png
    Click Element    xpath://span[contains(text(),'Login history')]
    Doctor Login History page

Write
    [Tags]    doctor.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://a[contains(@class,'m-menu__link m-menu__toggle')]//span[contains(@class,'m-menu__link-text')][contains(text(),'Write...')]
    Click Element    xpath://span[contains(@class,'m-menu__link-text')][contains(text(),'Recommendation/Prescription')]
    Capture Page Screenshot    recommendation-page-{index}.png
    Wait Until Element Is Visible    xpath://h4[contains(@class,'display-5')]
    #page
    Element Text Should Be    xpath://h4[contains(@class,'display-5')]    Recommendation/Prescription
    Element Should Be Visible    xpath://h4[contains(@class,'display-5')]
    Wait Until Element Is Visible    id:addrecommendation
    Element Should Be Enabled    id:addrecommendation
    Element Should Be Visible    id:addrecommendation
    Element Text Should Be    id:addrecommendation    Add Recommendation/Prescription
    Click Element    id:addrecommendation
    Add Recommendation/Prescription modal dialog
    Click Element    xpath://div[@id='newModal']//button[contains(@class,'close')][contains(text(),'×')]
    Sleep    2

Languages
    [Tags]    doctor.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    2
    Click Element    xpath://a[@id='languages_a']//span[@class='m-menu__link-text'][contains(text(),'Languages')]
    Capture Page Screenshot    languages-{index}.png
    Element Should Be Visible    xpath://span[contains(text(),'English')]
    Element Text Should Be    xpath://span[contains(text(),'English')]    English
    Element Should Be Visible    xpath://span[contains(text(),'German')]
    Element Text Should Be    xpath://span[contains(text(),'German')]    German
    Element Should Be Visible    xpath://span[contains(text(),'Arabic')]
    Element Text Should Be    xpath://span[contains(text(),'Arabic')]    Arabic

Help
    [Tags]    doctor.navigate.all.links
    #Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Help')]
    Click Element    xpath://span[contains(text(),'Help')]
    Help page

System Check
    [Tags]    doctor.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    2
    Click Element    xpath://span[contains(text(),'System Check')]
    Sleep    5
    System Check page

Logout
    [Tags]    doctor.navigate.all.links
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
