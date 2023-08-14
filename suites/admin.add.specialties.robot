*** Settings ***
Documentation     Test login and logout with ${ADMIN} add specialities sucess and fail,
...
...               Assert and verify login page, specialities page, add new specialties modal, delete specialties modal dialog
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Resource          _keywords.txt
Resource          _mysetup.txt
Library           XvfbRobot

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Create Specialties - success
    [Tags]    admin.add.speciality
    LoginAdminKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Doctors')]
    Sleep    1
    Click Element    xpath://span[contains(text(),'Specialties')]
    Specialties page
    Click Element    xpath://button[@class='btn btn-success']
    Admin Add new speciality
    Input Text    name:name    ${name_cert}
    Input Text    id=message-text    ${cert_decription}
    Input Text    name=de_name    ${name_cert}
    Input Text    name=de_description    ${cert_decription}
    Input Text    name=ar_name    ${name_cert}
    Input Text    name=ar_description    ${cert_decription}
    Capture Page Screenshot    admin-add-speciality-{index}.png
    Click Element    xpath://button[contains(text(),'Save')]
    #Element Text Should Be    css:.alert    ×
    Element Text Should Be    xpath://button[contains(text(),'×')]    ×
    Capture Page Screenshot    admin-create-specialties-sucessfuly-{index}.png
    Sleep    2
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}

Create Specialties - fail
    [Tags]    admin.add.speciality
    Click Element    xpath://button[@class='btn btn-success']
    Admin Add new speciality
    Input Text    name:name    ${name_cert}
    Input Text    id=message-text    ${cert_decription}
    Input Text    name=de_name    ${name_cert}
    Input Text    name=de_description    ${cert_decription}
    Input Text    name=ar_name    ${name_cert}
    Input Text    name=ar_description    ${cert_decription}
    Capture Page Screenshot    admin-add-specialitiy-{index}.png
    Click Element    xpath://button[contains(text(),'Save')]
    ${alert-danger} =    Get Text    class:alert-danger
    Log To Console    ${alert-danger}
    Element Should Be Visible    xpath://div[@class='alert alert-danger alert-dismissable']
    Element Text Should Be    xpath://div[@class='alert alert-danger alert-dismissable']    The name has already been taken.
    Capture Page Screenshot    name-of-certification-has-alredy-ben-taken-{index}.png
    Click Element    xpath://label[contains(text(),'Search:')]//input
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${name_cert}
    Click Element    xpath://a[@class='btn btn-danger m-btn m-btn--icon m-btn--icon-only show-delete-modal']
    Sleep    2

Delete Specilalties - success
    [Tags]    admin.add.speciality
    Delete Specialties modal
    Click Element    xpath://button[contains(text(),'Delete')]
    Sleep    1
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    after-delete-specialty-{index}.png
    LogoutKW

*** Keywords ***
