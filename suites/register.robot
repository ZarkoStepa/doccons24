*** Settings ***
Suite Setup             Open Testbrowser
Suite Teardown          Close All Browsers
Library                 SeleniumLibrary
Resource                _keywords.txt
Resource                _mysetup.txt
Library                 XvfbRobot
Library                 String

*** Variables ***
${TMP_PATH}             /tmp

*** Test Cases ***
Register page En
          [Tags]          register.page
          Go To          ${TESTURL}
          Click Link          /register
          Registration page
          ${url} =          Get Location
          Log to console          ${url}
          Submit Form
          Scroll Element Into View          name:check_agreement
          Capture Page Screenshot          required_fieds{index}.png
          Element Text Should Be          id:first_name-error          This field is required.
          Element Text Should Be          id:last_name-error          This field is required.
          Element Text Should Be          id:email-error          Please enter a valid email address.
          Element Text Should Be          id:password-error          This field is required.
          Element Text Should Be          id:check_agreement-error          This field is required.
          ${RANDOM}=          Generate Random String          1          [UPPER]
          ${RANDOM}=          Set Variable          ${RANDOM}
          Set Suite Variable          ${RANDOM}
          Input Text          name:first_name          ${RANDOM}
          Input Text          name:last_name          ${RANDOM}
          Input Text          name:email          ${RANDOM}
          Element Text Should Be          xpath://label[@id='email-error']          Please enter a valid email address.
          Capture Page Screenshot          enter_valid_email{index}.png
          Input Text          name:password          ${RANDOM}
          Input Text          name:password_confirmation          b
          Click Element          name:check_agreement
          Input Text          name:email          qwe2@sda
          Submit Form          #a@${RANDOM}.
          Capture Page Screenshot          allert-messages{index}.png
          ${name_format} =          Get Text          xpath://li[contains(text(),'The first name format is invalid.')]
          Log To Console          ${name_format}
          ${last_name_format} =          Get Text          xpath://li[contains(text(),'The last name format is invalid.')]
          Log To Console          ${last_name_format}
          ${valid_email} =          Get Text          xpath=//li[contains(text(),'The email format is invalid.')]
          Log To Console          ${valid_email}
          ${password_must_be_8} =          Get Text          xpath://li[contains(text(),'The password must be at least 8 characters.')]
          Log To Console          ${password_must_be_8}
          ${password_confirmation} =          Get Text          xpath://li[contains(text(),'The password confirmation does not match.')]
          Log To Console          ${password_confirmation}
          ${invalid_password_format} =          Get Text          xpath://li[contains(text(),'The password format is invalid.')]
          Log To Console          ${invalid_password_format}
          Element Text Should Be          xpath://li[contains(text(),'The first name format is invalid.')]          The first name format is invalid.
          Element Text Should Be          xpath://li[contains(text(),'The last name format is invalid.')]          The last name format is invalid.
          Element Text Should Be          xpath=//li[contains(text(),'The email format is invalid.')]          The email format is invalid.
          Element Text Should Be          xpath://li[contains(text(),'The password must be at least 8 characters.')]          The password must be at least 8 characters.
          Element Text Should Be          xpath://li[contains(text(),'The password confirmation does not match.')]          The password confirmation does not match.
          Element Text Should Be          xpath://li[contains(text(),'The password format is invalid.')]          The password format is invalid.
          Capture Page Screenshot          expected-alert-messages-{index}.png
          Input Text          name:first_name          ${MANUSER}
          Input Text          name:last_name          ${MANUSER}
          Input Text          name:email          ${USEREMAIL}
          Input Text          name:password          ${DOCPW}
          Input Text          name:password_confirmation          ${DOCPW}
          Click Element          name:check_agreement
          Submit Form
          ${email} =          Get Text          xpath://li[contains(text(),'The email has already been taken.')]
          Log To Console          ${email}
          Element Text Should Be          xpath://li[contains(text(),'The email has already been taken.')]          The email has already been taken.
          Capture Page Screenshot          expected-alert-messages-{index}.png

Register page Ar
          [Tags]          register.page
          Go To          ${TESTURL}
          Click Link          AR
          Click Link          تسجيل
          Capture Page Screenshot          register-page-ar-{index}.png
          Submit Form
          Capture Page Screenshot          register-page-ar-{index}.png
          Wait Until Element Is Visible          id:first_name-error
          Element Text Should Be          id:first_name-error          هذه الخانة مطلوبه.
          Wait Until Element Is Visible          id:last_name-error
          Element Text Should Be          id:last_name-error          هذه الخانة مطلوبه.
          Wait Until Element Is Visible          id:email-error
          Element Text Should Be          id:email-error          من فضلك أدخل بريد أليكترونى صحيح.
          Wait Until Element Is Visible          id:password-error
          Element Text Should Be          id:password-error          هذه الخانة مطلوبه.
          Wait Until Element Is Visible          id:check_agreement-error
          Element Text Should Be          id:check_agreement-error          هذه الخانة مطلوبه.
          Input Text          name:first_name          ${RANDOM}
          Input Text          name:last_name          ${RANDOM}
          Input Text          name:email          ${RANDOM}
          Element Text Should Be          xpath://label[@id='email-error']          من فضلك أدخل بريد أليكترونى صحيح.
          Capture Page Screenshot          enter_valid_email{index}.png
          Input Text          name:password          ${RANDOM}
          Input Text          name:password_confirmation          b
          Click Element          name:check_agreement
          Input Text          name:email          qwe2@sda
          Submit Form
          Capture Page Screenshot          allert-messages{index}.png
          ${name_format} =          Get Text          xpath://li[contains(text(),'تنسيق الاسم الأول غير صالح.')]
          Log To Console          ${name_format}
          ${last_name_format} =          Get Text          xpath://li[contains(text(),'تنسيق الاسم الأخير غير صالح.')]
          Log To Console          ${last_name_format}
          ${valid_email} =          Get Text          xpath=//li[contains(text(),'تنسيق البريد الإلكتروني غير صالح.')]
          Log To Console          ${valid_email}
          ${password_must_be_8} =          Get Text          xpath://li[contains(text(),'يجب أن تكون كلمة المرور على الأقل 8 الشخصيات.')]
          Log To Console          ${password_must_be_8}
          ${password_confirmation} =          Get Text          xpath://li[contains(text(),'تاكيد كلمة المرور لا يطابق.')]
          Log To Console          ${password_confirmation}
          ${invalid_password_format} =          Get Text          xpath://li[contains(text(),'تنسيق كلمة المرور غير صالح.')]
          Log To Console          ${invalid_password_format}
          Element Text Should Be          xpath://li[contains(text(),'تنسيق الاسم الأول غير صالح.')]          تنسيق الاسم الأول غير صالح.
          Element Text Should Be          xpath://li[contains(text(),'تنسيق الاسم الأخير غير صالح.')]          تنسيق الاسم الأخير غير صالح.
          Element Text Should Be          xpath=//li[contains(text(),'تنسيق البريد الإلكتروني غير صالح.')]          تنسيق البريد الإلكتروني غير صالح.
          Element Text Should Be          xpath://li[contains(text(),'يجب أن تكون كلمة المرور على الأقل 8 الشخصيات.')]          يجب أن تكون كلمة المرور على الأقل 8 الشخصيات.
          Element Text Should Be          xpath://li[contains(text(),'تاكيد كلمة المرور لا يطابق.')]          تاكيد كلمة المرور لا يطابق.
          Element Text Should Be          xpath://li[contains(text(),'تنسيق كلمة المرور غير صالح.')]          تنسيق كلمة المرور غير صالح.
          Capture Page Screenshot          expected-alert-messages-{index}.png
          Input Text          name:first_name          ${MANUSER}
          Input Text          name:last_name          ${MANUSER}
          Input Text          name:email          ${USEREMAIL}
          Input Text          name:password          ${DOCPW}
          Input Text          name:password_confirmation          ${DOCPW}
          Click Element          name:check_agreement
          Submit Form
          ${email} =          Get Text          xpath://li[contains(text(),'البريد الإلكتروني تم أخذه.')]
          Log To Console          ${email}
          Element Text Should Be          xpath://li[contains(text(),'البريد الإلكتروني تم أخذه.')]          البريد الإلكتروني تم أخذه.
          Capture Page Screenshot          expected-alert-messages-{index}.png

Register page De
          [Tags]          register.page
          Go To          ${TESTURL}
          Click Link          DE
          Click Link          Registrieren
          Capture Page Screenshot          register-page-de-{index}.png
          Submit Form
          Capture Page Screenshot          register-page-de-{index}.png
          Wait Until Element Is Visible          id:first_name-error
          Element Text Should Be          id:first_name-error          Dieses Feld wird benötigt.
          Wait Until Element Is Visible          id:last_name-error
          Element Text Should Be          id:last_name-error          Dieses Feld wird benötigt.
          Wait Until Element Is Visible          id:email-error
          Element Text Should Be          id:email-error          Bitte geben Sie eine gültige E-Mail-Adresse ein.
          Wait Until Element Is Visible          id:password-error
          Element Text Should Be          id:password-error          Dieses Feld wird benötigt.
          Wait Until Element Is Visible          id:check_agreement-error
          Element Text Should Be          id:check_agreement-error          Dieses Feld wird benötigt.
          Input Text          name:first_name          ${RANDOM}
          Input Text          name:last_name          ${RANDOM}
          Input Text          name:email          ${RANDOM}
          Element Text Should Be          xpath://label[@id='email-error']          Bitte geben Sie eine gültige E-Mail-Adresse ein.
          Capture Page Screenshot          enter_valid_email{index}.png
          Input Text          name:password          ${RANDOM}
          Input Text          name:password_confirmation          b
          Click Element          name:check_agreement
          Input Text          name:email          qwe2@sda
          Submit Form
          Capture Page Screenshot          allert-messages{index}.png
          ${name_format} =          Get Text          xpath://li[contains(text(),'Das Vornamenformat ist ungültig.')]
          Log To Console          ${name_format}
          ${last_name_format} =          Get Text          xpath://li[contains(text(),'Das Nachnamenformat ist ungültig.')]
          Log To Console          ${last_name_format}
          ${valid_email} =          Get Text          xpath=//li[contains(text(),'Das E-Mail-Format ist ungültig.')]
          Log To Console          ${valid_email}
          ${password_must_be_8} =          Get Text          xpath://li[contains(text(),'Das Passwort muss mindestens sein 8 figuren.')]
          Log To Console          ${password_must_be_8}
          ${password_confirmation} =          Get Text          xpath://li[contains(text(),'Die Passwort bestätigung stimmt nicht überein.')]
          Log To Console          ${password_confirmation}
          ${invalid_password_format} =          Get Text          xpath://li[contains(text(),'Das Passwort format ist ungültig.')]
          Log To Console          ${invalid_password_format}
          Element Text Should Be          xpath://li[contains(text(),'Das Vornamenformat ist ungültig.')]          Das Vornamenformat ist ungültig.
          Element Text Should Be          xpath://li[contains(text(),'Das Nachnamenformat ist ungültig.')]          Das Nachnamenformat ist ungültig.
          Element Text Should Be          xpath=//li[contains(text(),'Das E-Mail-Format ist ungültig.')]          Das E-Mail-Format ist ungültig.
          Element Text Should Be          xpath://li[contains(text(),'Das Passwort muss mindestens sein 8 figuren.')]          Das Passwort muss mindestens sein 8 figuren.
          Element Text Should Be          xpath://li[contains(text(),'Die Passwort bestätigung stimmt nicht überein.')]          Die Passwort bestätigung stimmt nicht überein.
          Element Text Should Be          xpath://li[contains(text(),'Das Passwort format ist ungültig.')]          Das Passwort format ist ungültig.
          Capture Page Screenshot          expected-alert-messages-{index}.png
          Input Text          name:first_name          ${MANUSER}
          Input Text          name:last_name          ${MANUSER}
          Input Text          name:email          ${USEREMAIL}
          Input Text          name:password          ${DOCPW}
          Input Text          name:password_confirmation          ${DOCPW}
          Click Element          name:check_agreement
          Submit Form
          ${email} =          Get Text          xpath=//li[contains(text(),'Die E-Mail-Adresse wird bereits verwendet.')]
          Log To Console          ${email}
          Element Text Should Be          xpath=//li[contains(text(),'Die E-Mail-Adresse wird bereits verwendet.')]          Die E-Mail-Adresse wird bereits verwendet.
          Capture Page Screenshot          expected-alert-messages-{index}.png
