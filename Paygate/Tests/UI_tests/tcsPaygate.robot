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
    Input Amount    10000000
    chon bank     1
    Verify title bank    Thanh toán qua Vietcombank 
    Verify placeholder    9704 1234 5678 9123 012    12/18    NGUYEN VAN A
Validate data 
    [Tags]    Validate
    Go To    ${PAYGATE_URL}
    Input Amount    10000000
    chon bank     1
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
    Wait Until Element Is Visible    ${locationTitlePageKetQua}    20s
    ${current_url}=   Get Location
    
    ${token_num}=    Extract Token Value    ${current_url}    vpc_TokenNum=    &
    ${token_exp}=    Extract Token Value    ${current_url}    vpc_TokenExp=    &
    Log To Console    token number ${token_num}
    Log To Console    token exp ${token_exp}
    Go To    ${PAYGATE_URL}
    Payment token merchant    ${token_num}    ${token_exp}
    Wait Until Element Is Visible    ${locationTitlePageKetQua}    20s
    Element Text Should Be    ${locationTitlePageKetQua}    Giao dịch thành công

Giao dich token OP 
    Go To    ${PAYGATE_URL}
    Create token onepay    token    AutoTest      1
    Go To    ${PAYGATE_URL}
    Select Merchant ID
    Input them    token
    Input Amount    1000000
    Input Customer User Id    AutoTest
    Paygate
    Payment Token Onepay
    Wait Until Element Is Visible    ${locationTitlePageKetQua}    20s
    Element Text Should Be    ${locationTitlePageKetQua}    Giao dịch thành công

Thanh toán token với số Amount min 
    Go To    ${PAYGATE_URL}
    Select Merchant ID
    Input Amount     100000
    Input them    token 
    Input Customer User Id    AutoTest
    Paygate
    Select token
    Verify popup    Số tiền thanh toán không hợp lệ!    

Thanh toán token với số Amount Max 
    Go To    ${PAYGATE_URL}
    Select Merchant ID
    Input Amount     20000000100
    Input them    token 
    Input Customer User Id    AutoTest
    Paygate
    Select token
    Verify popup    Số tiền thanh toán không hợp lệ!    

Thanh toan với user khác
    Go To    ${PAYGATE_URL}
    Select Merchant ID
    Input Amount     20000000100
    Input them    token 
    Input Customer User Id    AutoTest
    Paygate