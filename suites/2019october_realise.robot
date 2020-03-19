*** Settings ***
Documentation     Test API ${TESTURL}
Library           Collections
Library           RequestsLibrary
Resource          _mysetup.txt
Resource          _keywords.txt

*** Variable ***
${bearerToken}    "Bearer eHjL7wzBEWiS19XF3Qz6UahclLNkm0PAs7Ne1MLA"

*** Test Cases ***
TC_001
    [Documentation]    login
    create session    get_login    ${TESTURL}
    ${headers}    Create Dictionary    Autorisation=${bearerToken}    Content-Type=text/html
    ${response}=    get request    get_login    /api/loginApi
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    ${actual_code} =    Convert To String    ${response.status_code}
    Should Be Equal    ${actual_code}    200

TC_002
    [Documentation]    forgot password
    create session    get_doctors_details    ${TESTURL}
    ${response}=    get request    get_doctors_details    /password/reset
    Log To Console    ${response.status_code}
    #Log To Console    ${response.content}

TC_003
    [Documentation]    registration
    create session    get_doctors_details    ${TESTURL}
    ${response}=    get request    get_doctors_details    /register
    Log To Console    ${response.status_code}
    #Log To Console    ${response.content}
    Log To Console    ${response.headers}

TC_004
    create session    get_doctors_details    ${TESTURL}
    ${response}=    get request    get_doctors_details    /api/users/2/edit
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

TC_005
    create session    get_doctors_details    ${TESTURL}
    ${response}=    get request    get_doctors_details    /api/users/2/edit
    ${actual_code} =    Convert To String    ${response.status_code}
    Should Be Equal    ${actual_code}    200

TC_006
    create session    get_doctors_details    ${TESTURL}
    ${response}=    get request    get_doctors_details    /users/2/edit
    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${content_type_value}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Be Equal    ${content_type_value}    text/html; charset=UTF-8

count
