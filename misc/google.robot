*** Settings ***
Documentation     Hello World for robotframwork with headless chrome
Library           SeleniumLibrary    #Library    OperatingSystem    #Suite Setup    Setup chromedriver    ### https://stackoverflow.com/questions/28537290/how-to-set-path-chrome-driver-in-robot-framework    #*** Keywords ****
...               #Setup chromedriver    #Set Environment Variable    webdriver.chrome.driver    /usr/local/bin/chromedriver    #Set Environment Variable    webdriver.chrome.binary    /Applications/Chrome.app/Contents/MacOS/Google\ Chrome

*** Test Cases ***
