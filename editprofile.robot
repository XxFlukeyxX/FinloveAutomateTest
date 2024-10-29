*** Settings ***
Documentation     Profile Test Suite
Library           AppiumLibrary

*** Variables ***
${URL}                        http://25.4.244.140:4723
${ANDROID_AUTOMATION_NAME}     UiAutomator2
${ANDROID_PLATFORM_NAME}       Android
${ANDROID_PLATFORM_VERSION}    14
${ANDROID_APP}                 C:\\Users\\mikot\\AndroidStudioProjects\\FinloveAndroid1\\app\\build\\outputs\\apk\\debug\\app-debug.apk

${VALID_USERNAME}              a
${VALID_PASSWORD}              1234
${NEW_NICKNAME}                NewNick
${NEW_EMAIL}                   newemail@example.com
${NEW_FIRST_NAME}              NewFirstName
${NEW_LAST_NAME}               NewLastName
${NEW_HOME}                    New Address
${NEW_HEIGHT}                  180

*** Test Cases ***
Valid Edit Profile Test
    [Documentation]    แก้ไขโปรไฟล์ของผู้ใช้ด้วยข้อมูลใหม่
    Open Test Application
    Login With Valid Credentials
    Navigate to Profile Page
    Edit Profile Information
    Save Profile Changes
    Close Application

*** Keywords ***
Open Test Application
    Open Application    ${URL}    automationName=${ANDROID_AUTOMATION_NAME}   platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}  app=${ANDROID_APP}
    Wait Until Element Is Visible  id=th.ac.rmutto.finlove:id/btn_login

Login With Valid Credentials
    Click Element     id=th.ac.rmutto.finlove:id/btn_login
    Wait Until Element Is Visible   id=th.ac.rmutto.finlove:id/editTextUsername    timeout=10s
    Input Text        id=th.ac.rmutto.finlove:id/editTextUsername   ${VALID_USERNAME}
    Input Text        id=th.ac.rmutto.finlove:id/editTextPassword   ${VALID_PASSWORD}
    Click Element     id=th.ac.rmutto.finlove:id/buttonLogin  
    Wait Until Element Is Visible   id=th.ac.rmutto.finlove:id/container    timeout=30s

Navigate to Profile Page
    Wait Until Element Is Visible   id=th.ac.rmutto.finlove:id/navigation_profile
    Click Element    id=th.ac.rmutto.finlove:id/navigation_profile

Edit Profile Information
    # เปลี่ยนข้อมูลในหน้าข้อมูลส่วนตัว
    Wait Until Element Is Visible   id=th.ac.rmutto.finlove:id/buttonEditProfile
    Click Element    id=th.ac.rmutto.finlove:id/buttonEditProfile
    Input Text        id=th.ac.rmutto.finlove:id/textViewNickname    ${NEW_NICKNAME}
    Input Text        id=th.ac.rmutto.finlove:id/textViewEmail       ${NEW_EMAIL}
    Input Text        id=th.ac.rmutto.finlove:id/textViewFirstName   ${NEW_FIRST_NAME}
    Input Text        id=th.ac.rmutto.finlove:id/textViewLastName    ${NEW_LAST_NAME}

    Scroll Profile Screen  id=th.ac.rmutto.finlove:id/buttonDeleteAccount   10
    Input Text        id=th.ac.rmutto.finlove:id/textViewHome        ${NEW_HOME}
    Input Text        id=th.ac.rmutto.finlove:id/textViewHeight      ${NEW_HEIGHT}

Save Profile Changes
    Click Element     id=th.ac.rmutto.finlove:id/buttonSaveProfile

Scroll Profile Screen
    [Arguments]    ${element_id}    ${max_scrolls}
    ${scroll_count}=  Set Variable    0
    WHILE   ${scroll_count} < ${max_scrolls}
        Log To Console   Scroll Attempt: ${scroll_count}
        ${is_element_visible}=  Run Keyword And Return Status  Element Should Be Visible  ${element_id}  timeout=5s
        Run Keyword If  '${is_element_visible}' == 'True'  Exit For Loop
        Log To Console   Scrolling the screen... Attempt ${scroll_count}
        Swipe    500    1500    500    500    # เลื่อนหน้าจอจากล่างขึ้นบน
        ${scroll_count}=  Evaluate  ${scroll_count} + 1
    END
