*** Settings ***
Documentation     Test login and logout with ${DOCEMAIL} create ${CLINICNAME}
...
...               Test login and logout with ${EMAIL} activate ${CLINICNAME}
...
...               Test login and logout with ${USER} search for Hospital
...
...               Test delete clinic sucess with ${EMAIL}
...
...               Assert and verify login, new clinic modal, activation clinic, delete modal page.
...
...               Assert and verify login page for each user and clinic data.
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Library           String
Resource          _mysetup.txt
Resource          _keywords.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
create clinic - success
    [Tags]    create.clinic
    LoginDocKW
    Capture Page Screenshot    doctor-create-clinic-goto-{index}.png
    Click Element    xpath://a[contains(text(),'Qualifications')]
    Sleep    1
    Capture Page Screenshot    qualification-page-{index}.png
    Click Element    css:.form-group:nth-child(6) .m-radio:nth-child(1) > span
    Capture Page Screenshot    enable-add-clicnic-{index}.png
    Sleep    1
    Click Element    css:.col-2 > .btn
    Sleep    1
    Capture Page Screenshot    open-modal-dialog-clinic-{index}.png
    Doctor New Hospital modal
    ${create_clinic} =    Generate Random String    4    [UPPER]
    ${create_clinic} =    Set Variable    ${create_clinic}
    Set Suite Variable    ${create_clinic}
    Input Text    id:input1    ${create_clinic} ${CLINICNAME}
    Input Text    id:input2    ${ABOUTCLINIC}
    Input Text    id:input3    ${ADRESS}
    Input Text    id:input4    ${CITY}
    Input Text    id:input5    ${COUNTRY}
    Input Text    id:input6    ${ZIP}
    Click Element    xpath://span[contains(.,'Please choose')]
    Click Element    xpath://select[@id='input7']//option[contains(text(),'Germany')]
    Capture Page Screenshot    after-input-all-fields-{index}.png
    Click Button    xpath://button[@class='btn btn-primary']
    ${alert-warrning} =    Get Text    class:alert-warning
    Log To Console    ${alert-warrning}
    Capture Page Screenshot    alert-message-{index}.png
    LogoutKW

admin clinic activation
    [Tags]    create.clinic
    LoginAdminKW
    Capture Page Screenshot    activate-clinic-goto-{index}.png
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    2
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Browse hospitals')]
    Capture Page Screenshot    browse-hospitals-{index}.png
    Sleep    1
    Click Element    xpath://span[contains(text(),'All hospitals')]
    Capture Page Screenshot    all-hospitals-{index}.png
    Sleep    1
    Click Element    xpath://label[contains(text(),'Search:')]//input
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${create_clinic} ${CLINICNAME}
    Capture Page Screenshot    filter-hospitals-{index}.png
    Sleep    3
    Hospital Actions
    Sleep    2
    Click Element    xpath://tr[@class='odd']//a[@class='btn btn-success m-btn m-btn--icon m-btn--icon-only']
    Admin Clinic Activation page
    Click Element    xpath://label[contains(.,'Activated')]
    Click Element    xpath://button[@class='btn btn-primary']
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Sleep    2
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'All hospitals')]
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${create_clinic} ${CLINICNAME}
    Element Text Should Be    xpath://td[1]    ${create_clinic} ${CLINICNAME}
    Element Text Should Be    xpath://td[2]    Active
    Element Text Should Be    xpath://td[3]    ${ADRESS}
    Element Text Should Be    xpath://td[4]    ${CITY}
    Element Text Should Be    xpath://td[5]    ${DOCEMAIL}
    All Hospitals page
    Hospital Actions
    LogoutKW

search doctor by clinic
    [Tags]    create.clinic
    LoginKW
    Click Element    xpath://div[@class='m-radio-inline']/label[2]
    Click Element    xpath://button[@class='btn btn-primary']
    Sleep    1
    Capture Page Screenshot    result-search-clinic-{index}.png
    Wait Until Element Is Visible    xpath://div[@class='m-widget19__info m--padding-left-0']
    Element Text Should Be    xpath://span[@class='m-widget19__number m--font-brand']    1
    Click Element    xpath://div[@class='m-widget19__info m--padding-left-0']
    Capture Page Screenshot    image-{index}.png
    Element Text Should Be    xpath://h3[@class='m-subheader__title m-subheader__title--separator m-pageheading']    Clinic: ${create_clinic} ${CLINICNAME}
    LogoutKW

doctor deselect clinic - success
    [Tags]    create.clinic
    [Setup]
    LoginDocKW
    Click Element    id:qua
    Scroll Element Into View    xpath://div[@class='col-8']//div//i[@class='la la-close']
    Capture Page Screenshot    before-set-No-hospital-{index}.png
    Click Element    xpath://form[1]/div[1]/div[6]/div[1]/div[1]/label[2]/span[1]
    Capture Page Screenshot    after-set-No-hospital-{index}.png
    Click Element    xpath://div[@class='col-8']//div//i[@class='la la-close']
    Click Element    id:qualification-submit-btn
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW

admin delete clinic
    [Tags]    create.clinic
    LoginAdminKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Browse hospitals')]
    Click Element    xpath://span[contains(text(),'All hospitals')]
    All Hospitals page
    Wait Until Element Is Enabled    xpath://div[1]/table[1]/tbody[1]/tr[1]/td[7]/a[2]
    Click Element    xpath://div[1]/table[1]/tbody[1]/tr[1]/td[7]/a[2]
    Hospital modal delete page
    Click Element    xpath://button[@class='btn btn-primary']
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    after-delete-hospital-{index}.png
    Wait Until Element Is Visible    xpath://div[@class='alert alert-danger']
    Element Text Should Be    xpath://div[@class='alert alert-danger']    No Hospital found.
    LogoutKW
    [Teardown]

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
