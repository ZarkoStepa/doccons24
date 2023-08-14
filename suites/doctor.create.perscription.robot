*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _keywords.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Doctor adds prescription
    [Tags]    doctor.create.prescription
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Write...')]
    Click Element    xpath://span[@class='m-menu__link-text'][contains(text(),'Recommendation/Prescription')]
    Doctor recommendation/prescription page
    Click Element    xpath://a[@id='addrecommendation']
    Sleep    1
    Add new recommendation prescription modal
    Click Element    id:write_type
    Click Element    xpath://select[@id='write_type']//option[contains(text(),'Prescription')]
    Input Text    id:topic_add    Prescription
    Click Element    xpath://div[@id='newModal']//a[contains(@class,'fa fa-bold')]
    Click Element    xpath://div[@id='newModal']//a[contains(@class,'fa fa-header')]
    Click Element    xpath://div[@id='newModal']//a[contains(@class,'fa fa-italic')]
    Click Element    xpath://span[contains(text(),'Add Recommendation/Prescription')]
    Capture Page Screenshot    prescription-{index}.png

Approve prescription
    [Tags]    doctor.create.prescription
    Sleep    1
    Click Element    xpath://span[contains(text(),'Approve')]
    Capture Page Screenshot    apporve-reccomendation-{index}.png
    LogoutKW

The patient sees prescription- success
    [Tags]    doctor.create.prescription
    LoginKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Recommendation/Prescription')]
    Patient Recommendation/Prescription page
    Sleep    5
    LogoutKW

Delete prescription- success
    [Tags]    doctor.create.prescription
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Write...')]
    Click Element    xpath://span[@class='m-menu__link-text'][contains(text(),'Recommendation/Prescription')]
    Sleep    1
    Click Element    xpath://button[@class='delete-modal btn btn-danger']
    Sleep    1
    Recommendation delete modal
    Sleep    1
    Click Element    xpath://span[contains(text(),'Delete Recommendation/Prescription')]
    Capture Page Screenshot    when-delete-recommendation-{index}.png
    Sleep    3
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW
