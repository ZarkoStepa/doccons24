*** Settings ***
Documentation     Test login and logout with ${ADMIN}
...
...               Assert and verify all pages, delete modal dialog for clinic.
...
...               Setup Clinic with ${ADMIN} and activate. For assertation and verification Hospital page+table.
...
...               Delete Hospital.
...
...               Should present one inactive user
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _keywords.txt
Resource          _mysetup.txt
Library           String

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Login
    [Tags]    admin.navigate.all.links
    [Setup]
    LoginAdminKW

Users
    [Tags]    admin.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'All users')]
    Click Element    xpath://span[contains(text(),'All users')]
    All Users page
    Capture Page Screenshot    all-users-page-{index}.png
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Add new user')]
    Click Element    xpath://span[contains(text(),'Add new user')]
    Admin Add New User page
    Capture Page Screenshot    add-new-user-page-{index}.png
    Click Element    id:m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath://span[contains(text(),'Not confirmed')]
    Click Element    xpath://span[contains(text(),'Not confirmed')]
    Not Confirmed page
    Capture Page Screenshot    not-confirmed-page-{index}.png

Browse Hospitals
    [Tags]    admin.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Browse hospitals')]
    Capture Page Screenshot    browse-hospitals-{index}.png
    Wait Until Element Is Visible    xpath://span[contains(text(),'All hospitals')]
    Click Element    xpath://span[contains(text(),'All hospitals')]
    Sleep    1
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    hospitals-{index}.png
    Wait Until Element Is Visible    xpath://span[contains(text(),'Add new hospital')]
    Click Element    xpath://span[contains(text(),'Add new hospital')]
    Admin New Hospital page

Doctors
    [Documentation]    Admin
    [Tags]    admin.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Doctors')]
    Click Element    xpath://span[contains(text(),'Specialities')]
    Specialities page
    Click Element    xpath://button[@class='btn btn-success']
    Admin Add new speciality
    Click Element    css:.btn-secondary:nth-child(1)
    Sleep    2
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Certifications')]
    Certifications page
    Click Element    xpath://button[@class='btn btn-success']
    Admin Add new certification modal
    #todo
    #end
    Click Button    xpath://div[@id='m_modal_1']//button[@class='btn btn-secondary'][contains(text(),'Close')]
    Sleep    2
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Departments')]
    Admin Departments
    Click Button    xpath://button[@class='btn btn-success']
    Admin Add new department
    Click Element    xpath://div[@id='m_modal_1']//button[@class='btn btn-secondary'][contains(text(),'Close')]

All appointments
    [Tags]    admin.navigate.all.links
    Sleep    2
    Wait Until Element Is Visible    id:m_aside_left_offcanvas_toggle
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'All appointments')]
    Element Should Be Visible    xpath://h3[@class='m-subheader__title m-pageheading']
    Click Element    id:filter_plus
    Loop Search appointments page
    Click Element    id:filter_minus
    #Admin All Appointments page

Withdrawal Requests
    [Tags]    admin.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Withdrawal requests')]
    Admin Withdrawal Requests page
    Capture Page Screenshot    withdrawal-request-page-{index}.png

Translation fees
    [Tags]    admin.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Translation fees')]
    Sleep    1
    Admin Translations fees page
    Click Element    xpath://a[@class='btn btn-success']
    Add new fee page

Reports
    [Tags]    admin.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Reports')]
    Click Element    xpath://span[contains(text(),'Accounting report')]
    Sleep    1
    Admin Accounting report page
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Payment report')]
    Payment report page
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Login history')]
    Sleep    1
    Login histoy page
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Video Session Logs')]
    #Video Session logs page

Language
    [Tags]    admin.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Scroll Element Into View    xpath://span[contains(text(),'Help')]
    #Click Element    xpath://a[@id='languages_a']//span[@class='m-menu__link-text'][contains(text(),'Languages')]
    Wait Until Element Is Visible    xpath://span[contains(text(),'English')]
    Wait Until Element Is Visible    xpath://span[contains(text(),'German')]
    Wait Until Element Is Visible    xpath://span[contains(text(),'Arabic')]
    Element Text Should Be    xpath://span[contains(text(),'English')]    English
    Element Text Should Be    xpath://span[contains(text(),'German')]    German
    Element Text Should Be    xpath://span[contains(text(),'Arabic')]    Arabic

Create Session Link
    [Tags]    admin.navigate.all.links
    #Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Create Session Link')]
    Admin Session link page

Tracking Emails
    [Tags]    admin.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Tracking Emails')]
    Admin Tracking Emails page

Feedback
    [Tags]    admin.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Feedback')]
    #Admin Feedback page
    Element Should Be Visible    xpath://div[@class='m-grid__item m-grid__item--fluid m-wrapper']
    Element Should Be Visible    xpath://h4[contains(text(),'Feedback')]
    Element Text Should Be    xpath://h4[contains(text(),'Feedback')]    Feedback
    Element Should Be Visible    id:mytable_length
    Element Should Be Visible    id:mytable_filter
    Element Should Be Visible    xpath://label[contains(text(),'Search:')]
    Element Text Should Be    xpath://label[contains(text(),'Search:')]    Search:
    Element Should Be Visible    xpath://label[contains(text(),'Search:')]/input
    Element Should Be Visible    id:mytable_wrapper
    Element Should Be Visible    xpath://th[1]
    Element Text Should Be    xpath://th[1]    User ID
    Element Should Be Visible    xpath://th[2]
    Element Text Should Be    xpath://th[2]    Feedback
    Element Should Be Visible    xpath://th[3]
    Element Text Should Be    xpath://th[3]    First Name
    Element Should Be Visible    xpath://th[4]
    Element Text Should Be    xpath://th[4]    Last Name
    Element Should Be Visible    xpath://th[5]
    Element Text Should Be    xpath://th[5]    Date
    Element Should Be Visible    id:mytable_previous
    Element Text Should Be    id:mytable_previous    Previous
    Element Should Be Visible    id:mytable_next
    Element Text Should Be    id:mytable_next    Next

Help
    [Tags]    admin.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    #Element Text Should Be    xpath://span[contains(text(),'Help')]    Help
    Click Element    xpath://span[contains(text(),'Help')]
    Admin Help page

System Check
    [Tags]    admin.navigate.all.links
    Click Element    id:m_aside_left_offcanvas_toggle
    Element Text Should Be    xpath://span[contains(text(),'System Check')]    System Check
    Click Element    xpath://span[contains(text(),'System Check')]
    Sleep    3
    Capture Page Screenshot    system-check-page-{index}.png
    System Check page

Logout
    [Tags]    admin.navigate.all.links
    LogoutKW
    [Teardown]

*** Keywords ***
