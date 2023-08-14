*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           String
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Create a clinic - success
    [Tags]    admin.create.clinic
    LoginAdminKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    class:m-menu__link-text
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Browse hospitals')]
    Capture Page Screenshot    click-browse-hospital-{index}.png
    Wait Until Element Is Visible    xpath://span[contains(text(),'Add new hospital')]
    Click Element    xpath://span[contains(text(),'Add new hospital')]
    Capture Page Screenshot    click-add-new-hospital-{index}.png
    Admin New Hospital page
    Capture Page Screenshot    before-input-credentials-hospital-{index}.png
    ${create_clinic} =    Generate Random String    5    [UPPER]
    ${create_clinic} =    Set Variable    ${create_clinic}
    Set Suite Variable    ${create_clinic}
    Input Text    id:inputClinicName    ${create_clinic} ${CLINICNAME}
    Input Text    id:inputAboutClinic    ${ABOUTCLINIC}
    Input Text    id:inputStreet    ${ADRESS}
    Input Text    id:inputCity    ${CITY}
    Input Text    id:inputState    ${COUNTRY}
    Input Text    id:inputZipCode    ${ZIP}
    Capture Page Screenshot    Only-latin-characters-{index}.png
    Click Element    id:selectCountry
    Capture Page Screenshot    click-country-dropdown-list-{index}.png
    Click Element    xpath://option[contains(text(),'Germany')]
    Capture Page Screenshot    select-country-{index}.png
    Click Element    id:selectRequested
    Capture Page Screenshot    click-requested-dropdown-list-{index}.png
    Click Element    xpath://select[@id='selectRequested']//option[contains(text(),'${ADMINNAME} ${ADMINLASTNAME}')]
    Capture Page Screenshot    select-admin-{index}.png
    Click Element    id:selectAdded
    #Click Element    xpath://select[@id='selectAdded']//option[contains(text(),'${ADMINNAME} ${ADMINLASTNAME}')]
    Capture Page Screenshot    before-save-hospital-{index}.png
    Click Element    xpath://button[@class='btn btn-primary']
    Capture Page Screenshot    after-save-hospital-{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}

Admin clinic activation
    [Tags]    admin.create.clinic
    Admin Clinic Activation page
    Capture Page Screenshot    before-activate-hospital-{index}.png
    Click Element    xpath://label[contains(.,'Activated')]
    Capture Page Screenshot    after-activate-hospital-{index}.png
    Scroll Element Into View    xpath://button[@class='btn btn-primary']
    Click Element    xpath://button[@class='btn btn-primary']
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    save-activated-hospital-{index}.png
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'All hospitals')]
    Click Element    xpath://span[contains(text(),'All hospitals')]
    All Hospitals page
    Hospital Actions

Delete clinic
    [Tags]    admin.create.clinic
    [Setup]
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${create_clinic} ${CLINICNAME}
    Capture Page Screenshot    input-clicnic-name-{index}.png
    Click Element    xpath://div[1]/table[1]/tbody[1]/tr[1]/td[7]/a[2]
    Capture Page Screenshot    click-delete-button-{index}.png
    Hospital modal delete page
    Click Element    xpath://button[@class='btn btn-primary']
    Capture Page Screenshot    after-derlete-hospital-{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW

*** Keywords ***
