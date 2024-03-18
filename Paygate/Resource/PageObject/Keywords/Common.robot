*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${PAYGATE_URL}    https://dev.onepay.vn/client/qt/
${product}    https://mtf.onepay.vn/client/qt

*** Keywords ***
Open test brower
    [Arguments]    ${PAYGATE_URL}    ${BROWSER}
    Set Global Variable  ${PAYGATE_URL}
    Open Browser    ${PAYGATE_URL}    ${BROWSER}
    Maximize Browser Window
    # IF    ${env} == dev
    #     Open Browser    ${PAYGATE_URL}    ${BROWSER}
    # ELSE
    #     Open Browser    ${product}    ${BROWSER}
    # END
Close test brower
    Close All Browsers     
