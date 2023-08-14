*** Settings ***
Suite Setup             Open Testbrowser
Suite Teardown          Close All Browsers
Resource                _keywords.txt
Resource                _mysetup.txt
Library                 String
Library                 XvfbRobot
Library                 SeleniumLibrary

*** Variables ***
${TMP_PATH}             /tmp

*** Test Cases ***
Login
          [Tags]          all.logs
          LoginManagerKW

Doctors log
          [Tags]          all.logs
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Click Link          /account_manager
          Manager doc wrapper
          Click Element          link:All Logs
          Capture Page Screenshot          doctors-log-{index}.png
          Doctors Log table

Patient log
          [Tags]          all.logs
          Wait Until Element Is Visible          id:m_aside_left_offcanvas_toggle
          Click Element          id:m_aside_left_offcanvas_toggle
          Wait Until Element Is Visible          xpath://body[contains(@class,'m-page--fluid m--skin- m-content--skin-light2 m-header--fixed m-header--fixed-mobile m-aside-left--enabled m-aside-left--skin-dark m-aside-left--offcanvas m-footer--push m-aside--offcanvas-default m-aside-left--on')]/div[contains(@class,'m-grid m-grid--hor m-grid--root m-page')]/div[contains(@class,'m-grid__item m-grid__item--fluid m-grid m-grid--ver-desktop m-grid--desktop m-body')]/div[@id='m_aside_left']/div[@id='m_ver_menu']/ul[contains(@class,'m-menu__nav--dropdown-submenu-arrow')]/li[4]/a[1]/span[1]
          Click Element          xpath://a[contains(@class,'m-menu__link m-menu__toggle')]//span[contains(@class,'m-menu__link-text')][contains(text(),'Users')]
          Wait Until Element Is Visible          xpath://a[contains(@class,'m-menu__link m-menu__toggle')]//span[contains(@class,'m-menu__link-text')][contains(text(),'Users')]
          #          find path to skip Sleep
          Sleep          1
          Click Link          /list_patients
          Manager pat wrapper
          Click Element          link:All Logs
          Patient Log table

Logout
          LogoutKW
