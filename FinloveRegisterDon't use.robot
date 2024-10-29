*** Settings ***
Documentation     Register Test Suite for FINLOVE Application
Library           AppiumLibrary
Library           BuiltIn
Library           random  # ใช้สำหรับสุ่มค่า

*** Variables ***
${URL}                        http://25.4.244.140:4723
${ANDROID_AUTOMATION_NAME}     UiAutomator2
${ANDROID_PLATFORM_NAME}       Android
${ANDROID_PLATFORM_VERSION}    14
${ANDROID_APP}                C:\\Users\\mikot\\AndroidStudioProjects\\FinloveAndroid1\\app\\build\\outputs\\apk\\debug\\app-debug.apk
${PASSWORD}                   12345678
${FIRST_NAME}                 ga
${LAST_NAME}                  wa
${NICKNAME}                   ra
${PHONE_NUMBER}               0801234567
${HEIGHT}                     175
${LIKES}                      3
${GENDER_OPTIONS}             ['ชาย', 'หญิง', 'อื่นๆ']
${TARGET_OPTIONS}             ['หาคู่รักที่จริงใจ', 'หาคู่เดทช่วงสั้นๆ', 'หาเพื่อนใหม่', 'ไม่มีเจาะจง']
${INTERESTED_GENDER_OPTIONS}  ['ชาย', 'หญิง', 'อื่นๆ']
${IMAGE_PATH}                 C:\\path\\to\\image.jpg

*** Test Cases ***
Valid Register Test 3 Iterations
    FOR    ${index}    IN RANGE    1
        ${RANDOM_NUMBER}=    Evaluate    random.randint(100, 999)    random
        ${USERNAME}=    Set Variable    user${index}${RANDOM_NUMBER}
        ${EMAIL}=       Set Variable    user${RANDOM_NUMBER}@gmail.com
        Log    Registering with Username: ${USERNAME} and Email: ${EMAIL}
        Open Test Application
        Navigate to Registration Page
        Fill Registration First Page    ${USERNAME}    ${EMAIL}
        Fill Registration Second Page
        Fill Registration Third Page
        Fill Registration Fourth Page
        Fill Registration Fifth Page
        Fill Registration Sixth Page
        Fill Registration Seventh Page
        Fill Registration Eighth Page
        Wait Until First Page Is Visible
        Close Application
    END

*** Keywords ***
Open Test Application
    Open Application    ${URL}    automationName=${ANDROID_AUTOMATION_NAME}   platformName=${ANDROID_PLATFORM_NAME}  platformVersion=${ANDROID_PLATFORM_VERSION}  app=${ANDROID_APP}
    Wait Until Element Is Visible  id=th.ac.rmutto.finlove:id/btn_login
    Click Element     id=th.ac.rmutto.finlove:id/checkbox_terms
    Click Element     id=th.ac.rmutto.finlove:id/btn_register

Navigate to Registration Page
    Wait Until Element Is Visible  id=th.ac.rmutto.finlove:id/btn_next
    Click Element     id=th.ac.rmutto.finlove:id/btn_next

Fill Registration First Page
    [Arguments]    ${USERNAME}    ${EMAIL}
    Input Text    id=th.ac.rmutto.finlove:id/editTextEmail          ${EMAIL}
    Input Text    id=th.ac.rmutto.finlove:id/editTextUsername       ${USERNAME}
    Input Text    id=th.ac.rmutto.finlove:id/editTextPassword       ${PASSWORD}
    Click Element    id=th.ac.rmutto.finlove:id/buttonNext

Fill Registration Second Page
    Wait Until Element Is Visible  id=th.ac.rmutto.finlove:id/editTextLastname
    Input Text    id=th.ac.rmutto.finlove:id/editTextFirstname      ${FIRST_NAME}
    Input Text    id=th.ac.rmutto.finlove:id/editTextLastname       ${LAST_NAME}
    Input Text    id=th.ac.rmutto.finlove:id/editTextNickname       ${NICKNAME}
    Click Element    id=th.ac.rmutto.finlove:id/buttonNextStep2

Fill Registration Third Page
    Wait Until Element Is Visible  id=th.ac.rmutto.finlove:id/editTextPhoneNumber
    Select Gender
    Input Text        id=th.ac.rmutto.finlove:id/editTextHeight     ${HEIGHT}
    Input Text        id=th.ac.rmutto.finlove:id/editTextPhoneNumber    ${PHONE_NUMBER}
    Click Element     id=th.ac.rmutto.finlove:id/buttonNextStep3

Fill Registration Fourth Page
    Wait Until Element Is Visible  id=th.ac.rmutto.finlove:id/editTextHome
    Select Education Level   ปริญญาตรี
    Set Random Date of Birth
    Input Text               id=th.ac.rmutto.finlove:id/editTextHome    "123 Your Street, City"
    Click Element            id=th.ac.rmutto.finlove:id/buttonNextStep4

Fill Registration Fifth Page
    Select Interest   ${LIKES}
    Click Element     id=th.ac.rmutto.finlove:id/buttonNextStep5

Fill Registration Sixth Page
    Select Target
    Click Element     id=th.ac.rmutto.finlove:id/buttonNextStep6

Fill Registration Seventh Page
    Select Interested Gender
    Click Element               id=th.ac.rmutto.finlove:id/buttonNextStep7

Fill Registration Eighth Page
    Wait Until Element Is Visible  id=th.ac.rmutto.finlove:id/buttonSelectImage  timeout=20
    Click Element    id=th.ac.rmutto.finlove:id/buttonSelectImage
    Wait Until Element Is Visible  xpath=//android.support.v7.widget.RecyclerView/android.widget.RelativeLayout[1]  timeout=20
    Click Element  xpath=//android.support.v7.widget.RecyclerView/android.widget.RelativeLayout[1]
    Wait Until Element Is Visible  xpath=(//android.widget.ImageView[@content-desc="Photo taken on Oct 8, 2024 10:43 PM"])[2]  timeout=20
    Click Element  xpath=(//android.widget.ImageView[@content-desc="Photo taken on Oct 8, 2024 10:43 PM"])[2]
    Wait Until Element Is Visible  id=th.ac.rmutto.finlove:id/buttonUploadImage  timeout=30
    Click Element  id=th.ac.rmutto.finlove:id/buttonUploadImage  

Wait Until First Page Is Visible
    Wait Until Element Is Visible  id=th.ac.rmutto.finlove:id/btn_login  timeout=30

Select Gender
    ${gender} =    Evaluate    random.choice(${GENDER_OPTIONS})    random
    Log    Randomly selected gender: ${gender}
    Run Keyword If  '${gender}' == 'ชาย'     Click Element   id=th.ac.rmutto.finlove:id/buttonMale
    ...            ELSE IF  '${gender}' == 'หญิง'   Click Element   id=th.ac.rmutto.finlove:id/buttonFemale
    ...            ELSE   Click Element   id=th.ac.rmutto.finlove:id/buttonOther

Set Random Date of Birth
    Click Element    id=th.ac.rmutto.finlove:id/buttonSelectDate
    Wait Until Element Is Visible  id=android:id/date_picker_header_year
    Click Element    id=android:id/button1
    Wait Until Page Does Not Contain Element   id=android:id/button1

Select Interest
    [Arguments]   ${LIKES}
    Wait Until Element Is Visible  id=th.ac.rmutto.finlove:id/buttonOption1  timeout=10
    ${all_interests}    Create List    ฟุตบอล    ภาพยนตร์    ท่องเที่ยว    อนิเมชั่น    ช็อปปิ้ง    เล่นดนตรี    เล่นกีฬา    เล่นเกม    อ่านหนังสือ    ปาร์ตี้   สายควัน    ออกกำลังกาย    ตกปลา    รักสัตว์    ของหวาน    ถ่ายรูป              
    ${num_of_likes}    Convert To Integer    ${LIKES}
    ${interest_list_length}    Get Length    ${all_interests}
    Run Keyword If    ${num_of_likes} > ${interest_list_length}    Fail    "จำนวนความชอบที่ต้องการสุ่มเกินกว่าที่มีอยู่"
    ${random_interests}    Evaluate    random.sample(${all_interests}, ${num_of_likes})    random
    FOR    ${interest}    IN    @{random_interests}
        Run Keyword If  '${interest}' == 'ฟุตบอล'    Click Element   id=th.ac.rmutto.finlove:id/buttonOption1
        ...            ELSE IF  '${interest}' == 'ภาพยนตร์'  Click Element   id=th.ac.rmutto.finlove:id/buttonOption2
        ...            ELSE IF  '${interest}' == 'ท่องเที่ยว'  Click Element   id=th.ac.rmutto.finlove:id/buttonOption3
        ...            ELSE IF  '${interest}' == 'อนิเมชั่น'  Click Element   id=th.ac.rmutto.finlove:id/buttonOption4
        ...            ELSE IF  '${interest}' == 'ช็อปปิ้ง'   Click Element   id=th.ac.rmutto.finlove:id/buttonOption5
        ...            ELSE IF  '${interest}' == 'เล่นดนตรี'  Click Element   id=th.ac.rmutto.finlove:id/buttonOption6
        ...            ELSE IF  '${interest}' == 'เล่นกีฬา'   Click Element   id=th.ac.rmutto.finlove:id/buttonOption7
        ...            ELSE IF  '${interest}' == 'เล่นเกม'     Click Element   id=th.ac.rmutto.finlove:id/buttonOption8
        ...            ELSE IF  '${interest}' == 'อ่านหนังสือ'  Click Element   id=th.ac.rmutto.finlove:id/buttonOption9
        ...            ELSE IF  '${interest}' == 'ปาร์ตี้'    Click Element   id=th.ac.rmutto.finlove:id/buttonOption10
        ...            ELSE IF  '${interest}' == 'สายควัน'    Click Element   id=th.ac.rmutto.finlove:id/buttonOption11
        ...            ELSE IF  '${interest}' == 'ออกกำลังกาย'    Click Element   id=th.ac.rmutto.finlove:id/buttonOption12
        ...            ELSE IF  '${interest}' == 'ตกปลา'    Click Element   id=th.ac.rmutto.finlove:id/buttonOption13
        ...            ELSE IF  '${interest}' == 'รักสัตว์'    Click Element   id=th.ac.rmutto.finlove:id/buttonOption14
        ...            ELSE IF  '${interest}' == 'ของหวาน'    Click Element   id=th.ac.rmutto.finlove:id/buttonOption15
        ...            ELSE IF  '${interest}' == 'ถ่ายรูป'    Click Element   id=th.ac.rmutto.finlove:id/buttonOption16
    END

Select Target
    ${target} =    Evaluate    random.choice(${TARGET_OPTIONS})    random
    Log    Randomly selected target: ${target}
    Run Keyword If  '${target}' == 'หาคู่รักที่จริงใจ'    Click Element   id=th.ac.rmutto.finlove:id/buttonGoal1
    ...            ELSE IF  '${target}' == 'หาคู่เดทช่วงสั้นๆ'    Click Element   id=th.ac.rmutto.finlove:id/buttonGoal2
    ...            ELSE IF  '${target}' == 'หาเพื่อนใหม่'    Click Element   id=th.ac.rmutto.finlove:id/buttonGoal3
    ...            ELSE    Click Element   id=th.ac.rmutto.finlove:id/buttonGoal4

Select Interested Gender
    ${interested_gender} =    Evaluate    random.choice(${INTERESTED_GENDER_OPTIONS})    random
    Log    Randomly selected interested gender: ${interested_gender}
    Run Keyword If  '${interested_gender}' == 'ชาย'     Click Element   id=th.ac.rmutto.finlove:id/buttonMale
    ...            ELSE IF  '${interested_gender}' == 'หญิง'   Click Element   id=th.ac.rmutto.finlove:id/buttonFemale
    ...            ELSE   Click Element   id=th.ac.rmutto.finlove:id/buttonOther

Select Education Level
    [Arguments]   ${education_level}
    Run Keyword If  '${education_level}' == 'ปริญญาตรี'   Click Element   id=th.ac.rmutto.finlove:id/buttonBachelor
    ...            ELSE IF  '${education_level}' == 'มัธยมศึกษา'   Click Element   id=th.ac.rmutto.finlove:id/buttonHighSchool
    ...            ELSE IF  '${education_level}' == 'ปริญญาโท'   Click Element   id=th.ac.rmutto.finlove:id/buttonMaster
    ...            ELSE IF  '${education_level}' == 'ปริญญาเอก'   Click Element   id=th.ac.rmutto.finlove:id/buttonPhd
