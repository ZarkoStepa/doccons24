*** Settings ***
Suite Setup             Open Testbrowser
Suite Teardown          Close All Browsers
Test Setup
Test Template
Resource                _keywords.txt
Resource                _mysetup.txt
Library                 String
Library                 SeleniumLibrary
Library                 XvfbRobot

*** Variables ***
${TMP_PATH}             /tmp

*** Test Cases ***
Setup translation
          [Tags]          translation.fee
          Setup translation

Admin add a new translation
          [Tags]          translation.fee
          [Setup]
          LoginAdminKW
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Enabled          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath=//span[contains(text(),'Translation fees')]
          Wait Until Element Is Enabled          xpath=//span[contains(text(),'Translation fees')]
          Click Link          /translation_fees
          Sleep          3
          Click Link          /translation_fees/create
          Sleep          3

English translation
          [Tags]          translation.fee
          Admin Add new fee page
          Set Suite Variable          ${trasnaltionfee}
          Wait Until Element Is Visible          id:inputState
          Input Text          id:inputState          ${trasnaltionfee}
          Sleep          1
          Wait Until Element Is Visible          id:selectCountry
          Click Element          id:selectCountry
          Sleep          3
          Wait Until Element Is Visible          xpath://option[contains(text(),'English')]
          Click Element          xpath://option[contains(text(),'English')]
          Sleep          3
          Submit Form
          ${alert} =          Get Text          class:alert-important
          Log To Console          ${alert}
          Capture Page Screenshot          translation-{index}.png
          Sleep          3

French translation
          [Tags]          translation.fee
          Click Link          /translation_fees/create
          Sleep          1
          Input Text          id:inputState          ${trasnaltionfee}
          Sleep          1
          Click Element          id:selectCountry
          Sleep          3
          Click Element          xpath://option[contains(text(),'French')]
          Sleep          3
          Submit Form
          ${alert} =          Get Text          class:alert-success
          Log To Console          ${alert}
          Capture Page Screenshot          translation-{index}.png
          Sleep          3

Russian translation
          [Tags]          translation.fee
          Click Link          /translation_fees/create
          Sleep          1
          Input Text          id:inputState          ${trasnaltionfee}
          Sleep          1
          Click Element          id:selectCountry
          Sleep          3
          Click Element          xpath://option[contains(text(),'Russian')]
          Sleep          3
          Submit Form
          ${alert} =          Get Text          class:alert-success
          Log To Console          ${alert}
          Capture Page Screenshot          translation-{index}.png
          Sleep          3

Chinese translation
          [Tags]          translation.fee
          Click Link          /translation_fees/create
          Sleep          2
          Wait Until Element Is Enabled          id=inputState
          Input Text          id=inputState          ${trasnaltionfee}
          Sleep          3
          Wait Until Element Is Enabled          id=selectCountry
          Click Element          id=selectCountry
          Sleep          3
          Click Element          xpath=//option[contains(text(),'Chinese')]
          Sleep          3
          Submit Form
          ${alert} =          Get Text          class=alert-success
          Log To Console          ${alert}
          Capture Page Screenshot          translation-{index}.png
          Sleep          3

German translation
          [Tags]          translation.fee
          Click Link          /translation_fees/create
          Sleep          2
          Wait Until Element Is Enabled          id=inputState
          Input Text          id=inputState          ${trasnaltionfee}
          Sleep          3
          Wait Until Element Is Enabled          id=selectCountry
          Click Element          id=selectCountry
          Sleep          3
          Click Element          xpath=//option[contains(text(),'German')]
          Sleep          3
          Submit Form
          ${alert} =          Get Text          class=alert-success
          Log To Console          ${alert}
          Capture Page Screenshot          translation-{index}.png
          Sleep          3

Arabic translation
          [Tags]          translation.fee
          Click Link          /translation_fees/create
          Sleep          1
          Wait Until Element Is Enabled          id=inputState
          Input Text          id=inputState          ${trasnaltionfee}
          Sleep          3
          Click Element          id=selectCountry
          Sleep          3
          Click Element          xpath=//option[contains(text(),'Arabic')]
          Sleep          3
          Submit Form
          ${alert} =          Get Text          class=alert-success
          Log To Console          ${alert}
          Capture Page Screenshot          list-of-activated-tr-languages-{index}.png
          Sleep          3
          LogoutKW

Doctor speaks language
          [Tags]          translation.fee
          Doctor speaks language

Patient create an appointments for each translation
          [Documentation]          Remove all language which doctor speaks.
          ...          Book appointment with different language fee translation
          [Tags]          translation.fee
          [Setup]
          LoginKW
          Wait Until Element Is Visible          id=rq_btn3
          #1
          Sleep          3
          Click Element          id=rq_btn3
          Wait Until Element Is Visible          class=translation_fees
          Scroll Element Into View          class=translation_fees
          Capture Page Screenshot          fee-translations-{index}.png
          Input Text          id=patient_notes          appointment with English translation
          Wait Until Element Is Visible          xpath=//div[6]/label/span
          Sleep          3
          Click Element          xpath=//div[6]/label/span
          Capture Page Screenshot          english-{index}.png
          Sleep          3
          Wait Until Element Is Visible          id=rq_btn
          Click Element          id=rq_btn
          Toast message
          Click Element          id=ajax_payment
          Wait Until Element Is Visible          class=btn-group8
          Sleep          5
          Wait Until Element Is Visible          id=m_aside_left_offcanvas_toggle
          Click Element          id=m_aside_left_offcanvas_toggle
          Sleep          3
          Click Link          /doctors
          #2
          Wait Until Element Is Visible          id:rq_btn3
          Sleep          2
          Click Element          id:rq_btn3
          Input Text          id:patient_notes          appointment with Arabic translation
          Wait Until Element Is Visible          xpath://div[9]/label/span
          Sleep          2
          Click Element          xpath://div[9]/label/span
          Capture Page Screenshot          arabic-{index}.png
          Wait Until Element Is Visible          id:rq_btn
          Click Element          id:rq_btn
          Sleep          2
          Toast message
          Sleep          2
          Click Element          id=ajax_payment
          Wait Until Element Is Visible          class=btn-group8
          Sleep          5
          Wait Until Element Is Visible          id=m_aside_left_offcanvas_toggle
          Click Element          id=m_aside_left_offcanvas_toggle
          Sleep          2
          Click Link          /doctors
          #3
          Wait Until Element Is Visible          id=rq_btn3
          Sleep          2
          Click Element          id=rq_btn3
          Input Text          id=patient_notes          appointment with French translation
          Wait Until Element Is Visible          xpath=//div[12]/label/span
          Sleep          2
          Click Element          xpath=//div[12]/label/span
          Capture Page Screenshot          french-{index}.png
          Wait Until Element Is Visible          id=rq_btn
          Sleep          2
          Click Element          id=rq_btn
          Toast message
          Click Element          id=ajax_payment
          Wait Until Element Is Visible          class=btn-group8
          Sleep          5
          Click Element          id=m_aside_left_offcanvas_toggle
          Click Link          /doctors
          #4
          Wait Until Element Is Visible          id=rq_btn3
          Sleep          2
          Click Element          id=rq_btn3
          Input Text          id:patient_notes          appointment with German translation
          Wait Until Element Is Visible          xpath://div[15]/label/span
          Sleep          2
          Click Element          xpath=//div[15]/label/span
          Capture Page Screenshot          german-{index}.png
          Wait Until Element Is Visible          id=rq_btn
          Sleep          2
          Click Element          id=rq_btn
          Toast message
          Click Element          id=ajax_payment
          Wait Until Element Is Visible          class=btn-group8
          Sleep          5
          Wait Until Element Is Visible          id=m_aside_left_offcanvas_toggle
          Click Element          id=m_aside_left_offcanvas_toggle
          Click Link          /doctors
          #5
          Wait Until Element Is Visible          id=rq_btn3
          Click Element          id=rq_btn3
          Input Text          id=patient_notes          appointment with Russian translation
          Wait Until Element Is Visible          xpath=//div[18]/label/span
          Click Element          xpath=//div[18]/label/span
          Capture Page Screenshot          russian-{index}.png
          Wait Until Element Is Visible          id=rq_btn
          Click Element          id=rq_btn
          Toast message
          Click Element          id=ajax_payment
          Wait Until Element Is Visible          class=btn-group8
          Sleep          5
          Wait Until Element Is Visible          id=m_aside_left_offcanvas_toggle
          Click Element          id=m_aside_left_offcanvas_toggle
          Click Link          /doctors
          #6
          Wait Until Element Is Visible          id=rq_btn3
          Click Element          id=rq_btn3
          Input Text          id=patient_notes          appointment with Chinese translation
          Wait Until Element Is Visible          xpath=//div[21]/label/span
          Click Element          xpath=//div[21]/label/span
          Capture Page Screenshot          chinese-{index}.png
          Wait Until Element Is Visible          id=rq_btn
          Click Element          id=rq_btn
          Toast message
          Wait Until Element Is Visible          id=ajax_payment
          Click Element          id=ajax_payment
          Wait Until Element Is Visible          class=btn-group8
          Sleep          5
          Click Element          id=m_aside_left_offcanvas_toggle
          Click Link          /appointments
          Capture Page Screenshot          appointments-{index}.png
          LogoutKW
          [Teardown]

Delete translations
          [Tags]          translation.fee
          LoginAdminKW
          Wait Until Element Is Visible          id=m_aside_left_offcanvas_toggle
          Wait Until Element Is Enabled          id=m_aside_left_offcanvas_toggle
          Click Element          id=m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath=//span[contains(text(),'Translation fees')]
          Wait Until Element Is Enabled          xpath=//span[contains(text(),'Translation fees')]
          Click Link          /translation_fees
          Wait Until Element Is Visible          xpath=//table[1]/tbody[1]/tr[1]/td[3]/a[2]
          Click Element          xpath=//table[1]/tbody[1]/tr[1]/td[3]/a[2]
          Sleep          3
          Fee delete modal
          Wait Until Element Is Visible          xpath=//button[@class='btn btn-primary']
          Click Element          xpath=//button[@class='btn btn-primary']
          Capture Page Screenshot          Fee-has-been-deleted-successfully-{index}.png
          Sleep          3
          ${alert-success} =          Get Text          class=alert-success
          Log To Console          ${alert-success}
          Should Contain          Fee has been deleted successfully.          Fee has been deleted successfully.
          Wait Until Element Is Visible          xpath=//table[1]/tbody[1]/tr[1]/td[3]/a[2]
          Click Element          xpath=//table[1]/tbody[1]/tr[1]/td[3]/a[2]
          Sleep          3
          Fee delete modal
          Wait Until Element Is Visible          xpath=//button[@class='btn btn-primary']
          Click Element          xpath=//button[@class='btn btn-primary']
          Capture Page Screenshot          Fee-has-been-deleted-successfully-{index}.png
          Sleep          3
          ${alert-success} =          Get Text          class=alert-success
          Log To Console          ${alert-success}
          Should Contain          Fee has been deleted successfully.          Fee has been deleted successfully.
          Wait Until Element Is Visible          xpath=//table[1]/tbody[1]/tr[1]/td[3]/a[2]
          Click Element          xpath=//table[1]/tbody[1]/tr[1]/td[3]/a[2]
          Sleep          3
          Fee delete modal
          Wait Until Element Is Visible          xpath=//button[@class='btn btn-primary']
          Click Element          xpath=//button[@class='btn btn-primary']
          Capture Page Screenshot          Fee-has-been-deleted-successfully-{index}.png
          Sleep          3
          ${alert-success} =          Get Text          class=alert-success
          Log To Console          ${alert-success}
          Should Contain          Fee has been deleted successfully.          Fee has been deleted successfully.
          Wait Until Element Is Visible          xpath=//table[1]/tbody[1]/tr[1]/td[3]/a[2]
          Click Element          xpath=//table[1]/tbody[1]/tr[1]/td[3]/a[2]
          Sleep          3
          Fee delete modal
          Wait Until Element Is Visible          xpath=//button[@class='btn btn-primary']
          Click Element          xpath=//button[@class='btn btn-primary']
          Sleep          3
          Wait Until Element Is Visible          xpath=//table[1]/tbody[1]/tr[1]/td[3]/a[2]
          Click Element          xpath=//table[1]/tbody[1]/tr[1]/td[3]/a[2]
          Sleep          3
          Fee delete modal
          Wait Until Element Is Visible          xpath=//button[@class='btn btn-primary']
          Click Element          xpath=//button[@class='btn btn-primary']
          LogoutKW
          [Teardown]

Doctor speaks languages
          [Tags]          translation.fee
          Doctor speaks language
