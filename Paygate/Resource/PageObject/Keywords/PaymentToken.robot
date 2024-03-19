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
    Wait Until Element Is Enabled    ${localBtnThanhToan}
    Click Button    ${localBtnThanhToan}
    Wait Until Element Is Visible    ${localOtp}    15s
    Input OTP    ${otp}
    Click Button    ${localBtnSubmitOtp}

Payment token merchant
    [Arguments]    ${vpc_TokenNumber}    ${vpc_TokenExp}
    Wait Until Element Is Visible    ${localTokenNumber}    15s
    Input Text    ${localAmount}    1000000
    Input Text    ${localTokenNumber}    ${vpc_TokenNumber}
    Input Text    ${localTokenExp}    ${vpc_TokenExp}
    Click Button    ${btnPayNow}
    Wait Until Element Is Visible    ${localOtp}    30s
    Input OTP    123456
    Click Button    ${localBtnSubmitOtp}

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
    Wait Until Element Is Enabled    ${localBtnThanhToan}
    Click Button    ${localBtnThanhToan}
    Wait Until Element Is Visible    ${localOtp}    15s
    Input OTP    123456
    Click Button    ${localBtnSubmitOtp}

Payment Token Onepay
    Click Element    ${localToken}
    Wait Until Element Is Visible    ${localBtnThanhToanToken}
    Click Element    ${localBtnThanhToanToken}
    Wait Until Element Is Visible    ${localOtp}    15s
    Input OTP    123456
    Click Button    ${localBtnSubmitOtp}
