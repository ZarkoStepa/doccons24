*** Settings ***
Documentation           Test login and logout with ${MANEMAIL}
...
...                     Assert and werify all pages with ${MANEMAIL}
Suite Setup             Open Testbrowser
Suite Teardown          Close All Browsers
Library                 SeleniumLibrary
Library                 XvfbRobot
Resource                _mysetup.txt
Resource                _keywords.txt
Library                 RequestsLibrary

*** Variables ***
${TMP_PATH}             /tmp

*** Test Cases ***
Login
          [Tags]          manager.navigate.all.links
          LoginManagerKW

Users
          [Tags]          manager.navigate.all.links
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Click Element          xpath://span[contains(text(),'Doctors')]
          Capture Page Screenshot          after-clicking-doctors-link-{index}.png
          Manager doc wrapper
          Click Element          id:m_aside_left_offcanvas_toggle
          Click Element          xpath://span[contains(text(),'Patients')]
          Capture Page Screenshot          after-clicking-patients-link-{index}.png
          Manager pat wrapper

All appointments
          [Tags]          manager.navigate.all.links
          Wait Until Element Is Visible          id=m_aside_left_offcanvas_toggle
          Click Element          id=m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath=//span[contains(text(),'All appointments')]
          Click Element          xpath=//span[contains(text(),'All appointments')]
          Element Should Be Visible          xpath=//h3[@class='m-subheader__title m-pageheading']
          Element Text Should Be          xpath=//h3[@class='m-subheader__title m-pageheading']          Appointments
          Wait Until Element Is Visible          xpath=//tr[1]//td[1]
          Click Element          xpath=//tr[1]//td[1]
          All Appointments
          Element Should Be Visible          id=appointmentTable_info
          Element Should Be Visible          id=appointmentTable_paginate
          Element Should Be Visible          id=appointmentTable_previous
          Element Text Should Be          id=appointmentTable_previous          Previous
          Element Should Be Visible          id=appointmentTable_next
          Element Text Should Be          id=appointmentTable_next          Next

Book appointments
          [Tags]          manager.navigate.all.links
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Click Element          xpath://span[contains(text(),'Book an appointment')]
          Capture Page Screenshot          after-clicking-book-an-appointment-link-{index}.png
          Element Should Be Visible          xpath://h3[@class='m-subheader__title m-subheader__title--separator m-pageheading']
          Element Text Should Be          xpath://h3[@class='m-subheader__title m-subheader__title--separator m-pageheading']          Doctors
          Patient Search Doctor page
          Capture Page Screenshot          search-doctor-page-{index}.png

Wallet
          [Tags]          manager.navigate.all.links
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Click Element          xpath://span[contains(text(),'Wallet')]
          Capture Page Screenshot          after-clicking-wallet-link-{index}.png
          Patient Wallet page
          Capture Page Screenshot          wallet-page-{index}.png

Transfer money
          [Tags]          manager.navigate.all.links
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Sleep          1
          Wait Until Element Is Visible          xpath://span[contains(text(),'Transfer money')]
          Click Element          xpath://span[contains(text(),'Transfer money')]
          Capture Page Screenshot          after-clicking-transfer-money-link-{index}.png
          Manager Transfer page
          Capture Page Screenshot          transfer-money-page-{index}.png

Profile
          [Tags]          manager.navigate.all.links
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Sleep          1
          Click Element          xpath://span[contains(text(),'Profile')]
          Capture Page Screenshot          after-clicking-profile-link-{index}.png
          Click Element          xpath://a[contains(@class,'nav-link m-tabs__link dropdown-toggle')]
          Capture Page Screenshot          after-clicking-dropdown-{index}.png
          Click Element          xpath://a[contains(text(),'Personal info')]
          Capture Page Screenshot          manager-personal-info-page-{index}.png
          Personal Info page
          Click Element          xpath://a[contains(@class,'nav-link m-tabs__link dropdown-toggle')]
          Click Element          xpath://a[contains(text(),'Account info')]
          Capture Page Screenshot          after-clicking-account-info-link-{index}.png
          Scroll Element Into View          xpath://div[@id='m_user_profile_tab_2']//button[contains(@class,'btn btn-secondary m-btn m-btn--custom')][contains(text(),'Cancel')]
          Capture Page Screenshot          manager-account-info-page-{index}.png
          Account Info page
          Click Element          xpath://a[contains(@class,'nav-link m-tabs__link dropdown-toggle')]
          Click Element          xpath://a[contains(text(),'Location')]
          Capture Page Screenshot          manager-location-info-page-{index}.png
          Location page
          Click Element          xpath://a[contains(text(),'Payment info')]
          Capture Page Screenshot          after-clicking-payment-info-link-{index}.png
          Payment Info page
          Capture Page Screenshot          manager-payment-info-page-{index}.png
          Click Element          xpath://a[contains(text(),'Change password')]
          Change Password page
          Capture Page Screenshot          manager-password-change-page-{index}.png

Reports
          [Tags]          manager.navigate.all.links
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Sleep          1
          Click Element          xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Reports')]
          Click Element          xpath://span[contains(text(),'Payment report')]
          Payment report page
          Element Should Be Visible          xpath://h3[@class='m-subheader__title heading-text-color']
          Element Text Should Be          xpath://h3[@class='m-subheader__title heading-text-color']          Payment Report
          #Login History
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://span[contains(text(),'Login history')]
          Click Element          xpath://span[contains(text(),'Login history')]
          Capture Page Screenshot          after-clicking-login-history-{index}.png
          Manager Login History page
          Click Element          xpath://h3[@class='m-subheader__title heading-text-color']

Languages
          [Tags]          manager.navigate.all.links
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          #Click Element          xpath://a[@id='languages_a']//span[@class='m-menu__link-text'][contains(text(),'Languages')]
          Capture Page Screenshot          languages-{index}.png
          Element Should Be Visible          xpath://span[contains(text(),'English')]
          Element Text Should Be          xpath://span[contains(text(),'English')]          English
          Element Should Be Visible          xpath://span[contains(text(),'German')]
          Element Text Should Be          xpath://span[contains(text(),'German')]          German
          Element Should Be Visible          xpath://span[contains(text(),'Arabic')]
          Element Text Should Be          xpath://span[contains(text(),'Arabic')]          Arabic

Help
          [Tags]          manager.navigate.all.links
          Wait Until Element Is Visible          xpath://span[contains(text(),'Help')]
          Click Element          xpath://span[contains(text(),'Help')]
          Help page
          Capture Page Screenshot          help-page-{index}.png

System Check
          [Tags]          manager.navigate.all.links
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Click Element          xpath://span[contains(text(),'System Check')]
          Sleep          5
          System Check page
          Capture Page Screenshot          system-check-page-{index}.png

Logout
          [Tags]          manager.navigate.all.links
          LogoutKW

*** Keywords ***
