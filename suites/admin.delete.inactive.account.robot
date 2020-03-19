*** Settings ***
Documentation     Test registration and logout with ${random_email} succes
...
...               Test login and logout with ${ADMIN} delete not activated user
...
...               Create new user ${randomemail}
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           String
Library           XvfbRobot
Resource          _keywords.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Delete inactive user - success
    [Tags]    admin.delete.inactive.account
    [Setup]    Register doctor user - success
    LoginAdminKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'Not confirmed')]
    Sleep    1
    Capture Page Screenshot    before-delete-doctor-user-{index}.png
    Click Element    xpath://table[1]/tbody[1]/tr[1]/td[6]/a[3]
    Capture Page Screenshot    delete-modal-{index}.png
    Sleep    1
    Click Element    id:footer_action_button2
    Capture Page Screenshot    after-delete-doctor-user-{index}.png
    Sleep    1
    LogoutKW
    [Teardown]

*** Keywords ***
