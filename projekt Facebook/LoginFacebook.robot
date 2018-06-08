*** Settings ***
Suite Setup       GoToFacebook
Suite Teardown    Close All Browsers
Library           Selenium2Library

*** Variables ***
${URL}            https://www.facebook.com/
${BROWSER}        Chrome
${NAME}           Barbara
${SURNAME}        Kowalik
${EMAIL}          konto@gmail.com
${PASSWORD}       Olamakota!2018
${BIRTHDAY_DAY}    17
${BIRTHDAY_MONTH}    12
${BIRTHDAY_YEAR}    1978
${FUTURE_BIRTHDAY}    2018
${INVALIDPASSWORD}    11
${REGISTRATIONOK}    Potwierdź swój adres e-mail
${PASSERRORTEXT}    Hasło musi składać się z co najmniej 6 znaków. Wprowadź inne hasło.
${BIRTHDAYERRORTEXT}    Wygląda na to, że podano nieprawidłowe informacje. Podaj prawdziwą datę urodzin.

*** Test Cases ***
TC1_New_User_Invalid_Password
    [Tags]    NewUserInvalidPassword
    [Setup]    Go To Facebook
    Input Name    ${NAME}    ${SURNAME}
    Input Email    ${EMAIL}
    Input Passwd    ${INVALIDPASSWORD}
    Input Birthday    ${BIRTHDAY_DAY}    ${BIRTHDAY_MONTH}    ${BIRTHDAY_YEAR}
    Choose Gender
    Click Button Registration
    Result Test    //*[@id="reg_error_inner"]    ${PASSERRORTEXT}
    [Teardown]

TC2_New_User_Invalid_Birthday
    [Tags]    NewUserInvalidBirthday
    [Setup]    Go To Facebook
    Input Name    ${NAME}    ${SURNAME}
    Input Email    ${EMAIL}
    Input Passwd    ${PASSWORD}
    Input Birthday    ${BIRTHDAY_DAY}    ${BIRTHDAY_MONTH}    ${FUTURE_BIRTHDAY}
    Choose Gender
    Click Button Registration
    ResultTest    //*[@id="reg_error_inner"]    ${BIRTHDAYERRORTEXT}
    [Teardown]

TC3_New_User
    [Tags]    NewUser
    [Setup]    Go To Facebook
    InputName    ${NAME}    ${SURNAME}
    InputEmail    ${EMAIL}
    InputPasswd    ${PASSWORD}
    InputBirthday    ${BIRTHDAY_DAY}    ${BIRTHDAY_MONTH}    ${BIRTHDAY_YEAR}
    ChooseGender
    Click Button Registration
    ResultTest    //*[@class="uiHeaderTitle"]    ${REGISTRATIONOK}
    [Teardown]

*** Keywords ***
Input Name
    [Arguments]    ${firstname}    ${lastname}
    Input Text    //*[@id="u_0_l"]    ${firstname}
    Input Text    //*[@id="u_0_n"]    ${lastname}

Go To Facebook
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Input Birthday
    [Arguments]    ${day}    ${month}    ${year}
    Select From List By Index    //*[@id="day"]    ${day}
    Select From List By Index    //*[@id="month"]    ${month}
    Select From List By Value    //*[@id="year"]    ${year}

Input Email
    [Arguments]    ${mail}
    Input Text    //*[@id="u_0_q"]    ${mail}
    Input Text    //*[@id="u_0_t"]    ${mail}

Input Passwd
    [Arguments]    ${passwd}
    Input Password    //*[@id="u_0_x"]    ${passwd}

Choose Gender
    Click Element    //*[@id="u_0_11"]/span[1]/label

Click Button Registration
    Click Button    //*[@id="u_0_13"]
    Sleep    8s

Result Test
    [Arguments]    ${path}    ${expectedresult}
    ${obtainedresult}=    Get Text    ${path}
    Should Be Equal    ${obtainedresult}    ${expectedresult}
