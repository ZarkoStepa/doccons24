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
View ngrok true all appointments
    [Documentation]    navigate doctor to my appointments to see patient ngrok upload documentation
    [Tags]    ngrok
    LoginDocKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Sleep    1
    Wait Until Element Is Visible    id:docAppoint_wrapper
    Capture Page Screenshot    docAppoint_wrapper-{index}.png
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Wait Until Element Is Visible    xpath://div[6]//div[1]//p[1]//a[1]
    Click Element    xpath://div[6]//div[1]//p[1]//a[1]
    Wait Until Element Is Visible    xpath://div[contains(@class,'m-grid__item m-grid__item--fluid m-wrapper')]//li[3]//a[1]
    Click Element    xpath://div[contains(@class,'m-grid__item m-grid__item--fluid m-wrapper')]//li[3]//a[1]
    Click Element    xpath://a[contains(@class,'qualify-1')]//img
    Capture Page Screenshot    image1-{index}.png
    Click Element    xpath://a[contains(text(),'Patient Documentation')]
    Scroll Element Into View    xpath://a[@class='qualify-2']//img
    Capture Page Screenshot    image2-{index}.png
    Click Element    xpath://a[@class='qualify-1']//img
    Sleep    2
    Capture Page Screenshot    ngrok-{index}.png
    Sleep    2
    LogoutKW

View ngrok through the paid appointment
    [Documentation]    navigate doctor to paid appointment to see patient ngrok upload documentation
    [Tags]    ngrok
    LoginDocKW
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'My appointments')]
    Click Element    xpath://span[contains(text(),'My appointments')]
    Capture Page Screenshot    docAppoint_wrapper-{index}.png
    Wait Until Element Is Visible    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://tr[1]//td[3]//a[1]
    Click Element    xpath://a[contains(text(),'${NEWUSER} ${NEWLASTNAME}')]
    Click Element    partial link:Patient Documentati
    Click Element    xpath://a[@class='qualify-1']//img
    Sleep    3
    Capture Page Screenshot    ngrok-document-{index}.png
    LogoutKW
