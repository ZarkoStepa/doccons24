*** Settings ***
Documentation     Test login with ${ADMIN} add fee translation sucess and fail
...
...               Book appointment with ${EMAIL} with new translation
...
...               Delete translation with ${ADMIN}
...
...               Assert and verify login, logout, translation fee page, add new translation, delete translation fee modal page
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Add translations - success
    [Tags]    translation.fee
    LoginAdminKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Translation fees')]
    Sleep    2
    Admin Translations fees page
    Sleep    2
    Click Element    xpath://a[@class='btn btn-success']
    Capture Page Screenshot    trasnslation-fee-sucess-{index}.png

Add new fee - sucess
    [Tags]    translation.fee
    Admin Add new fee page
    Click Element    id:inputState
    Input Text    id:inputState    ${trasnaltionfee}
    Capture Page Screenshot    trasnslation-fee-state-{index}.png
    Sleep    1
    Click Element    id:selectCountry
    Sleep    1
    Click Element    xpath://option[contains(text(),'Chinese')]
    Capture Page Screenshot    set-language-fee-translation-{index}.png
    Click Element    xpath://button[@class='btn btn-primary']
    Capture Page Screenshot    trasnslation-fee-submit-{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Element Should Be Visible    xpath://button[contains(text(),'×')]
    Click Element    xpath://button[contains(text(),'×')]
    Capture Page Screenshot    trasnslation-fee-text-{index}.png
    LogoutKW

Patient book appointment - sucess
    [Tags]
    [Setup]
    LoginKW
    Click Element    xpath://button[@class='toast-close-button']
    Click Element    id:rq_btn3
    Input Text    id:symptoms    chenese fee
    Input Text    id:patient_notes    Book an appointment with Chinese fee
    Click Element    xpath://div[9]/label/span
    Click Button    id:rq_btn
    Click Element    id:ajax_payment
    Sleep    2
    Click Element    xpath://a[@class='btn btn-danger']
    Handle Alert
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW
    [Teardown]

Remove translation fee - sucess
    [Tags]    translation.fee
    LoginAdminKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Translation fees')]
    Sleep    2
    Admin Translations fees page
    Sleep    2
    Click Element    xpath://tr[@class='even']//a[@class='btn btn-danger m-btn m-btn--icon m-btn--icon-only show-delete-modal']
    Capture Page Screenshot    trasnslation-fee-delete-modal-{index}.png
    Fee delete modal
    Sleep    1
    Click Element    xpath://button[@class='btn btn-primary']
    Capture Page Screenshot    Fee-has-been-deleted-successfully-{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Should Contain    Fee has been deleted successfully.    Fee has been deleted successfully.
    Log    Fee has been deleted successfully.
    LogoutKW
