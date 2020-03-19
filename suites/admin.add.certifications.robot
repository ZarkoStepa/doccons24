*** Settings ***
Documentation     Test login with ${ADMIN} add cetification sucess and fail,
...
...               Assert and verify login page ,certification page, add new certification modal, delete certification modal
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Resource          _mysetup.txt
Resource          _keywords.txt
Library           SeleniumLibrary
Library           XvfbRobot

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Create Certification -success
    [Tags]    admin.add.certification
    LoginAdminKW
    Capture Page Screenshot    before-clicking-offcanvas-{index}.png
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Capture Page Screenshot    before-clicking-doctors-link-{index}.png
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Doctors')]
    Capture Page Screenshot    after-clicking-doctors-link-{index}.png
    Sleep    1
    Capture Page Screenshot    before-clicking-certifications-linktext-{index}.png
    Click Element    xpath://span[contains(text(),'Certifications')]
    Capture Page Screenshot    after-clicking-certifications-linktext-{index}.png
    Certifications page
    #Checking certification
    Click Element    xpath://label[contains(text(),'Search:')]//input
    Input Text    xpath://label[contains(text(),'Search:')]//input    ${name_cert}
    Capture Page Screenshot    checking-certification-{index}.png
    Sleep    2
    Capture Page Screenshot    before-clicking-add-new-certification-button-{index}.png
    Click Element    xpath://button[@class='btn btn-success']
    Capture Page Screenshot    after-clicking-add-new-certification-button-{index}.png
    Admin Add new certification modal
    Input Text    name:name    ${name_cert}
    Capture Page Screenshot    name-{index}.png
    Input Text    id=message-text    ${cert_decription}
    Input Text    name=de_name    ${name_cert}
    Input Text    name=de_description    ${cert_decription}
    Input Text    name=ar_name    ${name_cert}
    Input Text    name=ar_description    ${cert_decription}
    Capture Page Screenshot    before-clicking-save-button-{index}.png
    Click Element    xpath://button[contains(text(),'Save')]
    Capture Page Screenshot    after-clicking-save-button-{index}.png
    Element Text Should Be    xpath://button[contains(text(),'×')]    ×
    Capture Page Screenshot    admin-create-certification-sucessfuly-{index}.png
    Certifications page
    Sleep    2
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}

Create Certification - fail
    [Tags]    admin.add.certification
    Click Element    xpath://button[@class='btn btn-success']
    Admin Add new certification modal
    Input Text    name:name    ${name_cert}
    Input Text    id=message-text    ${cert_decription}
    Input Text    name=de_name    ${name_cert}
    Input Text    name=de_description    ${cert_decription}
    Input Text    name=ar_name    ${name_cert}
    Input Text    name=ar_description    ${cert_decription}
    Capture Page Screenshot    admin-add-certification-{index}.png
    Click Element    xpath://button[contains(text(),'Save')]
    ${alert-danger} =    Get Text    class:alert-danger
    Log To Console    ${alert-danger}
    Element Should Be Visible    xpath://div[@class='alert alert-danger alert-dismissable']
    Element Text Should Be    xpath://div[@class='alert alert-danger alert-dismissable']    The name has already been taken.
    Capture Page Screenshot    admin-create-certification-{index}.png

Delete Certification - sucess
    [Tags]    admin.add.certification
    Scroll Element Into View    xpath://a[@id='listcertifications_previous']
    Capture Page Screenshot    before-admin-delete-certification-{index}.png
    Click Element    xpath://table[@id='listcertifications']/tbody/tr[5]/td[8]/a[2]
    Sleep    2
    Delete Certification modal
    #Delete
    Click Element    xpath://button[contains(text(),'Delete')]
    Capture Page Screenshot    after-clicking-delete-button-{index}.png
    Sleep    2
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Scroll Element Into View    id:listcertifications_next
    Capture Page Screenshot    after-delete-certification-{index}.png
    LogoutKW

*** Keywords ***
