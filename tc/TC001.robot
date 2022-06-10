*** Settings ***
Library  SeleniumLibrary
Library   SeleniumLibrary

*** Variables ***
${widget_open_btn_loc}          id:widget-activator
${widget_frame_loc}             id:vc-chat-iframe
${widget_open_img_loc}          xpath://*[@id="app"]/div/div[1]/div
${widget_title_loc}             xpath://*[@id="app"]/div/div[1]/div/div[2]
${widget_minimize_btn_loc}      xpath://*[@id="app"]/div/div[1]/div/div[3]
${widget_get_started_btn_loc}   xpath://*[@id="app"]/div/div[3]/div/div
${widget_last_msg_me_loc}       xpath:(//div[@class="vc-message-text-bubble me"])[last()]
${widget_last_msg_bot_loc}      xpath:(//div[@class="vc-message-text-bubble"])[last()]
${widget_input_loc}             xpath://*[@id="app"]/div/div[3]/div/div[1]/input
${widget_hello_btn_loc}         xpath://span[@class="material-design-icon wrench-icon"]
${widget_what_btn_loc}          xpath://div[@class="message-button"][text()=" What "]

*** Test Cases ***
TC-000_Browser_Setup
    open browser    https://vouch-public.github.io/sdet-interview/  Chrome
    maximize browser window
    sleep   5

TC-001_Chat_Open_Button
    # click widget button
    click element   ${widget_open_btn_loc}
    sleep   2

    # switch to widget active frame
    select frame  ${widget_frame_loc}
    sleep   3

    # make sure the widget opened by checking widget toggle element visibility
    element should be visible   ${widget_open_img_loc}
    sleep   3

TC-002_Chat_Panel_Title_Check
    # active frame widget title matching
    element should contain  ${widget_title_loc}  Vouch Widget

TC-003_Chat_Panel_Minimize_Button
    # click minimize button
    click element   ${widget_minimize_btn_loc}
    sleep   2

    # makes sure widget closed / not visible
    element should not be visible  ${widget_title_loc}

TC-004_Get_Started_Button_Should_Start_Conversation
    # reset frame
    unselect frame

    # prerequisite, clear cookies, local storage
    delete all cookies
    execute javascript  localStorage.clear();

    # click widget button
    click element   ${widget_open_btn_loc}
    sleep   2

    # switch to widget active frame
    select frame  ${widget_frame_loc}
    sleep   3

    # click get started, wait for element visibility
    click element  ${widget_get_started_btn_loc}
    sleep   5
    wait until element is visible  ${widget_last_msg_bot_loc}

    # check message is not empty, content is "hi, how are you"
    element text should not be  ${widget_last_msg_bot_loc}  ${EMPTY}
    element should contain  ${widget_last_msg_bot_loc}  Hi! How are you?

TC-005_Sending_Hello_Message
    # input write hello
    input text  ${widget_input_loc}  hello
    press keys  ${widget_input_loc}  \ue006
    sleep  4

    # expect widget response "hello!"
    element should contain  ${widget_last_msg_bot_loc}  hello!

TC-006_Click_Bottom_Button_Should_Trigger_Message
    # click hello button
    click element  ${widget_hello_btn_loc}
    sleep  3

    # expecting trigger message to be send, 2nd message from me
    element text should be  ${widget_last_msg_me_loc}  Hello
    sleep  3

    # expecting hello! response from bot, 4th message from bot
    element text should be  ${widget_last_msg_bot_loc}  hello!

TC-007_Widget_Should_Reply_With_What
    # check visibilty of what button, and click
    element should be visible  ${widget_what_btn_loc}
    click element  ${widget_what_btn_loc}
    sleep  5

    # expecting widget to respon with what?
    element text should be  ${widget_last_msg_bot_loc}  what ?

TC-008_Widget_Retains_Conversation
    # unselect frame, refresh page
    reload page
    sleep  3

    # click widget button
    wait until element is visible  ${widget_open_btn_loc}
    click element   ${widget_open_btn_loc}
    sleep   2

    # switch to widget active frame
    select frame  ${widget_frame_loc}
    sleep   6

    # checking last message is same as last condition; me:What, bot:what ?
    element text should be  ${widget_last_msg_me_loc}  What
    element text should be  ${widget_last_msg_bot_loc}  what ?

TC-ZZZ_Browser_Close
    close browser

*** Keywords ***
