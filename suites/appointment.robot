*** Settings ***
Documentation     Appointment
Suite Setup       Open Testbrowser    # https://www.blazemeter.com/blog/robot-framework-the-ultimate-guide-to-running-your-tests
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Library           DateTime
Resource          _setup.txt    # documentation http://robotframework.org/Selenium2Library/Selenium2Library.html#Input%20Text    # keywords and parameters must be seperated by 2 spaces "    "    #Resource    newuser.txt
Resource          _mysetup.txt

*** Variables ***
${TMP_PATH}       /tmp
# 20190104 AUTHURL and BASEURL shall be in _setup.txt

*** Test Cases ***
Login with existing User
    [Tags]    appointment
    GoTo    ${BASEURL}
    Click Link    ${BASEURL}/lang/de
    Input Text    name:email    ${EMAIL}
    Input Text    name:password    ${USERPW}
    #Capture Page Screenshot    Screenshot-loginform-{index}.png
    Submit Form
    #Capture Page Screenshot    Screenshot-afterlogin-{index}.png

View doctors
    [Tags]    appointment
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /doctors
    Wait Until Page Contains    Ärzte
    #Capture Page Screenshot    Screenshot-doctors-{index}.png

Search Appointment
    [Tags]    appointment
    Click Element    id:pdate
    Capture Page Screenshot    Screenshot-searchform-{index}.png
    # Select Date on Datepicker
    ${current_date_noon} =    Get Current Date    result_format=%Y-%m-%d 00:00:00
    # Log    ${a}
    ${date_in_7d} =    Add Time To Date    ${current_date_noon}    7 days
    ${unixtime} =    get time    epoch    ${date_in_7d}
    ${data_format} =    Set Variable    ${unixtime}000
    # Log To Console    ${data_format}
    Click Element    xpath=//td[@data-date="${data_format}"]
    Submit Form
    Capture Page Screenshot    Screenshot-perform-search-{index}.png
    # @todo missing test, just a way

Choose appointment
    [Tags]    appointment
    Click Element    class:btn-sm
    Wait Until Page Contains    Geplanter
    #Capture Page Screenshot    Screenshot-geplanter-termin-{index}.png

Book appointment
    [Tags]    appointment.out
    Input Text    id:symptoms    My toe is itching
    Input Text    id:patient_notes    When a hammer was falling to my toe, it starts itching
    Wait Until Page Contains    19:00
    # Web Developer console ffx: $x("//input[@type='radio']")
    # --> https://librarycarpentry.org/lc-webscraping/02-xpath/
    Scroll Element Into View    id:rq_btn
    Capture Page Screenshot    Screenshot-choose-time-for-termin-{index}.png
    ${variable} =    Get Element Count    xpath=//div[id="dynamic-content"]
    Log To Console    ${variable}
    #${radio} =    Get Element Attribute    xpath=//input[@type="radio"][1]    name
    #Log To Console    ${radio}
    #Select Checkbox    name:requested_time
    #Capture Page Screenshot    Screenshot-choose-time-for-termin-{index}.png

Book appointment
    [Tags]    appointment
    Input Text    id:symptoms    My toe is itching
    Input Text    id:patient_notes    When a hammer was falling to my toe, it starts itching
    # @todo date must be dynamic, working on tag fii
    Click Element    id:requested_date
    # https://stackoverflow.com/questions/40025037/selenium-robot-framework-get-table-cell
    # http://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Get%20Table%20Cell
    # ${table_cell} =    Get Table Cell    xpath=//table[@class="table-condensed"]    6    6
    # Click Element    ${table_cell}
    #
    # @done date must be dynamic
    # https://stackoverflow.com/questions/42416928/how-can-i-get-the-current-day-in-robot-framework
    # https://stackoverflow.com/questions/24905393/robotframework-getting-date-at-runtime-using-get-current-date-in-specific-form
    ${current_date_noon} =    Get Current Date    result_format=%Y-%m-%d 00:00:00
    # Log    ${a}
    ${date_in_7d} =    Add Time To Date    ${current_date_noon}    7 days
    ${unixtime} =    get time    epoch    ${date_in_7d}
    ${data_format} =    Set Variable    ${unixtime}000
    # Log To Console    ${data_format}
    Click Element    xpath=//td[@data-date="${data_format}"]
    # Its not an timing issue
    # Sleep    5s    New timesframes shall load
    # @todo find the checkbox... ...seems that I have to execute the javascript which gets the new html to dispaly
    # the available timeframes
    # ${variable} =    Get Element Count    xpath=//input[@type="radio"]
    # Log    ${variable}
    # ${radio} =    Get Element Attribute    xpath=//input[@type="radio"][4]    name
    # Log    ${radio}
    # https://www.webperformance.com/load-testing-tools/blog/real-browser-manual/building-a-testcase/how-locate-element-the-page/xpath-locator-examples/
    Execute Javascript    window.getTimeSlots()
    #Select Checkbox    xpath=(//input[@type='radio'])[2]
    #Select Radio button    requested_time    19:00 - 19:30
    Wait Until Element Is Enabled    name:requested_time
    Select Radio Button    requested_time    19:00 - 19:30
    #Click Element    name:requested_time
    # Select Checkbox    xpath=//*[text()='19:00 - 19:30']
    #Select Checkbox    name:requested_time
    #Click Element    id:rq_btn
    Capture Page Screenshot    Screenshot-termin-buchen-{index}.png
    Submit Form

Say Goodbye
    [Tags] appointment
    Logout dc24

*** Keywords ***
Logout dc24
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /logout

Open Chrome Browser
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}

Open Testbrowser
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If    '${system}' == 'Linux'    Start Virtual Display    1920    1080
    Open Chrome Browser
