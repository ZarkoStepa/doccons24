*** Settings ***
Documentation     Test login and logout with ${USEREMAIL} payment method via PayPal
...
...               Assert and verify login, logout page, wallet page
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt
Library           DateTime
Library           String

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
patient input deposit - success
    [Tags]    deposit.money
    LoginKW
    Capture Page Screenshot    before-toast-message-{index}.png
    #Click Element    xpath://div[@class='toast-message']
    Sleep    1
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Capture Page Screenshot    goto-wallet-{index}.png
    Click Element    xpath://span[contains(text(),'Wallet')]
    Patient Wallet page
    Capture Page Screenshot    wallet-{index}.png
    Input Text    id:depositAmount    ${AMOUNT}
    Capture Page Screenshot    inpit-wallet-{index}.png
    Sleep    1
    Click Element    id:paymentButton
    Capture Page Screenshot    deposit-amount-{index}.png
    Sleep    1

deposit money via PayPal - success
    [Tags]    deposit.money
    Click Element    xpath://button[@class='btn btn-primary btn-large']//img
    Capture Page Screenshot    deposit-via-paypal-{index}.png
    Sleep    5
    Input Text    id:email    ${PAYPALUSER}
    Capture Page Screenshot    paypal-input-email-{index}.png
    Click Element    id:btnNext
    Capture Page Screenshot    click-button-next-{index}.png
    Sleep    5
    Input Text    id:password    ${PAYPALPW}
    Capture Page Screenshot    paypal-input-password-{index}.png
    Click Element    xpath://label[@class='checkboxLabel']
    Capture Page Screenshot    click-checkbox-{index}.png
    Click Element    id:btnLogin
    Capture Page Screenshot    click-login-button-{index}.png
    #Sleep    5
    #Element Should Be Visible    id:preloaderSpinner
    #Capture Page Screenshot    spinner-shold-be-present-{index}.png
    Sleep    15
    #Wait Until Element Is Visible    xpath://button[@class='btn full confirmButton continueButton']
    Capture Page Screenshot    before-paypal-confirm-{index}.png
    Click Element    xpath://button[@id='payment-submit-btn']
    #Click Element    xpath://button[@class='btn full confirmButton continueButton']
    #Click Button    id:confirmButtonTop
    Capture Page Screenshot    paypal-confirm-{index}.png
    Sleep    3
    #Wait Until Element Is Visible    id:confirmButtonTop
    #Click Element    id:confirmButtonTop
    Capture Page Screenshot    confirm-amount-{index}.png
    Sleep    8
    Wait Until Element Is Visible    xpath://div[@class='alert alert-success']
    ${alert} =    Get Text    class:alert-success
    Log To Console    ${alert}
    Capture Page Screenshot    succeess-transaction-{index}.png
    LogoutKW
    Capture Page Screenshot    logout-{index}.png

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
