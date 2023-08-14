*** Settings ***
Suite Setup             Open Testbrowser
Suite Teardown          Close All Browsers
Library                 String
Library                 XvfbRobot
Library                 SeleniumLibrary
Resource                _keywords.txt
Resource                _mysetup.txt

*** Variables ***
${TMP_PATH}             /tmp

*** Test Cases ***
Manager withdraw amount
          [Tags]          withdrawal.requests
          LoginManagerKW
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'Wallet')]
          Click Element          xpath://span[contains(text(),'Wallet')]
          Patient Wallet page
          ${balance} =          Get Text          xpath://h1[@class='text-color-gray']
          Log To Console          ${balance}
          Sleep          3
          Click Element          xpath://button[@class='send-modal btn btn-primary']
          Sleep          3
          Patient Withdraw Request modal
          ${withdraw} =          Generate Random String          1          [NUMBERS]
          Input Text          id:amount          1${withdraw}
          Capture Page Screenshot          amount-{index}.png
          Click Element          xpath://span[@id='footer_action_button']
          Sleep          5
          Scroll Element Into View          xpath://table[1]/tbody[1]/tr[2]/th[1]
          Capture Page Screenshot          withdraw-amount-request-{index}.png
          ${balance} =          Get Text          xpath://h1[@class='text-color-gray']
          Log To Console          ${balance}
          ${id} =          Get Text          xpath://th[@class='sorting_desc']
          Log To Console          ${id}
          ${id} =          Get Text          xpath://tbody[1]/tr[1]/th[1]
          Log To Console          ${id}
          ${amount} =          Get Text          xpath://th[contains(text(),'Amount')]
          Log To Console          ${amount}
          ${amount} =          Get Text          xpath://table[1]/tbody[1]/tr[1]/td[1]
          Log To Console          ${amount}
          ${current_balance} =          Get Text          xpath://th[contains(text(),'Current Balance')]
          Log To Console          ${current_balance}
          ${current_balance} =          Get Text          xpath://tbody[1]/tr[1]/td[2]
          Log To Console          ${current_balance}
          ${status} =          Get Text          xpath://th[contains(text(),'Status')]
          Log To Console          ${status}
          ${status} =          Get Text          xpath://tbody[1]/tr[1]/td[3]
          Log To Console          ${status}
          LogoutKW
          [Teardown]

Bookkeeper approve amount
          [Tags]          withdrawal.requests
          [Setup]
          LoginAdminKW
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'Withdrawal requests')]
          Click Element          xpath://span[contains(text(),'Withdrawal requests')]
          Admin Withdrawal Requests page
          Scroll Element Into View          xpath://table[1]/tbody[1]/tr[2]/th[1]
          Capture Page Screenshot          withdraw-amount-{index}.png
          Wait Until Element Is Visible          xpath://tbody[1]/tr[1]/td[5]/form[1]/button[1]
          Click Element          xpath://tbody[1]/tr[1]/td[5]/form[1]/button[1]
          Scroll Element Into View          xpath://table[1]/tbody[1]/tr[2]/th[1]
          Capture Page Screenshot          appove-withdraw-amount-{index}.png
          ${id} =          Get Text          xpath://th[contains(text(),'ID')]
          Log To Console          ${id}
          ${id} =          Get Text          xpath://tbody[1]/tr[1]/th[1]
          Log To Console          ${id}
          ${customer} =          Get Text          xpath://th[contains(text(),'Customer')]
          Log To Console          ${customer}
          ${customer} =          Get Text          xpath://table[1]/tbody[1]/tr[1]/td[1]
          Log To Console          ${customer}          .
          ${current_balance} =          Get Text          xpath://th[contains(text(),'Current Balance')]
          Log To Console          ${current_balance}
          ${current_balance} =          Get Text          xpath://tbody[1]/tr[1]/td[2]
          Log To Console          ${current_balance}
          ${amount} =          Get Text          xpath://th[contains(text(),'Amount')]
          Log To Console          ${amount}
          ${amount} =          Get Text          xpath://table[1]/tbody[1]/tr[1]/td[3]
          Log To Console          ${amount}
          ${status} =          Get Text          xpath://th[contains(text(),'Status')]
          Log To Console          ${status}
          ${status} =          Get Text          xpath://tbody[1]/tr[1]/td[4]
          Log To Console          ${status}
          LogoutKW
          [Teardown]
