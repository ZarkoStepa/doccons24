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
Login page
    [Documentation]    Test login page alert messages
    [Tags]    login.page
    Go To    ${TESTURL}
    Login page
    Submit Form
    Capture Page Screenshot    required_field{index}.png
    Element Text Should Be    xpath://li[contains(text(),'Email field is required.')]    Email field is required.
    Element Text Should Be    xpath://li[contains(text(),'Password field is required.')]    Password field is required.
    ${radnom_name}=    Generate Random String    6    [UPPER]
    ${radnom_name}=    Set Variable    ${radnom_name}
    Set Suite Variable    ${radnom_name}
    Input Text    name:email    ${radnom_name}
    ${radnom_password}=    Generate Random String    6    [UPPER]
    ${radnom_password}=    Set Variable    ${radnom_password}
    Set Suite Variable    ${radnom_password}
    Input Text    name:password    ${radnom_password}
    Submit Form
    ${alert-danger} =    Get Text    class:alert
    Log To Console    ${alert-danger}
    Element Text Should Be    xpath://li[contains(text(),'The email must be a valid email address.')]    The email must be a valid email address.
    Capture Page Screenshot    valid_email{index}.png
    Input Text    name:email    a@a.a
    Input Text    name:password    ${radnom_password}
    Submit Form
    ${alert-danger} =    Get Text    class:alert
    Log To Console    ${alert-danger}
    Capture Page Screenshot    credentials_do_not_match{index}.png
    Element Text Should Be    xpath://li[contains(text(),'These credentials do not match our records.')]    These credentials do not match our records.

Login page ar
    [Tags]    login.page
    Go To    ${TESTURL}/lang/ar
    Submit Form
    Capture Page Screenshot    required_field{index}.png
    Element Text Should Be    xpath://li[contains(text(),'حقل البريد الإلكتروني مطلوب.')]    حقل البريد الإلكتروني مطلوب.
    Element Text Should Be    xpath://li[contains(text(),'حقل كلمة المرور مطلوب.')]    حقل كلمة المرور مطلوب.
    ${radnom_name}=    Generate Random String    6    [UPPER]
    ${radnom_name}=    Set Variable    ${radnom_name}
    Set Suite Variable    ${radnom_name}
    Input Text    name:email    ${radnom_name}
    ${radnom_password}=    Generate Random String    6    [UPPER]
    ${radnom_password}=    Set Variable    ${radnom_password}
    Set Suite Variable    ${radnom_password}
    Input Text    name:password    ${radnom_password}
    Submit Form
    ${alert-danger} =    Get Text    class:alert
    Log To Console    ${alert-danger}
    Element Text Should Be    xpath://li[contains(text(),'يجب أن يكون البريد الإلكتروني عنوان بريد إلكتروني صالح')]    يجب أن يكون البريد الإلكتروني عنوان بريد إلكتروني صالح
    Element Text Should Be    xpath://div[@class='alert alert-danger alert-dismissable']//ul//li    يجب أن يكون البريد الإلكتروني عنوان بريد إلكتروني صالح
    Capture Page Screenshot    valid_email{index}.png
    Input Text    name:email    a@a.a
    Input Text    name:password    12
    Submit Form
    ${alert-danger} =    Get Text    class:alert
    Log To Console    ${alert-danger}
    Capture Page Screenshot    credentials_do_not_match{index}.png
    Element Text Should Be    xpath://li[contains(text(),'لا تتطابق بيانات الاعتماد هذه مع سجلاتنا.')]    لا تتطابق بيانات الاعتماد هذه مع سجلاتنا.
    Element Text Should Be    xpath://div[@class='alert alert-danger alert-dismissable']//ul    لا تتطابق بيانات الاعتماد هذه مع سجلاتنا.

Login page de
    [Tags]    login.page
    Go To    ${TESTURL}/lang/de
    Submit Form
    Capture Page Screenshot    required_field{index}.png
    Element Text Should Be    xpath://li[contains(text(),'E-Mail-Feld ist erforderlich.')]    E-Mail-Feld ist erforderlich.
    Element Text Should Be    xpath://li[contains(text(),'Passwortfeld ist erforderlich.')]    Passwortfeld ist erforderlich.
    Element Text Should Be    xpath://strong[contains(text(),'Passwortfeld ist erforderlich.')]    Passwortfeld ist erforderlich.
    ${radnom_name}=    Generate Random String    6    [UPPER]
    ${radnom_name}=    Set Variable    ${radnom_name}
    Set Suite Variable    ${radnom_name}
    Input Text    name:email    ${radnom_name}
    ${radnom_password}=    Generate Random String    6    [UPPER]
    ${radnom_password}=    Set Variable    ${radnom_password}
    Set Suite Variable    ${radnom_password}
    Input Text    name:password    ${radnom_password}
    Submit Form
    ${alert-danger} =    Get Text    class:alert
    Log To Console    ${alert-danger}
    Element Text Should Be    xpath://li[contains(text(),'E-Mail muss eine gültige E-Mail-Adresse sein')]    E-Mail muss eine gültige E-Mail-Adresse sein
    Element Text Should Be    xpath://div[@class='alert alert-danger alert-dismissable']//ul//li    E-Mail muss eine gültige E-Mail-Adresse sein
    Capture Page Screenshot    valid_email{index}.png
    Input Text    name:email    a@a.a
    Input Text    name:password    12
    Submit Form
    Wait Until Element Is Visible    xpath://li[contains(text(),'Diese Anmeldeinformationen stimmen nicht mit unseren Unterlagen überein.')]
    ${alert-danger} =    Get Text    class:alert
    Log To Console    ${alert-danger}
    Capture Page Screenshot    credentials_do_not_match{index}.png
    Element Text Should Be    xpath://li[contains(text(),'Diese Anmeldeinformationen stimmen nicht mit unseren Unterlagen überein.')]    Diese Anmeldeinformationen stimmen nicht mit unseren Unterlagen überein.
    Element Text Should Be    xpath://div[@class='alert alert-danger alert-dismissable']//ul    Diese Anmeldeinformationen stimmen nicht mit unseren Unterlagen überein.
