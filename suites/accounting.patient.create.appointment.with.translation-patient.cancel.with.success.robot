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
Patient create an appointment with translation
          [Tags]          accounting
          [Setup]
          LoginKW
          Click Button          id:rq_btn3
          Capture Page Screenshot          before-input-appointment-{index}.png
          Click Element          id:reason
          Click Element          xpath://option[contains(text(),'Follow up')]
          Input Text          id:symptoms          Patient create and pay appointment
          Input Text          id:patient_notes          No translation fee
          Radio Button Should Be Set To          fk_appoint_type          2
          Capture Page Screenshot          select-translation-{index}.png
          Wait Until Element Is Visible          xpath=//div[@class='col-8 col-form-label']//span
          Click Element          xpath=//div[@class='col-8 col-form-label']//span
          Capture Page Screenshot          before-first-appointment-{index}.png
          Click Button          id=rq_btn
          ${url} =          Get Location
          Log to console          ${url}
          Capture Page Screenshot          appointment-{index}.png
          Sleep          3
          Click Element          xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
          Click Element          xpath://div[contains(text(),'All appointment time are in german time. Please en')]
          Sleep          3
          Click Element          xpath://a[@id='ajax_payment']
          Sleep          2
          LogoutKW

Patient cancel appointment
          [Tags]          accounting
          [Setup]
          LoginKW
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
          Handle Alert
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}
          Capture Page Screenshot          after-canceling-appointment-{index}.png
          Sleep          2
          Click Element          id:m_aside_left_offcanvas_toggle
          Click Element          xpath://span[contains(text(),'Wallet')]
          Capture Page Screenshot          wallet-balance-{index}.png
          LogoutKW
          [Teardown]
