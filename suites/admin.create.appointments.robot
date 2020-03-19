*** Settings ***
Documentation     Test login with ${DOCUSER}${EMAIL} and create new session link
...
...               View invitation email with ${DOCEMAIL}
...
...               Assert and verify login page, session link page, Create Video Room ID modal dialog
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Login
    [Documentation]    log in
    [Tags]    admin.create.appointments
    LoginAdminKW

Create new session link
    [Documentation]    create new session
    [Tags]    admin.create.appointments
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Create Session Link')]
    Capture Page Screenshot    Random-hash-link-for-sessions-{index}.png
    Click Element    xpath://button[@class='send-modal btn btn-primary']
    #Click Element    xpath://button[@class='send-modal btn btn-primary']
    Create Video Room ID modal
    Input Text    id:email    ${DOCEMAIL}
    Capture Page Screenshot    input-email-{index}.png
    Click Element    id:footer_action_button
    Capture Page Screenshot    after-footer-action-{index}.png
    Admin Session link page
    #Wait Until Element Is Visible    xpath://table[@id='sessionTable']/tbody/tr[1]/td[6]/div/div/button
    #Click Element    xpath://*[@id="sessionTable"]/tbody/tr[1]/td[6]/div/div/button
    #here
    #Wait Until Element Is Visible    xpath://div[@id='windowModalForSendingMailUsers']//div[@class='modal-header']
    #Element Should Be Visible    xpath://div[@id='windowModalForSendingMailUsers']//div[@class='modal-header']
    #Element Should Be Visible    xpath://div[@id='windowModalForSendingMailUsers']//button[@class='close'][contains(text(),'×')]
    #Element Text Should Not Be    xpath://div[@id='windowModalForSendingMailUsers']//button[@class='close'][contains(text(),'×')]    ×
    #Element Should Be Enabled    xpath://div[@id='windowModalForSendingMailUsers']//button[@class='close'][contains(text(),'×')]
    #Element Should Be Visible    xpath://div[@id='windowModalForSendingMailUsers']//h4[@class='modal-title'][contains(text(),'Invite guest to video')]
    #Element Text Should Not Be    xpath://div[@id='windowModalForSendingMailUsers']//h4[@class='modal-title'][contains(text(),'Invite guest to video')]    Invite guest to video
    #Element Should Be Visible    xpath://div[@id='windowModalForSendingMailUsers']//div[@class='modal-body']
    #Element Should Be Visible    xpath://label[contains(text(),'ID Room')]
    #Element Text Should Not Be    xpath://label[contains(text(),'ID Room')]    ID Room
    #Element Should Be Visible    id:roomid
    #Element Should Be Disabled    id:roomid
    #Element Text Should Not Be    id:roomid    Empty
    #Element Should Be Visible    xpath://div[@id='windowModalForSendingMailUsers']//label[@class='control-label col-sm-2'][contains(text(),'Enter email')]
    #Element Text Should Be    xpath://div[@id='windowModalForSendingMailUsers']//label[@class='control-label col-sm-2'][contains(text(),'Enter email')]    Enter email
    #Element Should Be Visible    id:email2
    #Element Should Be Enabled    id:email2
    #Element Should Be Visible    xpath://div[@id='windowModalForSendingMailUsers']//div[@class='modal-footer']
    #Element Should Be Visible    xpath://*[@id="windowModalForSendingMailUsers"]/div/div/div[2]/div/button[1]
    #Element Text Should Be    xpath://*[@id="windowModalForSendingMailUsers"]/div/div/div[2]/div/button[1]    Send Invitation to Guest
    #Element Should Be Visible    xpath://*[@id="windowModalForSendingMailUsers"]/div/div/div[2]/div/button[2]
    #Element Text Should Be    xpath://*[@id="windowModalForSendingMailUsers"]/div/div/div[2]/div/button[2]    Close
    LogoutKW

Doctor check email
    [Documentation]    Test logout and check invitation email
    [Tags]    admin.create.appointments
    GoTo    ${email_server}
    Click Element    xpath://input[@id='inbox_field']
    Clear Element Text    xpath://input[@id='inbox_field']
    Input Text    xpath://input[@id='inbox_field']    ${DOCUSER}
    Click Element    xpath://button[@id='go_inbox']
    #Click Element    xpath://a[@class='cc-btn cc-dismiss']
    Sleep    2
    #Click Element    css:body.nav-md.ng-scope:nth-child(2) div.container.body:nth-child(2) div.main_container div.right_col:nth-child(3) div.col-md-12.col-sm-12.col-xs-12:nth-child(8) div.x_panel div.x_content div.table-responsive:nth-child(1) table.table.table-striped.jambo_table tbody:nth-child(2) tr.even.pointer.ng-scope:nth-child(1) td:nth-child(4) > a.ng-binding
    #Sleep    2
    Capture Page Screenshot    delete-email-{index}.png
    #Click Element    xpath://body[@id='InboxCtrl']/div[@class='container body']/div[@class='main_container']/div[@class='right_col']/div/div[@id='inbox_page_title']/div[@class='title_left']/div[@class='col-md-11 col-sm-11 col-xs-11 form-group pull-left top_search']/div/button[@id='trash_but']/*[1]
    [Teardown]
