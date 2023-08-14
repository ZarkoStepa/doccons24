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
          LoginKW

Go To Wallet
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'Wallet')]
          Click Element          xpath://span[contains(text(),'Wallet')]
          Capture Page Screenshot          goto-wallet-{index}.png

Visa
          [Template]
          Deposit Money via Stripe
          Wait Until Element Is Visible          id:cardNumber
          Capture Page Screenshot          stripe-{index}.png
          Wait Until Element Is Visible          id:cardNumber
          Click Element          id:cardNumber
          Sleep          1
          Input Text          id:cardNumber          ${VISA}
          Sleep          1
          Capture Page Screenshot          card-number-{index}.png
          Input Text          id:cardExpiry          1122
          Capture Page Screenshot          card-expiry-{index}.png
          ${cvc} =          Generate Random String          3          [NUMBERS]
          Input Text          id:cardCvc          ${cvc}
          Capture Page Screenshot          card-cvc-{index}.png
          Input Text          id:billingName          Skauto
          Submit Form
          Sleep          8
          Wait Until Element Is Visible          class:alert-success
          Capture Page Screenshot          charging-wallet-success-{index}.png
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}

Visa Debit
          Wait Until Element Is Visible          id:cardNumber
          Capture Page Screenshot          stripe-{index}.png
          Wait Until Element Is Visible          id:cardNumber
          Click Element          id:cardNumber
          Sleep          2
          Input Text          id:cardNumber          ${VISA_DEBIT}
          Sleep          2
          Capture Page Screenshot          card-number-{index}.png
          Input Text          id:cardExpiry          1122
          Capture Page Screenshot          card-expiry-{index}.png
          ${cvc} =          Generate Random String          3          [NUMBERS]
          Input Text          id:cardCvc          ${cvc}
          Capture Page Screenshot          card-cvc-{index}.png
          Input Text          id:billingName          Skauto
          Submit Form
          Sleep          8
          Wait Until Element Is Visible          class:alert-success
          Capture Page Screenshot          charging-wallet-success-{index}.png
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}

Mastercard
          Wait Until Element Is Visible          id:cardNumber
          Deposit Money via Stripe
          Wait Until Element Is Visible          id:cardNumber
          Capture Page Screenshot          stripe-{index}.png
          Wait Until Element Is Visible          id:cardNumber
          Click Element          id:cardNumber
          Sleep          2
          Input Text          id:cardNumber          ${MASTERCARD}
          Sleep          2
          Capture Page Screenshot          card-number-{index}.png
          Input Text          id:cardExpiry          1122
          Capture Page Screenshot          card-expiry-{index}.png
          ${cvc} =          Generate Random String          3          [NUMBERS]
          Input Text          id:cardCvc          ${cvc}
          Capture Page Screenshot          card-cvc-{index}.png
          Input Text          id:billingName          Skauto
          Submit Form
          Sleep          8
          Wait Until Element Is Visible          class:alert-success
          Capture Page Screenshot          charging-wallet-success-{index}.png
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}

Mastercard (2-series)
          Deposit Money via Stripe
          Wait Until Element Is Visible          id:cardNumber
          Capture Page Screenshot          stripe-{index}.png
          Wait Until Element Is Visible          id:cardNumber
          Click Element          id:cardNumber
          Sleep          2
          Input Text          id:cardNumber          ${MASTERCARD_2S}
          Sleep          2
          Capture Page Screenshot          card-number-{index}.png
          Input Text          id:cardExpiry          1122
          Capture Page Screenshot          card-expiry-{index}.png
          ${cvc} =          Generate Random String          3          [NUMBERS]
          Input Text          id:cardCvc          ${cvc}
          Capture Page Screenshot          card-cvc-{index}.png
          Input Text          id:billingName          Skauto
          Submit Form
          Sleep          8
          Wait Until Element Is Visible          class:alert-success
          Capture Page Screenshot          charging-wallet-success-{index}.png
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}

Mastercard (debit)
          Deposit Money via Stripe
          Wait Until Element Is Visible          id:cardNumber
          Capture Page Screenshot          stripe-{index}.png
          Wait Until Element Is Visible          id:cardNumber
          Click Element          id:cardNumber
          Sleep          2
          Input Text          id:cardNumber          ${MASTERCARD_DEBIT}
          Sleep          2
          Capture Page Screenshot          card-number-{index}.png
          Input Text          id:cardExpiry          1122
          Capture Page Screenshot          card-expiry-{index}.png
          ${cvc} =          Generate Random String          3          [NUMBERS]
          Input Text          id:cardCvc          ${cvc}
          Capture Page Screenshot          card-cvc-{index}.png
          Input Text          id:billingName          Skauto
          Submit Form
          Sleep          8
          Wait Until Element Is Visible          class:alert-success
          Capture Page Screenshot          charging-wallet-success-{index}.png
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}

Mastercard (prepaid)
          Deposit Money via Stripe
          Wait Until Element Is Visible          id:cardNumber
          Capture Page Screenshot          stripe-{index}.png
          Wait Until Element Is Visible          id:cardNumber
          Click Element          id:cardNumber
          Sleep          2
          Input Text          id:cardNumber          ${MASTERCARD_PREPAID}
          Sleep          2
          Capture Page Screenshot          card-number-{index}.png
          Input Text          id:cardExpiry          1122
          Capture Page Screenshot          card-expiry-{index}.png
          ${cvc} =          Generate Random String          3          [NUMBERS]
          Input Text          id:cardCvc          ${cvc}
          Capture Page Screenshot          card-cvc-{index}.png
          Input Text          id:billingName          Skauto
          Submit Form
          Sleep          8
          Wait Until Element Is Visible          class:alert-success
          Capture Page Screenshot          charging-wallet-success-{index}.png
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}

American Express 1
          Deposit Money via Stripe
          Wait Until Element Is Visible          id:cardNumber
          Capture Page Screenshot          stripe-{index}.png
          Wait Until Element Is Visible          id:cardNumber
          Click Element          id:cardNumber
          Sleep          2
          Input Text          id:cardNumber          ${AMERICAN_EXPRESS_1}
          Sleep          2
          Capture Page Screenshot          card-number-{index}.png
          Input Text          id:cardExpiry          1122
          Capture Page Screenshot          card-expiry-{index}.png
          ${cvc} =          Generate Random String          3          [NUMBERS]
          Input Text          id:cardCvc          ${cvc}
          Capture Page Screenshot          card-cvc-{index}.png
          Input Text          id:billingName          Skauto
          Submit Form
          Sleep          8
          Wait Until Element Is Visible          class:alert-success
          Capture Page Screenshot          charging-wallet-success-{index}.png
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}

American Express 2
          Deposit Money via Stripe
          Wait Until Element Is Visible          id:cardNumber
          Capture Page Screenshot          stripe-{index}.png
          Wait Until Element Is Visible          id:cardNumber
          Click Element          id:cardNumber
          Sleep          2
          Input Text          id:cardNumber          ${AMERICAN_EXPRESS_2}
          Sleep          2          98431
          Capture Page Screenshot          card-number-{index}.png
          Input Text          id:cardExpiry          1122
          Capture Page Screenshot          card-expiry-{index}.png
          ${cvc} =          Generate Random String          3          [NUMBERS]
          Input Text          id:cardCvc          ${cvc}
          Capture Page Screenshot          card-cvc-{index}.png
          Input Text          id:billingName          Skauto
          Submit Form
          Sleep          8
          Wait Until Element Is Not Visible          xpath://div[@class='SubmitButton-IconContainer']
          Wait Until Element Is Not Visible          xpath://span[@class='SubmitButton-Text SubmitButton-Text--pre Text Text-color--default Text-fontWeight--500 Text--truncate']
          Wait Until Element Is Not Visible          xpath://div[@class='Icon Icon--md']//*[local-name()='svg']
          Wait Until Element Is Visible          class:alert-success
          Capture Page Screenshot          charging-wallet-success-{index}.png
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}

Logout
          LogoutKW
