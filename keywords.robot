
*** Keywords ***
Pobierz Plik
    [Arguments]    ${path}
    ${plik}=   Get File  ${path}
    Log To Console  ${plik}
    [RETURN]  ${plik}

Policz slowa
    [Arguments]  ${plik}
    @{slowa}=  Split string  ${plik}
    ${ilosc_slow}=    Get Length   ${slowa}
    Log to Console   ${ilosc_slow}
    [RETURN]   ${ilosc_slow}