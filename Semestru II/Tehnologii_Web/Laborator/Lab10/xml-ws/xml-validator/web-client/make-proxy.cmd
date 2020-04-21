@echo off
rem Genereaza codul-sursa al clasei proxy folosite pentru invocarea 
rem serviciului Web de catre un client.

rem A se inlocui calea spre wsdl.exe cu cea existenta pe masina utilizata
rem (se presupune ca serviciul Web va putea fi invocat pe 'localhost', 
rem  la portul 8080).
rem Pentru .NET Framework 1.1, se substituie 'v2.0' cu 'v1.1'
"c:\Program Files\Microsoft.NET\SDK\v2.0\Bin\wsdl.exe" http://localhost:8080/xml-validator\xml-validator.asmx?WSDL
