*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Resource          _keywords.txt
Library           String
Resource          _mysetup.txt
Library           SeleniumLibrary
Library           XvfbRobot

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Login
    LoginKW

Go to wallet
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Wallet')]
    Click Element    xpath://span[contains(text(),'Wallet')]
    Capture Page Screenshot    goto-wallet-{index}.png

Deposit Amount
    Patient Wallet page
    Input Text    id:depositAmount    ${AMOUNT}
    Wait Until Element Is Visible    id:paymentButton
    Click Element    id:paymentButton
    Wait Until Element Is Visible    id:checkout-button-stripe
    Wait Until Element Is Visible    xpath://form[@id='payment-form2']//button[@class='btn btn-primary btn-large']
    Click Element    xpath://form[@id='payment-form2']//button[@class='btn btn-primary btn-large']
    Sleep    3

Deposit money via PayPal - success
    Capture Page Screenshot    deposit-via-paypal-{index}.png
    Wait Until Element Is Visible    id:email
    Input Text    id:email    ${PAYPALUSER}
    Capture Page Screenshot    paypal-input-email-{index}.png
    Wait Until Element Is Visible    id:btnNext
    Click Element    id:btnNext
    Capture Page Screenshot    click-button-next-{index}.png
    Wait Until Element Is Visible    id:password
    Input Text    id:password    ${PAYPALPW}
    Capture Page Screenshot    paypal-input-password-{index}.png
    #Click Element    xpath://label[@class='checkboxLabel']
    Capture Page Screenshot    click-checkbox-{index}.png
    Wait Until Element Is Visible    id:btnLogin
    Click Element    id:btnLogin
    Capture Page Screenshot    click-login-button-{index}.png
    Sleep    15
    #paypall issue
    Wait Until Element Is Visible    id:payment-submit-btn
    Wait Until Element Is Visible    xpath://button[@id='payment-submit-btn']
    Wait Until Element Is Visible    class:ppvx_btn
    Wait Until Element Is Visible    css:#payment-submit-btn
    Element Should Be Visible    css:#payment-submit-btn
    Sleep    5
    Scroll Element Into View    xpath://div[@class='Disclaimer_disclaimer_2hOSn']//p
    Sleep    3
    Click Button    css:#payment-submit-btn
    Sleep    5
    Capture Page Screenshot    confirm-amount-{index}.png
    Sleep    5
    Wait Until Element Is Visible    xpath://div[@class='alert alert-success']
    ${alert} =    Get Text    class:alert-success
    Log To Console    ${alert}
    Capture Page Screenshot    succeess-transaction-{index}.png
    LogoutKW

logins
    LoginKW

go to wallet s
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Wallet')]
    Click Element    xpath://span[contains(text(),'Wallet')]
    Capture Page Screenshot    goto-wallet-{index}.png

deposit amount on stripe
    Patient Wallet page
    Input Text    id:depositAmount    ${AMOUNT}
    Wait Until Element Is Visible    id:paymentButton
    Click Element    id:paymentButton
    Wait Until Element Is Not Visible    id:paymentButton
    Wait Until Element Is Visible    id:checkout-button-stripe
    Click Element    id:checkout-button-stripe
    Sleep    7

stripe
    #Wait Until Element Is Visible    xpath://*[name()='ellipse' and contains(@class,'Spinner-el')]
    #Wait Until Element Is Not Visible    xpath://*[name()='ellipse' and contains(@class,'Spinner-el')]
    Wait Until Element Is Visible    id:cardNumber
    Input Text    id:cardNumber    5555555555554444
    Input Text    id:cardExpiry    1122
    Input Text    id:cardCvc    155
    Input Text    id:billingName    Skauto
    Submit Form
    #    class:SubmitButton-IconContainer
    #click    xpath://div[@class='SubmitButton-IconContainer']
    Wait Until Element Is Visible    xpath://div[@class='App-Payment']//span[2]
    Sleep    10
    LogoutKW

test
