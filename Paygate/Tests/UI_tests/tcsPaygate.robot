*** Settings ***
Library    ../../Resource/PageObject/Common/subString.py

Resource    ../../Resource/PageObject/Keywords/Common.robot
Resource    ../../Resource/PageObject/Keywords/Paygate.robot
Resource    ../../Resource/PageObject/Keywords/PaymentToken.robot

Suite Setup    Open test brower    ${PAYGATE_URL}    chrome 
Suite Teardown    Close test brower
*** Variables ***
${EXCEL}    Paygate/Resource/Data/Excel/cardNumber.xlsx

*** Test Cases ***
Select bank 
    [Tags]    select bank
    chon bank     1
    Verify title bank    Thanh toán qua Vietcombank 
    Verify placeholder    9704 1234 5678 9123 012    12/18    NGUYEN VAN A
Validate data 
    [Tags]    Validate
    Open Excel Document    ${EXCEL}    sheet1
    Validate cardNumber
    Reload Page
    Validate expDate
    Reload Page
    Validate cardName
    Close All Excel Documents

Giao dich token merchant 
    Go To    ${PAYGATE_URL}
    Create payment token merchant    1
    Wait Until Element Is Visible    ${localTitlePageKetQua}    20s
    ${current_url}=   Get Location
    
    ${token_num}=    Extract Token Value    ${current_url}    vpc_TokenNum=    &
    ${token_exp}=    Extract Token Value    ${current_url}    vpc_TokenExp=    &
    Log To Console    token number ${token_num}
    Log To Console    token exp ${token_exp}
    Go To    ${PAYGATE_URL}
    Payment token merchant    ${token_num}    ${token_exp}
    Wait Until Element Is Visible    ${localTitlePageKetQua}    20s
    Element Text Should Be    ${localTitlePageKetQua}    Giao dịch thành công

# Tesst 1123
#     Open Excel Document    ${EXCEL}    sheet1
#     ${cardNumber}=    Get Value From Column By Name 
