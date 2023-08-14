*** Settings ***
Suite Setup             Open Testbrowser
Suite Teardown          Close All Browsers
Resource                _mysetup.txt
Resource                _keywords.txt
Library                 String
Library                 SeleniumLibrary
Library                 XvfbRobot

*** Variables ***
${TMP_PATH}             /tmp

*** Test Cases ***
Login
          [Tags]          stripe
          LoginKW

Go to Wallet
          [Tags]          stripe
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'Wallet')]
          Click Element          xpath://span[contains(text(),'Wallet')]
          Capture Page Screenshot          goto-wallet-{index}.png

Deposit Money on Stripe
          [Tags]          stripe
          Patient Wallet page
          ${amount} =          Generate Random String          2          [NUMBERS]
          Input Text          id:depositAmount          15${amount}
          Wait Until Element Is Visible          id:paymentButton
          Click Element          id:paymentButton
          Wait Until Element Is Not Visible          id:paymentButton
          Wait Until Element Is Visible          id:checkout-button-stripe
          Click Element          id:checkout-button-stripe
          Sleep          3

Stripe
          [Tags]          stripe
          Wait Until Element Is Visible          id:cardNumber
          Capture Page Screenshot          stripe-{index}.png
          Wait Until Element Is Visible          id:cardNumber
          Click Element          id:cardNumber
          Sleep          1
          Input Text          id:cardNumber          ${VISA}
          Sleep          1
          Capture Page Screenshot          card-number-{index}.png
          Clear Element Text          id:cardNumber
          Capture Page Screenshot          clear-card-number-{index}.png
          Sleep          1
          Input Text          id:cardNumber          ${VISA}
          Sleep          1
          Input Text          id:cardExpiry          ${cardExpiry}
          Capture Page Screenshot          card-expiry-{index}.png
          ${cvc} =          Generate Random String          3          [NUMBERS]
          Input Text          id:cardCvc          ${cvc}
          Capture Page Screenshot          card-cvc-{index}.png
          Input Text          id:billingName          Skauto
          Capture Page Screenshot          before-submit-{index}.png
          Submit Form
          Sleep          8
          Wait Until Element Is Visible          class:alert-success
          Capture Page Screenshot          charging-wallet-success-{index}.png
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}

Logout
          [Tags]          stripe
          LogoutKW
