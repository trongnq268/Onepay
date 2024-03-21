*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Common/subString.py
Variables    ../Locators/Paygate.py
Variables    ../Locators/Simulator.py

Resource    Paygate.robot

*** Keywords ***
Create payment token merchant
    [Arguments]    ${index}
    Select payment token
    Select domestic
    Select bank    ${index}
    Input carNumber    9704360000000000002
    Input expDate    1123
    Input cardName    Nguyen van a 
    Wait Until Element Is Enabled    ${locationBtnThanhToan}
    Click Button    ${locationBtnThanhToan}
    Wait Until Element Is Visible    ${locationOtp}    15s
    Input OTP    ${otp}
    Click Button    ${locationBtnSubmitOtp}

Payment token merchant
    [Arguments]    ${vpc_TokenNumber}    ${vpc_TokenExp}
    Wait Until Element Is Visible    ${locationTokenNumber}    15s
    Input Text    ${locationAmount}    1000000
    Input Text    ${locationTokenNumber}    ${vpc_TokenNumber}
    Input Text    ${locationTokenExp}    ${vpc_TokenExp}
    Click Button    ${btnPayNow}
    Wait Until Element Is Visible    ${locationOtp}    30s
    Input OTP    123456
    Click Button    ${locationBtnSubmitOtp}

Create token onepay
    [Arguments]    ${txtThem}    ${txtUserID}    ${index}    
    Select Merchant ID
    Input them    ${txtThem}
    Input Customer User Id    ${txtUserID} 
    Paygate
    Select domestic
    Select bank    ${index}
    Input carNumber    9704360000000000002
    Input expDate    1123
    Input cardName    Nguyen van a 
    Wait Until Element Is Enabled    ${locationBtnThanhToan}
    Click Button    ${locationBtnThanhToan}
    Wait Until Element Is Visible    ${locationOtp}    15s
    Input OTP    123456
    Click Button    ${locationBtnSubmitOtp}

Payment Token Onepay
    Click Element    ${locationToken}
    Wait Until Element Is Visible    ${locationBtnThanhToanToken}
    Click Element    ${locationBtnThanhToanToken}
    Wait Until Element Is Visible    ${locationOtp}    15s
    Input OTP    123456
    Click Button    ${locationBtnSubmitOtp}

Select token
    Click Element    ${locationToken}
    
Verify popup 
    [Arguments]    ${txtHeaderPopup}   
    Wait Until Element Is Visible    ${locationHeaderPopup}
    Element Text Should Be    ${locationHeaderPopup}    ${txtHeaderPopup}


    