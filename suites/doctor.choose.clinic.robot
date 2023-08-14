*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Doctor create clinic - success
    [Tags]    doctor.choose.clinic
    [Setup]    Set up Clinic
    LoginDocKW
    Click Element    id:qua
    Click Element    css:.form-group:nth-child(6) .m-radio:nth-child(1) > span
    Wait Until Element Is Visible    xpath://span[@class='filter-option pull-left'][contains(text(),'Select Clinic')]
    Click Element    xpath://span[@class='filter-option pull-left'][contains(text(),'Select Clinic')]
    Capture Page Screenshot    select-clinic-{index}.png
    Click Element    css:.show li:nth-child(2) .text
    Click Element    xpath://div[@class='col-8']//div//i[@class='la la-close']
    Capture Page Screenshot    close-clinic-{index}.png
    Wait Until Element Is Visible    xpath://h3[contains(text(),'Please confirm changes')]
    Click Button    id:qualification-submit-btn
    Capture Page Screenshot    save-changes-{index}.png
    LogoutKW

Doctor deselect clinic -success
    [Tags]    doctor.choose.clinic
    LoginDocKW
    Click Element    id:qua
    Click Element    css:.form-group:nth-child(6) .m-radio:nth-child(2) > span
    Capture Page Screenshot    deselect-clicnic-{index}.png
    Click Element    xpath://div[@class='col-8']//div//i[@class='la la-close']
    Click Button    id:qualification-submit-btn
    Capture Page Screenshot    after-submit-{index}.png
    LogoutKW
    [Teardown]    Delete clinic - success

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
