*** Settings ***
Documentation           Test login and logout with ${USEREMAIL}
...
...                     Book 3 appointment, 2 should be canceled , and one without tanslation should be paid.
...
...                     Show location for all 3 appointements.
...
...                     Assert and verify login, logout page, appointment page, video session page
Suite Setup             Open Testbrowser
Suite Teardown          Close All Browsers
Library                 SeleniumLibrary
Library                 XvfbRobot
Resource                _mysetup.txt
Resource                _keywords.txt
Library                 DateTime
Library                 String

*** Variables ***
${TMP_PATH}             /tmp

*** Test Cases ***
Patient books 3 appointments - success
          [Tags]          patient.appointment
          LoginKW
          #1st appointment
          Wait Until Element Is Visible          id:rq_btn3
          Click Button          id:rq_btn3
          Capture Page Screenshot          before-input-appointment-{index}.png
          Click Element          id:reason
          Click Element          xpath://option[contains(text(),'Follow up')]
          Input Text          id:symptoms          Awaiting Payment
          Input Text          id:patient_notes          This is my 1st appointment
          Radio Button Should Be Set To          fk_appoint_type          2
          Radio Button Should Be Set To          translation          0
          Capture Page Screenshot          before-first-appointment-{index}.png
          Click Element          id:rq_btn
          ${url} =          Get Location
          Log to console          ${url}
          Capture Page Screenshot          first-appointment-{index}.png
          Wait Until Element Is Visible          xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
          Wait Until Element Is Visible          xpath://div[contains(text(),'All appointment time are in german time. Please en')]
          Click Element          xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
          Click Element          xpath://div[contains(text(),'All appointment time are in german time. Please en')]
          Sleep          3
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Enabled          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'Book an appointment')]
          Click Link          /doctors
          #2nd appointment
          Click Button          id:rq_btn3
          Capture Page Screenshot          before-input-appointment-{index}.png
          Click Element          id:reason
          Click Element          xpath://option[contains(text(),'Follow up')]
          Input Text          id:symptoms          Cancelled
          Input Text          id:patient_notes          This is my 2nd appointment
          Radio Button Should Be Set To          fk_appoint_type          2
          Click Button          id:rq_btn
          ${url1} =          Get Location
          Log to console          ${url1}
          Capture Page Screenshot          second-appointment-{index}.png
          Wait Until Element Is Visible          xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
          Wait Until Element Is Visible          xpath://div[contains(text(),'All appointment time are in german time. Please en')]
          Click Element          xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
          Click Element          xpath://div[contains(text(),'All appointment time are in german time. Please en')]
          Sleep          3
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Enabled          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'Book an appointment')]
          Click Link          /doctors
          #3rd appointment
          Click Button          id:rq_btn3
          Capture Page Screenshot          before-input-appointment-{index}.png
          Click Element          id:reason
          Click Element          xpath://option[contains(text(),'Follow up')]
          Input Text          id:symptoms          Confirmed
          Input Text          id:patient_notes          This is my 3rd appointment
          Radio Button Should Be Set To          fk_appoint_type          2
          Radio Button Should Be Set To          translation          0
          Click Button          id:rq_btn
          ${url2} =          Get Location
          Log to console          ${url2}
          Wait Until Element Is Visible          xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
          Wait Until Element Is Visible          xpath://div[contains(text(),'All appointment time are in german time. Please en')]
          Capture Page Screenshot          third-appointment-{index}.png
          Click Element          xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
          Click Element          xpath://div[contains(text(),'All appointment time are in german time. Please en')]
          Sleep          3
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Enabled          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'Book an appointment')]
          Click Link          /appointments
          Element Should Be Visible          id:appointmentTable_wrapper
          Capture Page Screenshot          all-appointment-{index}.png
          LogoutKW

The patient sees an appointment in my appointments
          [Tags]          patient.appointment
          LoginKW
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'My appointments')]
          Click Link          /appointments
          Element Should Be Visible          id:appointmentTable_wrapper
          Element Should Be Visible          id:appointmentTable
          Wait Until Page Contains Element          id:appointmentTable_wrapper
          Capture Page Screenshot          my-appointments-{index}.png
          Patient my appointment page
          Wait Until Element Is Visible          xpath://tr[1]//td[3]//a[1]
          Click Element          xpath://tr[1]//td[3]//a[1]
          Appointments page
          Capture Page Screenshot          first-appointment-preview-{index}.png
          ${url}          Get Location
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'My appointments')]
          Click Element          xpath://span[contains(text(),'My appointments')]
          Patient my appointment page
          Wait Until Element Is Visible          xpath://tr[1]//td[3]//a[1]
          Click Element          xpath://tr[1]//td[3]//a[1]
          Appointments page
          Capture Page Screenshot          second-appointment-preview-{index}.png
          ${url1}          Get Location
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'My appointments')]
          Click Element          xpath://span[contains(text(),'My appointments')]
          Patient my appointment page
          Wait Until Element Is Visible          xpath://tr[1]//td[3]//a[1]
          Click Element          xpath://tr[1]//td[3]//a[1]
          Appointments page
          ${url2}          Get Location
          Capture Page Screenshot          third-appointment-preview-{index}.png
          LogoutKW

Patient navigate to appointment
          [Tags]          patient.appointment
          LoginKW
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Capture Page Screenshot          before-click-my-appointment-{index}.png
          Wait Until Element Is Visible          xpath://span[contains(text(),'My appointments')]
          Click Element          xpath://span[contains(text(),'My appointments')]
          Patient my appointment page
          Element Should Be Visible          id:appointmentTable_wrapper
          Element Should Be Visible          id:appointmentTable
          Capture Page Screenshot          before-click-element-on-appointment-{index}.png
          #add sleep 3sec
          Wait Until Element Is Visible          xpath://tr[1]//td[3]//a[1]
          Click Element          xpath://tr[1]//td[3]//a[1]
          Capture Page Screenshot          after-click-appointment-{index}.png
          ${url} =          Get Location
          Log to console          ${url}
          Capture Page Screenshot          before-offcanvas-{index}.png
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Capture Page Screenshot          before-click-element-on-appointment-{index}.png
          Wait Until Element Is Visible          xpath://span[contains(text(),'My appointments')]
          Click Element          xpath://span[contains(text(),'My appointments')]
          Element Should Be Visible          id:appointmentTable_wrapper
          Element Should Be Visible          id:appointmentTable
          Capture Page Screenshot          before-click-element-on-appointment-{index}.png
          Wait Until Element Is Visible          xpath://tr[2]//td[3]//a[1]
          Click Element          xpath://tr[2]//td[3]//a[1]
          ${url1} =          Get Location
          Log to console          ${url1}
          Capture Page Screenshot          before-offcanvas-{index}.png
          Click Element          id:m_aside_left_offcanvas_toggle
          Capture Page Screenshot          before-click-element-on-appointment-{index}.png
          Wait Until Element Is Visible          xpath://span[contains(text(),'My appointments')]
          Click Element          xpath://span[contains(text(),'My appointments')]
          Element Should Be Visible          id:appointmentTable_wrapper
          Element Should Be Visible          id:appointmentTable
          Capture Page Screenshot          before-click-element-on-appointment-{index}.png
          Wait Until Element Is Visible          xpath://tr[3]//td[3]//a[1]
          Click Element          xpath://tr[3]//td[3]//a[1]
          ${url2} =          Get Location
          Log to console          ${url2}
          Capture Page Screenshot          before-click-logout-{index}.png
          LogoutKW

Patient cancel appointment - canceled appointment has disappeared
          [Tags]          patient.appointment
          LoginKW
          Wait Until Page Contains Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'My appointments')]
          Click Link          /appointments
          Element Should Be Visible          id:appointmentTable_wrapper
          Wait Until Element Is Visible          xpath://tr[1]//td[3]//a[1]
          Click Element          xpath://tr[2]//td[3]//a[1]
          ${url1}          Select Window
          Appointments page
          Capture Page Screenshot          preview-appointment-{index}.png
          Click Element          xpath://a[@class='btn btn-danger']
          Sleep          1
          Handle Alert
          ${alert} =          Get Text          class:alert-success
          Log To Console          ${alert}
          Capture Page Screenshot          patient-after-canceling-appointment-{index}.png
          Wait Until Element Is Visible          xpath://span[@class='m-badge m-badge--brand m-badge--wide m-appointment-title-btn m-color-status-cancelled']
          Element Text Should Be          xpath://span[@class='m-badge m-badge--brand m-badge--wide m-appointment-title-btn m-color-status-cancelled']          Cancelled
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'My appointments')]
          Click Element          xpath://span[contains(text(),'My appointments')]
          Wait Until Element Is Visible          id:appointmentTable_wrapper
          Capture Page Screenshot          canceled-appointment-{index}.png
          LogoutKW

Patient pays one appointment - the status of appointment has changed
          [Tags]          patient.appointment
          LoginKW
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'My appointments')]
          Click Element          xpath://span[contains(text(),'My appointments')]
          Element Should Be Visible          id:appointmentTable_wrapper
          Wait Until Element Is Visible          xpath://tr[1]//td[3]//a[1]
          Click Element          xpath://tr[1]//td[3]//a[1]
          ${url2}          Select Window
          Appointments page
          Capture Page Screenshot          preview-appointment-{index}.png
          Wait Until Element Is Visible          id:ajax_payment
          Click Element          id:ajax_payment
          Wait Until Element Is Visible          class:btn-group8
          Wait Until Element Is Not Visible          id:ajax_payment
          Capture Page Screenshot          status-appointment-before-{index}.png
          Sleep          5
          Wait Until Element Is Visible          xpath://a[@class='btn btn-success']
          Capture Page Screenshot          status-appointment-{index}.png
          Sleep          2
          LogoutKW

*** Keywords ***
Open Testbrowser
          ${system}=          Evaluate          platform.system()          platform
          Run Keyword If          '${system}' == 'Linux'          Start Virtual Display          1920          1080
          Open Chrome Browser

Open Chrome Browser
          ${options}          Evaluate          sys.modules['selenium.webdriver'].ChromeOptions()          sys, selenium.webdriver
          Call Method          ${options}          add_argument          --no-sandbox
          ${prefs}          Create Dictionary          download.default_directory=${TMP_PATH}
          Call Method          ${options}          add_experimental_option          prefs          ${prefs}
          Create Webdriver          Chrome          chrome_options=${options}
