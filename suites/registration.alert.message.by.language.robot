*** Settings ***
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
register arabic
    Go To    ${TESTURL}
    Click Link    AR
    Click Link    تسجيل
    Capture Page Screenshot    register-page-ar-{index}.png
    Submit Form
    Capture Page Screenshot    register-page-ar-{index}.png
    Wait Until Element Is Visible    id:first_name-error
    Element Text Should Be    id:first_name-error    هذه الخانة مطلوبه.
    Wait Until Element Is Visible    id:last_name-error
    Element Text Should Be    id:last_name-error    هذه الخانة مطلوبه.
    Wait Until Element Is Visible    id:email-error
    Element Text Should Be    id:email-error    من فضلك أدخل بريد أليكترونى صحيح.
    Wait Until Element Is Visible    id:password-error
    Element Text Should Be    id:password-error    هذه الخانة مطلوبه.
    Wait Until Element Is Visible    id:check_agreement-error
    Element Text Should Be    id:check_agreement-error    هذه الخانة مطلوبه.
    Input Text    name:first_name    a
    Input Text    name:last_name    a
    Input Text    name:email    a
    Sleep    1
    Element Text Should Be    xpath://label[@id='email-error']    من فضلك أدخل بريد أليكترونى صحيح.
    Capture Page Screenshot    enter_valid_email{index}.png
    Input Text    name:password    a
    Input Text    name:password_confirmation    b
    Click Element    name:check_agreement
    Input Text    name:email    a@asd
    Submit Form
    #Sleep    3
    Capture Page Screenshot    allert-messages{index}.png
    ${name_format} =    Get Text    xpath://li[contains(text(),'تنسيق الاسم الأول غير صالح.')]
    Log To Console    ${name_format}
    ${last_name_format} =    Get Text    xpath://li[contains(text(),'تنسيق الاسم الأخير غير صالح.')]
    Log To Console    ${last_name_format}
    ${valid_email} =    Get Text    xpath://li[contains(text(),'يجب أن يكون البريد الإلكتروني عنوان بريد إلكتروني صالح')]
    Log To Console    ${valid_email}
    ${password_must_be_8} =    Get Text    xpath://li[contains(text(),'يجب أن تكون كلمة المرور على الأقل 8 الشخصيات.')]
    Log To Console    ${password_must_be_8}
    ${password_confirmation} =    Get Text    xpath://li[contains(text(),'تاكيد كلمة المرور لا يطابق.')]
    Log To Console    ${password_confirmation}
    ${invalid_password_format} =    Get Text    xpath://li[contains(text(),'تنسيق كلمة المرور غير صالح.')]
    Log To Console    ${invalid_password_format}
    Element Text Should Be    xpath://li[contains(text(),'تنسيق الاسم الأول غير صالح.')]    تنسيق الاسم الأول غير صالح.
    Element Text Should Be    xpath://li[contains(text(),'تنسيق الاسم الأخير غير صالح.')]    تنسيق الاسم الأخير غير صالح.
    Element Text Should Be    xpath://li[contains(text(),'يجب أن يكون البريد الإلكتروني عنوان بريد إلكتروني صالح')]    يجب أن يكون البريد الإلكتروني عنوان بريد إلكتروني صالح
    Element Text Should Be    xpath://li[contains(text(),'يجب أن تكون كلمة المرور على الأقل 8 الشخصيات.')]    يجب أن تكون كلمة المرور على الأقل 8 الشخصيات.
    Element Text Should Be    xpath://li[contains(text(),'تاكيد كلمة المرور لا يطابق.')]    تاكيد كلمة المرور لا يطابق.
    Element Text Should Be    xpath://li[contains(text(),'تنسيق كلمة المرور غير صالح.')]    تنسيق كلمة المرور غير صالح.

register german
    Go To    ${TESTURL}
    Click Link    DE
    Click Link    Registrieren
    Capture Page Screenshot    register-page-de-{index}.png
    Submit Form
    Capture Page Screenshot    register-page-de-{index}.png
    Wait Until Element Is Visible    id:first_name-error
    Element Text Should Be    id:first_name-error    Dieses Feld wird benötigt.
    Wait Until Element Is Visible    id:last_name-error
    Element Text Should Be    id:last_name-error    Dieses Feld wird benötigt.
    Wait Until Element Is Visible    id:email-error
    Element Text Should Be    id:email-error    Bitte geben Sie eine gültige E-Mail-Adresse ein.
    Wait Until Element Is Visible    id:password-error
    Element Text Should Be    id:password-error    Dieses Feld wird benötigt.
    Wait Until Element Is Visible    id:check_agreement-error
    Element Text Should Be    id:check_agreement-error    Dieses Feld wird benötigt.
    Input Text    name:first_name    a
    Input Text    name:last_name    a
    Input Text    name:email    a
    Sleep    1
    Element Text Should Be    xpath://label[@id='email-error']    Bitte geben Sie eine gültige E-Mail-Adresse ein.
    Capture Page Screenshot    enter_valid_email{index}.png
    Input Text    name:password    a
    Input Text    name:password_confirmation    b
    Click Element    name:check_agreement
    Input Text    name:email    a@asd
    Submit Form
    #Sleep    3
    Capture Page Screenshot    allert-messages{index}.png
    ${name_format} =    Get Text    xpath://li[contains(text(),'Das Vornamenformat ist ungültig.')]
    Log To Console    ${name_format}
    ${last_name_format} =    Get Text    xpath://li[contains(text(),'Das Nachnamenformat ist ungültig.')]
    Log To Console    ${last_name_format}
    ${valid_email} =    Get Text    xpath://li[contains(text(),'E-Mail muss eine gültige E-Mail-Adresse sein')]
    Log To Console    ${valid_email}
    ${password_must_be_8} =    Get Text    xpath://li[contains(text(),'Das Passwort muss mindestens sein 8 figuren.')]
    Log To Console    ${password_must_be_8}
    ${password_confirmation} =    Get Text    xpath://li[contains(text(),'Die Passwort bestätigung stimmt nicht überein.')]
    Log To Console    ${password_confirmation}
    ${invalid_password_format} =    Get Text    xpath://li[contains(text(),'Das Passwort format ist ungültig.')]
    Log To Console    ${invalid_password_format}
    Element Text Should Be    xpath://li[contains(text(),'Das Vornamenformat ist ungültig.')]    Das Vornamenformat ist ungültig.
    Element Text Should Be    xpath://li[contains(text(),'Das Nachnamenformat ist ungültig.')]    Das Nachnamenformat ist ungültig.
    Element Text Should Be    xpath://li[contains(text(),'E-Mail muss eine gültige E-Mail-Adresse sein')]    E-Mail muss eine gültige E-Mail-Adresse sein
    Element Text Should Be    xpath://li[contains(text(),'Das Passwort muss mindestens sein 8 figuren.')]    Das Passwort muss mindestens sein 8 figuren.
    Element Text Should Be    xpath://li[contains(text(),'Die Passwort bestätigung stimmt nicht überein.')]    Die Passwort bestätigung stimmt nicht überein.
    Element Text Should Be    xpath://li[contains(text(),'Das Passwort format ist ungültig.')]    Das Passwort format ist ungültig.

register en
    Go To    ${TESTURL}
    Click Link    /register
    Registration page
    ${url} =    Get Location
    Log to console    ${url}
    Submit Form
    Sleep    10
    Element Text Should Be    xpath://li[contains(text(),'The first name field is required.')]    The first name field is required.
    Element Text Should Be    xpath://li[contains(text(),'The last name field is required.')]    The last name field is required.
    Element Text Should Be    xpath://li[contains(text(),'Email field is required.')]    Email field is required.
    Element Text Should Be    xpath://li[contains(text(),'Password field is required.')]    Password field is required.
