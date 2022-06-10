*** Settings ***
Library  SeleniumLibrary
Library   SeleniumLibrary

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
    # reset frame
    unselect frame

    # prerequisite, clear cookies, local storage
    delete all cookies
    execute javascript  localStorage.clear();

    # click widget button
    click element   id:widget-activator
    sleep   2

    # switch to widget active frame
    select frame  id:vc-chat-iframe
    sleep   3

    # click get started, wait for element visibility
    click element  xpath://*[@id="app"]/div/div[3]/div/div
    sleep   5
    wait until element is visible  xpath://*[@id="vc-list"]/div/div[1]/div/div/div/div[2]/div[1]/div

    # check message is not empty, content is "hi, how are you"
    element text should not be  xpath://*[@id="vc-list"]/div/div[1]/div/div/div/div[2]/div[1]/div  ${EMPTY}
    element should contain  xpath://*[@id="vc-list"]/div/div[1]/div/div/div/div[2]/div[1]/div  Hi! How are you?

TC-005_Sending_Hello_Message
    # input write hello
    input text  xpath://*[@id="app"]/div/div[3]/div/div[1]/input  hello
    press keys  xpath://*[@id="app"]/div/div[3]/div/div[1]/input  \ue006
    sleep  4

    # expect widget response "hello!"
    element should contain  //*[@id="vc-list"]/div/div[3]/div/div/div/div[2]/div[1]/div  hello!

TC-006_Click_Bottom_Button_Should_Trigger_Message
    # click hello button
    click element  xpath://span[@class="material-design-icon wrench-icon"]
    sleep  3

    # expecting trigger message to be send, 2nd message from me
    element text should be  xpath://*[@class="vc-message-text-bubble me"][last()]  Hello
    sleep  3

    # expecting hello! response from bot, 4th message from bot
    element text should be  xpath://*[@class="vc-message-text-bubble"][last()]  hello!

TC-ZZZ_Browser_Close
    #close browser

*** Keywords ***
