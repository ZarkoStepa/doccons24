*** Settings ***
Suite Setup             Open Testbrowser
Suite Teardown          Close All Browsers
Library                 SeleniumLibrary
Library                 XvfbRobot
Library                 String
Resource                _keywords.txt
Resource                _mysetup.txt

*** Variables ***
${TMP_PATH}             /tmp

*** Test Cases ***
Login
          [Tags]          admin.account.manager.patient
          [Setup]          Setup account manager Patient
          LoginAdminKW

Go to Patient profile to add a manager
          [Tags]          admin.account.manager.patient
          Sleep          2
          All Users page
          Input Text          xpath://label[contains(text(),'Search:')]//input          ${USEREMAIL}
          Sleep          2
          Capture Page Screenshot          search-doctor-{index}.png
          Click Element          xpath://a[@class='btn btn-success m-btn m-btn--icon m-btn--icon-only']
          Sleep          2
          Scroll Element Into View          xpath://label[contains(text(),'Phone*')]
          Click Element          xpath://a[@id='admi']
          Capture Page Screenshot          click-on-admin-linktext-{index}.png
          Click Element          xpath://button[@class='btn dropdown-toggle btn-default']
          Capture Page Screenshot          click-to-open-dropdown-list-{index}.png
          Click Element          xpath://span[contains(text(),'${MANAGERNAME} ${MANAGERLASTNAME}')]
          Capture Page Screenshot          select-accountm-manager-{index}.png
          Click Element          xpath://div[@id='m_user_profile_tab_9']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
          Capture Page Screenshot          click-save-changes-{index}.png
          ${alert-success} =          Get Text          class:alert-success
          Log To Console          ${alert-success}
          LogoutKW

*** Keywords ***
