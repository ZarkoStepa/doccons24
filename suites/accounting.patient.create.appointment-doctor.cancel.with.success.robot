*** Settings ***
Suite Setup             Open Testbrowser
Suite Teardown          Close All Browsers
Library                 String
Library                 SeleniumLibrary
Library                 XvfbRobot
Resource                _keywords.txt
Resource                _mysetup.txt

*** Variables ***
${TMP_PATH}             /tmp

*** Test Cases ***
Patient create appointment
          [Tags]          accounting
          [Setup]
          LoginKW
          Click Button          id:rq_btn3
          Capture Page Screenshot          before-input-appointment-{index}.png
          Click Element          id:reason
          Capture Page Screenshot          click-dropdown-list-{index}.png
          Click Element          xpath://option[contains(text(),'Follow up')]
          Capture Page Screenshot          select-reaseon-{index}.png
          Input Text          id:symptoms          Patient create and pay appointment
          Input Text          id:patient_notes          No translation fee
          Capture Page Screenshot          input-text-in-to-symptoms-and-notes-{index}.png
          Radio Button Should Be Set To          fk_appoint_type          2
          Capture Page Screenshot          before-first-appointment-{index}.png
          Click Button          id:rq_btn
          ${url} =          Get Location
          Log to console          ${url}
          Capture Page Screenshot          appointment-{index}.png
          Sleep          3
          #Click Element          xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
          Wait Until Element Is Visible          xpath=//div[contains(text(),'All appointment time are in german time. Please en')]
          Click Element          xpath=//div[contains(text(),'All appointment time are in german time. Please en')]
          Sleep          3
          Click Element          xpath://a[@id='ajax_payment']
          Capture Page Screenshot          pay-appointment-{index}.png
          Sleep          7
          LogoutKW

Doctor cancel appointment
          [Tags]          accounting
          [Setup]
          LoginDocKW
          Click Element          id:m_aside_left_offcanvas_toggle
          Click Element          xpath://span[contains(text(),'My appointments')]
          Capture Page Screenshot          go-to-my-appointment-{index}.png
          Wait Until Element Is Visible          xpath://tr[1]//td[3]//a[1]
          Click Element          xpath://tr[1]//td[3]//a[1]
          Capture Page Screenshot          in-an-appointment-{index}.png
          ${url} =          Get Location
          Log to console          ${url}
          Capture Page Screenshot          before-canceling-appointment-{index}.png
          Click Element          xpath://a[@class='btn btn-danger']
          Sleep          2
          Handle Alert
          Sleep          2
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}
          Capture Page Screenshot          after-canceling-appointment-{index}.png
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'Wallet')]
          Click Element          xpath://span[contains(text(),'Wallet')]
          Capture Page Screenshot          wallet-balance-{index}.png
          LogoutKW
          [Teardown]
