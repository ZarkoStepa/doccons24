*** Settings ***
Suite Setup             Open Testbrowser
Suite Teardown          Close All Browsers
Resource                _keywords.txt
Resource                _mysetup.txt
Library                 String
Library                 SeleniumLibrary
Library                 XvfbRobot

*** Variables ***
${TMP_PATH}             /tmp

*** Test Cases ***
Login
          [Tags]          stripe
          LoginManagerKW

Go to Wallet
          [Tags]          stripe
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'Wallet')]
          Click Element          xpath://span[contains(text(),'Wallet')]
          Capture Page Screenshot          wallet-{index}.png

Deposit Money on Stripe
          [Tags]          stripe
          ${amount} =          Generate Random String          2          [NUMBERS]
          Input Text          id:depositAmount          1${amount}
          Wait Until Element Is Visible          id:paymentButton
          Click Element          id:paymentButton
          Wait Until Element Is Not Visible          id:paymentButton
          Capture Page Screenshot          checkout-button-stripe-{index}.png
          Click Element          id:checkout-button-stripe
          Sleep          3

Stripe
          [Tags]          stripe
          Wait Until Element Is Visible          id:cardNumber
          Wait Until Element Is Visible          id:billingCountry
          Scroll Element Into View          id:billingCountry
          Scroll Element Into View          id:root
          Click Element          id:cardNumber
          Sleep          2
          Input Text          id:cardNumber          ${MASTERCARD}
          Sleep          2
          Clear Element Text          id:cardNumber
          Input Text          id:cardNumber          ${MASTERCARD}
          Capture Page Screenshot          stripe-{index}.png
          Input Text          id:cardExpiry          ${cardExpiry}
          ${cvc} =          Generate Random String          3          [NUMBERS]
          Input Text          id:cardCvc          ${cvc}
          Input Text          id:billingName          Skauto2
          Submit Form
          Sleep          8
          Wait Until Element Is Visible          class:alert-success
          Capture Page Screenshot          charging-wallet-success-{index}.png
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}

Logout
          [Tags]          stripe
          LogoutKW
