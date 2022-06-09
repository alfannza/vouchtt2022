*** Settings ***
Library  SeleniumLibrary

*** Variables ***

*** Test Cases ***
TC-000_Browser_Setup
    open browser    https://vouch-public.github.io/sdet-interview/  Chrome
    maximize browser window
    sleep   5

TC-001_Chat_Open_Button
    # click widget button
    click element   id:widget-activator
    sleep   2

    # switch to widget active frame
    select frame  id:vc-chat-iframe
    sleep   3

    # make sure the widget opened by checking widget toggle element visibility
    element should be visible   xpath://*[@id="app"]/div/div[1]/div
    sleep   3

TC-002_Chat_Panel_Title_Check
    # active frame widget title matching
    element should contain  xpath://*[@id="app"]/div/div[1]/div/div[2]  Vouch Widget

TC-003_Chat_Panel_Minimize_Button
    # click minimize button
    click element   xpath://*[@id="app"]/div/div[1]/div/div[3]
    sleep   2

    # makes sure widget closed / not visible
    element should not be visible  //*[@id="app"]/div/div[1]/div/div[2]

TC-004_Get_Started_Button_Should_Start_Conversation
    # click widget button
    click element   id:widget-activator
    sleep   2

TC-ZZZ_Browser_Close
    #close browser

*** Keywords ***
