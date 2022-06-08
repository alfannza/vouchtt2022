*** Settings ***
Library  SeleniumLibrary

*** Variables ***


*** Test Cases ***
TC-000_Browser_Setup
    open browser    https://vouch-public.github.io/sdet-interview/  Chrome
    maximize browser window
    sleep   5

TC-001_Widget_Open_Button
    # click widget button
    click element   id:widget-activator
    sleep   2

    # make sure the widget opened by checking widget element visibility
    element should be visible   xpath://*[@id="app"]/div/div[1]/div
    sleep   3

TC-002_Widget_Title_Name_Check
    element should be visible  xpath://div[class="vc-app-bar"]
    sleep   3

TC-ZZZ_Browser_Close
    close browser

*** Keywords ***
