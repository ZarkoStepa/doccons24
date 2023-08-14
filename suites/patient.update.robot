*** Settings ***
Documentation     Test login and logout with user ${USEREMAIL} Update input fields
...               Assert all pages which include steps in test cases Patient Profile Info page, Location page.
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Test Setup
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _mysetup.txt
Resource          _keywords.txt
Library           String

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Patient update personal info
    [Tags]    patient.update
    LoginKW
    Wait Until Element Is Visible    id=m_aside_left_offcanvas_toggle
    Click Element    id=m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath=//span[contains(text(),'Profile')]
    Should Contain    link=Profile    Profile
    Click Link    /profile
    Click Element    xpath=//a[contains(text(),'Personal info')]
    Patient Profile Info page
    Wait Until Page Contains Element    id=inputProfilePic
    #Choose File    name:profile_pics    C:\\Users\\User\\Desktop\\Doctor.jpg
    Get Text    id=inputProfilePic
    Input Text    id=inputFirstName    ${NEWUSER}
    Clear Element Text    id=inputLastName
    Input Text    id=inputLastName    ${NEWLASTNAME}
    Click Element    xpath=//div[@id='m_user_profile_tab_1']//label[2]
    Click Element    id=inputDOB
    Click Element    xpath=//tr[1]//td[2]
    Clear Element Text    name=phone
    ${phone_number} =    Generate Random String    7    [NUMBERS]
    Input Text    id=inputPhone    +49${phone_number}
    Capture Page Screenshot    doctor-personalinfo-phone-{index}.png
    ${phone_number} =    Generate Random String    7    [NUMBERS]
    Input Text    id=inputAltPhone    +49${phone_number}
    Capture Page Screenshot    before-save-{index}.png
    Click Button    id=btnsave
    Capture Page Screenshot    after-save-successfully-{index}.png
    Should Contain    Personal detail updated successfully.    Personal detail updated successfully.
    Sleep    1
    Log    Personal detail updated successfully.
    ${alert-success} =    Get Text    class=alert-success
    Log To Console    ${alert-success}
    Click Element    xpath=//button[contains(text(),'×')]

Patient update account info
    [Tags]    patient.update
    Click Element    xpath=//a[contains(text(),'Account info')]
    Patient Account Info page
    Click Element    xpath=//div[@id='m_user_profile_tab_2']//button[contains(@class,'btn btn-primary m-btn m-btn--custom')][contains(text(),'Save changes')]
    Sleep    1
    ${alert-success} =    Get Text    class=alert-success
    Log To Console    ${alert-success}
    Capture Page Screenshot    account-info-update-{index}.png

Patient update location info
    [Tags]    patient.update
    Click Element    id=m_aside_left_offcanvas_toggle
    Wait Until Element Is Visible    xpath=//span[contains(text(),'Profile')]
    Click Link    /profile
    Click Link    xpath://a[contains(text(),'Location')]
    Location page
    Clear Element Text    id=inputAddress
    Input Text    id=inputAddress    ${ADRESS}
    Clear Element Text    id=inputCity
    Input Text    id=inputCity    ${CITY}
    Clear Element Text    id=inputProvince
    Input Text    id=inputProvince    ${PROVINCE}
    Clear Element Text    id=inputZip
    Input Text    id=inputZip    ${ZIP}
    Click Element    id=selectCountry
    Click Element    xpath=//option[contains(@value,'CA')]
    Capture Page Screenshot    before-save-location-{index}.png
    Click Button    xpath=(//button[@type='submit'])[3]
    Wait Until Element Is Visible    xpath=//div[@class='m-content']
    Capture Page Screenshot    after-location-save-{index}.png
    Should Contain    Address detail updated successfully.    Address detail updated successfully.
    Log    Address detail updated successfully.
    ${alert-success} =    Get Text    class=alert-success
    Log To Console    ${alert-success}
    Click Element    xpath=//button[contains(text(),'×')]
    LogoutKW
    Capture Page Screenshot    logout-{index}.png

*** Keywords ***
