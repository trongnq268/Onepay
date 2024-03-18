*** Settings ***
Library    SeleniumLibrary
Library    ExcelLibrary
Library    ../Common/subString.py
Variables    ../Locators/Paygate.py
Variables    ../Locators/Simulator.py
*** Variables ***
${EXCEL}    Paygate/Resource/Data/Excel/cardNumber.xlsx
*** Keywords ***
Select Merchant ID 
    Click Element    ${selectMid}
    Wait Until Element Is Visible    ${localMerchantTestToken}
    Click Element    ${localMerchantTestToken}

Input them 
    [Arguments]    ${txtThem}
    Input Text    ${localThem}    ${txtThem}

Input Customer User Id
    [Arguments]    ${txtUserId}
    Input Text    ${localUserId}    ${txtUserId}
    
Paygate
    Input Text    ${localAmount}    1000000
    Click Button    ${btnPayNow}
    Sleep    2

Select payment token 
    Input Text    ${localAmount}    1000000
    Click Element    ${createToken}
    Wait Until Element Is Visible    ${valueCreateTokenTrue}
    Click Element    ${valueCreateTokenTrue}
    Click Button    ${btnPayNow}

Select domestic
    Wait Until Element Is Visible    ${radioDomestic}    10s
    Click Element    ${radioDomestic}

Select bank 
    [Arguments]    ${bankId}
    Wait Until Element Is Visible    ${listBank}
    @{banks}=     Get WebElements    ${listBank}
    Click Element    ${banks}[${bankId}]
Get Index
    [Arguments]    ${string}    ${sub_string}
    ${index}=    Evaluate    ${string}.find("${sub_string}")
    [Return]    ${index}
Verify title bank
    [Arguments]    ${expectTitle}
    Element Text Should Be    ${titleCard}    ${expectTitle}

Input carNumber
    [Arguments]    ${txtCardNumber}
    Input Text    ${localCardNumber}    ${txtCardNumber}

Input expDate
    [Arguments]    ${txtExpDate}
    Input Text    ${localExpDate}    ${txtExpDate}

Input cardName
    [Arguments]    ${txtCardName}
    Input Text    ${localCardName}    ${txtCardName}

Input OTP 
    [Arguments]    ${otp}
    Input Text    ${localOtp}    ${otp}


Validate cardNumber
    FOR  ${index}  IN RANGE    2    7
        ${cardNumber}=    Read Excel Cell    ${index}    2
        Wait Until Element Is Visible     ${localCardNumber}    10s
        Input Text    ${localCardNumber}    ${cardNumber}
        Click Element    ${localExpDate}
        ${resual1}=    Run Keyword And Return Status    Element Should Be Visible    ${msgErrorCardNumne}
        IF  ${resual1} == $True
            Log    test
            ${epextMsg}    Read Excel Cell    ${index}    5
            ${resual2}=    Run Keyword And Return Status    Element Text Should Be    ${msgErrorCardNumne}    ${epextMsg}
            IF  ${resual2} == True
                Write Excel Cell    ${index}    6    PASS
                Save Excel Document    ${EXCEL}
            ELSE 
                Write Excel Cell    ${index}    6    FAIL
                Save Excel Document    ${EXCEL}
            END
        ELSE 
            Write Excel Cell    ${index}    6    PASS
            Save Excel Document    ${EXCEL}
        END
    END

Verify placeholder
    [Arguments]    ${txtPlaceholderCardNumber}    ${txtPlaceholderExpDate}    ${txtplaceholderCardName}
    ${placeholderCardNumber}=    Get Element Attribute    ${localCardNumber}    placeholder
    ${txtPlaceholderExpDate}=    Get Element Attribute    ${localExpDate}    placeholder
    ${txtplaceholderCardName}=    Get Element Attribute    ${localCardName}    placeholder
    # ${cardName}=     Get Element Attribute    locator    style
    Should Be Equal    ${placeholderCardNumber}     ${txtPlaceholderCardNumber} 
    Should Be Equal    ${txtPlaceholderExpDate}    ${txtPlaceholderExpDate}
    Should Be Equal    ${txtplaceholderCardName}     ${txtplaceholderCardName}
    
chon bank 
    [Arguments]    ${index}
    Paygate
    Select domestic
    Select bank    ${index}
      
Validate expDate
    FOR  ${index}  IN RANGE    7    10
        ${expDate}=    Read Excel Cell    ${index}    3
        Wait Until Element Is Visible    ${localExpDate}    10s
        Clear Element Text    ${localExpDate}
        Input Text    ${localExpDate}    ${expDate}
        Sleep    2
        Click Element    ${localCardName}
        ${epextMsg}    Read Excel Cell    ${index}    5
        ${resual1}=    Run Keyword And Return Status    Element Should Be Visible    ${msgErrorDate}
        IF  ${resual1} == $True
            Log    test
            ${resual2}=    Run Keyword And Return Status    Element Text Should Be    ${msgErrorDate}    ${epextMsg}
            IF  ${resual2} == True
                Write Excel Cell    ${index}    6    PASS
                Save Excel Document    ${EXCEL}
            ELSE 
                Write Excel Cell    ${index}    6    FAIL
                Save Excel Document    ${EXCEL}
            END
        ELSE 
            Write Excel Cell    ${index}    6    PASS
            Save Excel Document    ${EXCEL}
        END
    END
Validate cardName
    FOR  ${index}  IN RANGE    10    12
        ${userName}=    Read Excel Cell    ${index}    4
        Wait Until Element Is Visible    ${localCardName}    10s
        Clear Element Text    ${localCardName}
        Input Text    ${localCardName}    ${userName}
        Sleep    2
        Click Element    ${localExpDate}
        ${epextMsg}    Read Excel Cell    ${index}    5
        ${resual1}=    Run Keyword And Return Status    Element Should Be Visible    ${msgErrorCardNumne}
        IF  ${resual1} == $True
            Log    test
            ${resual2}=    Run Keyword And Return Status    Element Text Should Be    ${msgErrorCardNumne}    ${epextMsg}
            IF  ${resual2} == True
                Write Excel Cell    ${index}    6    PASS
                Save Excel Document    ${EXCEL}
            ELSE 
                Write Excel Cell    ${index}    6    FAIL
                Save Excel Document    ${EXCEL}
            END
        ELSE 
            Write Excel Cell    ${index}    6    PASS
            Save Excel Document    ${EXCEL}
        END
    END

#Thanh toán token
Get vpc_TokenNum
    [Arguments]    ${urlPayment}
    ${vpc_TokenNum}=    Extract Token Value    ${urlPayment}    vpc_TokenNum=    &
    [Return]    ${vpc_TokenNum}

Get vpc_TokenExp
    [Arguments]    ${urlPayment}
    ${vpc_TokenExp}=    Extract Token Value    ${urlPayment}    vpc_TokenExp=    &
    [Return]    ${vpc_TokenExp}


    