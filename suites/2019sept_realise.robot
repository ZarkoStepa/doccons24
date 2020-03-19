*** Settings ***
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           RequestsLibrary
Resource          _mysetup.txt
Resource          _keywords.txt
Library           XvfbRobot
Library           Collections
Library           requests
Library           SeleniumLibrary

*** Variables ***
${TMP_PATH}       /tmp
${userID}         2

*** Test Cases ***
Get_request_users
    Create Session    Admin    ${BASEURL}
    ${response} =    Get Request    Admin    /reports/login_history
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200

TC002
    ${auth}    Create List    ${EMAIL}    ${USERPW}
    Create Session    my_session    ${BASEURL}    auth=${auth}
    ${BASEURL}=    Create Dictionary    Accept    application/json    Content-Type    application/json
    #${resp}    POST    my_session    <your rest api>    data=<JSON DATA>    headers=${headers}

Get Requests
    ${auth}    Create List    ${EMAIL}    ${USERPW}
    Create Session    my_session    ${TESTURL}    auth=${auth}
    ${resp}=    Get Request    ${TESTURL}    /doctor
    ${auth}    Create List    ${EMAIL}    ${USERPW}
    Create Session    my_session    ${TESTURL}    auth=${auth}
    ${TESTURL}    Create Dictionary    Accept    application/json    Content-Type    application/json
    Should Be Equal As Strings    ${resp.status_code}    200
    #Dictionary Should Contain Value    ${resp.json()}    ${TESTURL}

TC004
    Create Session    FetchData    ${TESTURL}
    ${Response} =    Get Request    FetchData    /doctors/2/direct_appointment
    Should Be Equal    ${response.status_code}.    200

Get request appointments
    Create Session    Users    ${TESTURL}
    ${response} =    Get Request    Users    /doctors/2
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200

Get request profile
    Create Session    Users    ${BASEURL}
    ${response} =    Get Request    Users    /reports/payment
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200

Get request wallet
    Create Session    Users    ${TESTURL}
    ${response} =    Get Request    Users    /reports/login_history
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200
    Log Location

get requests proxy
    ${proxies}=    Create Dictionary    http=${TESTURL}
    Create Session    DocCons24    ${TESTURL}    proxies=${proxies}
    ${resp}=    Get Request    DocCons24    /doctors/2/direct_appointment
    Should Be Equal As Strings    ${resp.status_code}    200

get request cookies
    ${cookies}=    Create Dictionary    userid=2    last_visit=2019-09-16
    Create Session    DocCons24    ${TESTURL}    cookies=${cookies}
    ${resp}=    Get Request    DocCons24    /appointments/736
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp}

get TD001
    Create Session    Users    ${TESTURL}
    ${response} =    Get Request    Users    /reports/payment
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200
    ${url}=    Get Location
    Log to console    ${url}
    ${url}=    Get Window Titles
    Log to console    ${url}

Proxy Requests
    ${proxies}=    Create Dictionary    http=http://acme.com:912    https=http://acme.com:913
    Create Session    DocCons24    ${TESTURL}    proxies=${proxies}
    ${resp}=    Get Request    DocCons24    /
    Should Be Equal As Strings    ${resp.status_code}    200

Login_bookappointment_logout
    [Tags]
    LoginKW
    Maximize Browser Window
    Click Element    xpath://span[contains(text(),'Book an appointment')]
    Sleep    1
    Click Element    id:rq_btn3
    Sleep    3
    Scroll Element Into View    id:rq_btn
    Click Button    id:rq_btn
    Sleep    3
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Sleep    5
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    1
    Click Element    xpath://a[@id='ajax_payment']
    Sleep    1
    Click Element    xpath://a[@class='btn btn-success']
    Sleep    3
    Element Text Should Be    xpath://div[@id='refresh_part']    Status Nikola Tesla on web site is Offline
    Sleep    2
    Element Should Be Visible    xpath://div[@class='media-box']//video
    Sleep    3
    Click Element    id:endCall
    Sleep    6
    Patient my appointment page
    Click Element    xpath://span[contains(text(),'Logout')]

setup doctor days
    LoginDocKW
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    2
    Click Link    /profile
    Click Element    xpath://a[contains(text(),'Working days')]
    ${monday} =    Get WebElement    css:.m-form__group:nth-child(2) span
    Select Checkbox    ${monday}
    Sleep    1
    ${tuesday} =    Get WebElement    css:.m-form__group:nth-child(4) > .col-7 span
    Select Checkbox    ${tuesday}
    Sleep    1
    ${wednesday} =    Get WebElement    css:.m-form__group:nth-child(6) > .col-7 span
    Select Checkbox    ${wednesday}
    Sleep    1
    ${thursday} =    Get WebElement    css:.m-form__group:nth-child(8) span
    Select Checkbox    ${thursday}
    Sleep    1
    ${friday} =    Get WebElement    css:.m-form__group:nth-child(10) > .col-7 span
    Select Checkbox    ${friday}
    Sleep    2
    ${saturday} =    Get WebElement    css:.m-form__group:nth-child(12) > .col-7 span
    Select Checkbox    ${saturday}
    Sleep    2
    ${sunday} =    Get WebElement    css:.m-form__group:nth-child(14) span
    Select Checkbox    ${sunday}
    Sleep    2
    Click Button    xpath://div[@id='m_user_profile_tab_5']//button[@class='btn btn-primary m-btn m-btn--custom'][contains(text(),'Save changes')]
    LogoutKW

setup doctor
    LoginKW
    Click Button    id:rq_btn3
    Click Element    id:reason
    Click Element    xpath://option[contains(text(),'Follow up')]
    Input Text    id:symptoms    Set appointment
    Input Text    id:patient_notes    Without paying this appointment is not able to cancel an appointment after changing doctor working days in 24 hrs.
    Radio Button Should Be Set To    fk_appoint_type    2
    Click Element    xpath://label[contains(.,'Physical appearance')]
    Radio Button Should Be Set To    translation    0
    Click Element    xpath://div[@class='form-group m-form__group row']//label[1]
    Capture Page Screenshot    time-slot-{index}.png
    Click Button    id:rq_btn
    Click Element    xpath://div[contains(text(),'Your appointment has been sent to doctor successfu')]
    Click Element    xpath://div[contains(text(),'All appointment time are in german time. Please en')]
    Sleep    3
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    1
    Click Element    xpath://span[contains(text(),'My appointments')]
    Element Should Be Visible    id:appointmentTable_wrapper
    Click Element    xpath://tr[1]//td[2]//a[1]
    Capture Page Screenshot    preview-appointment-{index}.png
    Sleep    4
    Click Element    id:ajax_payment
    Sleep    2
    #Click Element    xpath://div[@class='toast-message']
    Sleep    3
    LogoutKW

TC_001
    create session    get_doctors_details    ${BASEURL}
    ${response}=    get request    get_doctors_details    api/login
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

count
    LoginDocKW
    Click Element    id:qua
    Page Should Contain Element    name:fk_speciality[]
    Page Should Contain Element    name:fk_certification[]
    ${spec} =    Get Element Count    name:fk_speciality[]
    Should Be True    ${spec} > 0
    Log to console    ${spec}
    ${cert} =    Get Element Count    name:fk_certification[]
    Should Be True    ${cert} > 0
    Log to console    ${cert}
    Sleep    1

*** Keywords ***
Open Testbrowser
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If    '${system}' == 'Linux'    Start Virtual Display    1920    1080
    Open Chrome Browser

Open Chrome Browser
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}

json_property_should_equal
    [Arguments]    ${json}    ${property}    ${value_expected}
    ${value_found} =    Get From Dictionary    ${json}    ${property}
    ${error_message} =    Catenate    SEPARATOR=    Expected value for property "    ${property}    " was "    ${value_expected}
    ...    " but found "    ${value_found}    "
    Should Be Equal As Strings    ${value_found}    ${value_expected}    ${error_message}    values=false
