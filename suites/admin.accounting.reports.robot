*** Settings ***
Documentation     Test login and logout with ${EMAIL}
...               Assert and verify accounting reposrts page
...               Log to console account_no, date,
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Resource          _keywords.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp

*** Test Cases ***
Login
    [Tags]    account.reports
    LoginAdminKW

Go to Accounting Reports
    [Tags]    account.reports
    Click Element    id:m_aside_left_offcanvas_toggle
    Sleep    3
    Capture Page Screenshot    offcanvas-{index}.png
    Click Element    xpath://a[@class='m-menu__link m-menu__toggle']//span[@class='m-menu__link-text'][contains(text(),'Reports')]
    Sleep    1
    Capture Page Screenshot    reports-{index}.png
    Click Element    xpath://span[contains(text(),'Accounting report')]
    Admin Accounting report page
    #Click Element    id:drawupaccount
    Sleep    2
    Click Element    xpath://div[1]/table[1]/tbody[1]/tr[1]/td[1]
    Sleep    1
    Capture Page Screenshot    report-{index}.png
    Wait Until Element Is Visible    xpath://span[@class='dtr-data']//i[@class='m-menu__link-icon la la-file-pdf-o']
    Element Should Be Visible    xpath://span[@class='dtr-data']//i[@class='m-menu__link-icon la la-file-pdf-o']
    Element Should Be Visible    xpath://th[2]
    Element Text Should Be    xpath://th[contains(text(),'Accounting No')]    Accounting No
    Element Should Be Visible    xpath://th[3]
    Element Text Should Be    xpath://th[contains(text(),'Date')]    Date
    Element Should Be Visible    xpath://th[4]
    Element Text Should Be    xpath://th[contains(text(),'User id')]    User id
    Element Should Be Visible    xpath://th[5]
    Element Text Should Be    xpath://th[contains(text(),'Name')]    Name
    Element Should Be Visible    xpath://th[6]
    Element Text Should Be    xpath://th[contains(text(),'Subtotal')]    Subtotal
    Element Should Be Visible    xpath://*[@id="mytable"]/thead/tr/th[7]
    Element Text Should Be    xpath://*[@id="mytable"]/thead/tr/th[7]    Fee
    Element Should Be Visible    xpath://span[contains(text(),'Total')]
    Element Text Should Be    xpath://span[contains(text(),'Total')]    Total
    Element Should Be Visible    xpath://span[contains(text(),'Currency')]
    Element Text Should Be    xpath://span[contains(text(),'Currency')]    Currency
    Element Should Be Visible    xpath://span[contains(text(),'Address')]
    Element Text Should Be    xpath://span[contains(text(),'Address')]    Address
    Element Should Be Visible    xpath://span[contains(text(),'Zip code')]
    Element Text Should Be    xpath://span[contains(text(),'Zip code')]    Zip code
    Element Should Be Visible    xpath://span[contains(text(),'Country')]
    Element Text Should Be    xpath://span[contains(text(),'Country')]    Country
    Element Should Be Visible    xpath://span[contains(text(),'IBAN')]
    Element Text Should Be    xpath://span[contains(text(),'IBAN')]    IBAN
    Element Should Be Visible    xpath://span[contains(text(),'Bic')]
    Element Text Should Be    xpath://span[contains(text(),'Bic')]    Bic
    Element Should Be Visible    xpath://span[contains(text(),'Receipt')]
    Element Text Should Be    xpath://span[contains(text(),'Receipt')]    Receipt
    ${accounting_no} =    Get Text    xpath://tr[1]/td[2]
    Log To Console    ${accounting_no}
    ${date} =    Get Text    xpath://tr[1]/td[3]
    Log To Console    ${date}
    ${user_id} =    Get Text    xpath://tr[1]/td[4]
    Log To Console    ${user_id}
    ${name} =    Get Text    xpath://tr[1]/td[5]
    Log To Console    ${name}
    ${subtotal} =    Get Text    xpath://tr[1]/td[6]
    Log To Console    ${subtotal}
    ${fee} =    Get Text    xpath://tr[1]/td[7]
    Log To Console    ${fee}
    ${total} =    Get Text    css:li:nth-child(1) > .dtr-data
    Log To Console    ${total}
    ${currency} =    Get Text    css:li:nth-child(2) > .dtr-data
    Log To Console    ${currency}
    ${address} =    Get Text    css:li:nth-child(3) > .dtr-data
    Log To Console    ${address}
    ${city} =    Get Text    css:li:nth-child(4) > .dtr-data
    Log To Console    ${city}
    ${zip} =    Get Text    css:li:nth-child(5) > .dtr-data
    Log To Console    ${zip}
    ${country} =    Get Text    css:li:nth-child(6) > .dtr-data
    Log To Console    ${country}
    ${iban} =    Get Text    css:li:nth-child(7) > .dtr-data
    Log To Console    ${iban}
    ${bic} =    Get Text    css:li:nth-child(8) > .dtr-data
    Log To Console    ${bic}
    Click Element    xpath://div[1]/table[1]/tbody[1]/tr[1]/td[1]
    LogoutKW

*** Keywords ***
