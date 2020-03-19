*** Settings ***
Documentation     Test log in and log out with ${MANEMAIL}
...
...               Test deposit money via PayPal
...
...               Assert and verify login page, wallet page.
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Resource          _keywords.txt
Resource          _mysetup.txt
Library           XvfbRobot

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Login
    [Tags]    account.manager.deposit.amount
    LoginManagerKW

Go To Wallet
    [Tags]    account.manager.deposit.amount
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    open-sidebar-menu-{index}.png
    Click Element    xpath://span[contains(text(),'Wallet')]
    Capture Page Screenshot    click-on-wallet-link-text-{index}.png
    Sleep    5
    Patient Wallet page
    Capture Page Screenshot    account-manager-wallet-page-{index}.png

Deposit Amount
    [Tags]    account.manager.deposit.amount
    Input Text    id:depositAmount    ${AMOUNT}
    Capture Page Screenshot    input-amount-{index}.png
    Click Element    id:paymentButton
    Capture Page Screenshot    after-click-paypal-button-{index}.png
    Paypal add amount
    Capture Page Screenshot    after-deposit-from-paypal-{index}.png
    LogoutKW

*** Keywords ***
