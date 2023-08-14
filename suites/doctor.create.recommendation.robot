*** Settings ***
Documentation     Test login and logout with ${DOCEMAIL} create recommendation sucess
...
...               Test login and logout with ${EMAIL}
...
...               Aassert and verify recommendation page with ${EMAIL}
...
...               Test delete recommendation with ${DOCEMAIL}
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _keywords.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Doctor add recomendation/prescription
    [Tags]    doctor.create.recommendation
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Write...')]
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Write...')]
    Click Element    xpath://span[@class='m-menu__link-text'][contains(text(),'Recommendation/Prescription')]
    Doctor recommendation/prescription page
    Click Element    xpath://a[@id='addrecommendation']
    Wait Until Element Is Visible    xpath://div[@id='newModal']//div[@class='modal-content']
    Add new recommendation prescription modal
    Click Element    id:write_type
    Click Element    xpath://select[@id='write_type']//option[contains(text(),'Recommendation')]
    Input Text    id:topic_add    Recommendation
    Click Element    xpath://div[@id='newModal']//a[contains(@class,'fa fa-bold')]
    Click Element    xpath://div[@id='newModal']//a[contains(@class,'fa fa-header')]
    Click Element    xpath://div[@id='newModal']//a[contains(@class,'fa fa-italic')]
    Click Element    xpath://span[contains(text(),'Add Recommendation/Prescription')]
    Capture Page Screenshot    recommendation-{index}.png

Approve recommendations
    [Tags]    doctor.create.recommendation
    Sleep    2
    Wait Until Element Is Visible    xpath://span[contains(text(),'Approve')]
    Click Element    xpath://span[contains(text(),'Approve')]
    Capture Page Screenshot    apporve-reccomendation-{index}.png
    LogoutKW

Patient see recommendation - success
    [Tags]    doctor.create.recommendation
    LoginKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Recommendation/Prescription')]
    Patient Recommendation/Prescription page
    LogoutKW

Delete recommendation - success
    [Tags]    doctor.create.recommendation
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Write...')]
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Write...')]
    Click Element    xpath://span[@class='m-menu__link-text'][contains(text(),'Recommendation/Prescription')]
    Wait Until Element Is Visible    xpath://button[@class='delete-modal btn btn-danger']
    Click Element    xpath://button[@class='delete-modal btn btn-danger']
    Recommendation delete modal
    Wait Until Element Is Visible    xpath://span[contains(text(),'Delete Recommendation/Prescription')]
    Click Element    xpath://span[contains(text(),'Delete Recommendation/Prescription')]
    Capture Page Screenshot    when-delete-recommendation-{index}.png
    Wait Until Element Is Visible    class:alert-success
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW

*** Keywords ***
Open Chrome Browser
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}

Open Testbrowser
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If    '${system}' == 'Linux'    Start Virtual Display    1920    1080
    Open Chrome Browser
