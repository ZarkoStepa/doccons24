*** Settings ***
Documentation     Test login with ${ADMIN} add department sucess and fail
...
...               Assert and verify login page, department page, add new department modal, delete department modal
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _keywords.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Create New Department - success
    [Tags]    admin.add.department
    LoginAdminKW
    Capture Page Screenshot    before-clicking-offcanvas-{index}.png
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Capture Page Screenshot    before-clicking-doctors-link-{index}.png
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Doctors')]
    Capture Page Screenshot    after-clicking-doctors-link-{index}.png
    Sleep    1
    Click Element    xpath://span[contains(text(),'Departments')]
    Capture Page Screenshot    after-clicking-departments-link-{index}.png
    Depatrment page
    Click Element    xpath://label[contains(text(),'Search:')]//input
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${name_cert}
    Capture Page Screenshot    checking-department-{index}.png
    Sleep    2
    Capture Page Screenshot    before-clicking-add-new-department-{index}.png
    Click Element    xpath://button[@class='btn btn-success']
    Capture Page Screenshot    after-clicking-add-new-department-{index}.png
    Admin Add new department
    Input Text    name:name    ${name_cert}
    Input Text    id=message-text    ${cert_decription}
    Input Text    name=de_name    ${name_cert}
    Input Text    name=de_description    ${cert_decription}
    Input Text    name=ar_name    ${name_cert}
    Input Text    name=ar_description    ${cert_decription}
    Capture Page Screenshot    admin-add-specialties-{index}.png
    Click Element    xpath://button[contains(text(),'Save')]
    Capture Page Screenshot    after-clicking-save-button-{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    speciality-added-successfully-{index}.png
    #Click Element    xpath://button[contains(text(),'×')]
    Click Element    xpath://label[contains(text(),'Search:')]//input
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${name_cert}
    Capture Page Screenshot    speciality-is-on-table-{index}.png

Create Department - fail
    [Tags]    admin.add.department
    Click Element    xpath://button[@class='btn btn-success']
    Admin Add new department
    Input Text    name:name    ${name_cert}
    Input Text    id=message-text    ${cert_decription}
    Input Text    name=de_name    ${name_cert}
    Input Text    name=de_description    ${cert_decription}
    Input Text    name=ar_name    ${name_cert}
    Input Text    name=ar_description    ${cert_decription}
    Capture Page Screenshot    admin-add-department-{index}.png
    Click Element    xpath://button[contains(text(),'Save')]
    ${alert-danger} =    Get Text    class:alert-danger
    Log To Console    ${alert-danger}
    Element Should Be Visible    xpath://div[@class='alert alert-danger alert-dismissable']
    Element Text Should Be    xpath://div[@class='alert alert-danger alert-dismissable']    The name has already been taken.
    Capture Page Screenshot    admin-create-departmant-{index}.png
    LogoutKW

Delete Department - success
    [Tags]    admin.add.department
    LoginAdminKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Doctors')]
    Sleep    1
    Click Element    xpath://span[contains(text(),'Departments')]
    Sleep    1
    Click Element    xpath://label[contains(text(),'Search:')]//input
    Sleep    1
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${name_cert}
    Capture Page Screenshot    input-department-{index}.png
    Sleep    1
    Click Element    xpath://a[@class='btn btn-danger m-btn m-btn--icon m-btn--icon-only show-delete-modal']
    Capture Page Screenshot    delete-department-{index}.png
    Sleep    1
    Capture Page Screenshot    successfull-delete-department-{index}.png
    Click Element    xpath://button[contains(text(),'Delete')]
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW

*** Keywords ***
