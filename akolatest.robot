*** Settings ***
Library  String
Library  OperatingSystem
Resource  ./keywords.robot

*** Variables ***
${SCIEZKA}=     \\\\10.0.0.1\\Wszyscy\\!NOKIA\\tekst.txt

*** Test Cases ***
Liczenie Slow
    ${plik}=   Pobierz plik   ${SCIEZKA}
    ${ilosc slow}=  Policz slowa  ${plik}
