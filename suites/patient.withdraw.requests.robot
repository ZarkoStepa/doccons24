*** Settings ***
Documentation     Test login and logout with user ${USEREMAIL}
...
...               Make 3 Amount to Withdraw requests.
...
...               Assert all pages which include steps in test cases, Patient Wallet page, \ Amount to Withdraw modal dialog
...
...               Test login and logout with user ${ADMIN}
...
...               Withdrawal Requests \ 2 should be cancelled one should approve with
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt
Library           String

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Log in
    [Tags]    withdrawal.requests
    LoginKW

Go to wallet
    [Tags]    withdrawal.requests
    Capture Page Screenshot    before-toast-message-{index}.png
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /wallet
    Patient Wallet page

Patient make 3 withdraw request
    [Documentation]    1st should be canceled from patient
    ...    -
    ...    2nd should be canceled from admin
    ...    -
    ...    3rd should be approved from admin
    [Tags]    withdrawal.requests
    Click Button    xpath://button[@class='send-modal btn btn-primary']
    Patient Withdraw Request modal
    Wait Until Element Is Visible    id:amount
    ${withdraw} =    Generate Random String    1    [NUMBERS]
    Input Text    id:amount    1${withdraw}
    Capture Page Screenshot    first-request-{index}.png
    Click Button    xpath://button[@class='btn actionBtn btn-primary runAjaxSend']
    Wait Until Element Is Visible    xpath://button[@class='send-modal btn btn-primary']
    Sleep    5
    Click Button    xpath://button[@class='send-modal btn btn-primary']
    Patient Withdraw Request modal
    Wait Until Element Is Visible    id:amount
    Input Text    id:amount    1${withdraw}
    Capture Page Screenshot    second-request-{index}.png
    Click Button    //button[@class='btn actionBtn btn-primary runAjaxSend']
    Wait Until Element Is Visible    //button[@class='send-modal btn btn-primary']
    Sleep    5
    Click Button    //button[@class='send-modal btn btn-primary']
    Patient Withdraw Request modal
    Wait Until Element Is Visible    id:amount
    Input Text    id:amount    1${withdraw}
    Capture Page Screenshot    third-request-{index}.png
    Click Button    //button[@class='btn actionBtn btn-primary runAjaxSend']
    Sleep    5

Patient Cancel Withdraw
    [Tags]    withdrawal.requests
    Scroll Element Into View    xpath://th[contains(text(),'Action')]
    Capture Page Screenshot    action-before-{index}.png
    Click Element    xpath://th[contains(text(),'Action')]
    Sleep    1
    Capture Page Screenshot    action-midle-{index}.png
    Click Element    xpath://th[contains(text(),'Action')]
    Capture Page Screenshot    action-after-{index}.png
    Scroll Element Into View    xpath://table[@id='paymentTable']/tbody/tr[5]/td[4]
    Wait Until Element Is Visible    xpath://table[@id='paymentTable']/tbody/tr[3]/td[4]/form/button
    Click Element    xpath://table[@id='paymentTable']/tbody/tr[3]/td[4]/form/button
    LogoutKW

Admin go to wallet
    [Tags]    withdrawal.requests
    LoginAdminKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /wallet/requests
    Admin Withdrawal Requests page
    #Scroll Element Into View    xpath://tr[9]/td[3]
    Capture Page Screenshot    capture-before-canceling-withdraw-{index}.png
    Click Element    xpath://table/tbody/tr[2]/td[5]/form[2]/button[1]
    Capture Page Screenshot    capture-after-canceling-withdraw-{index}.png
    Wait Until Element Is Not Visible    xpath://table/tbody/tr[2]/td[5]/form[2]/button[1]
    Capture Page Screenshot    capture-before-approve-withdraw-{index}.png
    Click Element    xpath://table/tbody[1]/tr[1]/td[5]/form[1]/button[1]
    Capture Page Screenshot    capture-after-approve-withdraw-{index}.png

Log out
    [Tags]    withdrawal.requests
    LogoutKW

*** Keywords ***
