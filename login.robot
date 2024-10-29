*** Settings ***
Documentation     Login Test Suite
Library           AppiumLibrary

*** Variables ***
${URL}                        http://25.4.244.140:4723
${ANDROID_AUTOMATION_NAME}     UiAutomator2
${ANDROID_PLATFORM_NAME}       Android
${ANDROID_PLATFORM_VERSION}    14
${ANDROID_APP}                 C:\\Users\\mikot\\AndroidStudioProjects\\FinloveAndroid1\\app\\build\\outputs\\apk\\debug\\app-debug.apk

${VALID_USERNAME}              a
${VALID_PASSWORD}              1234
${INVALID_USERNAME}            testdfsdf
${INVALID_PASSWORD}            1234

*** Test Cases ***
Valid Login Test
    [Documentation]    เข้าสู่ระบบด้วยชื่อผู้ใช้และรหัสที่ถูกต้อง
    [tags]             smoke
    Open Test Application
    Click Element     id=th.ac.rmutto.finlove:id/btn_login
    Wait Until Element Is Visible   id=th.ac.rmutto.finlove:id/editTextUsername    timeout=10s
    Input Text        id=th.ac.rmutto.finlove:id/editTextUsername   ${VALID_USERNAME}
    Input Text        id=th.ac.rmutto.finlove:id/editTextPassword   ${VALID_PASSWORD}
    Click Element     id=th.ac.rmutto.finlove:id/buttonLogin  
    Wait Until Element Is Visible   id=th.ac.rmutto.finlove:id/container    timeout=30s
    Close Application

Invalid Login Test
    [Documentation]    เข้าสู่ระบบด้วยชื่อผู้ใช้และรหัสที่ไม่ถูกต้อง
    [tags]
    Open Test Application
    Wait Until Element Is Visible  id=th.ac.rmutto.finlove:id/btn_login 
    Click Element     id=th.ac.rmutto.finlove:id/btn_login
    Wait Until Element Is Visible   id=th.ac.rmutto.finlove:id/editTextUsername    timeout=10s
    Input Text        id=th.ac.rmutto.finlove:id/editTextUsername   ${INVALID_USERNAME}
    Input Text        id=th.ac.rmutto.finlove:id/editTextPassword   ${INVALID_PASSWORD}
    Click Element     id=th.ac.rmutto.finlove:id/buttonLogin
    Wait Until Element Is Visible   id=th.ac.rmutto.finlove:id/buttonLogin    timeout=30s
    Close Application

*** Keywords ***
Open Test Application
    Sleep    10s
    Open Application    ${URL}    automationName=${ANDROID_AUTOMATION_NAME}   platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}  app=${ANDROID_APP}
    Wait Until Element Is Visible  id=th.ac.rmutto.finlove:id/btn_login
