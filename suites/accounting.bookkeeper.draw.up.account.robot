*** Settings ***
Suite Setup             Open Testbrowser
Suite Teardown          Close All Browsers
Library                 SeleniumLibrary
Library                 String
Library                 XvfbRobot
Resource                _keywords.txt
Resource                _mysetup.txt

*** Variables ***
${TMP_PATH}             /tmp

*** Test Cases ***
Draw up account
          [Tags]          draw.up
          [Setup]
          LoginAdminKW
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Reports')]
          Click Element          xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Reports')]
          Sleep          2
          Wait Until Element Is Visible          xpath://span[contains(text(),'Accounting report')]
          Click Element          xpath://span[contains(text(),'Accounting report')]
          admin draw up account page
          Click Element          id:drawupaccount
          Sleep          30
          admin draw up account page
          Scroll Element Into View          xpath://table[1]/tbody[1]/tr[1]/td[1]
          Capture Page Screenshot          account-report-{index}.png
          Element Should Be Visible          xpath://table[1]/tbody[1]/tr[1]/td[1]
          Click Element          xpath://table[1]/tbody[1]/tr[1]/td[1]
          Wait Until Element Is Visible          xpath://tbody/tr[2]/td[1]/ul[1]/li[1]/span[1]
          Element Should Be Visible          xpath://tbody/tr[2]/td[1]/ul[1]/li[1]/span[1]
          Element Should Be Visible          xpath://span[contains(text(),'Currency')]
          Element Should Be Visible          xpath://span[contains(text(),'Address')]
          Element Should Be Visible          xpath://span[contains(text(),'City')]
          Element Should Be Visible          xpath://span[contains(text(),'Zip code')]
          Element Should Be Visible          xpath://span[contains(text(),'Country')]
          Element Should Be Visible          xpath://span[contains(text(),'IBAN')]
          Element Should Be Visible          xpath://span[contains(text(),'Bic')]
          Element Should Be Visible          xpath://tbody/tr[2]/td[1]/ul[1]/li[10]/span[1]
          Element Should Be Visible          xpath://tbody/tr[2]/td[1]/ul[1]/li[10]/span[2]/form[1]/button[1]
          Element Should Be Visible          xpath://span[@class='dtr-data']//button[@class='btn btn-primary m-btn m-btn--custom']
          Scroll Element Into View          xpath://span[@class='dtr-data']//button[@class='btn btn-primary m-btn m-btn--custom']
          Capture Page Screenshot          accounting-{index}.png
          #Click Element          xpath://table[1]/tbody[1]/tr[1]/td[1]
          ${id} =          Get Text          xpath://tbody[1]/tr[1]/td[1]
          Log To Console          ${id}
          ${accounting} =          Get Text          xpath://table[1]/tbody[1]/tr[1]/td[2]
          Log To Console          ${accounting}
          ${date} =          Get Text          //table[1]/tbody[1]/tr[1]/td[3]
          Log To Console          ${date}
          ${user_id} =          Get Text          xpath://table[1]/tbody[1]/tr[1]/td[4]
          Log To Console          ${user_id}
          ${name} =          Get Text          xpath://tbody[1]/tr[1]/td[5]
          Log To Console          ${name}
          ${subtotal} =          Get Text          xpath://table[1]/tbody[1]/tr[1]/td[6]
          Log To Console          ${subtotal}
          ${fee} =          Get Text          xpath://tbody[1]/tr[2]/td[1]/ul[1]/li[1]/span[2]
          Log To Console          ${fee}
          ${total} =          Get Text          xpath://tbody[1]/tr[2]/td[1]/ul[1]/li[2]/span[2]
          Log To Console          ${total}
          ${currency} =          Get Text          xpath://tbody[1]/tr[2]/td[1]/ul[1]/li[3]/span[2]
          Log To Console          ${currency}
          ${address} =          Get Text          xpath://tbody[1]/tr[2]/td[1]/ul[1]/li[4]/span[2]
          Log To Console          ${address}
          ${currency} =          Get Text          xpath://tbody[1]/tr[2]/td[1]/ul[1]/li[5]/span[2]
          Log To Console          ${currency}
          ${zip} =          Get Text          xpath://tbody[1]/tr[2]/td[1]/ul[1]/li[6]/span[2]
          Log To Console          ${zip}
          ${country} =          Get Text          xpath://tbody[1]/tr[2]/td[1]/ul[1]/li[7]/span[2]
          Log To Console          ${country}
          ${iban} =          Get Text          xpath://tbody[1]/tr[2]/td[1]/ul[1]/li[8]/span[2]
          Log To Console          ${iban}
          ${bic} =          Get Text          xpath://tbody[1]/tr[2]/td[1]/ul[1]/li[9]/span[2]
          Log To Console          ${bic}
          LogoutKW
          [Teardown]

Doctors wallet
          [Tags]          draw.up
          LoginDocKW
          Sleep          1
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'Wallet')]
          Wait Until Element Is Enabled          xpath://span[contains(text(),'Wallet')]
          Click Element          xpath://span[contains(text(),'Wallet')]
          #Element Text Should Be          xpath://div[2]/div[1]/div[2]/h1[2]          -200.00€
          ${wallet} =          Get Text          xpath://div[2]/div[1]/div[2]/h1[2]
          Log To Console          ${wallet}
          Capture Page Screenshot          doctors-wallet-{index}.png
          LogoutKW
