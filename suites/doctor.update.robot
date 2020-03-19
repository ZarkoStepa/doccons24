*** Settings ***
Documentation     Test login and logouth with ${DOCEMAIL}
...
...               Assert all pages which include steps in test cases.
...
...               Test update all pages which include steps in test cases.
...
...               In this case Doctor must have ( Alergist, Magister, English and German, no Set Hospital)
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Test Setup
Library           SeleniumLibrary
Resource          _mysetup.txt
Resource          _keywords.txt
Library           XvfbRobot
Library           String

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
doctor update all required fields for personal info - success
    [Documentation]    Doctor personal
    [Tags]    doctor.update
    LoginDocKW
    Wait Until Element Is Visible    xpath://a[contains(text(),'General')]
    Click Link    xpath://a[contains(text(),'General')]
    Capture Page Screenshot    after-click-on-general-link-text-{index}.png
    Element Text Should Be    xpath://a[contains(text(),'Personal info')]    Personal info
    Element Text Should Be    xpath://a[contains(text(),'Account info')]    Account info
    Element Text Should Be    xpath://a[contains(text(),'Location')]    Location
    Click Element    xpath://a[contains(text(),'Personal info')]
    Capture Page Screenshot    after-click-on-personal-info-link-text-{index}.png
    Personal Info page
    Capture Page Screenshot    doctor-personalinfo-page-{index}.png
    Wait Until Element Is Visible    xpath://h3[contains(@class,'m-subheader__title m-pageheading')]
    Element Text Should Be    xpath://h3[contains(@class,'m-subheader__title m-pageheading')]    Edit Profile
    Wait Until Page Contains Element    id:inputProfilePic
    #Choose File    name:profile_cs    C:Fridayele\\Users\\User\\Desktop\\Doctor.jpg
    Click Element    name:first_name
    Input Text    name:first_name    ${NEWDOCUSER}
    Capture Page Screenshot    doctor-personalinfo-firstname-{index}.png
    Clear Element Text    name:last_name
    Input Text    name:last_name    ${NEWDOCLASTNAME}
    Capture Page Screenshot    doctor-personalinfo-lastname-{index}.png
    Click Element    xpath://div[@id='m_user_profile_tab_1']//label[2]
    Capture Page Screenshot    after-click-on-gender-female-radio-button-{index}.png
    Click Element    id:inputDOB
    Capture Page Screenshot    doctor-personalinfo-DOB-{index}.png
    Click Element    xpath://tr[2]//td[3]
    Capture Page Screenshot    after-clicking-day-on-calendar-{index}.png
    ${phone_number} =    Generate Random String    7    [NUMBERS]
    Input Text    id:inputPhone    +49${phone_number}
    Capture Page Screenshot    doctor-personalinfo-phone-{index}.png
    ${phone_number} =    Generate Random String    7    [NUMBERS]
    Input Text    id:inputAltPhone    +49${phone_number}
    Sleep    2
    Capture Page Screenshot    doctor-personalinfo-altphone-{index}.png
    Click Button    xpath://button[@id='btnsave']
    Capture Page Screenshot    doctor-update-after-submint-{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW

doctor update account info -success
    [Tags]    doctor.update
    LoginDocKW
    Click Element    xpath://a[contains(text(),'General')]
    Capture Page Screenshot    after-click-general-dropdown-menu-{index}.png
    Click Element    xpath://a[contains(text(),'Account info')]
    Capture Page Screenshot    after-click-account-info-link-text-{index}.png
    Click Element    xpath://div[@id='m_user_profile_tab_2']//button[contains(@class,'btn btn-primary m-btn m-btn--custom')][contains(text(),'Save changes')]
    Sleep    1
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW

doctor update all required fields for location - success
    [Documentation]    Doctor location
    [Tags]    doctor.update
    LoginDocKW
    Wait Until Element Is Visible    xpath://a[contains(text(),'General')]
    Click Element    xpath://a[contains(text(),'General')]
    Capture Page Screenshot    after-click-general-dropdown-menu-{index}.png
    Click Element    xpath://a[contains(text(),'Location')]
    Location page
    Capture Page Screenshot    doctor-location-page-{index}.png
    Element Text Should Be    xpath://label[@class='col-2 col-form-label'][contains(text(),'Street')]    Street
    Click Element    id:inputAddress
    Capture Page Screenshot    click-on-doctor-address-{index}.png
    Input Text    id:inputAddress    ${ADRESS}
    Capture Page Screenshot    input-doctor-address-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'City*')]    City*
    Click Element    id:inputCity
    Capture Page Screenshot    click-on-doctor-city-{index}.png
    Input Text    id:inputCity    ${CITY}
    Capture Page Screenshot    input-doctor-city-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'State/Province*')]    State/Province*
    Click Element    id:inputProvince
    Capture Page Screenshot    click-doctor-province-{index}.png
    Input Text    id:inputProvince    ${PROVINCE}
    Capture Page Screenshot    input-doctor-province-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Postcode')]    Postcode
    Click Element    id:inputZip
    Capture Page Screenshot    click-doctor-zip-{index}.png
    Input Text    id:inputZip    ${ZIP}
    Capture Page Screenshot    input-doctor-zip-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Country*')]    Country*
    Click Element    id:selectCountry
    Capture Page Screenshot    click-doctor-country-{index}.png
    Click Element    xpath://option[contains(@value,'DE')]
    Capture Page Screenshot    select-doctor-country-{index}.png
    Click Button    xpath://div[@id='m_user_profile_tab_3']//button[@type='submit'][contains(text(),'Save changes')]
    Capture Page Screenshot    after-clicking-button-save-on-doctor-location-{index}.png
    Wait Until Element Contains    xpath://div[contains(@class,'alert')]    Address detail updated successfully.
    Should Contain    Address detail updated successfully.    Address detail updated successfully.
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW

doctor update all payment information
    [Documentation]    Doctor Payment Info
    [Tags]    doctor.update
    LoginDocKW
    Click Element    xpath://a[contains(text(),'Payment info')]
    Capture Page Screenshot    doctor-payment-info-{index}.png
    Payment Info page
    Click Element    id:inputAON
    Capture Page Screenshot    click-doctor-AON-{index}.png
    Input Text    id:inputAON    skAuto Do
    Capture Page Screenshot    input-doctor-inputAON-{index}.png
    Click Element    id:inputIBAN
    Capture Page Screenshot    click-doctor-IBAN-{index}.png
    Input Text    id:inputIBAN    987654321
    Capture Page Screenshot    input-doctor-IBAN-{index}.png
    Click Element    id:inputBIC
    Capture Page Screenshot    click-doctor-BIC-{index}.png
    Input Text    id:inputBIC    DABAIE2D
    Capture Page Screenshot    input-doctor-BIC-{index}.png
    Click Element    id:inputRATE
    Capture Page Screenshot    click-doctor-RATE-{index}.png
    Input Text    id:inputRATE    ${INPUTRATE}
    Capture Page Screenshot    input-doctor-rate-{index}.png
    Click Button    xpath://div[@id='m_user_profile_tab_6']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    Capture Page Screenshot    doctor-after-save-changes-payment-info-{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW

doctor add for every working day a timeslot
    [Tags]    doctor.update
    [Setup]    Setup doctor days
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Capture Page Screenshot    click-offcanvas-{index}.png
    Sleep    3
    Click Link    /profile
    Capture Page Screenshot    click-link-profile-{index}.png
    Click Element    xpath://a[contains(text(),'Working days')]
    Capture Page Screenshot    click-link-working-days-{index}.png
    Scroll Element Into View    css:.m-form__group:nth-child(14) span
    Element Text Should Be    xpath://div[contains(@class,'m-portlet__body')]//div[1]//div[1]//div[1]//label[1]    Monday
    ${monday} =    Get WebElement    css:.m-form__group:nth-child(2) span
    Select Checkbox    ${monday}
    Capture Page Screenshot    select-checkbox-monday-{index}.png
    Sleep    2
    ${moday_start_time} =    Get WebElement    name:monday[start_time][]
    Click Element    ${moday_start_time}
    Capture Page Screenshot    monday-start-time-{index}.png
    Sleep    2
    Element Text Should Be    xpath://div[@id='m_user_profile_tab_5']//div[3]//div[1]//div[1]//label[1]    Tuesday
    Sleep    2
    ${tuesday} =    Get WebElement    css:.m-form__group:nth-child(4) > .col-7 span
    Select Checkbox    ${tuesday}
    Capture Page Screenshot    select-checkbox-tuesday-{index}.png
    Sleep    2
    ${tuesday_start_time} =    Get WebElement    name:tuesday[start_time][]
    Click Element    ${tuesday_start_time}
    Capture Page Screenshot    tuesday-start-time-{index}.png
    Sleep    2
    Element Text Should Be    xpath://div[@id='m_user_profile_tab_5']//div[5]//div[1]//div[1]//label[1]    Wednesday
    Sleep    2
    ${wednesday} =    Get WebElement    css:.m-form__group:nth-child(6) > .col-7 span
    Select Checkbox    ${wednesday}
    Capture Page Screenshot    select-checkbox-wednesday-{index}.png
    Sleep    2
    ${wednesday_start_time} =    Get WebElement    name:wednesday[start_time][]
    Click Element    ${wednesday_start_time}
    Capture Page Screenshot    wednesday-start-time-{index}.png
    Sleep    2
    Element Text Should Be    xpath://div[@id='m_user_profile_tab_5']//div[7]//div[1]//div[1]//label[1]    Thursday
    Sleep    2
    ${thursday} =    Get WebElement    css:.m-form__group:nth-child(8) span
    Select Checkbox    ${thursday}
    Capture Page Screenshot    select-checkbox-thursday-{index}.png
    Sleep    2
    ${thursday_start_time} =    Get WebElement    name:thursday[start_time][]
    Click Element    ${thursday_start_time}
    Capture Page Screenshot    thursday-start-time-{index}.png
    Element Text Should Be    xpath://div[9]//div[1]//div[1]//label[1]    Friday
    Sleep    2
    ${friday} =    Get WebElement    css:.m-form__group:nth-child(10) > .col-7 span
    Select Checkbox    ${friday}
    Capture Page Screenshot    select-checkbox-friday-{index}.png
    Sleep    2
    ${friday_start_time} =    Get WebElement    name:friday[start_time][]
    Click Element    ${friday_start_time}
    Capture Page Screenshot    friday-start-time-{index}.png
    Sleep    2
    Element Text Should Be    xpath://div[11]//div[1]//div[1]//label[1]    Saturday
    Sleep    2
    ${saturday} =    Get WebElement    css:.m-form__group:nth-child(12) > .col-7 span
    Select Checkbox    ${saturday}
    Capture Page Screenshot    select-checkbox-saturday-{index}.png
    Sleep    2
    ${saturday_start_time} =    Get WebElement    name:saturday[start_time][]
    Click Element    ${saturday_start_time}
    Capture Page Screenshot    saturday-start-time-{index}.png
    Element Text Should Be    xpath://div[13]//div[1]//div[1]//label[1]    Sunday
    Sleep    2
    ${sunday} =    Get WebElement    css:.m-form__group:nth-child(14) span
    Select Checkbox    ${sunday}
    Capture Page Screenshot    select-checkbox-sunday-{index}.png
    Sleep    2
    ${sunday_start_time} =    Get WebElement    name:sunday[start_time][]
    Click Element    ${sunday_start_time}
    Capture Page Screenshot    sunday-start-time-{index}.png
    Sleep    2
    Click Button    xpath://div[@id='m_user_profile_tab_5']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    Capture Page Screenshot    after-clicking-save-changes-{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    Working Days page
    LogoutKW
    [Teardown]

doctor update specialty, language
    [Tags]    doctor.update
    [Setup]    Setup Qualification - language
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Element    xpath://span[contains(text(),'Qualifications')]
    Capture Page Screenshot    qualification-{index}.png
    Scroll Element Into View    xpath://label[4]
    Element Text Should Be    xpath://label[contains(text(),'Title')]    Title
    Click Element    name:profession
    Capture Page Screenshot    doctor-profession-{index}.png
    Click Element    xpath://option[contains(@value,'Dr.')]
    Capture Page Screenshot    select-profession-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Education')]    Education
    Click Element    name:qualification
    Capture Page Screenshot    click-qualification-{index}.png
    Input Text    name:qualification    ${EDUCATION}
    Capture Page Screenshot    input-qualification-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Specialities')]    Specialities
    Click Element    xpath://span[contains(text(),'Choose specialities')]
    Capture Page Screenshot    click-choose-specialties-dropdown-{index}.png
    Click Element    xpath://span[contains(text(),'Allergist')]
    Capture Page Screenshot    doctor-specialities-{index}.png
    Element Text Should Be    xpath://label[contains(text(),'Certifications')]    Certifications
    Click Element    xpath://span[contains(text(),'Choose certifications')]
    Capture Page Screenshot    click-doctor-fk_certification-dropdown-{index}.png
    Click Element    xpath://span[contains(text(),"Master's degree")]    #Master's degree
    Capture Page Screenshot    click-masters-degree-{index}.png
    Element Should Contain    xpath://span[contains(text(),"Master's degree")]    Master's degree
    Element Should Contain    xpath://span[contains(text(),"Bachelor's degree")]    Bachelor's degree
    Element Should Contain    xpath://span[contains(text(),'Ph.D. candidate')]    Ph.D. candidate
    Element Should Contain    xpath://span[contains(text(),'Professor')]    Professor
    Element Text Should Be    xpath://label[contains(text(),'Languages')]    Languages
    Click Element    xpath://div[@id='m_user_profile_tab_4']//div[@class='m-form__group form-group row']//div[contains(@class,'col-8')]//label[1]    #En
    Capture Page Screenshot    click-checkbox-english-{index}.png
    #Click Element    xpath://div[5]/div/div/label[2]/span    #Arabic
    #Click Element    xpath://label[2]    #Ar
    #Click Element    xpath://label[3]    #Fr
    Click Element    xpath://label[4]    #German
    Capture Page Screenshot    click-checkbox-german-{index}.png
    Scroll Element Into View    css:.form-group:nth-child(6) .m-radio:nth-child(1) > span
    Capture Page Screenshot    doctor-language-{index}.png
    Sleep    3
    Scroll Element Into View    id:qualification-submit-btn
    Click Element    xpath://div[@class='col-8']//div//i[@class='la la-close']
    Capture Page Screenshot    click-X-no-file-chosen-{index}.png
    Wait Until Element Is Visible    xpath://h3[contains(text(),'Please confirm changes')]
    Element Should Be Visible    xpath://h3[contains(text(),'Please confirm changes')]
    Element Text Should Be    xpath://h3[contains(text(),'Please confirm changes')]    Please confirm changes
    Capture Page Screenshot    please-confirm-changes-{index}.png
    Click Element    id:qualification-submit-btn
    Capture Page Screenshot    qualification-after-submit-{index}.png
    ${alert-success} =    Get Text    class:alert-success
    Log To Console    ${alert-success}
    LogoutKW
    [Teardown]

*** Keywords ***
