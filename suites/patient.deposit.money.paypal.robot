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
Patient input deposit - success
    [Tags]    deposit.money
    LoginKW
    Capture Page Screenshot    before-toast-message-{index}.png
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Wallet')]
    Capture Page Screenshot    goto-wallet-{index}.png
    Click Element    xpath://span[contains(text(),'Wallet')]
    Patient Wallet page
    Capture Page Screenshot    wallet-{index}.png
    Input Text    id:depositAmount    ${AMOUNT}
    Capture Page Screenshot    inpit-wallet-{index}.png
    Wait Until Element Is Visible    id:paymentButton
    Click Element    id:paymentButton
    Wait Until Element Is Visible    id:checkout-button-stripe
    Wait Until Element Is Visible    xpath://button[@class='btn btn-primary btn-large']//img
    Click Element    xpath://button[@class='btn btn-primary btn-large']//img

Deposit money via PayPal - success
    Capture Page Screenshot    deposit-via-paypal-{index}.png
    Sleep    5
    #Wait Until Element Is Visible    id:acceptAllButton
    #Click Element    id:acceptAllButton
    #Click Element    class:baslLoginButtonContainer
    Wait Until Element Is Visible    id:email
    Input Text    id:email    ${PAYPALUSER}
    Capture Page Screenshot    paypal-input-email-{index}.png
    Wait Until Element Is Visible    id:btnNext
    Click Element    id:btnNext
    Capture Page Screenshot    click-button-next-{index}.png
    Wait Until Element Is Visible    id:password
    Input Text    id:password    ${PAYPALPW}
    Capture Page Screenshot    paypal-input-password-{index}.png
    Click Element    xpath://label[@class='checkboxLabel']
    Capture Page Screenshot    click-checkbox-{index}.png
    Wait Until Element Is Visible    id:btnLogin
    Click Element    id:btnLogin
    Capture Page Screenshot    click-login-button-{index}.png
    Sleep    15
    Wait Until Element Is Visible    xpath://button[@id='payment-submit-btn']
    Element Text Should Be    xpath://span[contains(text(),"test facilitator's Test Store")]    test facilitator's Test Store
    Element Text Should Be    xpath://span[contains(text(),'Add debit or credit card')]    Add debit or credit card
    Element Text Should Be    xpath://h2[contains(text(),'Pay Later')]    Pay Later
    Element Text Should Be    xpath://p[contains(text(),"You'll be able to review your order before you com")]    You'll be able to review your order before you complete your purchase.
    Element Should Be Visible    xpath://p[contains(text(),"You'll be able to review your order before you com")]
    Element Text Should Be    xpath://span[contains(text(),'PayPal Credit')]    PayPal Credit
    Sleep    2
    Get Title
    Get Text    id:payment-submit-btn
    Page Should Contain Button    id:payment-submit-btn
    Set Focus To Element    id:payment-submit-btn
    Capture Page Screenshot    before-paypal-confirm-{index}.png
    Click Element    id=payment-submit-btn
    Capture Page Screenshot    paypal-confirm-{index}.png
    Sleep    8
    Wait Until Element Is Visible    xpath://div[@class='alert alert-success']
    ${alert} =    Get Text    class:alert-success
    Log To Console    ${alert}
    Capture Page Screenshot    succeess-transaction-{index}.png
    LogoutKW
    Capture Page Screenshot    logout-{index}.png

Paypal Sandbox
    Capture Page Screenshot    deposit-via-paypal-{index}.png
    Sleep    5
    Input Text    name:login_email    ${PAYPALUSER}
    Sleep    1
    Click Element    name:btnNext
    Sleep    1
    Input Text    name:login_password    ${PAYPALPW}
    Click Element    name:btnLogin
    Sleep    25
    Wait Until Element Is Visible    class:src_heading_1SHop
    Submit Form
    #Click Element    id:payment-submit-btn
    Sleep    5
    Capture Page Screenshot    deposit-via-paypal-{index}.png
    Sleep    10
    Capture Page Screenshot    deposit-via-paypal-{index}.png

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
