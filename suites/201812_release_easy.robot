*** Settings ***
Documentation     201812 Release
Suite Setup       Open Testbrowser
Suite Teardown    Close All Browsers
Library           SeleniumLibrary
Library           XvfbRobot
Library           DateTime
Resource          _setup.txt

*** Variables ***
${TMP_PATH}       /tmp
# 20190104 AUTHURL and BASEURL shall be in newuser.txt

*** Test Cases ***
Login with existing User
    [Tags]    201812    201812-easy
    GoTo    ${BASEURL}
    Click Link    ${BASEURL}/lang/de
    Input Text    name:email    ${EMAIL}
    Input Text    name:password    ${USERPW}
    Capture Page Screenshot    Screenshot-loginform-{index}.png
    Submit Form
    Capture Page Screenshot    Screenshot-afterlogin-{index}.png

Check doctor icon
    [Tags]    201812    201812-easy
    # https://trello.com/c/PTrtPT61/
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /doctors
    Wait Until Page Contains    Ärzte
    ${count} =    Get Element Count    class:fa-user-md
    Should Be True    ${count} == 1
    Capture Page Screenshot    Screenshot-doctor-icon-{index}.png
    # Missing test, check if on the video session side the icon with the camera is available
    #${count} =    Get Element Count    class:fa-video
    #Should Be True    ${count} == 1

Set birth date on profile
    [Tags]    201812    201812-easy
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /profile
    # Must set the date of birth otherwise i cannot save the formular
    Click Element    id:inputDOB
    Capture Page Screenshot    Screenshot-profile-dob-{index}.png
    # Select Date on Datepicker
    ${current_date_noon} =    Get Current Date    result_format=%Y-%m-%d 00:00:00
    # Log    ${a}
    ${date_in_7d} =    Add Time To Date    ${current_date_noon}    -7 days
    ${unixtime} =    get time    epoch    ${date_in_7d}
    ${data_format} =    Set Variable    ${unixtime}000
    # Log To Console    ${data_format}
    Click Element    xpath=//td[@data-date="${data_format}"]
    Capture Page Screenshot    Screenshot-profile-dob-selected-{index}.png
    # Seems not to work, cannot get the error message and an update will be triggered.
    # Check to short phone number
    # https://trello.com/c/3A2irVEp
    #    [Tags]    201812    201812-easy
    #    Input Text    id:inputPhone    12
    #    Submit Form
    #    Wait Until Page Contains    Personal detail updated successfully.
    #    Capture Page Screenshot    Screenshot-too-short-phone-number-{index}.png
    #    Scroll Element Into View    id:inputPhone
    #    Capture Page Screenshot    Screenshot-too-short-phone-number-{index}.png

Check numbers with leading zero format for phone number
    [Tags]    201812    201812-easy
    # https://trello.com/c/3A2irVEp
    Input Text    id:inputPhone    0012345
    Submit Form
    Wait Until Page Contains    Personal detail updated successfully.

Check stored number leading zero format
    [Tags]    201812    201812-easy
    # https://trello.com/c/3A2irVEp
    ${phone} =    Get Value    id:inputPhone
    Should Be True    ${phone} == 0012345

Check numbers with spaces in phone number
    [Tags]    201812    201812-easy
    # https://trello.com/c/3A2irVEp
    Input Text    id:inputPhone    12 345
    Submit Form
    Wait Until Page Contains    Personal detail updated successfully.

Check numbers with leading + for phone number
    [Tags]    201812    201812-easy
    # https://trello.com/c/3A2irVEp
    Input Text    id:inputPhone    +12345
    Submit Form
    Wait Until Page Contains    Personal detail updated successfully.
    Capture Page Screenshot    Screenshot-leading+phone-number-{index}.png
    Scroll Element Into View    id:inputPhone
    Capture Page Screenshot    Screenshot-leading+phone-number-{index}.png
    # https://trello.com/c/j0NYuNRG/
    # Check first step, must be with a doctor

Say Goodbye patient
    Logout dc24

Check missing password in german on login page
    [Tags]    201812    201812-easy    faa
    # https://trello.com/c/QW3PwfaF
    GoTo    ${BASEURL}
    Click Link    ${BASEURL}/lang/de
    Input Text    name:email    ${EMAIL}
    #Input Text    name:password    ${USERPW}
    Capture Page Screenshot    Screenshot-loginform-{index}.png
    Submit Form
    Wait Until Page Contains    Passwortfeld ist erforderlich.

Check missing email in german on login page
    [Tags]    201812    201812-easy    faa
    # https://trello.com/c/QW3PwfaF
    Clear Element Text    name:email
    Input Text    name:password    ${USERPW}
    Capture Page Screenshot    Screenshot-loginform-{index}.png
    Submit Form
    Wait Until Page Contains    E-Mail-Feld ist erforderlich.

Search Appointment
    [Tags]    201812
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
    [Tags]    201812
    Click Element    class:btn-sm
    Wait Until Page Contains    Geplanter
    Capture Page Screenshot    Screenshot-geplanter-termin-{index}.png

Book appointment
    [Tags]    201812
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
    [Tags]    201812a
    Input Text    id:symptoms    My toe is itching
    Input Text    id:patient_notes    When a hammer was falling to my toe, it starts itching
    # @todo date must be dynamic
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
    Select Checkbox    xpath=(//input[@type='radio'])[2]
    # Select Checkbox    xpath=//*[text()='19:00 - 19:30']
    #Select Checkbox    name:requested_time
    #Click Element    id:rq_btn
    Capture Page Screenshot    Screenshot-termin-buchen-{index}.png

Say Goodbye
    Logout dc24

*** Keywords ***
Open Testbrowser
    ${system}=    Evaluate    platform.system()    platform
    Run Keyword If    '${system}' == 'Linux'    Start Virtual Display    1920    1080
    Open Chrome Browser
    # Missing tests for
    # https://trello.com/c/I23FKMrl/13-file-sharing-problem-at-video
    # https://trello.com/c/4PYpXn6w/16-update-links-in-e-mail-template
    # https://trello.com/c/xoisi14g/29-minimumdepositamount-not-work
    # https://trello.com/c/cAugQcQF/23-improve-filter-in-my-appointments
    # https://trello.com/c/H7rbueDi/27-symptoms-only-18-charaters-possible-correct
    # https://trello.com/c/zQAvQdJ7/9-reorder-layout-of-appointment-information-page
    # For doctors
    # https://trello.com/c/a9ixslYd/14-about-me-should-be-avilable-in-3-language
    # https://trello.com/c/xWpjFUog/19-improvement-tab-qualifikation

Open Chrome Browser
    ${options}    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${options}    add_argument    --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}

Logout dc24
    Click Element    id:m_aside_left_offcanvas_toggle
    Click Link    /logout
