*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    String
Library    Collections
Library    ../../Resource/PageObject/Common/subString.py
*** Variables ***
${url}=    https://dev.onepay.vn/client/qt/dr/?mode=TEST_PAYGATE&vpc_Amount=1000000&vpc_AuthorizeId=786773&vpc_Card=MC&vpc_CardExp=1224&vpc_CardNum=512345xxxxxx0008&vpc_CardUid=INS-tzPxWFXUDETgVQIMKZInFQ&vpc_Command=pay&vpc_MerchTxnRef=TEST_1710478448663756556774&vpc_Merchant=TESTONEPAY&vpc_Message=Approved&vpc_OrderInfo=Ma+Don+Hang&vpc_PayChannel=WEB&vpc_TokenExp=1224&vpc_TokenNum=5123455406576717&vpc_TransactionNo=PAY-cM95nfJWT2-77ME7Q8DiCQ&vpc_TxnResponseCode=0&vpc_Version=2&vpc_AcqResponseCode=00&vpc_SecureHash=F53F16A50FDA4455C5068D58ADD0815A3801BB4B6DBDE5499E5939F211922BC2

*** Test Cases ***
Example Test
    ${token_value}=    Get Token Value1    ${url}
    Log To Console   ket qua ${token_value}    # In ra giá trị của vpc_TokenNum

test2
    ${subString}=    Extract Token Value    ${url}    vpc_Amount    &
    Log To Console    ket qua ${subString}
    
*** Keywords ***
Get Token Value
    [Arguments]    ${url}
    ${result}=    Run Keyword And Return Status    Get Token    ${url}
    Run Keyword If    ${result}    Log    Không tìm thấy giá trị vpc_TokenNum trong URL.
    [Return]    ${result}

Get Token
    [Arguments]    ${url}
    ${parsed_url}=    Evaluate    urlparse('${url}')
    ${query_params}=    Evaluate    parse_qs('${parsed_url.query}')
    ${token_num}=    Get From Dictionary    ${query_params}    vpc_TokenNum    None
    ${token_value}=    Run Keyword If    '${token_num}' != 'None'    Get Token Value    ${token_num}
    [Return]    ${token_value}

Get Token Value1
    [Arguments]    ${token_num}
    ${tokens}=    Split String    ${token_num}    =
    [Return]    ${tokens}[1]



