*** Settings ***
Documentation     Test login and logout with ${DOCEMAIL}
...
...               Assert and verify login page , payed appointment page
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
doctor see payed appointment in my appointments
    [Tags]    doctor.appointment
    LoginDocKW
    # Element    xpath://button[@id='close1']//span[contains(text(),'×')]
    #Click Element    xpath://button[@id='close2']//span[contains(text(),'×')]
    Sleep    1
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Link    /appointments
    #Click Element    xpath://button[@id='close1']//span[contains(text(),'×')]
    #Click Element    xpath://button[@id='close2']//span[contains(text(),'×')]
    Sleep    1
    #Click Link    /appointments?filter=2
    Wait Until Element Is Visible    id:docAppoint_wrapper
    Capture Page Screenshot    docAppoint_wrapper-{index}.png
    Click Element    xpath://div[1]/table[1]/tbody[1]/tr[1]/td[2]/a[1]
    LogoutKW

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
