*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Resource          _mysetup.txt
Resource          _keywords.txt
Library           SeleniumLibrary
Library           String
Library           XvfrbRobot

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Login
    LoginKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /appointments
    Click Element    xpath://a[@class='rsc btn btn-default hor_menu'][contains(text(),'New')]
    Click Element    css:body.m-page--fluid.m--skin-.m-content--skin-light2.m-header--fixed.m-header--fixed-mobile.m-aside-left--enabled.m-aside-left--skin-dark.m-aside-left--offcanvas.m-footer--push.m-aside--offcanvas-default:nth-child(2) div.m-grid.m-grid--hor.m-grid--root.m-page:nth-child(9) div.m-grid__item.m-grid__item--fluid.m-grid.m-grid--ver-desktop.m-grid--desktop.m-body.m-backcolorarray:nth-child(2) div.m-grid__item.m-grid__item--fluid.m-wrapper:nth-child(5) div.m-content div.row div.col-md-12 div.m-section div.m-section__content div.scrol:nth-child(2) div.dataTables_wrapper.no-footer table.table.table-striped.table-bordered.dataTable.no-footer tbody:nth-child(2) tr.odd:nth-child(1) td:nth-child(3) > a.btn.btn-primary.btn-sm.m-appointment-title-btn

Go To Wallet
    [Tags]
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    open-sidebar-menu-{index}.png
    Click Element    xpath://span[contains(text(),'Wallet')]
    Capture Page Screenshot    click-on-wallet-link-text-{index}.png
    Sleep    5
    Patient Wallet page
    Capture Page Screenshot    account-manager-wallet-page-{index}.png

Deposit Amount
    [Tags]
    Input Text    id:depositAmount    ${AMOUNT}
    Capture Page Screenshot    input-amount-{index}.png
    Click Element    id:paymentButton
    Capture Page Screenshot    after-click-paypal-button-{index}.png
    Sleep    5
    Click Element    xpath://button[@class='btn btn-primary btn-large']//img
    Capture Page Screenshot    deposit-via-paypal-{index}.png
    #todo
    Sleep    5
    Click Element    id:acceptAllButton
    Sleep    5
    Click Element    class:baslLoginButtonContainer
    Sleep    5
    Input Text    id:email    ${PAYPALUSER}
    Capture Page Screenshot    paypal-input-email-{index}.png
    Sleep    10
    Click Element    id:btnNext
    Capture Page Screenshot    click-button-next-{index}.png
    Sleep    5
    Input Text    id:password    ${PAYPALPW}
    Capture Page Screenshot    paypal-input-password-{index}.png
    Click Element    xpath://label[@class='checkboxLabel']
    Capture Page Screenshot    click-checkbox-{index}.png
    Click Element    id:btnLogin
    Capture Page Screenshot    click-login-button-{index}.png
    #Sleep    5
    #Element Should Be Visible    id:preloaderSpinner
    #Capture Page Screenshot    spinner-shold-be-present-{index}.png
    Sleep    15
    #Wait Until Element Is Visible    xpath://button[@class='btn full confirmButton continueButton']
    Capture Page Screenshot    before-paypal-confirm-{index}.png
    #Click Element    id:acceptAllButton
    #Scroll Element Into View    id:confirmButtonTop
    #Scroll Element Into View    xpath://span[contains(text(),"Cancel and return to test facilitator's Test Store")]
    Sleep    3
    Click Element    id:payment-submit-btn
    #Click Element    xpath://button[@id='payment-submit-btn']
    #Click Element    xpath://button[@class='btn full confirmButton continueButton']
    #Click Button    id:confirmButtonTop
    Capture Page Screenshot    paypal-confirm-{index}.png
    Sleep    3
    #Wait Until Element Is Visible    id:confirmButtonTop
    #Click Element    id:confirmButtonTop
    Capture Page Screenshot    confirm-amount-{index}.png
    Sleep    8
    Wait Until Element Is Visible    xpath://div[@class='alert alert-success']
    ${alert} =    Get Text    class:alert-success
    Log To Console    ${alert}
    Capture Page Screenshot    succeess-transaction-{index}.png

speedtest
    [Tags]
    Go To    https://www.speedtest.net/th
    Wait Until Element Is Visible    id:_evidon-banner-acceptbutton
    Click Element    id:_evidon-banner-acceptbutton
    Wait Until Element Is Visible    class:start-text
    Wait Until Element Is Visible    xpath://div[@class='result-item result-item-host result-item-align-left result-item-icon']//a[@class='btn-server-select'][contains(text(),'Change Server')]
    Sleep    3
    Click Element    class:start-text
    Sleep    40
    Wait Until Element Is Visible    xpath://span[@class='result-data-large number result-data-value download-speed']
    Wait Until Element Is Visible    xpath://span[@class='result-data-large number result-data-value upload-speed']
    Capture Page Screenshot    resoult-{index}.png
