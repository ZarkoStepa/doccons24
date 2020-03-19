*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Library           String
Resource          _keywords.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Login
    [Tags]    withdrawal.requests
    LoginManagerKW

Go to Wallet
    [Tags]    withdrawal.requests
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Wallet')]
    Patient Wallet page

Make 3 withdraw request
    [Tags]    withdrawal.requests
    Click Button    xpath://button[@class='send-modal btn btn-primary']
    Patient Withdraw Request modal
    Wait Until Element Is Visible    id:amount
    Input Text    id:amount    ${withdraw1}
    Capture Page Screenshot    first-request-{index}.png
    Click Button    xpath://button[@class='btn actionBtn btn-primary runAjaxSend']
    Wait Until Element Is Visible    xpath://button[@class='send-modal btn btn-primary']
    Sleep    3
    Click Button    xpath://button[@class='send-modal btn btn-primary']
    Patient Withdraw Request modal
    Wait Until Element Is Visible    id:amount
    Input Text    id:amount    ${withdraw2}
    Capture Page Screenshot    second-request-{index}.png
    Click Button    xpath://button[@class='btn actionBtn btn-primary runAjaxSend']
    Wait Until Element Is Visible    xpath://button[@class='send-modal btn btn-primary']
    Sleep    3
    Click Button    xpath://button[@class='send-modal btn btn-primary']
    Patient Withdraw Request modal
    Wait Until Element Is Visible    id:amount
    Input Text    id:amount    ${withdraw3}
    Capture Page Screenshot    third-request-{index}.png
    Click Button    xpath://button[@class='btn actionBtn btn-primary runAjaxSend']
    Sleep    3

Accoun manager cancel withdraw
    [Tags]    withdrawal.requests
    Scroll Element Into View    xpath://th[contains(text(),'Action')]
    Click Element    xpath://th[contains(text(),'Action')]
    Sleep    2
    Click Element    xpath://th[contains(text(),'Action')]
    Scroll Element Into View    xpath://table[@id='paymentTable']/tbody/tr[5]/td[4]
    Capture Page Screenshot    scroll-to-withdraw-{index}.png
    Sleep    2
    Click Element    xpath://table[1]/tbody[1]/tr[3]/td[4]/form[1]/button[1]
    #Click Element    xpath://table[@id='paymentTable']/tbody/tr[3]/td[4]/form/button
    Capture Page Screenshot    click-to-cancel-withdraw-{index}.png
    Sleep    2
    LogoutKW

Admin go to Wallet
    [Tags]    withdrawal.requests
    LoginAdminKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /wallet/requests
    Admin Withdrawal Requests page
    #Scroll Element Into View    xpath://tr[9]/td[3]
    Capture Page Screenshot    capture-before-canceling-withdraw-{index}.png
    Click Element    xpath://tr[2]/td[5]/form[2]/button[1]
    #Click Element    xpath://table[1]/tbody[1]/tr[2]/td[4]/form[1]/button[1]
    Capture Page Screenshot    capture-after-canceling-withdraw-{index}.png
    Wait Until Element Is Not Visible    xpath://table/tbody/tr[2]/td[5]/form[2]/button[1]
    Capture Page Screenshot    capture-before-approve-withdraw-{index}.png
    Click Element    xpath://table/tbody[1]/tr[1]/td[5]/form[1]/button[1]
    Capture Page Screenshot    capture-after-approve-withdraw-{index}.png
    LogoutKW

*** Keywords ***
